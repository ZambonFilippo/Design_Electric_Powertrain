%% Main file

% Set the simulation name
simName ='DiscreteModelExam.slx';

%% Load motor data
motorData;

%% Load inverter
MCLV2_data;

%% Current regulator
currentRegulators;

%% Speed regulator
speedRegulator;

%% Discretization & Quantization
measurements_MCLV2;

%% Open Sim
 open(simName)