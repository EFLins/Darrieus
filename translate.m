function s = translate(r, delta)
  
  s = r;
  s.x1  = r.x1 + delta(1);
  s.x2  = r.x2 + delta(1);
  s.xo1 = r.xo1 + delta(1);
  s.xo2 = r.xo2 + delta(1);
  s.y1  = r.y1 + delta(2);
  s.y2  = r.y2 + delta(2);
  s.yo1 = r.yo1 + delta(2);
  s.yo2 = r.yo2 + delta(2);
  s.xy1  = r.xy1 + delta;
  s.xy2  = r.xy2 + delta;
  s.mean = r.mean + delta(2);
  s.xref = r.xref + delta(1);
  
endfunction
