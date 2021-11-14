function [xo yo] = compute_offset(x,y,xc,yc,ra,d)
  
  % ra : curvature radius
  % d:  offset
  xo = xc + (ra+d)./ra.*(x-xc);
  yo = yc + (ra+d)./ra.*(y-yc);
  
endfunction
