mu1 = [1 1];
sigma = [1 0; 0 1];

 
x1 = 0:.05:1;
x2 = 0:.05:1;
% x1 = -3:.05:3;
% x2 = -3:.05:3;

[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y1 = mvnpdf(X,mu1,sigma);
y1 = reshape(y1,length(x2),length(x1));

figure
c1 = contour(x1,x2,y1,[4], 'r');
f1 = gca;
f1.FontSize = 12;
xlabel('S')
ylabel('T')
f1.XAxisLocation ='bottom';
xticks([0 1])
xticklabels({'0', '1'})
f1.YAxisLocation ='left';
yticks([0 1])
yticklabels({'0', '1'})
hold on
scatter(1,1,'MarkerEdgeColor','r',...
              'MarkerFaceColor','r',...
              'LineWidth',1.5)
text(1,1.03,'K_m_a_x','FontSize', 14)
text(0.65,0.65,'K_1','FontSize', 14)
text(0.5,0.5,'K_2','FontSize', 14)
text(0.35,0.35,'K_3','FontSize', 14)
text(0.2,0.2,'K_4','FontSize', 14)

arrowX = [0.25 0.8];
arrowY = [0.08 0.08];
annotation('arrow',arrowX,arrowY);

arrowX2 = [0.1 0.1];
arrowY2 = [0.25 0.8];
annotation('arrow',arrowX2,arrowY2);

text(0.49,0.9,'K_m_a_x > K_1 > K_2 > K_3 > K_4','FontSize', 14)

