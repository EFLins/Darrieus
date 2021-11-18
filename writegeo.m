function writegeo(geo)
global NdivSplines;

point = geo.point;
  
fp = fopen('delme.geo','w');
%fprintf(fp,'SetFactory("OpenCASCADE");\n');
fprintf(fp,'lc = 0.20;\n');
for k=1:geo.number_points
    fprintf(fp,'Point(%d) = {%f,%f,lc};\n',k,point(k).x, point(k).y);
endfor

for k = 1:geo.number_curves
  line = geo.line(k);
  p1 = line.p1;
  p2 = line.p2;
  if line.rad == 0 
    fprintf(fp,'Line(%d) = {%d,%d};\n',k,p1,p2);    
  elseif line.rad == -1
    fprintf(fp,'BSpline(%d) = {%d:%d};\n',k,p1,p2);
  else
    fprintf(fp,'Circle(%d) = {%d,%d,%d};\n',k,p1,line.idc,p2);          
  end
endfor
%write bumps for all lines
fprintf(fp,'bumps = [ %f ',geo.line(1).bump);          
for k = 2:geo.number_curves
     fprintf(fp,', %f ',geo.line(k).bump);          
endfor
fprintf(fp,' ];\n');          

fprintf(fp,'Coherence;\nNP =20; \n');          
fprintf(fp,'For i In {1:%d} \n',geo.number_curves-4);          
fprintf(fp,' Transfinite Line {i} = NP Using Progression bumps{i};  \n');          
fprintf(fp,'EndFor \n');          

fprintf(fp,'For i In {%d:%d} \n',geo.number_curves-3,geo.number_curves);
fprintf(fp,' Transfinite Line {i} = 5*NP Using Progression bumps{i};;  \n');          
fprintf(fp,'EndFor \n');          


N = NdivSplines;
for n=2:N
  fprintf(fp,'Line Loop(%d) ={%d,%d,-%d,-%d}; \n',n,n,4*N+n,2*N+n,4*N+n-1);
  fprintf(fp,'Line Loop(%d) ={%d,%d,-%d,-%d}; \n',n+N,N+n,N+4*N+n,N+2*N+n,N+4*N+n-1);  
endfor
n = 1;
fprintf(fp,'Line Loop(%d) ={%d,%d,-%d,%d}; \n',n,n,6*N+1,2*N+n,4*N+n);
fprintf(fp,'Line Loop(%d) ={-%d,-%d,%d,-%d}; \n',n+N,N+n,6*N+1,N+2*N+n,N+4*N+n);  

n = 6*N+2;
fprintf(fp,'Line Loop(%d) ={-%d,%d,%d,-%d}; \n',2*N+1,5*N,n,n+4,n+2);
fprintf(fp,'Line Loop(%d) ={%d,-%d,%d,-%d}; \n',2*N+2,n-2,n,n+1,n+3);  

fprintf(fp,'Line Loop(%d) ={%d,-%d,%d,-%d,-%d:-%d,%d:%d}; \n',2*N+3,n+2,n+4,n+3,n+1,4*N,3*N+1,2*N+1,3*N);

n = 6*N+7;
fprintf(fp,'Line Loop(%d) ={%d,-%d,-%d,%d}; \n',2*N+4,n,n+1,n+2,n+3);

fprintf(fp,'For i In {1:%d}\n', 2*N+2);  
fprintf(fp,'	Plane Surface(i) = i;\n');  
fprintf(fp,'  	Transfinite Surface {i};\n');  
fprintf(fp,'	Recombine Surface {i};	\n');  
fprintf(fp,'EndFor\n');  

fprintf(fp,'	Plane Surface(%d) = {%d,%d};\n',2*N+3,2*N+4,2*N+3);  

fclose(fp);
return  
  
endfunction
