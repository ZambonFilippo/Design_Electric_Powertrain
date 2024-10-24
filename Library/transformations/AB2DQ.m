function g_DQ = AB2DQ(g_AB, pos_E)

% get matrix
T_ABDQ   = [cos(pos_E) sin(pos_E);...
           -sin(pos_E) cos(pos_E)];



% get output
g_DQ    = T_ABDQ*g_AB;

end
