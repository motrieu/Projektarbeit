load envs\linear_model_v001.mat;
A_num = double(A_sub);
b_num = double(b_sub);
c = eye(4);
d = [0; 0; 0; 0];
init_cond = [0, 5, .3, .3];

Q = [3 0 0 0; 0 5 0 0; 0 0 0 0; 0 0 0 0]
R = 0.0013
Ts = 0.004
[F, P, E] = lqrd(A_num, b_num, Q, R, Ts)