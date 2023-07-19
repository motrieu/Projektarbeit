load envs/nonlinear_fo_model_v001.mat model m_1 R_0 R_1 J_1 l  R_a k_m phi_0 g

numerical_model = vpa(subs(model,   [m_1,   m_2,    R_0,    R_1, J_1, l, R_a, k_m*phi_0, g], ...
                                [0.012, 0.734,  0.021,  0.02505, 5.02e-6, 0.19, 4.6, 0.48, 9.81]), 5)