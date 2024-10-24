function [output1] = f_cos(input1)

switch input1
    case 0
        output1=1;
    case 1
        output1=0.5;
    case 2
        output1=-0.5;
    case 3
        output1=-1;
    case 4
        output1=-0.5;
    case 5
        output1=0.5;
    case 6
        output1=1;
    otherwise
        error('error');
end

end