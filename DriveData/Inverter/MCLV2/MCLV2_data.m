%% MCLV2 inverter

inverter.param.freqSampling = 8e3; % (Hz)
inverter.param.timeSampling = 1/inverter.param.freqSampling; % (s)

inverter.param.freqSwitching = inverter.param.freqSampling; % (Hz)
inverter.param.timeSwitching = 1/inverter.param.freqSwitching; % (s)

%% Voltage supply
inverter.param.voltBus  = 24;   % (V)

%% Saturation
inverter.param.satCircleOn  = 1; % 1 = circle saturation active, 0 = hexagon saturation
