load envs/nonlinear_fo_model_v001.mat model m_1 m_2 R_0 R_1 J_1 l  R_a k_m phi_0 g
load envs\front_parameters.mat
load envs\side_parameters.mat

numerical_model_front = vpa(subs(model,   [m_1,       m_2,        R_0,        R_1,       J_1,       l,       R_a,       k_m*phi_0,         g], ...
                                          [m_1_front, m_2_front,  R_0_front,  R_1_front, J_1_front, l_front, R_a_front, k_m_x_phi_0_front, g_glob]), 5);

numerical_model_side = vpa(subs(model,    [m_1,       m_2,        R_0,        R_1,       J_1,       l,       R_a,       k_m*phi_0,         g], ...
                                          [m_1_side,  m_2_side,   R_0_side,   R_1_side,  J_1_side,  l_side,  R_a_side,  k_m_x_phi_0_side,  g_glob]), 5);