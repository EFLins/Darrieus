function [R, xc] = curvature(x,y)
% curvature calculation
% Given a set of points (x,y) compute the radius of curvature, or the radius of
% circle passing by three consecutive points.
% by Erb Lins.
% if no data is sent, shows results for a ellipsis

if (nargin == 0 ) % use a ellipsis to compute
	a=2 ; b=3; 
	np = 351; % number of points on my ellipsis
	%r=1; % radius 
	t=linspace(0,pi,np); % the variation of your angle
	x=[b*cos(t)]'; % the x coordinate
	y=[a*sin(t)]';
end
np = length(x);
R = zeros(np,1);
xc = zeros(np,2);

for k = 2:np-1
	x1 = x(k-1); y1 = y(k-1); 
	x2 = x(k  ); y2 = y(k  ); 
	x3 = x(k+1); y3 = y(k+1); 
	[xy,r] = points2circle([x1 y1],[x2 y2],[x3 y3]);
	R(k) = r;
	xc(k,:) = xy;
end
R(1) = R(2);
R(np) = R(np-1);

if(nargin ==0) 
	subplot(2,1,1), plot(x,y); title('Curve');
	subplot(2,1,2), plot(x,R); title('Radius');
end

return

