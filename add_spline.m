function [s, idline] = add_spline(r,listp)
  s = r;
  s.number_curves = s.number_curves + 1;
  idline = s.number_curves;

  s.line(idline).rad = -1; 
  s.line(idline).list = listp;
  s.line(idline).bump = 1.0;
 
  np = size(listp,1);
  [s, shift] = add_point(s,listp(1,1),listp(1,2));
  for k=2:np
    [s, iend] = add_point(s,listp(k,1),listp(k,2));
  endfor
  s.line(idline).p1 = shift;
  s.line(idline).p2 = iend;
  
endfunction
