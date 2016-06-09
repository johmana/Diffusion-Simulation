diffusionMatrix1 = DiffusionSim('Data3.xlsx','1',0,40000,10);

diffusionMatrix2 = DiffusionSim('Data3.xlsx','3',40000,40100,10);

initMean = mean(mean(diffusionMatrix1(:,:,end)));
finMean = mean(mean(diffusionMatrix2(:,:,end)));

fprintf('Equilibrium mean = %f \n', initMean);
fprintf('Final mean = %f \n',finMean);
