function trace_circle(x,y,r)

if (nargin == 0)
	x = 1;
	y = 2;
	r = 1.5;
end
teta = linspace(0,2*pi,180);
dt = teta(2);

for t = teta
	hold on;
	plot([r*cos(t)+x r*cos(t+dt)+x],[r*sin(t)+y r*sin(t+dt)+y],'-');
end
