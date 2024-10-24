function  [duties, voltRefSat_AB, satIsOn] = SVM(voltRef_AB, voltBus, inverter)
duties          = ones(3,1)*0.5;
voltRefSat_AB   = zeros(2,1);
volt_ABC        = zeros(3,1);
satIsOn         = zeros(2,1);
mod_voltRef_AB  = sqrt(voltRef_AB(1,1)*voltRef_AB(1,1) + voltRef_AB(2,1)*voltRef_AB(2,1));
k               = 1/sqrt(3);
k_sat_es        = 1;
k_sat_cir       = 1;
T_pwm           = inverter.param.timeSwitching * sqrt(3);
m               = 0;
t_0             = 0;
t_1             = 0;
t_2             = 0;

% identify sector
if(voltRef_AB(2,1) > 0.0)
    if(voltRef_AB(1,1) > voltRef_AB(2,1)*k)
        if (voltRef_AB(1) > 0.0)
            m = 1;
        else 
            m = 3;
        end
    else
            m = 2;
    end
else
    if(voltRef_AB(1,1) > voltRef_AB(2,1)*k)
        if(voltRef_AB(1,1)>0.0)
            m = 6;
        else
            m = 4;
        end
    else
        m = 5;
    end
end

if(inverter.param.satCircleOn)
        % check circle saturation
        if(mod_voltRef_AB > voltBus*k)
            SatIsOn = ones(2,1);
            k_sat_cir = voltBus*k/mod_voltRef_AB;
            voltRefSat_AB = k_sat_cir * voltRef_AB;
        else
             voltRefSat_AB = voltRef_AB; %faccio quest'operazione per calcolare t_0, t_1, t_2
        end
end
% calculate t_0, t_1, t_2
if (voltBus > 0.2)
    t_1 = T_pwm / voltBus *(voltRefSat_AB(1,1) * sin(m*pi/3) - voltRefSat_AB(2,1) * cos(m*pi/3));
    if ((m-1) > 0)
        t_2 = T_pwm / voltBus *(-voltRefSat_AB(1,1) * sin((m-1)*pi/3) - voltRefSat_AB(2,1) * cos((m-1)*pi/3));
    else
        t_2 = T_pwm / voltBus *(-voltRefSat_AB(1,1) * sin(6*pi/3) + voltRefSat_AB(2,1) * cos(6*pi/3));
    end
end

% check hexagon saturation
% if(inverter.param.satCircleOn == 0)
if ((t_1 + t_2) >inverter.param.timeSwitching)
    satIsOn = ones(2,1);
    k_sat_es = inverter.param.timeSwitching / (t_1 + t_2);
    t_1 = k_sat_es * t_1;
    t_2 = k_sat_es * t_2;
    voltRefSat_AB = k_sat_es * voltRef_AB; 
else
    t_0 = inverter.param.timeSwitching - t_1 - t_2;
end

switch(m)
    case 1
        duties(1,1) = (t_1 + t_2 + t_0/2)*inverter.param.freqSwitching;
        duties(2,1) = (t_2 + t_0/2)*inverter.param.freqSwitching;
        duties(3,1) = (t_0/2)*inverter.param.freqSwitching;
    case 2
        duties(1,1) = (t_1 + t_0/2)*inverter.param.freqSwitching;
        duties(2,1) = (t_1 + t_2 + t_0/2)*inverter.param.freqSwitching;
        duties(3,1) = (t_0/2)*inverter.param.freqSwitching;
    case 3
        duties(1,1) = (t_0/2)*inverter.param.freqSwitching;
        duties(2,1) = (t_1 + t_2 + t_0/2)*inverter.param.freqSwitching;
        duties(3,1) = (t_2 + t_0/2)*inverter.param.freqSwitching;
    case 4
        duties(1,1) = (t_0/2)*inverter.param.freqSwitching;
        duties(2,1) = (t_1 + t_0/2)*inverter.param.freqSwitching;
        duties(3,1) = (t_1 + t_2 + t_0/2)*inverter.param.freqSwitching;
    case 5
        duties(1,1) = (t_2 + t_0/2)*inverter.param.freqSwitching;
        duties(1,1) = (t_0/2)*inverter.param.freqSwitching;
        duties(3,1) = (t_1 + t_2 + t_0/2)*inverter.param.freqSwitching;
    case 6
        duties(1,1) = (t_1 + t_2 + t_0/2)*inverter.param.freqSwitching;
        duties(2,1) = (t_0/2)*inverter.param.freqSwitching;
        duties(3,1) = (t_1 + t_0/2)*inverter.param.freqSwitching;
    otherwise
        duties(1,1) = 0.5;
        duties(2,1) = 0.5;
        duties(3,1) = 0.5;

end
%end
% calculate u_abc
volt_abc = voltBus * duties; 
% volt_abc = voltBus * (duties -0.5);

end

