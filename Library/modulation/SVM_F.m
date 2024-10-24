
function [duties, voltRefSat_AB, satIsOn] = SVM_F(voltRef_AB, voltBus, inverter)

%% STEP 1

% initialize variables 
duties=ones(3,1)*0.5;
voltRefSat_AB=zeros(2,1);
% volt_abc=zeros(3,1);
satIsOn=zeros(2,1);

k=1;
k1=1;
m=0;
Tm=0;
Tm1=0;
T0=0;

% define constant
c=1/sqrt(3);


% if cascade to find m
if voltRef_AB(2,1)>0.0
    if abs(voltRef_AB(1,1))>abs(voltRef_AB(2,1)*c)
        if voltRef_AB(1,1)>0.0
            m=1;
        else
            m=3;
        end
    else
        m=2;
    end
else
    if abs(voltRef_AB(1,1))>abs(voltRef_AB(2,1)*c)
        if voltRef_AB(1,1)>0.0
            m=6;
        else
            m=4;
        end
    else
        m=5;
    end
end

%% STEP 2
c1=sqrt(3)*inverter.param.timeSwitching;

if not(voltBus>0.2)
    error('Bus voltage wrong');
end

% circle saturation
if inverter.param.satCircleOn==1

    if (voltRef_AB(1,1)^2+voltRef_AB(2,1)^2)>((voltBus*c)^2)

        satIsOn=ones(2,1);
        k=(voltBus*c)/(sqrt(voltRef_AB(1,1)^2+voltRef_AB(2,1)^2));
        % voltRefSat_AB(1,1)=voltRef_AB(1,1)*k;
        % voltRefSat_AB(2,1)=voltRef_AB(2,1)*k;
        voltRefSat_AB=k*voltRef_AB;
        Tm=(c1/voltBus)*(voltRefSat_AB(1,1)*sin(m*(pi/3))-voltRefSat_AB(2,1)*cos(m*(pi/3)));
        Tm1=(c1/voltBus)*(-voltRefSat_AB(1,1)*sin((m-1)*(pi/3))+voltRefSat_AB(2,1)*cos((m-1)*(pi/3)));

    else

        % voltRefSat_AB(1,1)=voltRef_AB(1,1);
        % voltRefSat_AB(2,1)=voltRef_AB(2,1);
        voltRefSat_AB=voltRef_AB;
        Tm=(c1/voltBus)*(voltRef_AB(1,1)*sin(m*(pi/3))-voltRef_AB(2,1)*cos(m*(pi/3)));
        Tm1=(c1/voltBus)*(-voltRef_AB(1,1)*sin((m-1)*(pi/3))+voltRef_AB(2,1)*cos((m-1)*(pi/3)));
        T0=inverter.param.timeSwitching-Tm-Tm1;

    end
else
        % voltRefSat_AB(1,1)=voltRef_AB(1,1);
        % voltRefSat_AB(2,1)=voltRef_AB(2,1);
         voltRefSat_AB=voltRef_AB;
        Tm=(c1/voltBus)*(voltRef_AB(1,1)*sin(m*(pi/3))-voltRef_AB(2,1)*cos(m*(pi/3)));
        Tm1=(c1/voltBus)*(-voltRef_AB(1,1)*sin((m-1)*(pi/3))+voltRef_AB(2,1)*cos((m-1)*(pi/3)));
        T0=inverter.param.timeSwitching-Tm-Tm1;

end

%% STEP 3
if T0<0

    k1=inverter.param.timeSwitching/(Tm+Tm1);
    Tm=Tm*k1;
    Tm1=Tm1*k1;
    T0=0;
    satIsOn=ones(2,1);
    voltRefSat_AB(1,1)=voltRef_AB(1,1)*k1;
    voltRefSat_AB(2,1)=voltRef_AB(2,1)*k1;

end

%% STEP 4

switch m
    case 1
        duties(1,1)=(Tm+Tm1+T0/2)*inverter.param.freqSwitching;
        duties(2,1)=(Tm1+T0/2)*inverter.param.freqSwitching;
        duties(3,1)=(T0/2)*inverter.param.freqSwitching;
    case 2
        duties(1,1)=(Tm+T0/2)*inverter.param.freqSwitching;
        duties(2,1)=(Tm+Tm1+T0/2)*inverter.param.freqSwitching;
        duties(3,1)=(T0/2)*inverter.param.freqSwitching;
    case 3
        duties(1,1)=(T0/2)*inverter.param.freqSwitching;
        duties(2,1)=(Tm+Tm1+T0/2)*inverter.param.freqSwitching;
        duties(3,1)=(Tm1+T0/2)*inverter.param.freqSwitching;
    case 4
        duties(1,1)=(T0/2)*inverter.param.freqSwitching;
        duties(2,1)=(Tm+T0/2)*inverter.param.freqSwitching;
        duties(3,1)=(Tm+Tm1+T0/2)*inverter.param.freqSwitching;
    case 5
        duties(1,1)=(Tm1+T0/2)*inverter.param.freqSwitching;
        duties(2,1)=(T0/2)*inverter.param.freqSwitching;
        duties(3,1)=(Tm+Tm1+T0/2)*inverter.param.freqSwitching;
    case 6
        duties(1,1)=(Tm+Tm1+T0/2)*inverter.param.freqSwitching;
        duties(2,1)=(T0/2)*inverter.param.freqSwitching;
        duties(3,1)=(Tm+T0/2)*inverter.param.freqSwitching;
    otherwise
        duties(1,1)=0.5;
        duties(2,1)=0.5;
        duties(3,1)=0.5;
end

% volt_abc=(duties-ones(3,1)*0.5)*voltBus;
% volt_abc=voltBus*duties;

end




