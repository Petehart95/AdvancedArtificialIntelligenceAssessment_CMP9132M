% Task 1a Script | Advanced Artificial Intelligence | CMP9132M
% 12421031 | Peter Hart

%Clear workspace variables
clear;

% Gather user input for the following three probabilities
% P(d) 
prompt = 'What is P(d)? ';
pd = input(prompt);

% P(t|d) 
prompt = 'What is P(t|d)? ';
ptd = input(prompt);

% P(¬t|¬d)
prompt = 'What is P(¬t|¬d)? ';
p_t_d = input(prompt);


%Bayes Rule = P(A|B) = P(B|A)P(A)/P(B)

%P(¬d)
p_d = 1 - pd;

%P(¬t|d)
p_td = 1 - p_t_d;

%P(t)
pt = (ptd*pd)+(p_td*p_d);

%P(d|t)
pdt = (ptd*pd) / pt;