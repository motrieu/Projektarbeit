clear;
clc;

addpath("Simulink\");

controller_design;
nonlinear_fo_prep;

time = 10;

% Stabilization
% sim("Simulink\nonlinear_simulation_stabilization.slx", time)

% Tracking
% sim("Simulink\nonlinear_simulation_tracking.slx", time)