loadData

% % show data
figure(1)
scatter3(normalData(:,2), normalData(:,3), normalData(:,1))
xlabel('S')
ylabel('T')
zlabel('K')

%histogram 
figure(2)
hist(permutData(:,2))
xlabel('S')

figure(3)
hist(permutData(:,3))
xlabel('T')

figure(4)
plotmatrix(normalData)


