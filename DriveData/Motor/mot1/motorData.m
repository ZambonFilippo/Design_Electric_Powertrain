

%% Electric Data
mot.param.resistance    =0.285; % (ohm) Staor resistance
mot.param.ind_D         =0.32e-3; % (H) d-axis inductance
mot.param.ind_Q         =0.32e-3; % (H) q-axis inductance
mot.param.fluxPM        =0.0068; % (Vs) PM flux linkage

%% Mechanical Data
mot.param.pp            =5; % Motor pole pairs
mot.param.inertiaM      =1.807e-6; % (kgms^2) Motor inertia
%mot.param.inertiaM      =1.807e-6+1e9; % (kgms^2) Motor inertia
mot.param.frictionM     =2.8e-5; % (N*m*s/rad) Viscous friction

mot.param.torqConst     =1.5*mot.param.pp*mot.param.fluxPM;

%% Matrices for the mechanical model

mot.param.Amech         =[-mot.param.frictionM/mot.param.inertiaM 0;...
                            1                                     0];
mot.param.Bmech         =[1/mot.param.inertiaM; 0];
mot.param.Cmech         =eye(2);
mot.param.Dmech         =[0; 0];
%% Rated Values
mot.rated.curr          =4.53; % (A)
mot.rated.speed_rads_M =292; % (rads)

%% Maps
mot.maps.currVec_D      =linspace(-1,1,10)*mot.rated.curr;
mot.maps.currVec_Q      =linspace(-3,3,30)*mot.rated.curr;


% HP: no magnetic saturation and no cross-saturation
mot.maps.fluxVec_D      =mot.param.fluxPM+...
                         mot.param.ind_D*mot.maps.currVec_D;
mot.maps.fluxVec_Q      =mot.param.ind_Q*mot.maps.currVec_Q;

[mot.maps.currMap_D,mot.maps.currMap_Q] =meshgrid(mot.maps.currVec_D,mot.maps.currVec_Q);

% comandi per effetuare una verifica
% surf(mot.maps.fluxVec_D, mot.maps.fluxVec_Q, mot.maps.currMap_D);
% figure;
% surf(mot.maps.fluxVec_D, mot.maps.fluxVec_Q, mot.maps.currMap_Q);

% maps for fcem
% mot.maps.posE_Vec       =linspace(0, 2*pi*5, 1200);


%% Maps for differential inductances
% mot.maps.currVecInd_D      =linspace(-1, 1, 10)*mot.rated.curr;
% mot.maps.currVecInd_Q      =linspace(-1, 1, 10)*mot.rated.curr;
% 
% [mot.maps.indMap_D, mot.maps.indMap_Q] = meshgrid(mot.maps.currVecInd_D, mot.maps.currVecInd_Q);
% L_d = sin(sqrt(mot.maps.indMap_D.^2 + mot.maps.indMap_Q.^2));  % d-axis inductance data
% L_q = cos(sqrt(mot.maps.indMap_D.^2 + mot.maps.indMap_Q.^2));  % q-axis inductance data

% Plot the map of d-axis inductances
% figure;
% surf(mot.maps.indMap_D, mot.maps.indMap_Q, L_d);
% title('Map of d-axis Differential Inductances');
% xlabel('i_d');
% ylabel('i_q');
% zlabel('Inductance (H)');

% Plot the map of q-axis inductances
% figure;
% surf(mot.maps.indMap_D, mot.maps.indMap_Q, L_q);
% title('Map of q-axis Differential Inductances');
% xlabel('i_d');
% ylabel('i_q');
% zlabel('Inductance [H]');



