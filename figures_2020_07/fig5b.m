clear all
clc

mu1 = [0 0];
mu2 = [1 1];
sigma = [0.7 0.5; 0.5 0.7];

x1 = -3:.05:5;
x2 = -3:.05:5;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y1 = mvnpdf(X,mu1,sigma);
y1 = reshape(y1,length(x2),length(x1));
y2 = mvnpdf(X,mu2,sigma);
y2 = reshape(y2,length(x2),length(x1));
y = y1+y2;

%find maximum point of y 
[tempV1, tempI1] = max(y);
[tempV2, tempI2] = max(max(y));

maxValue = tempV2;
max_x1 = x1(tempI1(tempI2));
max_x2 = x2(tempI2);

% plot surface
s1 = surf(X1,X2, y,'FaceAlpha',0);
hold on

% denote the maximum on the bottom
scatter(max_x1,max_x2,'MarkerEdgeColor',[0 .7 .5],...
    'MarkerFaceColor',[0 .7 .5],...
    'LineWidth',1.5)

% denote the maximum on the surface
scatter3(max_x1,max_x2,maxValue,'MarkerEdgeColor',[0 .7 .5],...
    'MarkerFaceColor',[0 .7 .5])

% zoom in to overlapped region
xlim([0 1])
ylim([0 1])
zlim([0 0.8])

% 1st contour 
c1 = contour(x1,x2,y1,[0.20 0.20], 'r', 'LineWidth',1.5 );
hold on

% A: point and test 
scatter(mu1(1),mu1(2),'MarkerEdgeColor','r',...
    'MarkerFaceColor','r',...
    'LineWidth',1.5)
text(-0.05,-0.05, 0,'A', 'Color','r','FontSize', 14)
hold on

% 2st contour 
c2 = contour(x1,x2,y2,[0.20 0.20], 'b', 'LineWidth',1.5);
hold on
scatter(mu2(1),mu2(2),'MarkerEdgeColor','b',...
    'MarkerFaceColor','b',...
    'LineWidth',1.5)
% B: point and test 
text(1.05,1.05, 0,'B', 'Color','b','FontSize', 14)


startN = 53;
endN = 80;

startN2 = 110;
endN2 =134;

btwRegion = [c1(1,startN:endN), c2(1,startN2:endN2)];
x_region = [c1(2,startN:endN), c2(2,startN2:endN2)];
ff = fill(x_region, btwRegion, [0.85 0.85 0.90]);
ff.EdgeColor = 'none';

hold on 

startM = 53;
endM = 80;

startM2 = 3;
endM2 =9;

btwRegion = [c1(1,startM:endM), c2(1,startM2:endM2)];
x_region = [c1(2,startM:endM), c2(2,startM2:endM2)];
ff = fill(x_region, btwRegion, [0.85 0.85 0.90]);
ff.EdgeColor = 'none';


fig = gca;
xLab = xlabel('S','FontSize', 14);
xticks([]);
yLab = ylabel('T','FontSize', 14);
yticks([]);
zlabel('K','FontSize', 14)
zticks([])

