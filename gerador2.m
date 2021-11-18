%%
clear;
close all;
clc;

DIST = 0.5;
ControlPoints = {[0 0]; [1,0]};
ControlLines  = { [1 2]; [0 0] };

%[p1, p2] = airfoil('naca9212');
% [p1, p2] = airfoil('raf27');
% [p1, p2] = airfoil('selig');
%[p1, p2] = airfoil('eppler472');
[p1, p2] = airfoil('naca0009');

x1  = p1(:,1);
y1  = p1(:,2);

x2  = p2(:,1);
y2  = p2(:,2);

r = profile_analysis(x1,y1,x2,y2,1);

NP = 2;
xmax = r.xref( r.thickness==max(r.thickness));
xmax = xmax(1);

%% top offset
npoints = size(x1,1);
xyoff1 = zeros(npoints,2);
for k=npoints-1:-1:2 % do from leading to trailing

	%compute line joining points at each side
	m = (y1(k+1)-y1(k-1))/(x1(k+1)-x1(k-1));
	m = -1/m;
	% draw normal line from current point
	% compute 2 solutions, these points are same distance
	x_1 = x1(k) - DIST/sqrt(m^2+1); x = x_1;
	y_1 = y1(k) + m*(x_1-x1(k));    y = y_1;
	
	x_2 = x1(k) + DIST/sqrt(m^2+1);
	y_2 = y1(k) + m*(x_2-x1(k));
	
	% check if curvature is ok, for first 10 points put them above
	if (k > (npoints-10) )
		if (y < y1(k))
			x = x_2;
			y = y_2;	
		end
	else
		% use the proximity to the last point to select from two choices
		d1 = (x_1-xyoff1(k+1,1))^2+(y_1-xyoff1(k+1,2))^2;
		d2 = (x_2-xyoff1(k+1,1))^2+(y_2-xyoff1(k+1,2))^2;
		if (d2 < d1)
			x = x_2; y = y_2;
		end
		% here we check if offset is calculated to move backwards
		% if so, we push forward
		if (x < xyoff1(k+1,1))
			x = 2*xyoff1(k+1,1)-xyoff1(k+2,1);
			y = 2*xyoff1(k+1,2)-xyoff1(k+2,2);
		end
	end
	
	xyoff1(k,:) = [x y];
% 	plot(x1,y1,'g.-',x2,y2,'m.-',...
%  	xyoff1(:,1),xyoff1(:,2),'.-',xe,ye,xl,yl);
% 	drawnow;
% 	shg;
% 	pause
end

%% bottom offset
npoints = size(x2,1);
xyoff2 = zeros(npoints,2);
for k=2:npoints-1

	m = (y2(k+1)-y2(k-1))/(x2(k+1)-x2(k-1));
	m = -1/m;

	% draw normal line from current point
	% compute 2 solutions, these points are same distance
	x_1 = x2(k) - DIST/sqrt(m^2+1); x = x_1;
	y_1 = y2(k) + m*(x_1-x2(k));    y = y_1;
	
	x_2 = x2(k) + DIST/sqrt(m^2+1);
	y_2 = y2(k) + m*(x_2-x2(k));
	
	% check if curvature is ok, for first 10 points put them above
	if (k < 10 )
		if (y > y2(k))
			x = x_2;
			y = y_2;	
		end
	else
		% use the proximity to the last point to select from two choices
		d1 = (x_1-xyoff2(k-1,1))^2+(y_1-xyoff2(k-1,2))^2;
		d2 = (x_2-xyoff2(k-1,1))^2+(y_2-xyoff2(k-1,2))^2;
		if (d2 < d1)
			x = x_2; y = y_2;
		end
		% here we check if offset is calculated to move backwards
		% if so, we push forward
		if (x < xyoff2(k-1,1))
			x = 2*xyoff2(k-1,1)-xyoff2(k-2,1);
			y = 2*xyoff2(k-1,2)-xyoff2(k-2,2);
		end
	end

	xyoff2(k,:) = [x y];

end


%% point before head
m = (xyoff1(end-1,2)-xyoff2(2,2))/(xyoff1(end-1,1)-xyoff2(2,1));
m = -1/m;
x = x2(1) - DIST/sqrt(m^2+1);
y = y2(1) + m*(x-x2(1));
if (x > x2(1))
	x = x2(1) + DIST/sqrt(m^2+1);
	y = y2(1) + m*(x-x2(1));	
end
% add this point to offsets
xyoff1(end,:) = [x y];
xyoff2(1,:)   = [x y];

%% correct tail points of offsets
xyoff1(1,:) = xyoff1(2,:);
xyoff2(end,:) = xyoff2(end-1,:);

plot(x1,y1,'g.-',x2,y2,'m.-',...
 	xyoff1(:,1),xyoff1(:,2),'.-',xyoff2(:,1),xyoff2(:,2),'.-')

%% get point nearest xmax on top
dif = abs(x1 - xmax);
id = min(dif) == dif; pos = 1:length(dif); k = min(pos(id));

xv = [x1(k) xyoff1(k,1)]; yv = [y1(k) xyoff1(k,2)];
ControlPoints{3} = [x1(k) y1(k)]; 
ControlPoints{4} = [xyoff1(k,1) xyoff1(k,2)]; 

%% get point in the middle top
% total distance
sum = 0;
for j=(length(x1)-1):-1:k
	sum = sum + sqrt ( (x1(j)-x1(j+1))^2 + (y1(j)-y1(j+1))^2 );
end
s = 0;
for j=(length(x1)-1):-1:k
	s = s + sqrt ( (x1(j)-x1(j+1))^2 + (y1(j)-y1(j+1))^2 );
	if ( s > sum/4 )
		break;
	end
end
k = j;
xs = [x1(k) xyoff1(k,1)]; ys = [y1(k) xyoff1(k,2)];
ControlPoints{5} = [x1(k) y1(k)]; 
ControlPoints{6} = [xyoff1(k,1) xyoff1(k,2)]; 

%% get point nearest xmax on bottom
dif = abs(x2 - xmax);
id = min(dif) == dif; pos = 1:length(dif); k = min(pos(id));
xr = [x2(k) xyoff2(k,1)]; yr = [y2(k) xyoff2(k,2)];
ControlPoints{7} = [x2(k) y2(k)]; 
ControlPoints{8} = [xyoff2(k,1) xyoff2(k,2)]; 

%% get point in the middle bottom
% total distance
sum = 0;
for j=1:k
	sum = sum + sqrt ( (x2(j)-x2(j+1))^2 + (y2(j)-y2(j+1))^2 );
end
s = 0;
for j=1:k
	s = s + sqrt ( (x2(j)-x2(j+1))^2 + (y2(j)-y2(j+1))^2 );
	if ( s > sum/4 )
		break;
	end
end

k = j;
xt = [x2(k) xyoff2(k,1)]; yt = [y2(k) xyoff2(k,2)];
xh = [x2(1) xyoff2(1,1)]; yh = [y2(1) xyoff2(1,2)];
ControlPoints{9}  = [x2(k) y2(k)]; 
ControlPoints{10} = [xyoff2(k,1) xyoff2(k,2)]; 


%% the block
angle = 0; % in degrees
DOUT = 0.5;
L = 0.5;
H = DIST;

xo = [0 0; 0 -H; L -H; L 0; L H; 0 H;];
Q = [cosd(angle) sind(angle); -sind(angle) cosd(angle)];
for k=1:size(xo,1)
	xo(k,:) = (Q*(xo(k,:)'))';
end
yo = xo(:,2); xo(:,2) =[];
xo = xo + 1 + DOUT*cosd(angle);
yo = yo + DOUT*sind(-angle);
for k=1:size(xo,1)
	ControlPoints{end+1} = [xo(k) yo(k)];
end

%% The trail
% calc angle at top offset
m = (xyoff1(1,2)-y1(1))/(xyoff1(1,1)-x1(1));
bet = atand(-1/m);
cut = (angle+bet)/2;
% find nearest point in top off 
xc = 1 + DIST*cosd(cut+90);
yc = DIST*sind(cut+90);
if (xc > xyoff1(1,1)) % add to offset
	xyoff1 = [xc yc; xyoff1];
else % cut out some
	id = xyoff1(:,1) < xc; % only at right
	xyoff1 = xyoff1(id,:);
end

% calc angle at bot offset
m = (xyoff2(end,2)-y2(end))/(xyoff2(end,1)-x2(end));
bet = atand(-1/m);
cut = (angle+bet)/2;
% find nearest point in top off 
xc = 1 + DIST*cosd(cut-90);
yc = DIST*sind(cut-90);
if (xc > xyoff2(end,1)) % add to offset
	xyoff2 = [xyoff2; xc yc];
else % cut out some
	id = xyoff2(:,1) < xc; % only at right
	xyoff2 = xyoff2(id,:);
end

%% add final control points and define lines
ControlPoints{end+1} = xyoff1(1,:);
ControlPoints{end+1} = xyoff2(end,:);
ControlPoints{end+1} = xyoff2(1,:);


ControlLines{2}     = [9 10];
ControlLines{end+1} = [5 6];
ControlLines{end+1} = [3 4];
ControlLines{end+1} = [7 8];
ControlLines{end+1} = [2 18];
ControlLines{end+1} = [2 17];
ControlLines{end+1} = [16 11];
ControlLines{end+1} = [11 12];
ControlLines{end+1} = [18 12];
ControlLines{end+1} = [17 16];
ControlLines{end+1} = [19 1];
ControlLines{end+1} = [2 11];
ControlLines{end+1} = [15 16];
ControlLines{end+1} = [14 15];
ControlLines{end+1} = [13 14];
ControlLines{end+1} = [12 13];
ControlLines{1} = [14 11];

% define that lines above are all straigt lines
Lt = cell(size(ControlLines,1),1);
for k=1:size(ControlLines,1)
	l = ControlLines{k};
	Lt{k} = [ ControlPoints{l(1)}; ControlPoints{l(2)}];
end

%% Add lines that belong to profiles and offsets
for j=1:4
	switch j
		case 1
			xd = x1; yd = y1;
		case 2
			xd = x2; yd = y2;
		case 3
			xd = xyoff1(:,1); yd = xyoff1(:,2); 
		case 4
			xd = xyoff2(:,1); yd = xyoff2(:,2);
	end
			
	% now walk throug profiles and and offset and copy them as control lines
	pini = 0;
	for i=1:size(xd)
		for k=1:size(ControlPoints,1)
			% check if this CnP belongs to profile
			x = ControlPoints{k};
			if (xd(i) == x(1)) && (yd(i) == x(2))
				if pini ~= 0 % enter here only if has a point before	
					ControlLines{end+1} = [pini k];
					Lt{size(ControlLines,1)} = [xd(ini:i) yd(ini:i)];
				end
				pini = k; 
				ini = i;
			end
		end
	end
end

%% plot
cla;
for k=1:size(ControlPoints,1)
	x = ControlPoints{k};
	text(x(1),x(2),sprintf('P%2.2d',k));
end

hold on;
for k=1:size(ControlLines,1)
	l = Lt{k};
	plot(l(:,1),l(:,2));
	x = mean(l);
	text(x(1),x(2),sprintf('L%2.2d',k));
end

% plot(x1,y1,'g.-',x2,y2,'m.-',...
% 	xyoff1(:,1),xyoff1(:,2),'.-',xyoff2(:,1),xyoff2(:,2),'.-');
axis([-1 3 -1 1])
axis equal

pts = [xyoff1(:,1),xyoff1(:,2)
     xyoff2(:,1),xyoff2(:,2)];
pts(33,:) =[];     
pts = [0.*pts(:,1)+1 (1:size(pts,1))' pts 0.*pts(:,1)];
     
