function fVprm = objectiveFunction_vprm(parameterVec, pscale, tscale, wscale, par, evi, towerGpp)

% This function is used in "lsqnonline" as an objective function.
%parameterVec is a two element vector: epsilonMax (written as lambda in  and parZero). 
% Variables are air temperature, vapor pressure deficit, gpp and
% aAPAR=fpar*PAR OR evi*PAR.
%% IMPORTANT ------------
%         MAKE SURE PARAMETERS AND INPUT VARIABLES ARE IN SAME UNITS 

fVprm = towerGpp-parameterVec(1).* pscale.*tscale.*wscale.* (1/(1+(par/parameterVec(2)))).*par.*evi;
