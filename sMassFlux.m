function [ sourceMassFlux ] = sMassFlux(t, sMassFluxFunc1,sMassFluxFunc2)

sourceMassFlux(:,1) = sMassFluxFunc1(t);
sourceMassFlux(:,2) = sMassFluxFunc2(t);

end
