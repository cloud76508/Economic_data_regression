%single interception plane, haven't done yet

N = 10.0;
pointsNum = 15;
threshold = 0.4;
sigma = 0.5;
S1 = -5;
T1 = -5;

x=linspace(0, N,pointsNum);
y=x;
[X,Y]=meshgrid(x,y);

planeZ = zeros(pointsNum,pointsNum)+threshold;

z1=(1/sqrt(2*pi*sigma^2).*exp(-((X+S1).^2/2*sigma^2)-((Y+T1).^2/2*sigma^2)));
z = z1;

%surf(X,Y, z,'FaceAlpha',0.1);

zLower = z;
%zLower(zLower>= threshold) = threshold;

s1 = surf(X,Y, zLower,'FaceAlpha',0);

hold on

zUpper = z;
zUpper(:,:) = threshold;
s2 = surf(X,Y, zUpper,'FaceAlpha',0,'FaceColor', 'flat', 'EdgeColor' ,'r');
c2 = s2.CData;
c2(z < threshold) = 0;
s2.CData = c2;
text(1.5,8.7, 0.6,'U = CONST', 'Color','r','FontSize', 14)


hold on

[M, c1] = contour(X,Y,z1,[threshold threshold], 'r');
c1.LineWidth = 1.5;
%c1.ShowText = 'on';

% zProject =  zeros(pointsNum,pointsNum);
% s3 = surf(X,Y, zProject,'FaceColor', 'flat');
% c3 = s3.CData;
% c3(z >= threshold) = 1;
% c3(z < threshold) = 0;
% s3.CData = c3;
hold on
scatter(5,5, 'r', 'filled')
hold off


fig = gca;
fig.FontSize = 8;

xLab = xlabel('T','fontsize',14);
xLab.Position = [7 -0.25 -0.05];
xticks([]);
% xticks([5])
% xticklabels({'C_1'})

yLab = ylabel('S','fontsize',14);
yLab.Position = [-0.25 4 -0.05];
yticks([]);
% yticks([5])
% yticklabels({'C_2'})

XX = yLab.Position;
zlabel('U','fontsize',14)
zticks([])

%shading interp
%axis tight