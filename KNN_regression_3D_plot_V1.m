clear all

[~,~, data, ~] = loadData('C:\Users\User\Documents\GitHub\Economic_data_regression\Economic_data.csv');


% Using all data to train and test model
trn_data.X = data(:,2:3)';
trn_data.y = data(:,1);
tst_data.X = data(:,2:3)';
tst_data.y = data(:,1);

pointsNum = 30;

x=linspace(max(trn_data.X(1,:)), min(trn_data.X(1,:)),pointsNum);
y=linspace(max(trn_data.X(2,:)), min(trn_data.X(2,:)),pointsNum);
[X,Y]=meshgrid(x,y);

meshPoint = [reshape(X,[],1) reshape(Y,[],1)];

optimalK = 10;
meshPointZ = [];
for n =1:size(meshPoint,1)
    loop = 1;
    E_distance = (data(:,2)-meshPoint(n,1)).^2 +  (data(:,3)-meshPoint(n,2)).^2;
    tempData = data;
    
    while loop <= optimalK
        [~, tempIndex] = min(E_distance);
        meshPointZ(n,loop) = tempData(tempIndex,1);
        E_distance(tempIndex) = [];
        tempData(tempIndex,:) = [];
        loop = loop+1;
    end
    
end


Z = reshape(mean(meshPointZ'),pointsNum,pointsNum);


f=figure;
f.Position = [200, 50, 800, 600];
% %black and white plot
%s1 = surf(X,Y, Z,'FaceAlpha',0);
% colored plot
mesh(Y,X,Z)

hold on
scatter3(data(:,3),data(:,2), data(:,1),'x','red','LineWidth', 2)
set (gca, 'ydir', 'reverse' )
xlabel('T')
ylabel('S')
zlabel('K')
title('KNN regression (k = 10), NRMS = 0.3626')

% hold on
% 
% if data == 'SPYandGLD'
%     h = scatter(spyDiff, gldDiff);
%     haxis = gca;
%     xlim = haxis.XLim;
%     ylim = haxis.YLim;
%     d = (max([xlim ylim])-min([xlim ylim]))/1000;
%     [X1Grid,X2Grid] = meshgrid(xlim(1):d:xlim(2),ylim(1):d:ylim(2));
%     hold on
%     contour(X1Grid,X2Grid,reshape(pdf(Model,[X1Grid(:) X2Grid(:)]),...
%         size(X1Grid,1),size(X1Grid,2)),20)
%     
%     xLab = xlabel('SPY');
%     xLab.Position = [0.4 -0.2 -0.05];
%     yLab = ylabel('GLD');
%     yLab.Position = [-0.2 0.4 0.05];
%     XX = yLab.Position;
%     
% elseif data == 'SPYandTLT'
%     h = scatter(spyDiff, tltDiff);
%     haxis = gca;
%     xlim = haxis.XLim;
%     ylim = haxis.YLim;
%     d = (max([xlim ylim])-min([xlim ylim]))/1000;
%     [X1Grid,X2Grid] = meshgrid(xlim(1):d:xlim(2),ylim(1):d:ylim(2));
%     hold on
%     contour(X1Grid,X2Grid,reshape(pdf(Model,[X1Grid(:) X2Grid(:)]),...
%         size(X1Grid,1),size(X1Grid,2)),20)
%     
%     xLab = xlabel('SPY');
%     xLab.Position = [0.4 -0.2 -0.05];
%     yLab = ylabel('TLT');
%     yLab.Position = [-0.2 0.4 0.05];
%     XX = yLab.Position;
% end