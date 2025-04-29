gpuDevice
validateGPU("all")

arraySize = 10000000;

maxa = 1;
maxb = 1;
maxz = 1;
maxL0 = 0.0001;
maxLstar = 0.0001;
maxKd = 0.5;
maxTheta = 180;

a = rand(1, arraySize) * maxa;
b = rand(1, arraySize) * maxb;
z = rand(1, arraySize) * maxz;
e = repmat(exp(1), 1, arraySize);

L0 = rand(1, arraySize) * maxL0;
Lstar = rand(1, arraySize) * maxLstar;
Kd = rand(1, arraySize) * maxKd;
theta = rand(1, arraySize) * maxTheta;

gpuaD = gpuArray(a);
gpubD = gpuArray(b);
gpuzD = gpuArray(z);
gpueD = gpuArray(e);

gpuL0D = gpuArray(L0);
gpuLstarD = gpuArray(Lstar);
gpuKdD = gpuArray(Kd);
gputhetaD = gpuArray(theta);

gpuaS = gpuArray(single(a));
gpubS = gpuArray(single(b));
gpuzS = gpuArray(single(z));
gpueS = gpuArray(single(e));

gpuL0S = gpuArray(single(L0));
gpuLstarS = gpuArray(single(Lstar));
gpuKdS = gpuArray(single(Kd));
gputhetaS = gpuArray(single(theta));

tic
doubleM = rte(gpuL0D, gpuLstarD, gpuaD + gpubD, gpuKdD, gpuzD, gputhetaD, gpueD);
singleM = rte(gpuL0S, gpuLstarS, gpuaS + gpubS, gpuKdS, gpuzS, gputhetaS, gpueS);
diffM = abs(doubleM - double(singleM));
percentDiff = diffM ./ doubleM;
toc

avgPercentDiff = mean(percentDiff)
maxDiff = max(percentDiff)
minDiff = min(percentDiff)
Q = quantile(percentDiff, 3)
stdDev = std(percentDiff)

filterDiff = percentDiff;
filterDiff(filterDiff < 0.0001) = [];
numel(filterDiff)
filterDiff = percentDiff;
filterDiff(filterDiff < 0.001) = [];
numel(filterDiff)
filterDiff = percentDiff;
filterDiff(filterDiff < 0.01) = [];
numel(filterDiff)

outliers = isoutlier(percentDiff, "median");
filterDiff = percentDiff;
filterDiff(filterDiff < median(percentDiff)) = 0;
filterDiff(filterDiff >= median(percentDiff)) = 1;
outliers = outliers .* filterDiff;
sum(outliers)

clear
