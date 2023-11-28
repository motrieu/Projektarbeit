clear;
clc;

addpath("Simulink\");

controller_design;
time = 10;

% Stabilization
sim("Simulink\linear_simulation_stabilization.slx", time)

% Tracking
% sim("Simulink\linear_simulation_tracking.slx", time)