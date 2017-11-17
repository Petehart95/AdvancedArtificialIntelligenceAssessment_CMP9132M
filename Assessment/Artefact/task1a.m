clear;

%https://www.eecs.qmul.ac.uk/~norman/BBNs/Bayes_rule.htm

prompt = 'What is P(d)? ';
pd = input(prompt);

prompt = 'What is P(t|d)? ';
ptd = input(prompt);

prompt = 'What is P(¬t|¬d)? ';
p_t_d = input(prompt);

%P(¬d)
p_d = 1 - pd;

%P(¬t|d)
p_td = 1 - p_t_d;

%P(t)
pt = (ptd*pd)+(p_td*p_d);

%P(d|t)
pdt = (ptd*pd) / pt;