clear all
clc

[data,~, ~, ~] = loadData('C:\Users\User\Documents\GitHub\Economic_data_regression\Economic_data.csv')

sort(data(:,3))



for n = 1:size(data,1)
    x = data(n,3);
    %Order 3
    %ypred(n) = 0.0002*x^3 - 0.0168*x^2 + 0.6299*x - 7.1263;
    ypred(n) = 0.000150505*x^3 - 0.016771*x^2 + 0.629867*x - 7.1262900;
    %Order 2
    %ypred(n)=0.0003*x^2-0.0104*x+0.8628;
    %linear
    %ypred(n) = 0.0094*x + 0.4939;
end

% self calculated NRMS (slightly different to xtal)
NRMS = sqrt(sum((ypred' - data(:,1)).^2)/size(data,1)) / (std(data(:,1)))

xx = [min(data(:,3)):0.1:max(data(:,3))];
for n =1:size(xx,2)
    x = xx(n);
    %yy(n) = 0.0002*x^3 - 0.0168*x^2 + 0.6299*x - 7.1263;
    yy(n) = 0.0001505*x^3 - 0.0167711*x^2 + 0.6298678*x - 7.1262900;
end

figure
plot(xx, yy);
%text(34,4,'y = 0.0002*x^3-0.0168*x^2+0.6299*x-7.1263')
text(34,0.8,'y = 0.0001505*x^3 - 0.0167711*x^2 + 0.6298678*x - 7.126290')
hold on
scatter(data(:,3), data(:,1));
legend('regression function', 'raw data')
hold off