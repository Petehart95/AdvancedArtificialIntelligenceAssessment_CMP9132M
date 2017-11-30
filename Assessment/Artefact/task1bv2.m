% Task 1b Script | Advanced Artificial Intelligence | CMP9132M
% 12421031 | Peter Hart

% Clear the workspace and command window.
clear;clc;

% Bayesian Network:
%P(B)        P(E)
%   \       /
%    \     /
%      P(A)
%    /     \
%   /       \
%P(J)        P(M)

% Input array:
%        A,     M,     J,     B,     E;
input = [true,  true,  true,  true,  false;
         false, false, false, false, false;
         true,  true,  false, false, true;
         false, false, true,  false, false;
         false, false, false, false, false;
         false, false, false, false, false;
         true,  true,  true,  true,  false;
         true,  true,  true,  true,  false;
         false, false, false, false, true;
         true,  true,  true,  false, true];

%Variables storing dimensions of input array
totalRow = size(input,1);
totalCol = size(input,2);
  
%Store column values for each variable to simplify referencing
colA = 1; colM = 2; colJ = 3; colB = 4; colE = 5;  

% Conditional Probability Tables (CPT)
Pb = varOneMLE(input,colB,1); P_b = varOneMLE(input,colB,0); %P(B)
Pe = varOneMLE(input,colE,1); P_e = varOneMLE(input,colE,0); %P(E)

Pabe = varThreeMLE(input,colA,colB,colE,1,1,1); P_abe = varThreeMLE(input,colA,colB,colE,0,1,1); %P(A)
Pab_e = varThreeMLE(input,colA,colB,colE,1,1,0); P_ab_e = varThreeMLE(input,colA,colB,colE,0,1,0);
Pa_be = varThreeMLE(input,colA,colB,colE,1,0,1); P_a_be = varThreeMLE(input,colA,colB,colE,0,0,1);
Pa_b_e = varThreeMLE(input,colA,colB,colE,1,0,0); P_a_b_e = varThreeMLE(input,colA,colB,colE,0,0,0);

Pja = varTwoMLE(input,colJ,colA,1,1); P_ja = varTwoMLE(input,colJ,colA,0,1); %P(J)
Pj_a = varTwoMLE(input,colJ,colA,1,0); P_j_a = varTwoMLE(input,colJ,colA,0,0);

Pma = varTwoMLE(input,colM,colA,1,1); P_ma = varTwoMLE(input,colM,colA,0,1); %P(M)
Pm_a = varTwoMLE(input,colM,colA,1,0); P_m_a = varTwoMLE(input,colM,colA,0,0);

keySetB = {'+b','-b'};
valueSetB = [Pb,P_b];
varB = containers.Map(keySetB,valueSetB);

keySetE = {'+e','-e'};
valueSetE = [Pe,P_e];
varE = containers.Map(keySetE,valueSetE);

keySetA = {'+a|+b+e', '+a|+b-e','+a|-b+e','+a|-b-e','-a|+b+e','-a|+b-e','-a|-b+e','-a|-b-e'};
valueSetA = [Pabe, Pab_e, Pa_be, Pa_b_e, P_abe, P_ab_e, P_a_be, P_a_b_e];
varA = containers.Map(keySetA,valueSetA);

keySetJ = {'+j|+a','+j|-a','-j|+a','-j|-a'};
valueSetJ = [Pja,Pj_a,P_ja,P_j_a];
varJ = containers.Map(keySetJ,valueSetJ);

keySetM = {'+m|+a','+m|-a','-m|+a','-m|-a'};
valueSetM = [Pma, Pm_a, P_ma, P_m_a];
varM = containers.Map(keySetM,valueSetM);

% Inference by Enumeration
%P(b|j,m)
X1 = Pb*(Pe*(Pabe*Pja*Pma+P_abe*Pj_a*Pm_a)+(P_e*(Pab_e*Pja*Pma+P_ab_e*Pj_a*Pm_a)));
%P(�b|j,m)
X2 = P_b*(Pe*(Pa_be*Pja*Pma+P_a_be*Pj_a*Pm_a)+(P_e*(Pa_b_e*Pja*Pma+P_a_b_e*Pj_a*Pm_a)));

% Normalisation
Pbjm = 1/(X1+X2)*X1;
P_bjm = 1/(X1+X2)*X2;


N = 10000;
for i=1:N
    event = [];
    sampledValueB = sampleVariable(varB, 'b');
    event = [event, sampledValueB];

    sampledValueE = sampleVariable(varE, 'e');
    event = [event, sampledValueE];

    conditionalA = strcat('a|',sampledValueB,sampledValueE);
    sampledValueA = sampleVariable(varA, conditionalA);
    sampledValueA_split = extractBefore(sampledValueA,'|');
    event = [event, sampledValueA_split];

    conditionalJ = strcat('j|',sampledValueA_split);
    sampledValueJ = sampleVariable(varJ, conditionalJ);
    sampledValueJ_split = extractBefore(sampledValueJ,'|');
    event = [event, sampledValueJ_split];

    conditionalM = strcat('m|',sampledValueA_split);
    sampledValueM = sampleVariable(varM, conditionalM);
    sampledValueM_split = extractBefore(sampledValueM,'|');
    event = [event,sampledValueM_split];
    disp(event);
end

function sampledValue = sampleVariable(vari, value)
    sampledValue = '';
    randnum = rand();
    value1 = '';
    value2 = '';
   % for i=1:size(vari,1)
        
        value1 = vari(strcat('+',value)); %here
        value2 = vari(strcat('-',value));
    if randnum<value1
        sampledValue = strcat('+',value);
    else
        sampledValue = strcat('-',value);
    end
    %end
end

% Parameter Learning Functions: Maximum Likelihood Estimation (MLE)
% One Variable MLE Function
function P = varOneMLE (X,colx,valx)
    %Variable for counting number of instances a value appears (e.g. T/F)
    x1 = 0;
    %Calculate number of observations which will be considered
    N = size(X,1);
    %For all of the observations in the input dataset
    for i=1:N
        %If this value is equal to value that is being counted
        if X(i,colx) == valx
            %Add one to the counter variable
            x1 = x1 + 1;
        end
    end
    %Once all instances have been counted, conduct MLE calculation
    %P(X = x) = count(x) + 1 / count(X) + |X|
    %(where |X| = domain size of variable X. Domain size = number of possible values for this variable.)
    P = (x1 + 1) / (N + 2); 
end

%Two Variable MLE Function
function P = varTwoMLE (X,colx,coly,valx,valy)
    %Variables for counting number of instances a value appears (e.g. T/F)
    x1 = 0; x2 = 0;
    N = size(X,1);
    %For all of the observations in the input dataset
    for i=1:N
        if X(i,colx) == valx && X(i,coly) == valy
            x1 = x1 + 1;
        end
        if X(i,coly) == valy
            x2 = x2 + 1;
        end
    end
    P = (x1 + 1) / (x2 + 2);
end

%Three Variable MLE Function
function P = varThreeMLE (X,colx,coly,colz,valx,valy,valz)
    x1 = 0; x2 = 0;
    N = size(X,1);
    for i=1:N
        if X(i,colx) == valx && X(i,coly) == valy && X(i,colz) == valz
            x1 = x1 + 1;
        end
        if X(i,coly) == valy && X(i,colz) == valz
            x2 = x2 + 1;
        end
    end
    P = (x1 + 1) / (x2 + 2);
end

%end of script