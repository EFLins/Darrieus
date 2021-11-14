function [s, idline] = add_line(r,id1,id2,bump)
  s = r;
  s.number_curves = s.number_curves + 1;
  idline = s.number_curves;
  s.line(idline).p1 = id1;
  s.line(idline).p2 = id2;
  if nargin == 3
    bump = 1.0;
  end
  s.line(idline).bump = bump;
  
% its a line      
    s.line(idline).rad = 0;
    s.line(idline).a1 = 0;
    s.line(idline).a2 = 0;
  
endfunction
