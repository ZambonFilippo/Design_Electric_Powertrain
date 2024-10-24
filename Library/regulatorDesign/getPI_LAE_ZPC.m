function [kp, ki] = getPI_LAE_ZPC(L, R, phaMar, delay)

% The PI time constant tauI is set to be equal to the time constant tau:
tau    = L/R;
tauI    = tau;

% the angular frequency at which the desired phase margin is guaranteed can be calculated as follows:
wgc = tan(pi/2 - phaMar)/delay;

% the proportional gain of the PI regulator can be worked out as:
kp  = R * tauI * wgc * sqrt(1+(wgc^2)*(delay^2));

% the integral gain of the PI regulator can be worked out as:
ki  = kp/tauI;

end
