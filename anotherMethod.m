clear all
clc

loadData

for n = 1:size(data,1)
    x = data(n,3);
    %Order 3
    ypred(n) = 0.0002*x^3 - 0.0168*x^2 + 0.6299*x - 7.1263;
    %ypred(n) = 0.000150505*x^3 - 0.016771*x^2 + 0.629867*x - 7.12629;
    %Order 2
    %ypred(n)=0.0003*x^2-0.0104*x+0.8628;
    %linear
    %ypred(n) = 0.0094*x + 0.4939;
end

% self calculated NRMS (slightly different to xtal)
NRMS = sqrt(sum((ypred' - data(n,1)).^2)/size(data,1)) / (std(data(:,1)))

figure
plot(data(:,3), ypred);
hold on
scatter(data(:,3), data(:,1));
hold off