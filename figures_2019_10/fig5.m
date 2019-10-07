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

c1 = contour(X,Y,z1,[8], 'b');


xLab = xlabel('X_1');
xLab.Position = [5 -0.5 -0.05];
xticks([])
yLab = ylabel('X_2');
yLab.Position = [-0.5 5 -0.08];
yticks([])
XX = yLab.Position;
zlabel('U')
zticks([])

%shading interp
%axis tight