% Global Parameters
g_glob = 9.81;

% Front Parameters
m_1_front = 0.020;
m_2_front = 0.697;
R_0_front = 0.043;
R_1_front = 0.079;
J_1_front = 2/3 * m_1_front * R_1_front^2;
l_front = 0.1504;
R_a_front = 4.6;
k_m_x_phi_0_front = 0.48;


% Side Parameters
m_1_side = 0.020;
m_2_side = 0.697;
R_0_side = 0.043;
R_1_side = 0.079;
J_1_side = 2/3 * m_1_side * R_1_front^2;
l_side = 0.1504;
R_a_side = 4.6;
k_m_x_phi_0_side = 0.48;

save("envs\front_parameters", "m_1_front", "m_2_front", "R_0_front", "R_1_front", "J_1_front", "l_front", "R_a_front", "k_m_x_phi_0_front", "g_glob");
save("envs\side_parameters", "m_1_side", "m_2_side", "R_0_side", "R_1_side", "R_1_side", "J_1_side", "l_side", "k_m_x_phi_0_side", "R_a_side", "g_glob");