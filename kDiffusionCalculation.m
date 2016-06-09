function [ kDiffusionMatrix ] = kDiffusionCalculation(DiffusivityCoeff, MassFlow, t, distanceMatrix, fieldMat )

[r,c] = find(fieldMat(:,:) > 0);

if fieldMat(r,c) == 1 
    MassFlow = MassFlow(:,1);
else 
    MassFlow = MassFlow(:,2);
end

 kDiffusionMatrix(:,:) = -MassFlow/(sqrt(4*pi*DiffusivityCoeff*t))*...
     exp(-distanceMatrix(:,:).^2/(4*DiffusivityCoeff*t));
        
end
