
function drs(data, dn)

  r = zeros(Int, 100,10,7);

  n = size(data,1);

  m = 10;

  for iter = 1:n

    t = data[iter, :];

    for dep = 1:m

      r[t[dep], dep, dn[iter]] += 1;

      end;

    end;

  return r;

  end;



function drb(r)

  dc = zeros(Int, 100,10);

  t = [2;3;4;5;6;7;8];

  for iter = 1:100

    for iterb = 1:10

      dc[iter, iterb] = r[iter, iterb, :]' * t;

      end;

    end;

  return dc;
 
  end;


function drcalcs(dc, minr=125);

  zx = zeros(100,10);

  zy = zeros(100,1);

  zz = zeros(100,1);

  for iter = 1:10

    zx[:,iter] = dc[:,iter] ./ minr;

    zy = zy .+ zx[:,iter];

    zz[zz.==0] = iter .* (zy[zz.==0] .>= 1.0);

    end;

  return zx, zz;

  end;


function min_est(zx, cf, r)

  targ0 = zx[:,1] .< 2.0;

  println(sum(targ0));

  end;



function xcart(x)
 
  return CartesianIndex(x[2], x[1]);

  end;


function dayx(ch, targ, cf, cutoff=125, mincount=4)

  tch = ch[targ, :,:];

  tselect = zeros(10,7);

  cur_cost = 0.0;

  ccount = 0;

  x(a) = a >= (mincount);

  cur_pos = CartesianIndex(1,1);

  cur_pos = xcart(findnext(x, tch', xcart(cur_pos)));

  while((ccount < cutoff) & (cur_pos!==nothing))

##    println(cur_pos);

    tch[cur_pos] -= mincount;

    tselect[cur_pos] += mincount;

    ccount += mincount * (cur_pos[2]+1);

    cur_cost += mincount * (cur_pos[2]+1) * cf[cur_pos];

##    cur_pos = findnext(x, tch, cur_pos);


    cur_pos = xcart(findnext(x, tch', xcart(cur_pos)));

    end;

  println("count: $ccount, tot = $(cur_cost)");

  return tselect;

  end;


function dayS(ch, targ, cf, cl, cutoff=125, mincount=4)

  tch = ch[targ, :,:];

  tselect = zeros(10,7);

  cur_cost = 0.0;

  ccount = 0;

  x(a) = a >= (mincount);

  cur_pos = cl[1]; ##CartesianIndex(1,1);

  ##cur_pos = xcart(findnext(x, tch', xcart(cur_pos)));

  cur_pos = Ordered_findnext(x, tch, cur_pos, cl);

  while((ccount < cutoff) & (cur_pos!==nothing))

##    println(cur_pos);

    tch[cur_pos] -= mincount;

    tselect[cur_pos] += mincount;

    ccount += mincount * (cur_pos[2]+1);

    cur_cost += mincount * (cur_pos[2]+1) * cf[cur_pos];

##    cur_pos = findnext(x, tch, cur_pos);
    ##cur_pos = xcart(findnext(x, tch', xcart(cur_pos)));

    if(tch[cur_pos] < mincount)

      cur_pos = Ordered_findnext(x, tch, cur_pos, cl);

      end;

    end;

  println("count: $ccount, tot = $(cur_cost)");

  return tselect, cur_cost;

  end;



function loop0(xdrs, ps, cl; cutoff=125, mincount=1, uc=false, co=[])

  counts = zeros(100);

  maps = [];

  for iter=1:100

    if(uc) cutoff = co[iter]; end;

    xa,xb = dayS(xdrs, iter, ps, cl, cutoff, mincount);

    counts[iter] = xb;

    push!(maps, xa);

    end;

  return counts, maps;

  end;


