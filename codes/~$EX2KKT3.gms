variables
     p(i) 'multipler for equation sssdef(i)'
     q(j) 'multipler for equations tttdef(j)'
     r1 ' multipler for esum' /lo 0 /
     r2 ' multipler for ssum' /lo 0/
     s1 ' multipler for allbnd' /up 0/
     ;

equations
     dLdttt(j)
     dLdsss(i)
     dLdx(j)
     ;

*assigning marginal(.m) from NLP result to variable marginal con1_m
p.l(i)= sssdef.m(i);
q.l(j) =tttdef.m(j);
r1.l = esum.m;
r2.l = ssum.m;
s1.l = allbnd.m;

*dLdttt(j)..  37 =n= 0;          ttt.fx(j)=ttt.l(j);
dLdttt(j).. sum(i,p(i)*A(i,j)) - q(j) - s1 =n= 0;

*dLdsss(i).. 37 + p(i) =n= 0;               sss.fx(i) = sss.l(i);
dLdsss(i).. 2*(sss(i)-s0(i)) - p(i) - r2$(i2(i)) -s1=n=0;
* r2 is active only for the equations where i2 is part of i

*dLdx(j).. r1 + r2 + s1 +q(j) =n= 0;   x.fx(j) = x.l(j);
dLdx(j).. c(j) + 4*q(j) + q(j-1)- [r1*exp(x(j)-1)]$j2(j) - s1 =n= 0;
*exp over set j2. hence the differentiation term is over j2 as well

model nlpkkt / dLdttt.ttt , dLdsss.sss, dLdx.x, sssdef.p , tttdef.q,  esum.r1, ssum.r2, allbnd.s1 / ;

nlpkkt.iterlim=0;

solve nlpkkt using MCP;

abort $(nlpkkt.objval >1e-5) 'We should start at a solution';