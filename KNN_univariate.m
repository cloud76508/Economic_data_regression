clear all
clc

loadData

cd C:\Users\User\Documents\MATLAB\xtal\xtal_linux

%clear;
close all;

%-----------------------------------------
% load training/testing data
%-----------------------------------------

% Using all data to train and test model
[Value1, Index1] = sort(normalData(:,2));
temp1 = normalData(Index1,:);
trn_data.X = temp1(:,2)';
trn_data.y = temp1(:,1);
tst_data.X = temp1(:,2)';
tst_data.y = temp1(:,1);

% % Spliting data into traning and test

% trn = permutData(1:13,:);
% tst = permutData(14:end,:);

% % y = K (human development), x = S (Youth_unemployment)
% [Value1, Index1] = sort(trn(:,2));
% temp1 = trn(Index1,:);
% [Value2, Index2] = sort(tst(:,2));
% temp2 = tst(Index2,:);
% 
% trn_data.X = temp1(:,2)';
% trn_data.y = temp1(:,1);
% tst_data.X = temp2(:,2)';
% tst_data.y = temp2(:,1);

% % y = K (human development), x = T (GDP)
% [Value1, Index1] = sort(trn(:,3));
% temp1 = trn(Index1,:);
% [Value2, Index2] = sort(tst(:,3));
% temp2 = tst(Index2,:);
% 
% trn_data.X = temp1(:,3)';
% trn_data.y = temp1(:,1);
% tst_data.X = temp2(:,3)';
% tst_data.y = temp2(:,1);

%-----------------------------------------
% experiment setup
%-----------------------------------------
exp(1).method = 'KNN1';
exp(1).params = [2;3;4;5;6;7];

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

