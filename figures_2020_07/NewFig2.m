clear all
clc

x1 = 0:0.1:2;
x2 = 0:0.1:2;

% two univariate normal distributions
Z_1 = normpdf(x1,1, 0.3);
Z_2 = normpdf(x2,1, 0.2);
Z_2_r = max(Z_1)/max(Z_2)*Z_2;

% bivariate normal distribution
mu = [1 1];
sigma = [0.3^2 0; 0 0.2^2];
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,mu,sigma);
y = reshape(y,length(x2),length(x1));
y = max(Z_1)/max(Z_2)*y;

threshold = 1;
yLower = y;
%zLower(zLower>= threshold) = threshold;

s1 = surf(x1,x2, yLower,'FaceAlpha',0);

hold on

yUpper = y;
yUpper(:,:) = threshold;
s2 = surf(x1,x2, yUpper,'FaceAlpha',0,'FaceColor', 'flat', 'EdgeColor' ,'r');
c2 = s2.CData;
c2(y < threshold) = 0;
s2.CData = c2;
text(1.5,8.7, 0.6,'K = CONST', 'Color','r','FontSize', 14)
hold on
[M, c1] = contour(x1,x2,y,[threshold threshold], 'r');
c1.LineWidth = 1.5;
%c1.ShowText = 'on';
hold off

fig = gca;
fig.FontSize = 12;
xLab = xlabel('S','fontsize',14);
%xLab.Position = [7 -0.25 -0.05];
fig.XAxis.LineWidth = 2;
% xticks([]);
% xticks([5])
% xticklabels({'1'})
yLab = ylabel('T','fontsize',14);
%yLab.Position = [-0.25 4 -0.05];
fig.YAxis.LineWidth = 2;
% yticks([]);
% yticks([0 5])
% yticklabels({'0','1'})
XX = yLab.Position;
zlabel('K','fontsize',14)
fig.ZAxis.LineWidth = 2;
zticks([])

hold on
plot3(x1, ones(size(x1))*x2(end), Z_1,'-b','LineWidth',2); 
plot3(ones(size(x2))*x1(end), x2, Z_2_r,'-r','LineWidth',2);