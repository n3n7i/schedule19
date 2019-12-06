

function bayes_init(data_c, data_n);

  cc = graph_genA(data_c, data_n, [1,2]);

  cx = graph_hybrid(cc);

  bx = zeros(size(data_c,1), 10);

  bz = zeros(100,1);

  ins = cx.inpeak; ##min.(cx.inreq ./ cx.s1, 1);

  outs = cx.outreq; ## ./ cx.s2;

  n = size(data_c,1);
  
  for iter = 1:n

    c1 = data_c[iter, 1];

    xtest=2;

    while(xtest < 6);

      xc = data_c[iter, xtest];

      bx[iter, xtest] = 1* ((ins[xc] > 0) & (outs[c1] > 0));

      if(bx[iter,xtest]==1)

        ins[xc]-= data_n[iter];
        outs[c1]-= data_n[iter];
        bz[xc] += data_n[iter];
        xtest = 11;

        end; 

      xtest += 1;

      end;

    bx[iter, 1] = 1* (sum(bx[iter,:]) == 0);

    if(bx[iter,1] == 1)  bz[c1] += data_n[iter]; end;

    end;

  return bx,bz;

  end;


    

##    bx[iter, 3] = 1* ((ins[c3] > 0) & (outs[c1] > 0));

##    bx[iter, 4] = 1* ((ins[c4] > 0) & (outs[c1] > 0));

##    bx[iter, 1] = 1* (sum(bx[iter,:]) == 0);
    ##bx[iter, 1] = 1* ((outs[c1] <= 0) | (ins[c1] > 0));


##    if(bx[iter,2]==1) ins[c2]-= data_n[iter]; outs[c1]-= data_n[iter]; end; 

##    if(bx[iter,3]==1) ins[c3]-= data_n[iter]; outs[c1]-= data_n[iter]; end; 

##    if(bx[iter,4]==1) ins[c4]-= data_n[iter]; outs[c1]-= data_n[iter]; end; 

##    end;


##  cci = cc .* ins';

##  cco = cc .* outs;

##  ccx = (cc .* outs) .* ins';

##  ccy = (cc .* ins') .* outs;

##  return cx, cci, cco;

##  end;



  

  