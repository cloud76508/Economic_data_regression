%[data, annuChangeRate,normalData, permutData]  = loadData('C:\Users\User\Documents\GitHub\Economic_data_regression\Economic_data.csv');

[~, data,~, ~]  = loadData('C:\Users\User\Documents\GitHub\Economic_data_regression\Economic_data.csv');


% % show data
figure(1)
scatter3(data(:,2), data(:,3), data(:,1))
xlabel('S')
ylabel('T')
zlabel('K')


%histogram 
figure(2)
hist(data(:,1))
xlabel('K')

figure(3)
hist(data(:,2))
xlabel('S')

figure(4)
hist(data(:,3))
xlabel('T')

figure(5)
plotmatrix(data)


