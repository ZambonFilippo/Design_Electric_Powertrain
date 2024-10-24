function [output1] = f_sin(input1)

switch input1
    case 0
        output1=0;
    case 1
        output1=0.8660254038;
    case 2
        output1=0.8660254038;
    case 3
        output1=0;
    case 4
        output1=-0.8660254038;
    case 5
        output1=-0.8660254038;
    case 6
        output1=0;
    otherwise
        error('error');
end

end

