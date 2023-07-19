syms q_1(t)
syms q_2(t)
syms u_a(t)
syms m_1
syms m_2
syms g
syms l
syms J_1
syms R_a
syms R_0
syms R_1
syms F_x
syms k_m
syms phi_0

load envs\nonlinear_fo_model_v001.mat

num_model = vpa(subs(model,[m_1,   m_2,   R_0,   R_1,     J_1,     l,    R_a, k_m * phi_0, g,      u_a(t)],...
                            [0.012, 0.734, 0.021, 0.02505, 5.02e-6, 0.19, 4.6, 0.48,        9.81,   0]), 5)
% 
% % [t, y] = ode45(@(t, y) num_model, [0 20], [0; 0; 0; 0]);
% % 
% % plot(t,y)
