function tscaleAll= tscaleFun (tair, landCover)

Topt=20; Tmax=40;

if strmatch('CRO', landCover)==1;
    Tmin=5;
else
    Tmin=0;
end;

index1=tair<=Tmin;
index2=tair>=Tmax;

tscaleNumerator = (tair-Tmin).*(tair-Tmax);
tscaleDenominator= (tair-Tmin).*(tair-Tmax)-(tair-Topt).^2;
tscaleAll = tscaleNumerator./tscaleDenominator;

tscaleAll(index1)=0;
tscaleAll(index2)=0;

