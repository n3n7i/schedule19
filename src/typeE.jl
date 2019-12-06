

function map_revert!(targ, table, data, dn, okf, zlist)

  ##ndata = data[okf, :];

  xtab = table;

  n = size(data,1);

  for iter = 1:n

    if(okf[iter]) continue; end;

    if(targ in data[iter,:])

   ##   print("i");

      sel = table[data[iter,:] .== targ, dn[iter] - 1];

   ##   print(sel[1], " ");

      if(sel[1] < 1) continue; end;

      xtab[data[iter,:] .== targ, dn[iter] - 1] .-= 1;

      okf[iter] = true;

      zlist[iter] = targ;

      end;

    end;

  return okf, zlist;

  end;

