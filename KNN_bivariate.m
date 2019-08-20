clear all
close all;
clc

[~,~, normalData, ~] = loadData('C:\Users\User\Documents\GitHub\Economic_data_regression\Economic_data.csv');

cd C:\Users\User\Documents\MATLAB\xtal\xtal_linux

%-----------------------------------------
% multidimensional data
%-----------------------------------------

% Using all data to train and test model
trn_data.X = normalData(:,2:3)';
trn_data.y = normalData(:,1);
tst_data.X = normalData(:,2:3)';
tst_data.y = normalData(:,1);

%-----------------------------------------
% experiment setup
%-----------------------------------------
exp(1).method = 'KNN1';
% try several different values
exp(1).params = [2;3;4;5;10];

% % manually select a value
% exp(1).params = [2];


%-----------------------------------------
% CHANGE THE ENIVORMENT TO CYGWIN!
[XTAL_RootDir, SOMRoot, Cygdir] = xtal_rootdir;
path1 = getenv('PATH');
if isempty(regexpi(path1, Cygdir))
    path2 = [Cygdir path1];
    setenv('PATH', path2);
end
%-----------------------------------------


for i = 1:length(exp)

    fprintf('\nExperiment: %s\n', exp(i).method);
    fprintf('---------------------------------------\n');

    % run xtal with selected inputs and parameters
    [ypred, exp(i).nrms, exp(i).rms0, exp(i).nmin] = xtal(trn_data, tst_data, exp(i).method, exp(i).params);

    [exp(i).min_nrms, exp(i).best_param_idx] = min(exp(i).nrms);

    fprintf('Minimal NRMS = %f achieved with parameter ( ', exp(i).min_nrms);
    fprintf('%d ', exp(i).params(exp(i).best_param_idx,:));
    fprintf(')\n');
end

% find out the best method
[min_nrms,best_method] = min([exp.min_nrms]);

fprintf('\n** Summary **\n\n');
fprintf('Method         NRMS         NMAX  parameter\n');
fprintf('--------------------------------------------------\n');

for i = 1:length(exp)

    fprintf('%s   %12.6f %12.6f  ( ',...
            exp(i).method, exp(i).min_nrms, exp(i).nmin(exp(i).best_param_idx));
        fprintf('%d ', exp(i).params(exp(i).best_param_idx,:));

    fprintf(')');
    if i == best_method

        fprintf('         best result');

    end
    fprintf('\n');
end

%-----------------------------------------
% RECHANGE ENVIRONMENT BACK
setenv('PATH', path1);
%-----------------------------------------


