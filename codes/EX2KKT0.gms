Variables
     sssdef_m(i)  'multipler for equation sssdef(i)'
     tttdef_m(j)  'multipler for equations tttdef(j)'
     esum_m       'multipler for esum'      /lo 0 /
     ssum_m       'multipler for ssum'      /lo 0/
     allbnd_m     'multipler for allbnd'    /up 0/
     ;

Equations
     dLdttt(j)    'gradient of Lagrangian w.r.t ttt(j)'
     dLdsss(i)    'gradient of Lagrangian w.r.t sss(i)'
     dLdx(j)      'gradient of Lagrangian w.r.t x(j)'
     ;

*initializing the marginals/lagrangian multipliers
sssdef_m.l(i)= sssdef.m(i);
tttdef_m.l(j) =tttdef.m(j);
esum_m.l = esum.m;
ssum_m.l = ssum.m;
allbnd_m.l = allbnd.m;

* dummy equations with differentiating variable values

dLdttt(j)..     37 =n= 0;
                ttt.fx(j)=ttt.l(j);
              
dLdsss(i)..     sssdef_m(i) + 37 =n= 0;
                sss.fx(i) = sss.l(i);
              
dLdx(j)..       tttdef_m(j)+ esum_m + ssum_m + allbnd_m =n= 0;
                x.fx(j) = x.l(j);

model nlpkkt / dLdttt.ttt , dLdsss.sss, dLdx.x, sssdef.sssdef_m , tttdef.tttdef_m,  esum.esum_m, ssum.ssum_m, allbnd.allbnd_m / ;

nlpkkt.iterlim=0;

solve nlpkkt using MCP;

abort $(nlpkkt.objval >1e-5) 'We should start at a solution';