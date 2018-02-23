function sse = von_mises_fit(p,x,y)

%% function
yf = p(1)*exp(p(2)*cos(x-p(3)));

%% error
error = yf - y;

%% error^2
% When curvefitting, a typical quantity to
% minimize is the sum of squares error
sse = sum(error.^2);

end