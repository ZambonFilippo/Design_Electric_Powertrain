function g_AB = abc2AB(g_abc)

% get matrix
T_abcAB = (2/3)*[1 -1/2 -1/2;...
                 0 sqrt(3)/2 -(sqrt(3)/2)];
     
% get output
g_AB    = T_abcAB*g_abc;

end
