
function graph_genA(data, dn, tab=[1,2])

  spread = zeros(100,100);

  for iter = 1:size(data,1);

    spread[data[iter,tab[1]], data[iter,tab[2]]] += dn[iter];

    end;

  return spread;

  end;


function graph_genB(spr, lim=[125, 300])

  genb = zeros(100,100);

  s2 = sum(spr, dims=2); ## total = outbound

  outb_rate = max.(s2 .- lim[2], 0) ./ s2;

  #s1 = sum(spr, dims=1); ## inbound total

  s1 = sum(spr .* outb_rate, dims=1); ## inbound total

  inb_rate = 1.0 .- (max.(s1 .- lim[2], 0) ./ s1);

  return outb_rate, inb_rate;

  end;



function eye(n)

  x = zeros(Int,n,n);

  for iter = 1:n
  
    x[iter,iter] = 1;

    end;

  return x;

  end;


function graph_fold(spr, lim=300)

  ##genb = zeros(100,100);

  s2 = sum(spr, dims=2); ## total == outbound - lim [+inb]

  outb_rate = max.(s2 .- lim, 0) ./ s2;

  spr2 = spr .* outb_rate; ##excess

  s3 = sum(spr2 .* (1.0 .- eye(100)), dims=1); ## avg inbound

  spr = spr .* (1.0 .- eye(100)) .+ (s3 .* eye(100));

  return spr, spr2, outb_rate;

  end;


function graph_underflow(spr, limlo=100)

  ##genb = zeros(100,100);

  n = size(spr,1);

  s2 = sum(spr, dims=2); ## inbound == lim - total + outbound

  inb_req = max.(limlo .- s2, 0);

  inb_avail = sum(spr .* (1.0 .- eye(n)), dims=1);

  inb_rate = min.(inb_req ./ inb_avail', 1.0);

  xinb = inb_avail' .* inb_rate;

  spr2 = spr .* ((1.0 .- eye(n)) .* (1.0 .- inb_rate')) .+ (spr .* eye(n)) .+ (xinb .* eye(n));

  spr = spr .* (1.0 .- eye(n)) .+ (xinb .* eye(n));

  return spr2, xinb;

  end;





