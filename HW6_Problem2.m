clear
close all
clc

syms P1 P2 P3 lambda1 lambda2 lambda3

% Define the total generation cost
C_max = (3 + P1 + 0.1*P1^2) + (1 + P2 + 0.2*P2^2) + (2 + 0.3*P3 + P3^2);

% Define the constraints
constraint1 = P1 + P2 - 70;
constraint2 = P3 + P2 - 40;
constraint3 = P1 + P2 + P3 - 100;

% Formulate the Lagrangian function
Lagrangian = C_max + lambda1 * constraint1 + lambda2 * constraint2 + lambda3 * constraint3;

% Compute the partial derivatives 
dL_dP1 = diff(Lagrangian, P1);
dL_dP2 = diff(Lagrangian, P2);
dL_dP3 = diff(Lagrangian, P3);
dL_dlambda1 = diff(Lagrangian, lambda1);
dL_dlambda2 = diff(Lagrangian, lambda2);
dL_dlambda3 = diff(Lagrangian, lambda3);

% Solve the system of 6 equations
solutionSystem = solve([dL_dP1 == 0, dL_dP2 == 0, dL_dP3 == 0, dL_dlambda1 == 0, dL_dlambda2 == 0, dL_dlambda3 == 0], [P1, P2, P3, lambda1, lambda2, lambda3]);

% Display all the solution of the system
disp('Solution of the system:');
disp(['P1 = ', char(solutionSystem.P1)]);
disp(['P2 = ', char(solutionSystem.P2)]);
disp(['P3 = ', char(solutionSystem.P3)]);
disp(['Lambda1 = ', char(solutionSystem.lambda1)]);
disp(['Lambda2 = ', char(solutionSystem.lambda2)]);
disp(['Lambda3 = ', char(solutionSystem.lambda3)]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Initialization of the variables
syms P1 P2 P3

f= (3+P1+0.1*P1^2 )+(1+P2+0.2 *P2^2 )+(2+0.3*P3+P3^2 );

alpha = 0.05; % step size

A = [1 1 0; 0 1 1 ; 1 1 1];
b = [70 40 100]';
H = 10;

P = zeros(3,H);
P(1:3,1) = [0,0,0];

grad_f = gradient(f);
grad_f = matlabFunction(grad_f);

proj = @(P1,P2,P3)  [P1;P2;P3]- A'*inv((A*A'))*(A*[P1;P2;P3]-b);

for k = 1:H-1
    non_projected = P(1:3,k) - alpha * gradient(P(1,k),P(2,k),P(3,k));
    P(1:3,k+1) = proj(non_projected(1),non_projected(2),non_projected(3));
end

plot(1:H,P(1,:))
hold on
plot(1:H,P(2,:))
hold on
plot(1:H,P(3,:))
shg
xlabel("Iteration")
ylabel("Value")
legend("P1","P2","P3")
title ("Projected gradient descent")

