clear all
close all;
clc

loadData

cd C:\Users\User\Documents\MATLAB\xtal\xtal_linux

%-----------------------------------------
% multidimensional data (function 9 as in paper)
%-----------------------------------------
[trn_data, tst_data] = function9(100, 961);

% trn_data.X = permutData(1:13,2:3)';
% trn_data.y = permutData(1:13,1);
% tst_data.X = permutData(14:end,2:3)';
% tst_data.y = permutData(14:end,1);

% tst_data.X = trn_data.X;
% tst_data.y = trn_data.y;


%-----------------------------------------
% experiment setup
%-----------------------------------------

exp(1).method = 'ANN1';
exp(1).params = [5;10;20;40];

exp(2).method = 'PPR1';
exp(2).params = [1;2;5;8];

exp(3).method = 'CTM1';
exp(3).params = [[2,0];[2,2];[2,5];[2,9]];

exp(4).method = 'KNN1';
exp(4).params = [2;4;8;16];

exp(5).method = 'RBF1';
exp(5).params = [16;25;36;49;64];


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


