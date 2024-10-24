%% design parameters
%contrInfo_speed.wgc = 20*(2*pi);
contrInfo_speed.wgc = 16*(2*pi);
contrInfo_speed.phim = 80*(pi/180);
contrInfo_speed.contrSettings=[contrInfo_speed.wgc; contrInfo_speed.phim];
s = tf('s');

%% speed regulator parameter Bode's Method
contr_speed.gain     = 1/mot.param.frictionM;
contr_speed.pole1    = 1/(contrInfo_curr.wgc);
contr_speed.pole2    = mot.param.inertiaM/mot.param.frictionM;
[contr_W.param.propGain, contr_W.param.intGain] = getPI_LAE(contr_speed.gain, contr_speed.pole1, contr_speed.pole2, contrInfo_speed.contrSettings);

%% Anti-WindUp
contr_W.speedContr_kt = contr_W.param.intGain/contr_W.param.propGain;

%% speed regulator parameter Zero-Pole Cancellation
[speed_ZPC_propGain, speed_ZPC_intGain] = getPI_LAE_ZPC(mot.param.inertiaM, mot.param.frictionM, contrInfo_speed.phim, 1.5*inverter.param.timeSwitching);

%% speed regulator parameter Numeric Solution Algorithm
[speed_NSA_propGain, speed_NSA_intGain] = getPI_LAE_NSA(mot.param.inertiaM, mot.param.frictionM, contrInfo_speed.phim, 1.5*inverter.param.timeSwitching, contrInfo_speed.wgc);

%% speed regulator parameter AIEME
[speed_AIEME_propGain, speed_AIEME_intGain] = getPI_LAE_AIEME(mot.param.inertiaM, mot.param.frictionM, contrInfo_speed.phim, 1.5*inverter.param.timeSwitching, contrInfo_speed.wgc);

