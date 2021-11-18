function r = interpolate_profile(prof,level)

r = prof;

xi = prof.x1;
yi = prof.y1;
NN = numel(xi);  
n = 1:NN;
m = linspace(1,NN,level*NN-1)';
xi = interp1(n,xi,m,'spline');
yi = interp1(n,yi,m,'spline');        % interpolate new profiles
r.x1 = sortrows([xi yi],-1);            % top profile in reverse
r.y1 = r.x1(:,2); r.x1(:,2) = [];            % save data
r.curv1 = interp1(n,prof.curv1,m,'spline'); 
r.xy1 = interp1(n,prof.xy1,m,'spline'); 

xi = prof.x2;
yi = prof.y2;
NN = numel(xi);  
n = 1:NN;
m = linspace(1,NN,level*NN-1)';
xi = interp1(n,xi,m,'spline');
yi = interp1(n,yi,m,'spline');   
r.x2 = sortrows([xi  yi]);            
r.y2 = r.x2(:,2); r.x2(:,2) = [];            % save data
r.curv2 = interp1(n,prof.curv2,m,'spline'); 
r.xy2 = interp1(n,prof.xy2,m,'spline'); 


  
endfunction
