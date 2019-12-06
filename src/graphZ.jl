

function graph_genC(data, dn)

  spreadB = Array[];

  for t = 2:10

    push!(spreadB, graph_genA(data,dn, [1, t]));

    end;

  return spreadB;

  end;