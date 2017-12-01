% Task 1a Script | Advanced Artificial Intelligence | CMP9132M
% 12421031 | Peter Hart

%Clear workspace variables and command window.
clear;clc;

% Variables involved in this solution can be defined as:
% d = the person has the disease.
% t = the test is positive. 

% The solution gathers user input for the following three variables:

% P(d) 
prompt = 'What is P(d)? ';
Pd = input(prompt);

% P(t|d) 
prompt = 'What is P(t|d)? ';
Ptd = input(prompt);

% P(�t|�d)
prompt = 'What is P(�t|�d)? ';
P_t_d = input(prompt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Bayes Rule = P(A|B) = P(B|A)*P(A)/P(B)
%             P(d|t) = P(t|d)*P(d)/P(t)

%P(�d)
P_d = 1 - Pd;

%P(�t|d)
P_td = 1 - P_t_d;

%P(t)
Pt = (Ptd*Pd)+(P_td*P_d);

%P(d|t)
Pdt = (Ptd*Pd) / Pt;

% Output the Results:
disp('P(d|t) = (P(t|d)*P(d))/P(t)');
UI = ['P(d|t) = (',num2str(Ptd), ' * ', num2str(Pd),') / ', num2str(Pt)]; 
disp(UI);
UI = ['P(d|t) = ',num2str(Pdt)];
disp(UI);

%end of script