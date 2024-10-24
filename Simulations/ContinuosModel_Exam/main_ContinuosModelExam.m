%% Main file

% Set the simulation name
simName ='ContinuosModelExam.slx';

%% Load motor data
motorData;

%% Load inverter
MCLV2_data;

%% Current regulator
currentRegulators;

%% Speed regulator
speedRegulator;

%% Open Sim
 open(simName)