function g_AB = DQ2AB(g_DQ, pos_E)

% get matrix
T_DQAB = [cos(pos_E) -sin(pos_E);...
           sin(pos_E) cos(pos_E)];
     
% get output
g_AB    = T_DQAB*g_DQ;

end
