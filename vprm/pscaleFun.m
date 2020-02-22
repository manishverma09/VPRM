function pscaleAll= pscaleFun (sosEos, lswi, landCover)

% Check 

if numel (lswi)~= 366
   error ('Wrong size of lswi');
end;

%%

if strmatch('ENF', landCover)==1
    pscaleAll=repmat(1, 366,1);
elseif strmatch('EBF', landCover)==1
    pscaleAll=repmat(1, 366,1);
else
    if isnan (sosEos (3)) ==1
        sos=round(sosEos(1));
        eos=round(sosEos(2));
        if eos>sos
            gpl=eos-sos;
            maturity=round(sos+gpl/4);
            senescence=round(sos+3*gpl/4);
            pscaleAll=(1+lswi)/2;
            pscaleAll(maturity:senescence)=1; % Full canopy pscale is one.
            pscaleAll (1:sos)  = nan;  % undefined before bud burst
            pscaleAll (eos:end) = nan;
        elseif eos<sos
            timeP1=round(eos/2);
            timeP2=round((365-sos)/2);
            timeP2=sos+timeP2;
            pscaleAll=(1+lswi)/2;
            pscaleAll(1:timeP1)=1;    % Day 1 to starat of senescence
            pscaleAll(timeP2:366)=1;  % Maturity to day 366
            pscaleAll (eos:sos) = nan;
        end;
    elseif sosEos (3) == 160  % for one site sos1=50, eos1=140, sos2=160, eos2=290;
        sos1 = round(sosEos(1));
        eos1 = round(sosEos(2));
        gpl1 = eos1-sos1;
        maturity1 = round(sos1+gpl1/4);
        senescence1 = round(sos1+3*gpl1/4);
        sos2 = round(sosEos(3));
        eos2 = round (sosEos(4));
        gpl2 = eos2-sos2;
        maturity2 = round(sos2+gpl2/4);
        senescence2 = round(sos2+3*gpl2/4);
        pscaleAll=(1+lswi)/2;
        pscaleAll(maturity1:senescence1) = 1;
        pscaleAll(maturity2:senescence2) = 1;
        pscaleAll (1:sos1) = nan;
        pscaleAll (eos1:sos2) = nan;
        pscaleAll (eos2:end) = nan;
        
    elseif sosEos (3) == 275  %sos1=1, eos1=255, sos2=275, eos2=365
        sos1 = round (sosEos(1));
        eos1 = round (sosEos(2));
        gpl1 = eos1-sos1;
        maturity1 = round(sos1+gpl1/4);
        senescence1 = round(sos1+3*gpl1/4);
        sos2 = round (sosEos(3));
        eos2 = round (sosEos(4));
        gpl2 = eos2-sos2;
        maturity2 = round(sos2+gpl2/4);
        senescence2 = round(sos2+3*gpl2/4);
        pscaleAll =(1+lswi)/2;
        pscaleAll(maturity1:senescence1) = 1;
        pscaleAll(maturity2:senescence2) = 1;
        pscaleAll (eos1:sos2) = nan;
    else
        error('Sos and eos values may be wrong');
    end
end;

