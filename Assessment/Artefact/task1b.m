% Task 1b Script | Advanced Artificial Intelligence | CMP9132M
% 12421031 | Peter Hart

% Clear the workspace and command window.
clear;clc;

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
% Values for each prior and conditional probability have been 
% calculated using Parameter Learning. (where 1 = true, 0 = false)

%P(+b)                       
Pb = varOneMLE(input,colB,1); 
%P(-b)
P_b = varOneMLE(input,colB,0); 

%P(+e)                        
Pe = varOneMLE(input,colE,1); 
%P(-e)
P_e = varOneMLE(input,colE,0); 

%P(+j|+a)                             
Pja = varTwoMLE(input,colJ,colA,1,1); 
%P(-j|+a)
P_ja = varTwoMLE(input,colJ,colA,0,1); 
%P(+j|-a)                             
Pj_a = varTwoMLE(input,colJ,colA,1,0); 
%P(-j|-a)
P_j_a = varTwoMLE(input,colJ,colA,0,0);

%P(+m|+a)                             
Pma = varTwoMLE(input,colM,colA,1,1); 
%P(-m|+a)
P_ma = varTwoMLE(input,colM,colA,0,1); 
%P(+m|-a)                             
Pm_a = varTwoMLE(input,colM,colA,1,0); 
%P(-m|-a)
P_m_a = varTwoMLE(input,colM,colA,0,0);

%P(+a|+b,+e)                                    
Pabe = varThreeMLE(input,colA,colB,colE,1,1,1); 
%P(-a|+b,+e)
P_abe = varThreeMLE(input,colA,colB,colE,0,1,1); 
%P(+a|+b,-e)                                    
Pab_e = varThreeMLE(input,colA,colB,colE,1,1,0); 
%P(-a|+b,-e)
P_ab_e = varThreeMLE(input,colA,colB,colE,0,1,0);
%P(+a|-b,+e)                                    
Pa_be = varThreeMLE(input,colA,colB,colE,1,0,1); 
%P(-a|-b,+e)
P_a_be = varThreeMLE(input,colA,colB,colE,0,0,1);
%P(+a|-b,-e)                                    
Pa_b_e = varThreeMLE(input,colA,colB,colE,1,0,0); 
%P(-a|-b,-e)
P_a_b_e = varThreeMLE(input,colA,colB,colE,0,0,0);

% Data Dictionary:
%Store values from the conditional probability table into the data
%dictionary. Values for each conditional probability will be mapped to a
%key
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

%sampleSize = total amount of samples to be generated for rejection
%sampling
sampleSize = 100000;
Pbjm = rejectionSampling(varB,varE,varA,varM,varJ,sampleSize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Output the results:
%P(b|j,m)
UI = ['P(+b|+j,+m) = ', num2str(Pbjm(1))];
disp(UI);

%P(-b|j,m)
UI = ['P(-b|+j,+m) = ', num2str(Pbjm(2))];
disp(UI);

function P = rejectionSampling(varB,varE,varA,varM,varJ,N)

    %Variable for counting positive cases where the sample is consistent with
    %the evidence
    n1 = 0;
    %Variable for counting negative cases where the sample is consistent with
    %the evidence
    n2 = 0;

    %for each sample that will be generated
    for i=1:N
        %Obtain a random sample for P(b)
        sampledValueB = priorSample(varB, 'b');
        %Obtain a random sample for P(e)
        sampledValueE = priorSample(varE, 'e');

        %Obtain a random sample for P(a|b,e), using prior probabilities
        %generated
        conditionalA = strcat('a|',sampledValueB,sampledValueE);
        sampledValueA = priorSample(varA, conditionalA);
        %Only store the randomly generated 'a' value. (+a or -a)
        sampledValueA_Q = extractBefore(sampledValueA,'|'); 

        %Obtain a random sample for P(j|a), using the previous conditional
        %probability that was randomly generated.
        conditionalJ = strcat('j|',sampledValueA_Q);
        sampledValueJ = priorSample(varJ, conditionalJ);
        %Only store the randomly generated 'j' value. (+j or -j)
        sampledValueJ_Q = extractBefore(sampledValueJ,'|');

        %Obtain a random sample for P(m|a), using the previous conditional
        %probability that was randomly generated.
        conditionalM = strcat('m|',sampledValueA_Q);
        sampledValueM = priorSample(varM, conditionalM);
        %Only store the randomly generated 'm' value. (+m or -m)
        sampledValueM_Q = extractBefore(sampledValueM,'|');

        %Check to see if the values generated in the sample are consistent with
        %the conditional probability being estimated.

        %First check if the evidence variables are consistent.
        %For example: a sample containing -j, +m != P(b|j,m), and therefore
        %would be rejected.
        x1 = isConsistent('+j', sampledValueJ_Q);
        x2 = isConsistent('+m', sampledValueM_Q);
        if x1 > 0 && x2 > 0
           %If evidence variables are consistent, check the value of the query
           %variable and add one count for which case it belongs to.
           x3 = isConsistent('+b',sampledValueB);

           if x3 > 0
               %If sample contains a positive case, add one to this counter.
               n1 = n1 + 1;
           else
               %Otherwise add one to the counter for the negative case.
               n2 = n2 + 1;
           end
        end
    end

    %Once all samples have been considered, normalise the count values into
    %a probability.
    Pbjm = normalise(n1,n2);
    P_bjm = normalise(n2,n1);

    %Check to see if the normalised values sum to 1.
    if (Pbjm + P_bjm) ~= 1
        disp('Error! Values did not normalise correctly!');
    end
    
    %Final estimated probability output.
    P = [Pbjm,P_bjm];
end

%Normalisation Function
function n = normalise(count1,count2)
    n = 1 / (count1+count2) * count1;
end

%Sample Check Function
function x = isConsistent(e,sample)
    x = 0;
    %If the value in the sample is equal to the queried value
    if e == sample
        %Return with 1, indicating a match was found.
        x = x + 1;
    else
        %else return with 0, indicating a match was not found.
        x = 0;
    end
end

%Prior Sample Function
function sampledVariable = priorSample(var, value)
    % Generate a random number between 0 and 1.
    randnum = rand();
    
    %Acquire conditional probability value by referencing the key of the
    %respective variable in the data dictionary.
    value1 = var(strcat('+',value)); 
    
    %If the randomly generated value is lower than the probability stored
    %in the data dictionary, then:
    if randnum<value1
        %Generate this as a positive sample.
        sampledVariable = strcat('+',value);
    else
        %Generate this as a negative sample.
        sampledVariable = strcat('-',value);
    end
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
    %x1 = x|y
    x1 = 0; 
    %x2 = y
    x2 = 0;
    
    %N = total observations
    N = size(X,1);
    %For all of the observations in the input dataset
    for i=1:N
        %If x AND y match their respective values 
        if X(i,colx) == valx && X(i,coly) == valy
            %Add 1 to the counter
            x1 = x1 + 1;
        end
        %If y matches its respective value
        if X(i,coly) == valy
            %Add 1 to the counter
            x2 = x2 + 1;
        end
    end
    %Once all instances have been counted, conduct MLE calculation
    %P(x|y) = count(x|y)+1 / count(y)+|X|
    %(where |X| = domain size of variable X. Domain size = number of possible values for this variable.)
    P = (x1 + 1) / (x2 + 2);
end

%Three Variable MLE Function
function P = varThreeMLE (X,colx,coly,colz,valx,valy,valz)
    %Variables for counting number of instances a value appears (e.g. T/F)
    %x1 = x|y,z 
    x1 = 0; 
    %x2 = y,z
    x2 = 0;
    
    %N = total observations.
    N = size(X,1);
    %For all of the observations in the input dataset
    for i=1:N
        %If z AND y AND z match their respective values 
        if X(i,colx) == valx && X(i,coly) == valy && X(i,colz) == valz
            %Add 1 to this counter
            x1 = x1 + 1;
        end
        %If y AND z match to their respective values
        if X(i,coly) == valy && X(i,colz) == valz
            %Add 1 to this counter
            x2 = x2 + 1;
        end
    end
    %Once all instances have been counted, conduct MLE calculation
    %P(x|y,z) = count(x|y,z)+1 / count(y,z)+|X|
    %(where |X| = domain size of variable X. Domain size = number of possible values for this variable.)
    P = (x1 + 1) / (x2 + 2);
end

%end of script