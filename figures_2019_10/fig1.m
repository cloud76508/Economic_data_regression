mu1 = [0 0];
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
xlabel('X_1')
ylabel('X_2')
f1.XAxisLocation ='top';
xticks([0 1])
xticklabels({'X_1_m_a_x', '0'})
f1.YAxisLocation ='right';
yticks([0 1])
yticklabels({'X_2_m_a_x', '0'})
hold on
scatter(0,0,'MarkerEdgeColor','r',...
              'MarkerFaceColor','r',...
              'LineWidth',1.5)
text(-0.03,-0.03,'U_A_m_a_x')
text(0.3,0.3,'U_A_1')
text(0.5,0.5,'U_A_2')
text(0.65,0.65,'U_A_3')
text(0.8,0.8,'U_A_4')

text(0.03,0.1,'U_A_m_a_x > U_A_1 > U_A_2 > U_A_3 > U_A_4')

