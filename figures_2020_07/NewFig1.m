x1 = [-3:.01:3];
y1 = normpdf(x1,0.8,0.3);

x2 = [-3:.01:3];
y2 = normpdf(x2,0.9,0.2);
y2_r = max(y1)/max(y2)*y2;

figure(1)
plot(x1,y1)
xlim([0 1])
yticks([]);
xlabel('S')
ylabel('K_S')

figure(2)
plot(x2,y2_r)
xlim([0 1])
yticks([])
xlabel('T')
ylabel('K_T')