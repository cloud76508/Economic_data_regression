clear all

% Running KNN1 with parameter ( 2 ) ... done.  NRMS: 0.197642  NMAX: 0.123810
% Running KNN1 with parameter ( 3 ) ... done.  NRMS: 0.217653  NMAX: 0.117460
% Running KNN1 with parameter ( 4 ) ... done.  NRMS: 0.233897  NMAX: 0.121429
% Running KNN1 with parameter ( 5 ) ... done.  NRMS: 0.246151  NMAX: 0.148571
% Running KNN1 with parameter ( 6 ) ... done.  NRMS: 0.272923  NMAX: 0.142857


loadData

N = 1.0;
pointsNum = 30;

normalData = sortrows(normalData,3);

x=normalData(:,3);

optimalK = 2;
y = [];
for n =1:size(x,1)
    loop = 1;
    E_distance = (normalData(:,3)-x(n)).^2;
    tempData = normalData;
    
    while loop <= optimalK
        [~, tempIndex] = min(E_distance);
        y(n,loop) = tempData(tempIndex,1);
        E_distance(tempIndex) = [];
        tempData(tempIndex,:) = [];
        loop = loop+1;
    end
    
end

yPred = mean(y');

% self calculated NRMS (slightly different to xtal)
NRMS = sqrt(sum((yPred' - normalData(:,1)).^2)/size(normalData,1)) / (std(normalData(:,1)))


f=figure;
f.Position = [200, 50, 800, 600];
plot(x, yPred);
hold on
scatter(normalData(:,3), normalData(:,1),'x','red','LineWidth', 2)
xlabel('T')
ylabel('K')
title(sprintf('NRMS = %0.3f',NRMS));