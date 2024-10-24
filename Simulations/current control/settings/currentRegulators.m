%% design parameters
contrInfo_curr.wgc = 160*(2*pi);
contrInfo_curr.phim = 80*(pi/180);
contrInfo_curr.contrSettings=[contrInfo_curr.wgc; contrInfo_curr.phim];
s = tf('s');

%% d-axis
contr_D.gain     = 1/mot.param.resistance;
contr_D.pole1    = mot.param.ind_D/mot.param.resistance;
contr_D.pole2    = 1.5*inverter.param.timeSwitching;
[contr_D.param.propGain, contr_D.param.intGain] = getPI_LAE(contr_D.gain, contr_D.pole1, contr_D.pole2, contrInfo_curr.contrSettings);

%% q-axis
contr_Q.gain     = 1/mot.param.resistance;
contr_Q.pole1    = mot.param.ind_Q/mot.param.resistance;
contr_Q.pole2    = 1.5*inverter.param.timeSwitching;
[contr_Q.param.propGain, contr_Q.param.intGain] = getPI_LAE(contr_Q.gain, contr_Q.pole1, contr_Q.pole2, contrInfo_curr.contrSettings);

%% evaluation performance d-axis
% sysMotD     = 1/(mot.param.resistance + s * mot.param.ind_D);
% sysDelayApp = 1/(1 + s*1.5*inverter.param.timeSwitching);
% tauI_D      = contr_D.param.propGain/contr_D.param.intGain;
% sysPI_D     = (contr_D.param.propGain*(1+s*tauI_D))/(s*tauI_D);
% sysOL_D     = sysMotD*sysDelayApp*sysPI_D;
% sysCL_D     = minreal(sysOL_D/(sysOL_D+1));
% figure;
% step(sysCL_D);
% 
% tr_d_axis       = 0.00204 - 0.000231;
% BW_CC_d_axis    = 0.35/tr_d_axis;

%% evaluation performance q-axis
% sysMotQ     = 1/(mot.param.resistance + s * mot.param.ind_Q);
% sysDelayApp = 1/(1 + s*1.5*inverter.param.timeSwitching);
% tauI_Q      =contr_Q.param.propGain/contr_Q.param.intGain;
% sysPI_Q     =(contr_Q.param.propGain*(1+s*tauI_Q))/(s*tauI_Q);
% sysOL_Q     =sysMotQ*sysDelayApp*sysPI_Q;
% sysCL_Q     =minreal(sysOL_D/(sysOL_D+1));
% figure;
% step(sysCL_Q);
% 
% in this case the BW_CC_q_axis = BW_CC_d_axis

%% zero-pole cancellation (ZPC)
[curr_ZPC_propGain, curr_ZPC_intGain] = getPI_LAE_ZPC(mot.param.ind_Q, mot.param.resistance, contrInfo_curr.phim, 1.5*inverter.param.timeSwitching);

%% if we have a map of differential inductances for d-axis
% propMap_D    = zeros(10,10);
% intMap_D     = zeros(10,10);
% gain_D     = 1/mot.param.resistance;
% pole2_D    = 1.5*inverter.param.timeSwitching;
% 
% for dd = 1:length(mot.maps.currVecInd_D)
%     for qq = 1:length(mot.maps.currVecInd_Q)
%         pole1_D = mot.maps.indMap_D(dd,qq)/mot.param.resistance;
%         [propMap_D(dd,qq), intMap_D(dd,qq)]  = getPI_LAE(gain_D, pole1_D, pole2_D, contrInfo_curr.contrSettings);
%     end
% end

%% if we have a map of differential inductances for q-axis
% propMap_Q    = zeros(10,10);
% intMap_Q     = zeros(10,10);
% gain_Q     = 1/mot.param.resistance;
% pole2_Q    = 1.5*inverter.param.timeSwitching;
% 
% for dd = 1:length(mot.maps.currVecInd_D)
%     for qq = 1:length(mot.maps.currVecInd_Q)
%         pole1_Q = mot.maps.indMap_Q(dd,qq)/mot.param.resistance;
%         [propMap_Q(dd,qq), intMap_Q(dd,qq)]  = getPI_LAE(gain_Q, pole1_Q, pole2_Q, contrInfo_curr.contrSettings);
%     end
% end


