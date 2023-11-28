% Literature Matricies
A_test = [0    0     1 0;...
          0    0     0 1;...
          0 -360 -4761 0;...
          0 1947 25056 0];
b_test = [0; 0; 248.4; -1307.6];

% Load environment from equation_of_motions.mlx and convert to numeric
% matrices. Init C, D matrices and init conditions
syms m_1 m_2 R_0 R_1 J_1 l R_a k_m phi_0 g;

load envs\linear_model_v001.mat;
load envs\front_parameters.mat;
load envs\side_parameters.mat;


% Front
A_front = double(vpa(subs(A,   [m_1,       m_2,        R_0,        R_1,       J_1,       l,       R_a,       k_m*phi_0,         g], ...
                               [m_1_front, m_2_front,  R_0_front,  R_1_front, J_1_front, l_front, R_a_front, k_m_x_phi_0_front, g_glob]), 5));
b_front = double(vpa(subs(b,   [m_1,       m_2,        R_0,        R_1,       J_1,       l,       R_a,       k_m*phi_0,         g], ...
                               [m_1_front, m_2_front,  R_0_front,  R_1_front, J_1_front, l_front, R_a_front, k_m_x_phi_0_front, g_glob]), 5));

% Side
A_side = double(vpa(subs(A,   [m_1,       m_2,        R_0,        R_1,       J_1,       l,       R_a,       k_m*phi_0,         g], ...
                              [m_1_side,  m_2_side,   R_0_side,   R_1_side,  J_1_side,  l_side,  R_a_side,  k_m_x_phi_0_side,  g_glob]), 5));
b_side = double(vpa(subs(b,   [m_1,       m_2,        R_0,        R_1,       J_1,       l,       R_a,       k_m*phi_0,         g], ...
                              [m_1_side,  m_2_side,   R_0_side,   R_1_side,  J_1_side,  l_side,  R_a_side,  k_m_x_phi_0_side,  g_glob]), 5));

c = eye(4);
C = [1 0 0 0; 0 1 0 0];
d = [0; 0; 0; 0];
init_cond = [0, 0.0174533, 0, 0]; %[m, rad, m/s, rad/s]

% Test matrices against literature
% test_difference = abs(A_num - A_test)

% LQR weight matrices and control vector
Q = [1 0 0 0; 0 20 0 0; 0 0 0 0; 0 0 0 0];
R = 0.0013;
Ts = 0.004;

% Front
[F_front, P_front, E_front] = lqrd(A_front, b_front, Q, R, Ts);

% Side
[F_side, P_side, E_side] = lqrd(A_side, b_side, Q, R, Ts);


% % Adjusted System with integrator
% % Front
% A_hat_front = [A_front zeros(4,1); [1 0 0 0], 0];
% b_hat_front = [b_front; 0];
% 
% % Side
% A_hat_side = [A_side zeros(4,1); [1 0 0 0], 0];
% b_hat_side = [b_side; 0];
% 
% % Global
% c_hat = [1 0 0 0 0];
% 
% 
% Q_int = [5 0 0 0 0; 0 3 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0.00001];
% R_int = 0.0008;
% 
% % Front
% [F_int_front, P_int_front, E_int_front] = lqrd(A_hat_front, b_hat_front, Q_int, R_int, Ts);
% 
% % Side
% [F_int_side, P_int_side, E_int_side] = lqrd(A_hat_side, b_hat_side, Q_int, R_int, Ts);

% Observer
C_out = [1 0 0 0; 0 0 0 1];
% Front
max_eig = max(abs(E_front));
obs_mult = 25;
observer_front = place(A_front', C_out',  [-max_eig * obs_mult, -max_eig * obs_mult + 0.1, -max_eig *obs_mult + 0.2, -max_eig * obs_mult + 0.3])';
% Side
observer_side = place(A_side', C_out', [-4, -4.1, -4.2, -4.3])';

% Tracking Filter for 2DOF
Cz = [1 0 0 0];
Dz = 0;

% Front
M_front = (Dz - (Cz - Dz * F_front) * inv(A_front - b_front * F_front) * b_front);
G_front = 1 / M_front;

% Side
M_side = (Dz - (Cz - Dz * F_side) * inv(A_side - b_side * F_side) * b_side);
G_side = 1 / M_side ;

% Nonlinear Model
% load envs\nonlinear_fo_model_v001.mat

% fo_sys_sub = matlabFunction(fo_sys, "vars", {"t", "q"});
% y_sol = ode45(fo_sys_sub, [0 10], init_cond);
% 
% t_values = linspace(0, 20, 100);
% y_values = deval(y_sol, t_values, 1)
% plot(t_values, y_values)
