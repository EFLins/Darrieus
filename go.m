clc;
close all;
clear;

global NdivSplines;
NdivSplines = 5;

if (0)
	% Load normalized profile , chord lenght = 1
	xy = load('Naca_0012.txt');
else % obtain profile using formula
	x = linspace(0,1,1001);
	y = -5*0.12*(0.2969*sqrt(x) - 0.1260*x - 0.3516*x.^2+0.2843*x.^3-0.1015*x.^4);
	y= -0.594689181*(0.298222773*sqrt(x) - 0.127125232*x - 0.357907906*x.^2 + 0.291984971*x.^3 - 0.105174606*x.^4); % from https://turbmodels.larc.nasa.gov/naca0012_val.html
	xy =  [flip([x' -y']); [x(2:end)' y(2:end)']];
	xy(1,2) = 0; xy(end,2)=0;
end
x = xy(:,1);
y = xy(:,2);

%break profile in 2 (1): top (2): bot
ix1 = find(x==0);
x1 = x(1:ix1);
y1 = y(1:ix1);
x2 = x(ix1:end);
y2 = y(ix1:end);

r = profile_analysis(x1,y1,x2,y2,0,[0 1]);
%r = interpolate_profile(r,1);

if (1) 
  % center of circle to replace trailing edge tip
  xc = [0.99 0.00];
  Ndiv = 10;

  % get which points in profile after and before x center
  % (discover where to cut the profile)
  % check drawing.svg 
  d = r.x1 - xc(1);
  id1 = 1:numel(d); id1 = id1(d > 0)(end); % profile will be cut between id1 and id1+1 points
  p1 = [r.x1(id1) r.y1(id1)];
  p2 = [r.x1(id1+1) r.y1(id1+1)];
  dx  = norm(p1-p2);
  dc1 = norm(p1-xc);
  dc2 = norm(p2-xc);
  beta = acosd((dc2^2 - dc1^2 - dx^2)/(-2*dc1*dx));
  rd = dc1*sind(beta);
  alfa = asind((p1(2)-xc(2))/dc1);
  t = linspace(0,alfa+90-beta,Ndiv);
  
  xx = xc(1) + rd*cosd(t);
  yy = xc(2) + rd*sind(t);
  
  r.x1(1:id1) = [];
  r.y1(1:id1) = [];
  r.x1 = [xx'; r.x1; ];
  r.y1 = [yy'; r.y1; ];

  d = r.x2 - xc(1);
  id1 = 1:numel(d); id1 = id1(d > 0)(1);
  p1 = [r.x2(id1) r.y2(id1)];
  p2 = [r.x2(id1-1) r.y2(id1-1)];

  dx  = norm(p1-p2);
  dc1 = norm(p1-xc);
  dc2 = norm(p2-xc);
  beta = acosd((dc2^2 - dc1^2 - dx^2)/(-2*dc1*dx));
  rd = dc1*sind(beta);
  alfa = asind((p1(2)-xc(2))/dc1);
  t = linspace(alfa-90+beta,0,Ndiv);
 
  xx = xc(1) + rd*cosd(t);
  yy = xc(2) + rd*sind(t); 
  r.x2(id1:end) = [];
  r.y2(id1:end) = [];
  r.x2 = [r.x2; xx'];
  r.y2 = [r.y2; yy'];

end

if (0) 
  % center of circle to replace leading edge tip
  xc = r.xy1(end,:);
  
  Ndiv = 10;  
  % In leading edge cut the first point
  % check drawing.svg 
  p1 = [r.x1(end-1) r.y1(end-1)];
  p2 = [r.x2(2) r.y2(2)];

  alfa = atan2d(p1(2) - xc(2), p1(1) - xc(1));
  beta = atan2d(p2(2) - xc(2), p2(1) - xc(1));

  t = linspace(alfa,180,Ndiv);  
  xx = xc(1) + r.curv2(1)*cosd(t);
  yy = xc(2) + r.curv2(1)*sind(t);
  r.x1(end) = [];
  r.y1(end) = [];
  r.x1 = [ r.x1;xx';];
  r.y1 = [ r.y1;yy';];

  t = linspace(180,360+beta,Ndiv);  
  xx = xc(1) + r.curv2(1)*cosd(t);
  yy = xc(2) + r.curv2(1)*sind(t);
  r.x2(1) = [];
  r.y2(1) = [];
  r.x2 = [ xx'; r.x2];
  r.y2 = [ yy'; r.y2];

end

r = profile_analysis(r.x1,r.y1,r.x2,r.y2,0,[0 1]);
%r = interpolate_profile(r,4);

% create offsets
d_offset = 0.1;
[r.xo1 r.yo1] = compute_offset(r.x1,r.y1,r.xy1(:,1),r.xy1(:,2),r.curv1,d_offset);
[r.xo2 r.yo2] = compute_offset(r.x2,r.y2,r.xy2(:,1),r.xy2(:,2),r.curv2,d_offset);

plot(r.x1,r.y1,'bo-',r.x2,r.y2,'ro-');
axis equal;
return

subplot(3,1,1)
plot(r.xref,r.mean,r.x1,r.y1,'bo-',r.xo1,r.yo1,'ko-',r.x2,r.y2,'bo-',r.xo2,r.yo2,'ko-')
axis equal
subplot(3,1,2)
plot(r.xy1(:,1),r.xy1(:,2),'-o')

figure
plot(r.curv1,'o-')
figure
plot(r.x1,'o-')
figure
plot(r.y1,'o-')
%return

% invert point order
r.x1 = r.x1(end:-1:1);
r.y1 = r.y1(end:-1:1);
r.xy1 = r.xy1(end:-1:1,1);
r.xo1 = r.xo1(end:-1:1);
r.yo1 = r.yo1(end:-1:1);
r.curv1 = r.curv1(end:-1:1);

% turbine data
% external radius of moving zone
Rout = 3;
% internal radius of MZ
Rin  = 1;
% radius of turbine
R    = 2;

Nblades = 3;
angle = 360/Nblades;

yc = sqrt(R*R-0.5^2);
r = translate(r,[-0.5 yc]);

sh = -30;
cp = cosd(90+angle/2+sh);
sp = sind(90+angle/2+sh);
cl = cosd(90-angle/2+sh);
sl = sind(90-angle/2+sh);
ca = cosd(90-angle/2+sh+60);
sa = sind(90-angle/2+sh+60);

geo = [];
geo.number_points = 0;
geo.number_curves = 0;
[geo,pc] = add_point(geo,0,0); % central point

r1 = sqrt(r.xo2(1)^2+r.yo2(1)^2);
[geo, p2] = add_point(geo, r1*cp, r1*sp); 
[geo, p3] = add_point(geo, r.xo2(1), r.yo2(1)); %leading edge offset

r1 = sqrt(r.x2(1)^2+r.y2(1)^2);
[geo, p4] = add_point(geo, r.x2(1),r.y2(1)); %leading edge profile

r1 = sqrt(r.x2(end)^2+r.y2(end)^2);
[geo, p5] = add_point(geo, r.x2(end), r.y2(end)); %trailing edge profile
[geo, p6] = add_point(geo, r1*ca,r1*sa); %trailing edge offset

[geo, p7] = add_point(geo, Rin*cp,Rin*sp);
[geo, p8] = add_point(geo, Rin*cl,Rin*sl);
   
r1 = sqrt(r.xo2(end)^2+r.yo2(end)^2);
[geo, p9] = add_point(geo, r.xo2(end), r.yo2(end));
[geo, p10] = add_point(geo, r1*ca,r1*sa);

r1 = sqrt(r.xo1(end)^2+r.yo1(end)^2);
[geo, p11] = add_point(geo, r.xo1(end), r.yo1(end));
[geo, p12] = add_point(geo, r1*ca,r1*sa); 
[geo, p13] = add_point(geo, Rout*cp,Rout*sp);
[geo, p14] = add_point(geo, Rout*cl,Rout*sl);


N = NdivSplines;
[geo, id] = add_spline(geo,[r.x1 r.y1]); geo = break_spline(geo,id,NdivSplines);
[geo, id] = add_spline(geo,[r.x2 r.y2]); geo = break_spline(geo,id,NdivSplines);
[geo, id] = add_spline(geo,[r.xo1 r.yo1]); geo = break_spline(geo,id,NdivSplines);
[geo, id] = add_spline(geo,[r.xo2 r.yo2]); geo = break_spline(geo,id,NdivSplines);

%create lines connecting offsets to profiles
bump = 1.2;
for k=0:N-1
    pa1 = geo.line(k+1).p2;
    pa2 = geo.line(k+1+2*N).p2;
    geo = add_line(geo,pa1,pa2,bump);
end
for k=0:N-1    
    pa1 = geo.line(k+1+N).p2;
    pa2 = geo.line(k+1+3*N).p2;
    geo = add_line(geo,pa1,pa2,bump);    
end
geo = add_line(geo,p3,p4);

%geo = add_arc(geo,p5,p6,pc);
%geo = add_arc(geo,p9,p10,pc);
%geo = add_arc(geo,p11,p12,pc);
%geo = add_line(geo,p6,p10);
%geo = add_line(geo,p6,p12);
%
%geo = add_arc(geo,p7,p8,pc);
%geo = add_arc(geo,p13,p14,pc);
%
%geo = add_line(geo,p7,p13);
%geo = add_line(geo,p8,p14);

plotgeo(geo)
axis equal
writegeo(geo)
plot(r.x1,r.y1,'bo-',r.xo1,r.yo1,'ko-', ...
r.x2,r.y2,'bo-',r.xo2,r.yo2,'ko-')
axis equal


