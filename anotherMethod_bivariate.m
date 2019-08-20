clear all
clc
[data,~, ~, ~] = loadData('C:\Users\User\Documents\GitHub\Economic_data_regression\Economic_data.csv')

data(:,2) =  - data(:,2);

pointsNum = 30;

x=linspace(-15, -30,pointsNum);
y=linspace(25, 45,pointsNum);
[X,Y]=meshgrid(x,y);

meshPoint = [reshape(X,[],1) reshape(Y,[],1)];


conA = 1;
for n = 1:size(meshPoint,1)
    T = meshPoint(n,1);
    S = meshPoint(n,2);
    KT = 0.0002*T^3 - 0.0168*T^2 + 0.6299*T - 7.1263;
    %KT = 0.000150505*T^3 - 0.016771*T^2 + 0.629867*T - 7.12629;
    MT = 0.002*T^2 - 0.1748*T + 6.892;
    SigmaT = 0.0005*T^2 - 0.0335*T + 0.722;
    KST(n) = conA*KT*(1/(S*SigmaT*sqrt(2*pi)))*exp(-(log(S)-MT)^2/(2*SigmaT^2));
end

Z = reshape(KST,pointsNum,pointsNum);

% self calculated NRMS (slightly different to xtal)
%NRMS = sqrt(sum((KST' - data(n,1)).^2)/size(data,1)) / (std(data(:,1)))

f=figure;
f.Position = [200, 50, 800, 600];
% %black and white plot
%s1 = surf(X,Y, Z,'FaceAlpha',0);
% colored plot
mesh(Y,X,Z)

% hold on
% scatter3(data(:,3),data(:,2), data(:,1),'x','red','LineWidth', 2)
% xlabel('T')
% ylabel('1-S')
% zlabel('K')
% title('NRMS = 0.123')