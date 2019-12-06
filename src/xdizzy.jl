

function xdistrib(tot, rise=0.05, init=125)

  xtot = tot;

  x1 = init;

  res = zeros(100,1);

  for iter = 1:100;

    res[iter] = x1;

    xtot -= x1;

    xtarg = xtot / ((100-iter) + (iter==100));

##    print(" ", round((xtarg-x1)*rise));

    x1 += round((xtarg-x1)*rise);

    end;

  return res;

  end;



function zdistrib(tot, rise=0.05, init=125, cutoffs = [])

  xtot = tot;

  x1 = cutoffs[1];

  res = zeros(100,1);

  for iter = 1:100;

    res[iter] = x1;

    xtot -= x1;

    xtarg = ((xtot / ((100-iter) + (iter==100))) + (cutoffs[iter+1 - (iter==100)])) / 2;

##    print(" ", round((xtarg-x1)*rise));

##    x1 += round((xtarg-x1)*rise);

    x1 += round(((cutoffs[iter+1 - (iter==100)])-x1)*rise);

    end;

  return res;

  end;



