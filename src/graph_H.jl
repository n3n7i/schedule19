
struct graphstat

  inreq;
  inpeak;
  s1;
  outreq;
  outpeak;
  s2;
  end;


function graph_hybrid(spr, lims = [125, 300])

  s1 = vec(sum(spr, dims=1)); ## second choice sums

  s2 = sum(spr, dims=2); ## total == outbound - lim [+inb]

  inb_req = max.(lims[1] .- s2, 0);

  outb_req = max.(s2 .- lims[2], 0);

  inb_peak = max.(lims[2] .- s2, 0);

  outb_peak = max.(s2 .- lims[1], 0);
  
  return graphstat(inb_req, inb_peak, s1, outb_req, outb_peak, s2);

  end;

