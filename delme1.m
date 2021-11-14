x = linspace(0.9,1,5000);

damp = @(x) 0.02*exp(-50*abs(1-x)).*sqrt(1-x);
ddamp =  @(x) exp(-50*abs(1-x)).*(0.01*abs(1-x)+(1-x).*x)./(sqrt(x).*abs(1-x));
d2damp = @(x) (exp(-50*abs(x - 1)).*((x .*(x .*(50*x - 50) - 0.005) + 0.005).* abs((1 - x).^3) - (1 - x).^4 .*x))./((x - 1).*x.^(3/2).*abs((x - 1).^3))

%plot(x,damp(x))

plot(x,y(x),x,y(x)-damp(x),...
x,-y(x),x,-y(x)+damp(x))

axis equal

%plot(x,ddamp(x))