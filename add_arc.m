function [s, idcurv] = add_arc(r,id1,id2,idcenter,bump)
  s = r;
  s.number_curves = s.number_curves + 1;
  idline = s.number_curves;
  s.line(idline).p1 = id1;
  s.line(idline).p2 = id2;
  if nargin == 4
    bump = 1.0;
  end
  s.line(idline).bump = bump;
  
% its a arc
    xy1 = r.point(id1);
    xy2 = r.point(id2);
    xyc = r.point(idcenter);
    dx = xy1.x-xyc.x;
    dy = xy1.y-xyc.y;
    a1 = atan2d(dy,dx);
    if (a1 < 0) 
      a1 = 180-a1;
    end
    dx = xy2.x-xyc.x;
    dy = xy2.y-xyc.y;    
    a2 = atan2d(dy,dx);
    if (a2 < 0) 
      a2 = 180-a2;
    end
    s.line(idline).rad = sqrt(dx^2+dy^2);
    s.line(idline).a1 = a1;
    s.line(idline).a2 = a2;
    s.line(idline).idc = idcenter;
  
endfunction
