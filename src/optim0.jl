

function set_initial(data, r=1)

  t = zeros(Int, 5000,1);

  c = zeros(Int, 100,1);

  n = size(data,1);

  for iter = 1:n

    t[iter] = data[iter, r+1];

    c[t[iter]] += data[iter, 12];

    end;

  return c,t;

  end;



function popcount(data)

  ccs = zeros(Int, 100,1);

  for iter=1:10

    wa,wb = set_initial(data, iter);

    ccs += wa ./ iter;

    end;

  return ccs;

  end;


function grid_connect!(t, grid=zeros(Int, 5000, 100));

  n = size(t,1);

  for iter=1:n

    if(t[iter] == 0) continue; end;

    grid[iter, t[iter]] = 1;

    end;

  return grid;

  end;


function grid_resolve(xgrid)

  grid=zeros(Int, 5000, 100);
 
  activef = falses(5000);

  m = sortperm(vec(sum(xgrid,dims=1)));

  for iter = m;

    grid[.!(activef), iter] = xgrid[.!(activef), iter];

    activef[.!(activef)] = xgrid[.!(activef), iter] .== 1;

    end;

  return grid;

  end;




