# Optimization Homework — Least Squares Regression & Economic Dispatch

MATLAB solutions to a two-part optimization assignment (Homework 6, Tampere University): fitting a linear predictor to housing data via least squares (both analytically and via gradient descent), and solving a constrained economic dispatch problem via Lagrangian multipliers and projected gradient descent.

## Overview

**Problem 1 — Linear regression via least squares.** Given housing data (apartment size vs. price), fit a linear predictor `ŷ = c1·y1 + c2` in three ways:
1. Load and visualize the raw data.
2. Solve for `c = [c1, c2]ᵀ` analytically using the closed-form least squares solution.
3. Solve for `c` numerically using gradient descent with a constant step size, using data standardization (`zscore`) to address the scale mismatch between the slope and bias terms.

**Problem 2 — Constrained economic dispatch.** Given three power generation units with quadratic cost functions and linear demand constraints (see `HW6.pdf` for the problem diagram), find the optimal power allocation `P = [P1, P2, P3]ᵀ` that minimizes total generation cost:
1. Formulate the problem analytically using Lagrangian multipliers, solving the resulting system of stationarity/constraint equations symbolically.
2. Solve the same problem numerically using **projected gradient descent**, projecting each iterate back onto the constraint set at every step.

## Repository structure

| File | Description |
|---|---|
| `HW6.pdf` | Assignment sheet (problem statements, economic dispatch diagram, point breakdown). |
| `HW6_Problem1.m` | Problem 1, parts 1–2: loads and plots the housing data, then computes the least squares solution `c = (AᵀA)⁻¹ Aᵀy` in closed form and plots the fitted line together with the residuals. |
| `HW6_Problem1_3.m` | Problem 1, part 3: solves for `c` numerically via gradient descent on standardized data, plotting the convergence of `c1` and `c2` over 100 iterations. |
| `HW6_Problem2.m` | Problem 2: sets up the economic dispatch cost function and constraints symbolically, solves the Lagrangian stationarity conditions for the analytical optimum, then solves the same problem via projected gradient descent and plots the convergence of `P1`, `P2`, `P3`. |

> Note: `HW6_Problem1.m` and `HW6_Problem1_3.m` both expect a `data.txt` file (two columns: apartment size, price) in the working directory. This data file is not included here — add it alongside the scripts before running them.

## Method details

### Problem 1 — Least squares regression
- **Model:** `ŷ = c1·y1 + c2`, i.e. a simple linear predictor of price from size.
- **Analytical solution:** the normal equations `c = (AᵀA)⁻¹Aᵀy`, where `A = [y1, 1]`.
- **Numerical solution:** batch gradient descent on the least-squares objective, with the gradient `∇c = -2·Aᵀ(y - Ac)`, run for a fixed number of iterations (`H = 100`) with a constant step size (`alpha = 0.01`). The data is standardized with `zscore` beforehand specifically to correct for the very different natural scales of the slope (`c1`) and intercept (`c2`) terms, which would otherwise make a single shared step size ineffective.

### Problem 2 — Economic dispatch
- **Objective:** minimize the total quadratic generation cost `(3 + P1 + 0.1·P1²) + (1 + P2 + 0.2·P2²) + (2 + 0.3·P3 + P3²)`.
- **Constraints:** three linear demand constraints (`P1 + P2 = 70`, `P3 + P2 = 40`, `P1 + P2 + P3 = 100`), following the dispatch diagram in `HW6.pdf`.
- **Analytical solution:** the Lagrangian is formed with one multiplier per constraint, and the full system of stationarity + constraint equations is solved symbolically with MATLAB's Symbolic Math Toolbox (`syms`, `solve`).
- **Numerical solution:** projected gradient descent — at each iteration, an unconstrained gradient step is taken on the cost function, then the result is projected back onto the constraint set `{P : AP = b}` using the closed-form projection `P ← P − Aᵀ(AAᵀ)⁻¹(AP − b)`. As noted in the assignment, this particular problem is set up to converge in a single iteration.

## Requirements

- MATLAB
- Symbolic Math Toolbox (required for `HW6_Problem2.m`, which uses `syms`, `diff`, `solve`, `gradient`, and `matlabFunction`)

## How to run

1. Place `data.txt` (two columns: size, price) in the same folder as the scripts.
2. Run `HW6_Problem1.m` for the data visualization and closed-form least squares fit.
3. Run `HW6_Problem1_3.m` for the gradient descent solution and convergence plot.
4. Run `HW6_Problem2.m` for both the analytical (Lagrangian) and numerical (projected gradient descent) solutions to the economic dispatch problem.

## Notes

This is university coursework (Tampere University, optimization course, Homework 6, March 2024). Parameters such as step size, iteration count, and the cost/constraint coefficients are specific to the assignment and can be adapted for other datasets or dispatch configurations.

## License

Add your preferred license here (e.g. MIT), and confirm with your course/institution whether any distribution restrictions apply to coursework repositories.
