function r = profile_analysis(x1,y1,x2,y2,smooth,sharp_edges)
% analise profiles and return useful statistics 
% the results are composed in a struct. 
% the x1 is the top profile and should start at (1,0) and advances to (0,0)
% x2 profiles is bottom and starts at end of x1
% x1 -> top profile -> start at trailing edge
% x2 -> bot profile -> start at leading edge
% by E. Lins:
% Returns:
% .x1, .y1, .x2, .y2 : airfoil profiles (smoothed or not)
% .curv1, .curv2 : curvature of each section
% .xref : coordinates x of all points
% .thickness : thickness of profile in each point
% .mean : mean value of profile
% .xy1, .xy2 : vector [x y] containing center of curvature of profiles

if size(x1,1) == 1
  x1 = x1';
endif
if size(y1,1) == 1
  y1 = y1';
endif
if size(x2,1) == 1
  x2 = x2';
endif
if size(y2,1) == 1
  u2 = y2';
endif

% check profile consistency
if max(x1) ~= 1 
	warning('top profile does not start at 1.');
end
if min(x1) ~= 0 
	warning('top profile does not end at 0.');
end

if max(x2) ~= 1 
	warning('bottom profile does not end at 1.');
end
if min(x2) ~= 0 
	warning('bottom profile does not end at 0.');
end

% return smoothed profiles
r.x1 = x1;
r.y1 = y1;
r.x2 = x2;
r.y2 = y2;

%% radius of curvature
%r.curv1 = curvature(x1,y1)';
%r.curv2 = curvature(x2,y2)';

%as the x position of the two profiles could be diferent, we join them
xref = unique(sort([x1; x2])); 

% compute thickness
r.xref = xref;
r.thickness = abs(interp1(x1,y1,xref) - interp1(x2,y2,xref));

% mean line
r.mean = (interp1(x1,y1,xref) + interp1(x2,y2,xref))/2;

[rd, xc] = curvature(x1,y1);
r.curv1 = rd;
r.xy1 = xc;

[rd, xc] = curvature(x2,y2);
r.curv2 = rd;
r.xy2 = xc;

NP1 = numel(x1);
NP2 = numel(x2);

if sharp_edges(2) == 0 %% Trailing edge is smooth so set the same curvature at 
  % both start of top profile and end of bottom prof
  % compute curvatures and center position of endpoints
  [xy1, rad1] = points2circle([x1(1) y1(1)],...
    [x1(2) y1(2)],[x2(end-1) y2(end-1)]);
  r.curv1(1) = rad1;
  r.xy1(1,:) = xy1;
  %close all;
  %plot([x1(1) x1(2) x2(end-1)],[y1(1) y1(2) y2(end-1)],'ko')
  %hold on
  %plot(r.xy1(1,1),r.xy1(1,2),'r*')
  %trace_circle(r.xy1(1,1),r.xy1(1,2),r.curv1(1));
  [xy2, rad2] = points2circle([x2(end) y2(end)], ...
    [x2(end-1) y2(end-1)],[x1(2) y1(2)]);
  r.curv2(end) = rad2;
  r.xy2(end,:) = xy2;
  %close all;
  %plot([x1(2) x2(end) x2(end-1)],[y1(2) y2(end) y2(end-1)],'ko')
  %hold on
  %plot(r.xy2(NP,1),r.xy2(NP,2),'r*')
  %trace_circle(r.xy2(NP,1),r.xy2(NP,2),r.curv2(NP));
end

if sharp_edges(1) == 0 %% Leading edge is smooth so set the same curvature at 
  % both end of top profile and start of bottom prof
  % compute curvatures and center position of endpoints
  [xy1, rad1] = points2circle([x1(end-1) y1(end-1)],...
    [x1(end) y1(end)],[x2(2) y2(2)]);
  r.curv1(end) = rad1;
  r.xy1(end,:) = xy1;
  %close all;
  %plot([x2(2) x1(end) x1(end-1)],[y2(2) y1(end) y1(end-1)],'ko')
  %hold on
  %plot(r.xy1(NP,1),r.xy1(NP,2),'r*')
  %trace_circle(r.xy1(NP,1),r.xy1(NP,2),r.curv1(NP));

  [xy2, rad2] = points2circle([x2(2) y2(2)], ...
    [x2(1) y2(1)],[x1(end-1) y1(end-1)]);
  r.curv2(1) = rad2;
  r.xy2(1,:) = xy2;
  %close all;
  %plot([x2(2) x2(1) x1(end-1)],[y2(2) y2(1) y1(end-1)],'ko')
  %hold on
  %plot(r.xy2( 1,1),r.xy2(1 ,2),'r*')
  %trace_circle(r.xy2( 1,1),r.xy2( 1,2),r.curv2( 1));
end


if sharp_edges(2) == 1 % trailing edge is sharp 
	% use same curvature of 2nd point and just displace center of curvature
	% using the same displacement of 1st point
  r.xy1(1,1) = r.x1(1)-r.x1(2)+r.xy1(2,1);
  r.xy1(1,2) = r.y1(1)-r.y1(2)+r.xy1(2,2);
  r.curv1(1) = r.curv1(2);

  r.xy2(end,1) = r.x2(end)-r.x2(end-1)+r.xy2(end-1,1);
  r.xy2(end,2) = r.y2(end)-r.y2(end-1)+r.xy2(end-1,2);
  r.curv2(end) = r.curv2(end-1);

end
if sharp_edges(1) == 1 % leading edge is sharp 
  r.xy1(end,1) = r.x1(end)-r.x1(end-1)+r.xy1(end-1,1);
  r.xy1(end,2) = r.y1(end)-r.y1(end-1)+r.xy1(end-1,2);
  r.curv1(end) = r.curv1(end-1);

  r.xy2(1,1) = r.x2(1)-r.x2(2)+r.xy2(1,1);
  r.xy2(1,2) = r.y2(1)-r.y2(2)+r.xy2(1,2);
  r.curv2(1) = r.curv2(2);
end


return
