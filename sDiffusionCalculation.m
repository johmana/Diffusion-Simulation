function [ sDiffusionMatrix ] = sDiffusionCalculation(DiffusivityConstant, MassFlow, t, distMat, fieldMat)

[r,c] = find(fieldMat(:,:) > 0);

if fieldMat(r,c) == 1
    MassFlow = MassFlow(:,1);
else
    MassFlow = MassFlow(:,2);
end

sDiffusionMatrix(:,:) = MassFlow/(sqrt(4*pi*DiffusivityConstant*t))*...
    exp(-distMat(:,:).^2/(4*DiffusivityConstant*t));

end
