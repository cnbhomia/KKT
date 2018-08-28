$title: refer EX2KKT3.gms,  KKT conditions development
$ontext
This is an advanced model for showcasing development of KKT conditions for an NLP.
All dummy equations are replaced with KKT conditions
$offtext

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


*dummy equations with differentiating variable values

dLdttt(j).. sum(i,sssdef_m(i)*A(i,j)) - tttdef_m(j) - allbnd_m =n= 0;

dLdsss(i).. 2*(sss(i)-s0(i)) - sssdef_m(i) - ssum_m$(i2(i)) - allbnd_m =n=0;
* ssum_m is active only for the equations where i2 is part of i

dLdx(j).. c(j) + 4*tttdef_m(j) + tttdef_m(j-1)- [esum_m*exp(x(j)-1)]$j2(j) - allbnd_m =n= 0;
*exp over set j2. hence the differentiation term is over j2 as well

model nlpkkt / dLdttt.ttt , dLdsss.sss, dLdx.x, sssdef.sssdef_m , tttdef.tttdef_m,  esum.esum_m, ssum.ssum_m, allbnd.allbnd_m / ;

nlpkkt.iterlim=0;

solve nlpkkt using MCP;

abort $(nlpkkt.objval >1e-5) 'We should start at a solution';