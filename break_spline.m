function s = break_spline(r,id,N)


list = r.line(id).list;
np = size(list,1);
nchunk = ceil(np/N);
id1 = id;

ranges = r.line(id).p1:nchunk:r.line(id).p2;
N = numel(ranges);
if (ranges(end) ~= r.line(id).p2)
  ranges(end+1) = r.line(id).p2;
  N = N+1;
endif

for j = 1:N-1
  n1 = ranges(j);
  n2 = ranges(j+1);
  if (j~=1)
    [r, id1] = add_line(r,n1,n2);
  endif

  indx = (n1:n2) - ranges(1) + 1;
  r.line(id1).list = list(indx,:);
  r.line(id1).rad = -1;
  r.line(id1).p1 = n1;
  r.line(id1).p2 = n2;

endfor
  
s = r;
endfunction
