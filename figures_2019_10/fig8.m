clear all
clc

mu1 = [0 0];
mu2 = [2 2];
sigma = [1 0; 0 1];

x1 = -3:.2:5;
x2 = -3:.2:5;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y1 = mvnpdf(X,mu1,sigma);
y1 = reshape(y1,length(x2),length(x1));
y2 = mvnpdf(X,mu2,sigma);
y2 = reshape(y2,length(x2),length(x1));

s1 = surf(X1,X2, y1,'FaceAlpha',0);

hold on

s2 = surf(X1,X2, y2,'FaceAlpha',0);

hold on


c1 = contour(x1,x2,y1,[0.01 0.01], 'r', 'LineWidth',1.5 );

hold on
scatter(0,0,'MarkerEdgeColor','r',...
              'MarkerFaceColor','r',...
              'LineWidth',1.5)
text(-0.3,-0.3, 0.17,'A', 'Color','r','FontSize', 14)

hold on
c2 = contour(x1,x2,y2,[0.01 0.01], 'b', 'LineWidth',1.5);
hold on
scatter(2,2,'MarkerEdgeColor','b',...
              'MarkerFaceColor','b',...
              'LineWidth',1.5)
text(2.1,2.1, 0.17,'B', 'Color','b','FontSize', 14)


startN = 28;
endN = 55;

startN2 = 70;
endN2 =94;

btwRegion = [c1(1,startN:endN), c2(1,startN2:endN2)];
x_region = [c1(2,startN:endN), c2(2,startN2:endN2)];
ff = fill(x_region, btwRegion, [0.85 0.85 0.90]);
ff.EdgeColor = 'none';


fig = gca;
xLab = xlabel('S');
xticks([]);
yLab = ylabel('T');
yticks([]);
zlabel('U')
zticks([])

