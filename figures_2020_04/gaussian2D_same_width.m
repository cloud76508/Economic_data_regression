x = [-2:.01: 3];

x1 = x;
y1 = normpdf(x1,0,0.6);

x2 = x;
y2 = normpdf(x2,1,0.6);

y= y1+y2;

figure(1)
plot(x1,y1)
hold on
plot(x2,y2)
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

figure(2)
plot(x1,y)
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