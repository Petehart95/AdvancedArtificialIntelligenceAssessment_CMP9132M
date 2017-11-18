clear;

% warm = 1, cold = 2, hot = 3, freezing = 4

%T = {0.75,0.25;
%     0.25,0.75};

%O = {0.45,0.45,0.05,0.05;
%     0.05,0.05,0.45,0.45};
 
%Owarm = {0.45,0.0;0.0,0.05};
%Ocold = {0.45,0.0;0.0,0.05};
%Ohot = {0.05,0.0;0.0,0.45};
%Ofreezing = {0.05,0.0;0.0,0.45};


%st = Ot T' st-1

Omama = [0.4,0.0;
         0.0,0.1];
Opapa = [0.4,0.0;
         0.0,0.1];
Opee = [0.1,0.0;
        0.0,0.4];
Opoo = [0.1,0.0;
        0.0,0.4];
    
T = [0.5,0.5;
     0.8,0.2];  
    
s0 = [0.5,0.5]';

UIcontinue = 1;


ctr =  1;
while (UIcontinue == 1)
    clc;
    UI = ['What is the value of s', num2str(ctr), ' ? (mama, papa, pee, poo)'];
    disp(UI);
    prompt = ' ';
    i = input(prompt,'s');
    
    if (i == 'papa')
        st = Opapa * T' * s0;
    elseif (i == 'mama')
        st = Omama * T' * s0;
    elseif (i == 'pee')
        st = Opee * T' * s0;
    else
        st = Opoo * T' * s0;
    end
    
    totalProb = st(1) + st(2);
    
    UI = ['s', num2str(ctr), ' = ', num2str(totalProb), ' '];
    disp(UI);
    disp('Would you like to continue? (Y/N)');
    prompt = ' ';
    
    i = input(prompt,'s');
    
    if i == 'N'
        UIcontinue = 0;
    end
    
    ctr = ctr + 1;
    s0 = st;
end


% n = [];
% 
% prompt = 'What is the size of the input sequence? ';
% n = input(prompt);



% for ctr=1:4
%     clc;
%     UI = ['What is the value of s', ctr, ' ? (mama, papa, pee, poo)'];
%     disp(UI);
%     prompt = ' ';
%     in = input(prompt,'s');
%     
%     n = n + in;
%     if ctr < 4
%         n = n + ' ';
%     end
% end


