%% Measurements
FS                          = 8.8;      % (A) Full scale (+- 4.4A)
Nb                          = 12;       % ADC number of bit
meas.quant.currMeas         = FS/2^Nb;  % (A)

Np                          = 250;      % Number of pulses
meas.quant.posMeas          = 2*pi/Np;   % (rad)

meas.filter.numTabsSpeed    = 16;
meas.time.posMeas           = inverter.param.timeSampling;

z                           = tf('z', inverter.param.timeSampling); % Z-transform variable
sysFiltDer                  = (1-z^(-meas.filter.numTabsSpeed))/...
                              (meas.filter.numTabsSpeed*meas.time.posMeas);
