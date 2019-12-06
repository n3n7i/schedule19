

function s0(mat)

  n = prod(size(mat));

  matb = copy(mat);

  c = [CartesianIndex(0,0)];

  v = [0.0]; 

  r = maximum(vec(mat)) +1;

  clist = [];

  for iter = 1:n

    findmin!(v, c, matb);

    push!(clist, c[1]);

    matb[c[1]] = r;

    end;

  return clist;

  end;


function Ordered_findnext(f, mat, cpos, clist)

  ind = findnext(x->x==cpos, clist, 1);

  n = size(clist,1);

  for iter = ind:n

    if(f(mat[clist[iter]])) return clist[iter]; end;

    end;

  return nothing;

  end;




