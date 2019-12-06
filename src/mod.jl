

"""
santa Helpfiles!                              \n
  eval:     pref, day, account, submit _score \n
  typeC:    drs, [dayS], loop0                \n
  typeE:    [map_revert!]                     \n
  search0:  s0, [Ordered_findnext]            \n
  seventen: invertmap                         \n
  xdizzy:   xdistrib, zdistrib                \n
  optim0:   grid _connect, grid _resolve        \n
</santa>
"""
module santa;

  include("eval.jl");

  include("typeC.jl");
  include("typeE.jl");

  include("search0.jl");
  include("seventen.jl");

  include("xdizzy.jl");

  include("optim0.jl");

  end;

