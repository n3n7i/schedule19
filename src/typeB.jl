

function dep_prior(rb2, mini)

  return mini ./ rb2;

  end;


##function zeva()

  

function zpass!(data, dn, xpri, d_store, targ; dep = 3, cutoff = 75, pri = 1.0, xrate=50)

  ##d_store = zeros(100,1);

  ##targ = zeros(5000,1);

  bstr = "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b";

  n = size(data, 1);

  cpr1 = 0;

  cpr2 = 0;

  fpr = pri;

  for xdep = 1:dep

    for iter=1:n

      ##fpr = fpr*0.99995;

      if(targ[iter] > 0) continue; end;

      t = data[iter, xdep];

      cpn1 = 2 - (d_store[t] / cutoff);

      ##cpn2 = xpri[t] / pri;

      cpn2 = xpri[t] / fpr;

      cpr1 = cpr1 + (cpn1-cpr1)*0.05;

      cpr2 = cpr2 + (cpn2-cpr2)*0.05;

      if(mod(iter, xrate) == 0) print(bstr, round(cpn1, sigdigits=3), " ", round(cpn2, sigdigits=3), "   "); sleep(0.05); end;

##      if(d_store[t] > cutoff) continue; end;

##      if(xpri[t] < pri) continue; end;

      if(cpn1*cpn2 < cpr1 * cpr2) continue; end;

      targ[iter] = t;

      d_store[t] += dn[iter];

      end;

    end;

  return d_store, targ;

  end;




function zbpass!(data, dn, d_store, targ; dep = 3, cutoffs = [210])

  ##d_store = zeros(100,1);

  ##targ = zeros(5000,1);

  xpi = zeros(10,1);

  n = size(data, 1);

  cpr1 = 0;

  cpr2 = 0;

  for iter=1:n

    for xdep = 1:dep

      if(targ[iter] > 0) continue; end;

      t = data[iter, xdep];

      cpn1 = 1 - (d_store[t] / (cutoffs[t]+1));

      if(d_store[t]+dn[iter] > cutoffs[t]) continue; end;

      targ[iter] = t;

      d_store[t] += dn[iter];

      xpi[xdep] += dn[iter];

      end;

    end;

  return d_store, targ, xpi;

  end;


