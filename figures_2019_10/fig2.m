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
c1 = contour(x1,x2,y1,[4], 'b');
f1 = gca;
xlabel('X_1')
ylabel('X_2')
f1.XAxisLocation ='bottom';
xticks([0 1])
xticklabels({'0', 'C_1'})
f1.YAxisLocation ='left';
yticks([0 1])
yticklabels({'0', 'C_2'})
hold on
scatter(1,1,'MarkerEdgeColor','b',...
              'MarkerFaceColor','b',...
              'LineWidth',1.5)
text(1,1.03,'U_B_m_a_x')
text(0.65,0.65,'U_B_1')
text(0.5,0.5,'U_B_2')
text(0.35,0.35,'U_B_3')
text(0.2,0.2,'U_B_4')

arrowX = [0.25 0.8];
arrowY = [0.1 0.1];
annotation('arrow',arrowX,arrowY);

arrowX2 = [0.1 0.1];
arrowY2 = [0.25 0.8];
annotation('arrow',arrowX2,arrowY2);

text(0.53,0.9,'U_B_m_a_x > U_B_1 > U_B_2 > U_B_3 > U_B_4')

