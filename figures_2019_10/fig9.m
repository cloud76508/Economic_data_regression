x1 = [-2:.01:2];
y1 = normpdf(x1,0,1);

plot(x1,y1)

threshold = 0.13;
hold on

plot(x1,zeros(length(x1),1)+threshold)

hold on
yy = 0:0.01:0.4;
plot(zeros(length(yy),1),yy,'--','Color','r')

hold on 
yy = 0:0.01:threshold;
plot(zeros(length(yy),1)-1.5,yy,'--','Color','r')

hold on 
yy = 0:0.01:threshold;
plot(zeros(length(yy),1)+1.5,yy,'--','Color','r')

xticks([-1.5, 0, 1.5])
xticklabels({'Q1', 'Q*', 'Q2'})
xlabel('Perpendicular to the vector of optimal solutions')

yticks([threshold])
yticklabels({'constant'})
ylabel('U')