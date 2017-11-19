% Task 2 Script | Advanced Artificial Intelligence | CMP9132M
% 12421031 | Peter Hart

%Clear workspace variables
clear;

% ON/OFF Transition Probabilities
T = [0.75,0.25; 
     0.25,0.75];  
 
% Emission Probabilities
% (Warm, Cold, Hot, Freezing)
Owarm = [0.45,0.0;
         0.0,0.05]; 
Ocold = [0.45,0.0;
         0.0,0.05];
Ohot = [0.05,0.0;
        0.0,0.45];
Ofreezing = [0.05,0.0;
             0.0,0.45];
         
%Starting state probability.
s0 = [0.5,0.5]'; 
%Initialise current state.
st = s0; 
%Variable used for controlling recursive loop.
UIcontinue = 1; 
%Counter variable that will be used for tracking current state value.
ctr =  1;

%While the user wants to input more values...
while (UIcontinue == 1)
    %Clear command window.
    clc; 
    %Display probability values of previous state.
    UI = ['s',num2str(ctr-1), ' = ']; 
    disp(UI); 
    disp(st);
    %Gather user input for current state selection
    UI = ['What is the value of s', num2str(ctr), ' ? (warm, cold, hot, freezing)'];
    disp(UI); 
    prompt = ' ';
    %Store user input in variable i. Convert string to lowercase.
    i = lower(input(prompt,'s'));
    

    % Compute current state probabilities depending on which emission
    % probability is selected by the user.
    % st = Ot * T' * st-1
    if (strcmp(i,"warm") == 1)
        st = Owarm * T' * s0;
    elseif (strcmp(i,"cold") == 1)
        st = Ocold * T' * s0;
    elseif (strcmp(i,"hot") == 1)
        st = Ohot * T' * s0;
    elseif (strcmp(i,"freezing") == 1)
        st = Ofreezing * T' * s0;
    else
        %If user has made a mistake, ask for more input.
        disp("Invalid input.");
        continue;
    end
    
    %Computation successful. Display the computed probability results.
    disp(st);
    totalProb = st(1) + st(2);
    UI = ['s', num2str(ctr), ' Total Probability = ', num2str(totalProb), ' '];
    disp(UI);
    
    %Ask user if they wish to exit the program.
    disp('Would you like to continue? (Y/N)');
    prompt = ' ';
    i = lower(input(prompt,'s'));
    
    if strcmp(i,'y') == 1
        UIcontinue = 1;
        %Increase current state counter.
        ctr = ctr + 1;
        %Store the calculated probabilites of the current state in s0(st-1)
        %to ensure first-order Markov assumption.
        s0 = st;
    elseif strcmp(i,'n') == 1
        UIcontinue = 0;
    else
        UIcontinue = 0;
        disp("Invalid input. Exiting...");
    end
end
%end of script