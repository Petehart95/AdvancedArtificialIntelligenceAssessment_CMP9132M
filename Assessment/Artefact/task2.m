clear;

% warm = 1, cold = 2, hot = 3, freezing = 4

%X = {0.75,0.25;0.25,0.75};
%XRowNames = {'On','Off'};
%XColNames = {'On','Off'};
%XTable = array2table(X,'RowNames',XRowNames,'VariableNames',XColNames);

%e = {0.45,0.45,0.05,0.05;0.05,0.05,0.45,0.45};
%eRowNames = {'On', 'Off'};
%eColNames = {'Warm','Cold','Hot','Freezing'};
%eTable = array2table(e,'RowNames',eRowNames,'VariableNames',eColNames);


X = {0.5,0.5;0.8,0.2};
XRowNames = {'clean','dirty'};
XColNames = {'clean','dirty'};
XTable = array2table(X,'RowNames',XRowNames,'VariableNames',XColNames);

e = {0.4,0.4,0.1,0.1;0.1,0.1,0.4,0.4};
eRowNames = {'clean','dirty'};
eColNames = {'mama','papa','poo-poo','pee-pee'};
eTable = array2table(e,'RowNames',eRowNames,'VariableNames',eColNames);

