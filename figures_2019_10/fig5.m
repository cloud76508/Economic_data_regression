N = 10.0;
pointsNum = 15;
threshold = 0.25;
sigma = 0.5;
S1 = -5;
T1 = -5;


x=linspace(0, N,pointsNum);
y=x;
[X,Y]=meshgrid(x,y);

planeZ = zeros(pointsNum,pointsNum)+threshold;

z1=(1/sqrt(2*pi*sigma^2).*exp(-((X+S1).^2/2*sigma^2)-((Y+T1).^2/2*sigma^2)));
z = z1;

s1 = surf(X,Y, z,'FaceAlpha',0);

hold on

c1 = contour(X,Y,z1,[8], 'r');


scatter(5,5, 'r', 'filled')
hold off


fig = gca;
fig.FontSize = 8;

xLab = xlabel('X_1','fontsize',10);
xLab.Position = [7 -0.25 -0.05];
%xticks([]);
xticks([5])
xticklabels({'C_1'})

yLab = ylabel('X_2','fontsize',10);
yLab.Position = [-0.25 4 -0.05];
%yticks([]);
yticks([5])
yticklabels({'C_2'})

XX = yLab.Position;
zlabel('U','fontsize',10)
zticks([])

%shading interp
%axis tight