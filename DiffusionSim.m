function [diffusionMatrix1,sMassFlow,kMassFlow] = DiffusionSim(xlsFile,xlsPage1,Tinitial,Tfinal,timeSteps)

% .xlsx read
[data]= round(xlsread(xlsFile,xlsPage1));
kCoord = data(:,1:3);
sCoord = data(:,5:7);
dimDeterminant = max(max(data));

% Allocating Memory
sourceLocationMatrix = zeros(dimDeterminant,dimDeterminant);
sinkLocationMatrix = zeros(dimDeterminant,dimDeterminant);
sourceDistanceMatrix = zeros(dimDeterminant,dimDeterminant);
sinkDistanceMatrix = zeros(dimDeterminant,dimDeterminant);
kYmat = zeros(dimDeterminant,dimDeterminant,size(sCoord,1));
sYmat = zeros(dimDeterminant,dimDeterminant,size(sCoord,1));

% Time, functions and more memory allocation
t = linspace(Tinitial,Tfinal,timeSteps); D = 1.33; 
diffusionMatrix1 = zeros(dimDeterminant,dimDeterminant, length(t)); 

sfunc = @(x) x./x;
kfunc = @(x) 1./(x-1);
tic
sMassFlow = sMassFlux(t,kfunc,sfunc);
kMassFlow = kMassFlux(t,kfunc,@(x) 1);

for ii = 1:size(sCoord,1)
    
    sourceLocationMatrix(sCoord(ii,1), sCoord(ii,2),ii) = sCoord(ii,3);
    sinkLocationMatrix(kCoord(ii,1),kCoord(ii,2),ii) = kCoord(ii,3);
    
    sourceDistanceMatrix(:,:,ii) = bwdist(sourceLocationMatrix(:,:,ii));
    sinkDistanceMatrix(:,:,ii) = bwdist(sinkLocationMatrix(:,:,ii)); 
end
toc

clims = [-0.1,0.1];
for ii = 1:length(t)  
    
    tic
    for jj = 1:size(sinkDistanceMatrix,3) 
    kYmat(:,:,jj) = kDiffusionCalculation(D, kMassFlow(ii,:), t(ii), sinkDistanceMatrix(:,:,jj), sinkLocationMatrix(:,:,jj));
    sYmat(:,:,jj) = sDiffusionCalculation(D, sMassFlow(ii,:), t(ii), sourceDistanceMatrix(:,:,jj),sourceLocationMatrix(:,:,jj));
    end
    toc
    
    diffusionMatrix1(:,:,ii) = sum(kYmat(:,:,:),3) +...
        sum(sYmat(:,:,:),3);
    
end

for ii = 1:length(t)     
    
    figure(1)
    imagesc(diffusionMatrix1(:,:,ii),clims)
    axis equal tight
   
    F(ii) = getframe(figure(1));
end
