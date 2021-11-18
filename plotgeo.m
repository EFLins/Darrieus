function plotgeo(geo)
  point = geo.point;
  for k=1:numel(point)
    if ~isempty(point(k).x)
#      h = text(point(k).x, point(k).y,sprintf("%d",k));
#      set(h,'fontsize',18);
    endif
  endfor
  
  for k = 1:numel(geo.line)
    line = geo.line(k);
    p1 = line.p1;
    p2 = line.p2;
    if line.rad == 0 
      hold on;
      plot([point(p1).x point(p2).x],[point(p1).y point(p2).y]);
      mx = mean([point(p1).x point(p2).x]);
      my = mean([point(p1).y point(p2).y]);
      h = text(mx,my,sprintf("line %d",k));
      set(h,'fontsize',18);
    elseif line.rad == -1
      continue;
    elseif line.rad > 0.0
      hold on;
      Nres = 20; % resolution
      a = linspace(line.a1,line.a2,Nres);
      xx = line.rad*cosd(a);
      yy = line.rad*sind(a);
      plot(xx,yy);
      h = text(xx(Nres/2),yy(Nres/2),sprintf("arc %d",k));
      set(h,'fontsize',18);      
    else
      printf("Error: surface not identified!\n");
    endif
  endfor
  

endfunction
