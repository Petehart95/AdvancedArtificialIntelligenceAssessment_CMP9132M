% Task 1b Script | Advanced Artificial Intelligence | CMP9132M
% 12421031 | Peter Hart

%Clear the workspace and command window.
clear;clc;

%Bayesian Network:
%P(B)        P(E)
%   \       /
%    \     /
%      P(A)
%    /     \
%   /       \
%P(J)        P(M)

%Conditional Probability Table (CPT)
Pb = 0.001; P_b = 0.999; %P(B)
Pe = 0.002; P_e = 0.998; %P(E)
Pabe = 0.950; P_abe = 0.050; %P(A)
Pab_e = 0.940; P_ab_e = 0.060;
Pa_be = 0.290; P_a_be = 0.710;
Pa_b_e = 0.001; P_a_b_e = 0.999;
Pja = 0.900; P_ja = 0.100; %P(J)
Pj_a = 0.050; P_j_a = 0.950;
Pma = 0.700; P_ma = 0.300; %P(M)
Pm_a = 0.010; P_m_a = 0.990;

%Inference by Enumeration
%P(b|j,m)
Pbjm = Pb*(Pe*(Pabe*Pja*Pma+P_abe*Pj_a*Pm_a)+(P_e*(Pab_e*Pja*Pma+P_ab_e*Pj_a*Pm_a)));
%P(¬b|j,m)
P_bjm = P_b*(Pe*(Pa_be*Pja*Pma+P_a_be*Pj_a*Pm_a)+(P_e*(Pa_b_e*Pja*Pma+P_a_b_e*Pj_a*Pm_a)));

%Normalisation
A = 1/(Pbjm+P_bjm)*Pbjm;
B = 1/(Pbjm+P_bjm)*P_bjm;