x = [-2:.01: 3];



x2 = x;
y2 = normpdf(x2,1,0.6);



y2_part = y2;
x2_part = x2;


y2_part(x2>1) = [];
x2_part(x2>1) = [];

figure(1)
plot(x2_part,y2_part,'r')
hold on
threshold2 = 0.4;

[~,temp_index2] = min(abs(y2(1:(length(y2)-1)/2)-threshold2));
region_color = [0.7 0.7 0.7];
regionX = x(temp_index2:end);


line([-2,min(regionX)],[threshold2,threshold2],'LineStyle','--','Color','r')
hold on
line([min(regionX),min(regionX)],[threshold2,0], 'Color',region_color,'LineStyle','--','Color','r')
hold on

if sum(diff(regionX)>0.010001) ==0 
   line([regionX(1),regionX(end)],[0,0], 'Color',region_color,'LineWidth',6)
   hold off
else
   midPoint = find(diff(regionX)>0.01001);
   line([regionX(1),regionX(midPoint)],[0,0], 'Color',region_color,'LineWidth',6)
   hold on
   line([regionX(midPoint+1),regionX(end)],[0,0], 'Color',region_color,'LineWidth',6)
   hold off
end
text(0.78,0.55,'K_1(X)', 'Color','r','FontSize', 14)


hold off
ax1 = gca; % current axes
ax1.FontSize = 14;
ax1.XColor = 'r';
ax1.YColor = 'r';
ax1.XAxisLocation = 'origin';
ylabel('K','Color','black')
yticks([0 threshold2 1])
yticklabels({'0','C_1','1'})
xlabel('X','Color','black')
xlim([0 1])
ylim([0 1])