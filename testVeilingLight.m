gpuDevice
validateGPU("all")

arraySize = 1000000;

maxa = 1;
maxb = 1;
maxE = 1000;

a = rand(1, arraySize) * maxa;
b = rand(1, arraySize) * maxb;
E = rand(1, arraySize) * maxE;
e = repmat(exp(1), 1, arraySize);

gpuaD = gpuArray(a);
gpubD = gpuArray(b);
gpuED = gpuArray(E);
gpueD = gpuArray(e);

gpuaS = gpuArray(single(a));
gpubS = gpuArray(single(b));
gpuES = gpuArray(single(E));
gpueS = gpuArray(single(e));

tic
doubleM = gather(veilingLight(gpubD, gpuED, gpuaD + gpubD));
singleM = gather(veilingLight(gpubS, gpuES, gpuaS + gpubS));
diffM = abs(doubleM - double(singleM));
percentDiff = diffM ./ doubleM;
toc

avgPercentDiff = mean(percentDiff)
maxDiff = max(percentDiff)

clear
