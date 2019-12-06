

function pref_score(choice, members)

 famx =  [0; 50; 50; 100; 200; 200; 300; 300; 400; 500; 500];

 memberx = [0; 0; 9; 9; 9; 18; 18; 36; 36; 36 + 199; 36 + 398];

 costx = famx[choice] + memberx[choice] * members;

 return costx;

 end;


function day_score(day, d1)

  if (day<125 || day>300) println("125 => $day => 300?"); end;

  d0 = d1;

  nD = day;

  pA = max((nD - 125) / 400,0);

  pB = abs(nD - d0) / 50;

  pC = pA * (nD ^ (0.5 + pB));

  return pC;

  end;




function account_score(daylist)

  d0 = daylist[1]; ##!

  rtot = 0;

  ntot = zeros(100,1);

  for iter=1:100

    nD = daylist[iter];

    pA = max((nD - 125) / 400, 0);

    pB = abs(nD - d0) / 50;

    pC = pA * (nD ^ (0.5 + pB));

    rtot = rtot + pC;

    ntot[iter] = pC;

    d0 = nD;

    end;

  return rtot, ntot;

  end;



function submit_score(xlist, data, dn)

  zlist = zeros(Int, 5000);  

  ylist = zeros(100);

  ylistb = zeros(100);

  for iter = 1:10

    zlist[vec(xlist .== data[:, iter])] .= iter;

    end;

  for iter=1:100

    v1 = xlist .== iter;

    ylist[iter] = sum(xlist .== iter);

    ylistb[iter] = sum(v1 .* dn);

    end;

  acc_score, acl = account_score(ylistb[end:-1:1]);

  p_score = pref_score.(zlist[vec(zlist .> 0)], dn[vec(zlist .> 0)]);

  err_score = sum(zlist .== 0);

  println("score A: $(acc_score), score P: $(sum(p_score)), score Err: $err_score, ")

  return acl, ylistb;

  end;

