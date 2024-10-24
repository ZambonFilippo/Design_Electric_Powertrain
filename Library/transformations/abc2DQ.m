function g_DQ = abc2DQ(g_abc, pos_E)

% get matrix
T_abcDQ = (2/3)*[cos(pos_E) cos(pos_E-2*pi/3) cos(pos_E-4*pi/3);...
               -sin(pos_E) -sin(pos_E-2*pi/3) -sin(pos_E-4*pi/3)];

% get output
g_DQ    = T_abcDQ*g_abc;

end

