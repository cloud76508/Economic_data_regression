x = [-1.5:.01: 3];

x1 = x;
y1 = normpdf(x1,0,0.6);

x2 = x;
y2 = normpdf(x2,1,0.7);

y= y1+y2;

y1_part = y1;
x1_part = x1;
y2_part = y2;
x2_part = x2;

y1_part(x1<0) = [];
x1_part(x1<0) = [];
y2_part(x2>1) = [];
x2_part(x2>1) = [];

figure(1)
plot(x1_part,y1_part,'b')
hold on
plot(x2_part,y2_part,'r')
hold on
threshold1 = 0.4;
threshold2 = 0.3;

[~,temp_index0] = max(y1);
[~,temp_index1] = min(abs(y1(temp_index0:end)-threshold1));
[~,temp_index2] = min(abs(y2(1:(length(y2)-1)/2)-threshold2));
region_color = [0.7 0.7 0.7];
regionX = x(temp_index2:temp_index1+temp_index0);

line([max(regionX),3],[threshold1,threshold1],'LineStyle','--','Color','b')
hold on
line([-2,min(regionX)],[threshold2,threshold2],'LineStyle','--','Color','r')
hold on
line([min(regionX),min(regionX)],[threshold2,0], 'Color',region_color,'LineStyle','--','Color','r')
hold on
line([max(regionX),max(regionX)],[threshold1,0], 'Color',region_color,'LineStyle','--','Color','b')
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
text(0.12,0.55,'K_2(1-X)', 'Color','b','FontSize', 14)
text(0.78,0.60,'K_1(X)', 'Color','r','FontSize', 14)


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
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
ax2.FontSize = 14;
ax2.XColor = 'b';
ax2.YColor = 'b';
%xticklabels({'1','0.9','0.8','0.7','0.6','0.5','0.4','0.3','0.2','0.1','0'})
xticklabels({'1','0.8','0.6','0.4','0.2','0'})
yticks([0 threshold1 1])
yticklabels({'0','C_2','1'})
ylim([0 1])
%yyaxis left

figure(2)
plot(x1,y,'Color',[0 .7 .7])
hold on
line([max(regionX),3],[threshold1,threshold1],'LineStyle','--')
hold on
line([-2,min(regionX)],[threshold2,threshold2],'LineStyle','--','Color','r')
hold on
line([min(regionX),min(regionX)],[threshold2,0], 'Color',region_color,'LineStyle','--','Color','r')
hold on
line([max(regionX),max(regionX)],[threshold1,0], 'Color',region_color,'LineStyle','--','Color','b')
hold on

if sum(diff(regionX)>0.010001) ==0 
   line([regionX(1),regionX(end)],[0,0], 'Color',region_color,'LineWidth',6)
else
   midPoint = find(diff(regionX)>0.01001);
   line([regionX(1),regionX(midPoint)],[0,0], 'Color',region_color,'LineWidth',6)
   hold on
   line([regionX(midPoint+1),regionX(end)],[0,0], 'Color',region_color,'LineWidth',6)
end

hold on
[max_v, max_i] =  max(y);
scatter(x(max_i),max_v,'MarkerEdgeColor',[0 .7 .7],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5)
hold on
scatter(x(max_i),0,'MarkerEdgeColor',[0 .7 .7],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5)
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
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
ax2.FontSize = 14;
ax2.XColor = 'b';
ax2.YColor = 'b';
xticks([])
yticks([0 threshold1 1])
yticklabels({'0','C_2','1'})