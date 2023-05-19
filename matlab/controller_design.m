load envs\linear_model_v001.mat;
A_num = double(A_sub);
b_num = double(b_sub);
c = eye(4);
d = [0; 0; 0; 0];
init_cond = [0.4, 1, 0.2, .3];

Q = [3 0 0 0; 0 5 0 0; 0 0 0 0; 0 0 0 0];
R = 0.0013;
Ts = 0.004;
[F, P, E] = lqrd(A_num, b_num, Q, R, Ts)

A_hat = [A_num zeros(4,1); [1 0 0 0], 0];
b_hat = [b_num; 0];
c_hat = [1 0 0 0 0];

Q_new = [3 0 0 0 0; 0 5 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0.00001];
R_new = 0.0013;

[F_new, P_new, E_new] = lqrd(A_hat, b_hat, Q_new, R_new, Ts)