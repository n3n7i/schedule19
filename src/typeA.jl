

function getstats(data)

  dayscores = zeros(100, 10)

  dayscoresB = zeros(100, 10)

  db = data[:, 2:11];

  dn = data[:,12];

  n = size(data,1);

  for iterb = 1:10

    for itera =1:n

      dayscores[db[itera, iterb], iterb] += 1;

      dayscoresB[db[itera, iterb], iterb] += dn[itera];

      end;

    end;

  return dayscores, dayscoresB;

  end;


function xpass(data, dn; dep = 3, cutoff = 125)

  d_store = zeros(100,1);

  targ = zeros(5000,1);

  n = size(data, 1);

  for xdep = 1:dep

    for iter=1:n

      if(targ[iter] > 0) continue; end;

      t = data[iter, xdep];

      if(d_store[t] > cutoff) continue; end;

      targ[iter] = t;

      d_store[t] += dn[iter];

      end;

    end;

  return d_store, targ;

  end;
