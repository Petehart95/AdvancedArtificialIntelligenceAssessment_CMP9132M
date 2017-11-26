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



% Parameter Learning (developing new CPT)

% Input array:
%     A, M, J, B, E;
bn = [1, 1, 1, 1, 0;
      0, 0, 0, 0, 0;
      1, 1, 0, 0, 1;
      0, 0, 1, 0, 0;
      0, 0, 0, 0, 0;
      0, 0, 0, 0, 0;
      1, 1, 1, 1, 0;
      1, 1, 1, 1, 0;
      0, 0, 0, 0, 1;
      1, 1, 1, 0, 1];

CPT = 

%Variables storing dimensions of input array
totalRow = size(bn,1);
totalCol = size(bn,2);
  
%Store column values for each variable to simplify referencing
colA = 1; colM = 2; colJ = 3; colB = 4; colE = 5;  

% Conditional Probability Table (CPT)
Pb = varOneMLE(bn,colB,1); P_b = varOneMLE(bn,colB,0); %P(B)

Pe = varOneMLE(bn,colE,1); P_e = varOneMLE(bn,colE,0); %P(E)

Pabe = varThreeMLE(bn,colA,colB,colE,1,1,1); P_abe = varThreeMLE(bn,colA,colB,colE,0,1,1); %P(A)
Pab_e = varThreeMLE(bn,colA,colB,colE,1,1,0); P_ab_e = varThreeMLE(bn,colA,colB,colE,0,1,0);
Pa_be = varThreeMLE(bn,colA,colB,colE,1,0,1); P_a_be = varThreeMLE(bn,colA,colB,colE,0,0,1);
Pa_b_e = varThreeMLE(bn,colA,colB,colE,1,0,0); P_a_b_e = varThreeMLE(bn,colA,colB,colE,0,0,0);

Pja = varTwoMLE(bn,colJ,colA,1,1); P_ja = varTwoMLE(bn,colJ,colA,0,1); %P(J)
Pj_a = varTwoMLE(bn,colJ,colA,1,0); P_j_a = varTwoMLE(bn,colJ,colA,0,0);

Pma = varTwoMLE(bn,colM,colA,1,1); P_ma = varTwoMLE(bn,colM,colA,0,1); %P(M)
Pm_a = varTwoMLE(bn,colM,colA,1,0); P_m_a = varTwoMLE(bn,colM,colA,0,0);

% Inference by Enumeration
%P(b|j,m)
X1 = Pb*(Pe*(Pabe*Pja*Pma+P_abe*Pj_a*Pm_a)+(P_e*(Pab_e*Pja*Pma+P_ab_e*Pj_a*Pm_a)));
%P(�b|j,m)
X2 = P_b*(Pe*(Pa_be*Pja*Pma+P_a_be*Pj_a*Pm_a)+(P_e*(Pa_b_e*Pja*Pma+P_a_b_e*Pj_a*Pm_a)));

% Normalisation
Pbjm = 1/(X1+X2)*X1;
P_bjm = 1/(X1+X2)*X2;
    
function P = varOneMLE (X,colx,valx)
    x1 = 0;
    N = size(X,1);
    for i=1:N
        if X(i,colx) == valx
            x1 = x1 + 1;
        end
    end
    P = (x1 + 1) / (N + 2); 
end

function P = varTwoMLE (X,colx,coly,valx,valy)
    x1 = 0; x2 = 0;
    N = size(X,1);
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