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

% Conditional Probability Table (CPT)
% Pb = 0.001; P_b = 0.999; %P(B)
% Pe = 0.002; P_e = 0.998; %P(E)
% Pabe = 0.950; P_abe = 0.050; %P(A)
% Pab_e = 0.940; P_ab_e = 0.060;
% Pa_be = 0.290; P_a_be = 0.710;
% Pa_b_e = 0.001; P_a_b_e = 0.999;
% Pja = 0.900; P_ja = 0.100; %P(J)
% Pj_a = 0.050; P_j_a = 0.950;
% Pma = 0.700; P_ma = 0.300; %P(M)
% Pm_a = 0.010; P_m_a = 0.990;

% Inference by Enumeration
%P(b|j,m)
% x1 = Pb*(Pe*(Pabe*Pja*Pma+P_abe*Pj_a*Pm_a)+(P_e*(Pab_e*Pja*Pma+P_ab_e*Pj_a*Pm_a)));
% %P(¬b|j,m)
% x2 = P_b*(Pe*(Pa_be*Pja*Pma+P_a_be*Pj_a*Pm_a)+(P_e*(Pa_b_e*Pja*Pma+P_a_b_e*Pj_a*Pm_a)));
% 
% % Normalisation
% Pbjm = 1/(x1+x2)*x1;
% P_bjm = 1/(x1+x2)*x2;

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

%Variables storing dimensions of input array
totalRow = size(bn,1);
totalCol = size(bn,2);
  
%Perform count operations to conduct Maximum Likelihood Estimation(MLE)
%Store column values for each variable to simplify referencing
colA = 1; colM = 2; colJ = 3; colB = 4; colE = 5;

%Counter variables for counting query variable values
ctrABE = 0; ctrMA = 0; ctrJA = 0; ctrBE = 0;

%Count variables for counting total entries in each individual varible
ctrB = sum(bn(:,colB)); ctrE = sum(bn(:,colE)); ctrA = sum(bn(:,colA));
ctrJ = sum(bn(:,colJ)); ctrM = sum(bn(:,colM));

%Iterate through entire input array
for i=1:totalRow
   %P(a|b,e)
   if bn(i,colA) == 1 && bn(i,colB) == 1 && bn(i,colE) == 1
      ctrABE = ctrABE + 1;
   end
    
   %P(m|a)
   if bn(i,colM) == 1 && bn(i,colA) == 1
      ctrMA = ctrMA + 1;
   end
   
   %P(j|a)
   if bn(i,colJ) == 1 && bn(i,colA) == 1
      ctrJA = ctrJA + 1;
   end
   
   % B,E
   if bn(i,colB) == 1 && bn(i,colE) == 1
       ctrBE = ctrBE + 1;
   end
end

Pb = (ctrB + 1) / (totalRow + 2); 
Pe = (ctrE + 1) / (totalRow + 2);
Pabe = (ctrABE + 1) / (ctrBE + 4);
Pab_e = 0; 
Pa_be = 0; 
Pa_b_e = 0; 
Pja = (ctrJA + 1) / (ctrA + 3); 
Pj_a = 0; 
Pma = (ctrMA + 1) / (ctrM + 3); 
Pm_a = 0; 

%end of script