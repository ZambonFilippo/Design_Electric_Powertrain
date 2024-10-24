function [kp, ki] = getPI_LAE(staticGain, pole1, pole2, controlSettings)
%GETPI_LAE Summary of this function goes here
% Only transfer function in the bode form are adopted.
% The "controlSettings" input is: [crossOverFrequency_rads; phaseMargin_rad]

% Laplace variable
s = tf('s');

% Get the transfer function
sysP    = staticGain*(1/(s*pole1+1))*(1/(s*pole2+1));

% Get mag and phase of sysP at the crossover frequency
[magSysP, phaSysP] = bode(sysP, controlSettings(1));

% Since the bode command returns a phase value in degree, it must be
% converted to radian:
phaSysP = (phaSysP*pi)/180;

% get gain and phase
deltaK = 1/magSysP;
deltaPhi = controlSettings(2)-pi-phaSysP;

% get parameters
kp = deltaK*cos(deltaPhi);
ki = -controlSettings(1)*deltaK*sin(deltaPhi);

end

