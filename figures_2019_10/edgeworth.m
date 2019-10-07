mu1 = [0 0];
mu2 = [1 1];
sigma = [1 0; 0 1];

%p = mvncdf([0 0],[1 1],mu,sigma);

x1 = 0:.05:1;
x2 = 0:.05:1;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y1 = mvnpdf(X,mu1,sigma);
y1 = reshape(y1,length(x2),length(x1));

y2 = mvnpdf(X,mu2,sigma);
y2 = reshape(y2,length(x2),length(x1));


c1 = contour(x1,x2,y1,[1], 'r')
hold 
c2 = contour(x1,x2,y2,[1], 'b')
hold on


% r1 = c1;
% r1(:,1) = [];
% r2 = c2;
% r2(:,1) = [];
% r2 = fliplr(r2);
 
%   btwRegion = [c1(1,5:33), c2(1,5:33)];
%   x_region = [c1(2,5:33), c2(2,5:33)];
%   fill(x_region, btwRegion, 'g');

%   btwRegion = [c1(1,60:92), c2(1,60:92)];
%   x_region = [c1(2,60:92), c2(2,60:92)];
%   fill(x_region, btwRegion, 'g');

xlabel('x')
ylabel('y')
%line([0 0 1 1 0],[1 0 0 1 1],'Linestyle','--','Color','k')
