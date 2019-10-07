mu1 = [0 0];
mu2 = [1 1];
sigma = [1 0; 0 1];

x1 = 0:.01:1;
x2 = 0:.01:1;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y1 = mvnpdf(X,mu1,sigma);
y1 = reshape(y1,length(x2),length(x1));

y2 = mvnpdf(X,mu2,sigma);
y2 = reshape(y2,length(x2),length(x1));


c1 = contour(x1,x2,y1,[1], 'r', 'LineWidth',1.5 );
f1 =gca;
f1.XAxisLocation ='top';
xticks([0])
xticklabels({'Smax'})
f1.YAxisLocation ='right';
yticks([0])
yticklabels({'Tmax'})
hold on
scatter(0,0,'MarkerEdgeColor','r',...
              'MarkerFaceColor','r',...
              'LineWidth',1.5)
text(0.03,0.05,'A', 'Color','r')

hold on
c2 = contour(x1,x2,y2,[1], 'b', 'LineWidth',1.5);
% f2 = gca;
% xlabel('S')
% ylabel('T')
% f2.XAxisLocation ='bottom';
% xticks([0 1])
% xticklabels({'0', 'Smax'})
% f2.YAxisLocation ='left';
% yticks([0 1])
% yticklabels({'0', 'Tmax'})
hold on
scatter(1,1,'MarkerEdgeColor','b',...
              'MarkerFaceColor','b',...
              'LineWidth',1.5)
text(0.95,0.95,'B', 'Color','b')
text(0.5,-0.07,'S_A')
text(0.5,1.05,'S_B')
text(-0.1,0.5,'T_A')
text(1.05,0.5,'T_B')
text(0.2,0.33,'U_B = Constant', 'Color','b')
text(0.65,0.65,'U_A = Constant', 'Color','r')

% r1 = c1;
% r1(:,1) = [];
% r2 = c2;
% r2(:,1) = [];
% r2 = fliplr(r2);

for n = 2:size(c1,2)
    if c1(1,n) > c2(1,size(c1,2)+2-n)
       startN = n;
       break
    end   
end

for n = 2:size(c1,2)
    if c1(1,n) < c2(1,size(c1,2)+2-n) && n > startN
       endN = n;
       break
    end 
end

btwRegion = [c1(1,startN:endN), c2(1,startN:endN)];
x_region = [c1(2,startN:endN), c2(2,startN:endN)];
ff = fill(x_region, btwRegion, [0.95 0.95 0.9]);
ff.EdgeColor = 'none';

%example of drawing a arrow
% p1 = [2 3];                         % First Point
% p2 = [9 8];                         % Second Point
% dp = p2-p1;                         % Difference
% figure(1)
% quiver(p1(1),p1(2),dp(1),dp(2))