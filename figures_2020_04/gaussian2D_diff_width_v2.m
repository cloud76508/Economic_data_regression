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
plot(x1_part,y1_part)
hold on
plot(x2_part,y2_part)
hold on
threshold = 0.3;
line([-2,3],[threshold,threshold],'LineStyle','--')

[~,temp_index1] = min(abs(y1((length(y1)-1)/2+1:end)-threshold));
[~,temp_index2] = min(abs(y2(1:(length(y2)-1)/2)-threshold));
hold on

region_color = [0.7 0.7 0.7];
regionX = x(temp_index2:temp_index1+(length(y1)-1)/2);
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
hold off
ylabel('U')
yticks([0 1])
xlabel('S')
ylim([0 1])
xlim([0 1])

figure(2)
plot(x,y)
hold on
line([-2,3],[threshold,threshold],'LineStyle','--')
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


ylabel('U')
yticks([0 1])
xlabel('S')
ylim([0 1])
xlim([0 1])