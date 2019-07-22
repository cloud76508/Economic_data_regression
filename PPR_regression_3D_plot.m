clear all
close all;
clc

% User specified optimal parameter
optimalPara = 2;

% GDP data
[~,data, ~, ~] = loadData('C:\Users\User\Documents\GitHub\Financial_data_regression\financial_data.csv');

% [data, ~, ~, ~] = loadData('C:\Users\User\Documents\GitHub\Financial_data_regression\financial_data.csv');
% data(:,2) =  - data(:,2);

% % CLI data
% [raw, data, ~, ~] = loadData('C:\Users\User\Documents\GitHub\Financial_data_regression\financial_data_CLI.csv');

%  % WIP data
%  [raw, data, ~, ~] = loadData('C:\Users\User\Documents\GitHub\Financial_data_regression\financial_data_WIP.csv');

%  % PJ data
%  [raw, data, ~, ~] = loadData('C:\Users\User\Documents\GitHub\Financial_data_regression\financial_data_PJ.csv');


cd C:\Users\User\Documents\MATLAB\xtal\xtal_linux

%-----------------------------------------
% multidimensional data
%-----------------------------------------

% Using all data to train and test model
trn_data.X = data(:,2:3)';
trn_data.y = data(:,1);
tst_data.X = data(:,2:3)';
tst_data.y = data(:,1);

pointsNum = 30;

% x=linspace(-15, -30,pointsNum);
% y=linspace(25, 45,pointsNum);

x=linspace(max(trn_data.X(1,:)), min(trn_data.X(1,:)),pointsNum);
y=linspace(max(trn_data.X(2,:)), min(trn_data.X(2,:)),pointsNum);
[X,Y]=meshgrid(x,y);

meshPoint = [reshape(X,[],1) reshape(Y,[],1)];

mesh_data.X = meshPoint';
mesh_data.y = zeros(size(mesh_data.X,2),1);


meshPointZ = [];


%-----------------------------------------
% experiment setup
%-----------------------------------------
exp(1).method = 'PPR1';

% manually select a value
exp(1).params = [optimalPara];

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
    [meshPointZ, exp(i).nrms, exp(i).rms0, exp(i).nmin] = xtal(trn_data, mesh_data, exp(i).method, exp(i).params);
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

Z = reshape(meshPointZ',pointsNum,pointsNum);

% self calculated NRMS (slightly different to xtal)
NRMS = sqrt(sum((ypred' - data(:,1)).^2)/size(data,1)) / (std(data(:,1)));

f=figure;
f.Position = [200, 50, 800, 600];
% %black and white plot
%s1 = surf(X,Y, Z,'FaceAlpha',0);
% colored plot
mesh(Y,X,Z)

hold on
scatter3(data(:,3),data(:,2), data(:,1),'x','red','LineWidth', 2)
xlabel('T')
ylabel('S')
zlabel('K')
%title(sprintf('NRMS = %0.3f',min_nrms));
title(sprintf('NRMS = %0.3f, PPR.para = %d',NRMS, optimalPara));
