function [ sinkMassFlux ] = kMassFlux(t, massFlowFunc1, massFlowFunc2 )

sinkMassFlux(:,1) = massFlowFunc1(t);
sinkMassFlux(:,2) = massFlowFunc2(t);

end
