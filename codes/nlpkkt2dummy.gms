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
*dLdx(i,j+1)
     ;

*assigning marginal(.m) from NLP result to variable marginal con1_m
p.l(i)= sssdef.m(i);
q.l(j) =tttdef.m(j);
r1.l = esum.m;
r2.l = ssum.m;
s1.l = allbnd.m;

*dLdttt(j)..  37 =n= 0;ttt.fx(j)=ttt.l(j);

dLdttt(j).. sum(i,p(i)*A(i,j)) - q(j) - s1 =n= 0;

dLdsss(i).. sss(i)-s0(i) - p(i) - r2$(i2(i))=n=0;
* r2 is active only for the equations where i2 is part of i


dLdx(j).. r1 + r2 + s1 =n= 0;   x.fx(j) = x.l(j);



model nlpkkt / dLdttt.ttt , dLdsss.sss, dLdx.x, sssdef.p , tttdef.q,  esum.r1, ssum.r2, allbnd.s1 / ;
*model nlpkkt / dLdttt.ttt , dLdsss.sss, dLdx.x , dLdr1.r1, dLdr2.r2, dLds1.s1 / ;
*nlpkkt.iterlim=20;
solve nlpkkt using MCP;

abort $(nlpkkt.objval >1e-5) 'We should start at a solution';