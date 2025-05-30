gpuDevice
validateGPU("all")

arraySize = 1000000;

maxa = 1;
maxb = 1;
maxE = 2;
minz = 0.000001;
maxz = 0.1;
maxJc = 255;

a = rand(1, arraySize) * maxa;
b = rand(1, arraySize) * maxb;
E = rand(1, arraySize) * maxE;
z = rand(1, arraySize) * (maxz - minz) + minz;
e = repmat(exp(1), 1, arraySize);
Jc = rand(1, arraySize) * maxJc;

gpuaD = gpuArray(a);
gpubD = gpuArray(b);
gpuED = gpuArray(E);
gpuzD = gpuArray(z);
gpueD = gpuArray(e);
gpuJcD = gpuArray(Jc);

gpuaS = gpuArray(single(a));
gpubS = gpuArray(single(b));
gpuES = gpuArray(single(E));
gpuzS = gpuArray(single(z));
gpueS = gpuArray(single(e));
gpuJcS = gpuArray(single(Jc));

tic
doubleM = gather(imgForm(gpubD, gpuED, gpuaD + gpubD, gpuzD, gpueD, gpuJcD));
singleM = gather(imgForm(gpubS, gpuES, gpuaS + gpubS, gpuzS, gpueS, gpuJcS));
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
