function g_abc = DQ2abc(g_DQ, pos_E)

% get matrix
T_DQabc = [cos(pos_E)           -sin(pos_E);...
           cos(pos_E-2*pi/3)    -sin(pos_E-2*pi/3);...
           cos(pos_E-4*pi/3)    -sin(pos_E-4*pi/3)];

% get output
g_abc    = T_DQabc*g_DQ;

end