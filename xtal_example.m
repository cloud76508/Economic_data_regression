clear all
clc

loadData

cd C:\Users\User\Documents\MATLAB\xtal\xtal_linux

%clear;
close all;

%-----------------------------------------
% load training/testing data
%-----------------------------------------

trn_data.X = normalData(1:2:27,3)';
trn_data.y = normalData(1:2:27,1);
tst_data.X = normalData(2:2:26,3)';
tst_data.y = normalData(2:2:26,1);

% tmp = load('xtal_linuxtrain.txt', '-ascii');
% trn_data.X = tmp(:,1)';
% trn_data.y = tmp(:,2);
% 
% tst_data = trn_data;
% tmp = load('xtal_linuxtest.txt', '-ascii');
% tst_data.X = tmp(:,1)';
% tst_data.y = tmp(:,2);

%-----------------------------------------
% experiment setup
%-----------------------------------------
exp(1).method = 'KNN1';
exp(1).params = [3;5;7;9;11;13];


% exp(1).method = 'ANN1';
% exp(1).params = [10;20;30;40;50];
% 
% exp(2).method = 'PPR1';
% exp(2).params = [1;2;3;4;5;10;15];
% 
% exp(3).method = 'CTM1';
% exp(3).params = [[1,0]; [1,2]; [1,5]; [1,9]];

% exp(4).method = 'KNN1';
% exp(4).params = [2;5;10;20;30;40];

% exp(5).method = 'RBF1';
% exp(5).params = [2;5;10;15;20;25];

% exp(6).method = 'MRS1';
% exp(6).params = [[20,0]; [20,5]; [20,9]; [50,0]; [50,5]; [50,9]; [100,0]; [100,5]; [100,9]];

%-----------------------------------------
% Change the environment to Cygwin
[XTAL_RootDir, SOMRoot, Cygdir] = xtal_rootdir;
path1 = getenv('PATH');
if isempty(regexpi(path1, Cygdir))
    path2 = [Cygdir path1]; % add Cygdir to PATH
    setenv('PATH', path2);
end
%-----------------------------------------


for i = 1:length(exp)

    fprintf('\nExperiment: %s\n', exp(i).method);
    fprintf('---------------------------------------\n');

    % run xtal with selected inputs and parameters
    [ypred, exp(i).nrms,exp(i).rms0, exp(i).nmin] = xtal(trn_data, tst_data, exp(i).method, exp(i).params, 1);

    [exp(i).min_nrms, exp(i).best_param_idx] = min(exp(i).nrms);

    fprintf('Minimal NRMS = %f achieved with parameter ( ', exp(i).min_nrms);
    fprintf('%d ', exp(i).params(exp(i).best_param_idx,:));
    fprintf(')\n');

    % plot and visualize the results
    h0 = figure;
    hold on;
    set(h0, 'Name', exp(i).method);

    h1 = plot(trn_data.X, trn_data.y, 'kx');
    h2 = plot(tst_data.X, tst_data.y, 'ro');
    h3 = plot(tst_data.X, ypred(exp(i).best_param_idx,:), 'b.-');

    legend([h1 h2 h3], 'training examples', 'testing examples', 'prediction', ...
           'location', 'best');

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
% Change the environment back
setenv('PATH', path1);
%-----------------------------------------

