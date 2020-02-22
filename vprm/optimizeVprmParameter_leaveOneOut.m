function x = optimizeVprmParameter_leaveOneOut( par, tscale, wscale, pscale, evi, gpp, noOfSt_, algorithmChoice, st_, lb_, ub_)


%% Remove unrealistic values of each scalar

pscale(pscale<0)=nan;
pscale(pscale>1)=nan;

tscale(tscale<0)=nan;
tscale(tscale>1)=nan;

wscale(wscale<0)=nan;
wscale(wscale>1)=1;   % make greater than one as one, sicne we are taking mean of four for max (see above)

gpp(gpp<0)=nan;
par(par<0)=nan;


%% Clean up
index1=isnan(par) | isnan(pscale) | isnan(tscale)| isnan(wscale)| isnan(evi) | isnan(gpp);

par=par(~index1); pscale=pscale(~index1); tscale=tscale(~index1);
wscale=wscale(~index1); evi=evi(~index1); gpp=gpp(~index1);

%% Optimize only if there are more than 180 valid values.

%% Optimize
if numel(par)>180
    
    
    
    f = @(parameterVec)objectiveFunction_vprm(parameterVec,pscale, tscale, wscale, par, evi, gpp);
    
    
    if strcmp('TR', algorithmChoice)==1
        
        x=nan(noOfSt_,2); resnorm=nan(noOfSt_,1); exitflag=nan(noOfSt_,1);
        [x(1,1:2),resnorm(1,1),~,exitflag(1,1)] = lsqnonlin(f,st_, lb_, ub_);
        
        k=1;
        while exitflag<=0
            [x(1,1:2),resnorm(1,1),~,exitflag(1)] = lsqnonlin(f,x, lb_, ub_);
            k=k+1;
            if k==25
                break
            end;
        end;
        
        %    Now generate 999 random vector between lower and upper bound and use as
        %   starting point.
        
        for r11=1:noOfSt_-1
            st1_=lb_+(ub_-lb_).*rand(1,1);
            [x(r11+1,1:2),resnorm(r11+1,1),~,exitflag(r11+1,1)] = lsqnonlin(f,st1_, lb_, ub_);
        end;
        
        allX = x;
        minResnorm=find(resnorm==min(resnorm));
        bestX=x(minResnorm(1,1),:);
        
    elseif strcmp('LM', algorithmChoice)==1
        
        options1=optimset('algorithm', {'levenberg-marquardt',.005});
        
        x=nan(noOfSt_,2); resnorm=nan(noOfSt_,1); exitflag=nan(noOfSt_,1);
        [x(1,1:2),resnorm(1,1),~,exitflag(1,1)] = lsqnonlin(f,st_,[], [],options1);
        
        k=1;
        while exitflag<=0
            [x(1,1:2),resnorm(1,1),~,exitflag(1)] = lsqnonlin(f,st_,[], [],options1);
            k=k+1;
            if k==25
                break
            end;
        end;
        
        %    Now generate 999 random vector between lower and upper bound and use as
        %   starting point.
        
        for r11=1:noOfSt_-1
            st1_=lb_+(ub_-lb_).*rand(1,1);
            [x(r11+1,1:2),resnorm(r11+1,1),~,exitflag(r11+1,1)] = lsqnonlin(f,st1_,[], [],options1);
        end;
        %% Choose the one with minimum residual.
        allX = x;
        minResnorm=find(resnorm==min(resnorm));
        bestX=x(minResnorm(1,1),:);
    else
        error('Choose TR or LM')
    end;
else
    x=[nan, nan];
end;

x.bestX = bestX;
x.allX = allX;
