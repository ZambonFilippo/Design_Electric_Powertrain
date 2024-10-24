function [duties, voltRefSat_AB, satIsOn] = SVM_test(voltRef_AB, voltBus, inverter)

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
        if (voltRef_AB(1,1)>0.0)
            m=1;
        else
            m=3;
        end
    else
        m=2;
    end
else
    if abs(voltRef_AB(1,1))>abs(voltRef_AB(2,1)*c)
        if (voltRef_AB(1,1)>0.0)
            m=6;
        else
            m=4;
        end
    else
        m=5;
    end
end

