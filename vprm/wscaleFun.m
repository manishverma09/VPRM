function wscaleAll= wscaleFun (lswi366) 

% Sort 
sortLswi=sort(lswi366, 'ascend');

% Remove NAN
nanIndex = isnan(sortLswi);  
sortLswi = sortLswi (~nanIndex);

% Take max
sortLswi = sortLswi(end-31:end);
maxLswi = nanmean(sortLswi);

% Calculate wscale
wscaleAll = (1+lswi366)./(1+maxLswi);

wscaleAll (wscaleAll>1)= 1;
wscaleAll (wscaleAll < 0) = 0;
