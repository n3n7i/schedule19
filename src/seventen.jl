

function invertmap(z2, data; iperm=collect(1:100), comp = falses(5000))

  d1 = data[:,2:11];

  dn = data[:,12];

  res = zeros(Int, 5000);

  ##comp = falses(5000);

  for iter = iperm

    map_revert!(iter, z2[iter], d1, dn, comp, res);

    end;

  return comp, res;

  end;


    