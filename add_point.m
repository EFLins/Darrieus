function [s, id] = add_point(r,x,y)
  s = r;
  s.number_points = s.number_points + 1;
  id = s.number_points;

  s.point(id).x = x;
  s.point(id).y = y;

endfunction
