function [kp, ki] = getPI_LAE_NSA(L, R, phaMar, delay, wgc)

tauE    = L/R;

% The tauI calculation can be obtained as:
fun = @(Tau) abs(pi - phaMar + angle((1+1j*wgc*Tau)/...
(1j*wgc*(1+1j*wgc*delay)*(1+1j*wgc*tauE))));

tauI = fminsearch(fun,0);

% The calculation of kp is obtained by:
fun2 = @(Kp) abs((Kp/(R*tauI) * abs((1+1j*wgc*tauI)/...
(1j*wgc*(1+1j*wgc*delay)*(1+1j*wgc*tauE))))-1);

kp = fminsearch(fun2,0);

% the integral gain of the PI regulator can be worked out as:
ki  = kp/tauI;



end

