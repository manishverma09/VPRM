function fVprm = objectiveFunction_vprm_dirAndDiffuse(parameterVec, pscale, tscale, wscale, directPar, diffusePar, evi, towerGpp)

% This function is used in "lsqnonline" as an objective function.
%parameterVec is a two element vector: epsilonMax (written as lambda in  and parZero). 
% Variables are air temperature, vapor pressure deficit, gpp and
% aAPAR=fpar*PAR OR evi*PAR.
%% IMPORTANT ------------
%         MAKE SURE PARAMETERS AND INPUT VARIABLES ARE IN SAME UNITS 
halfSaturationDir = (1./(1+(directPar/parameterVec(1))));
halfSaturationDiffuse =  (1./(1+(diffusePar./parameterVec(2))));

dirComponent = (parameterVec(3).* pscale.*tscale.*wscale.*halfSaturationDir.*directPar.*evi);
                  
diffuseComponent = (parameterVec(4).* pscale.*tscale.*wscale.*halfSaturationDiffuse.*diffusePar.*evi);

fVprm = towerGpp - (dirComponent + diffuseComponent);


%fVprm = towerGpp-((parameterVec(1).* pscale.*tscale.*wscale.*halfSaturationDir.*directPar.*evi) + (parameterVec(3).* pscale.*tscale.*wscale.*halfSaturationDiffuse.*diffusePar.*evi));
