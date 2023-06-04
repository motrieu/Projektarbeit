% Literature Matricies
A_test = [0    0     1 0;...
          0    0     0 1;...
          0 -360 -4761 0;...
          0 1947 25056 0];
b_test = [0; 0; 248.4; -1307.6];

% Load environment from equation_of_motions.mlx and convert to numeric
% matrices. Init C, D matrices and init conditions
load envs\linear_model_v001.mat;
A_num = double(A_sub);
b_num = double(b_sub);
c = eye(4);
C = [1 0 0 0; 0 1 0 0];
d = [0; 0; 0; 0];
init_cond = [0, 0.0174533, 0, 0]; %[m, rad, m/s, rad/s]

% Test matrices against literature
test_difference = abs(A_num - A_test)

% LQR weight matrices and control vector
Q = [3 0 0 0; 0 5 0 0; 0 0 0 0; 0 0 0 0];
R = 0.0013;
Ts = 0.004;
[F, P, E] = lqrd(A_num, b_num, Q, R, Ts);


% Adjusted System with integrator
A_hat = [A_num zeros(4,1); [1 0 0 0], 0];
b_hat = [b_num; 0];
c_hat = [1 0 0 0 0];


Q_new = [3 0 0 0 0; 0 5 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0.00001];
R_new = 0.0013;

[F_new, P_new, E_new] = lqrd(A_hat, b_hat, Q_new, R_new, Ts);

% Tracking Filter for 2DOF
Cz = [1 0 0 0];
Dz = 0;
M = (Dz - (Cz - Dz*F) * inv(A_num-b_num*F) * b_num);
G = 1 / M;

% Nonlinear Model
load envs\nonlinear_fo_model_v001.mat

% fo_sys_sub = matlabFunction(fo_sys, "vars", {"t", "q"});
% y_sol = ode45(fo_sys_sub, [0 10], init_cond);
% 
% t_values = linspace(0, 20, 100);
% y_values = deval(y_sol, t_values, 1)
% plot(t_values, y_values)
