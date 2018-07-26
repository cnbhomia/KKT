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
p.l(i)= sssdef.m(i);
q.l(j) =tttdef.m(j);
r1.l = esum.m;
r2.l = ssum.m;
s1.l = allbnd.m;

dLdttt(j)..   37 =n= 0;             ttt.fx(j)=ttt.l(j);


dLdsss(i).. p(i) + 37 =n= 0;               sss.fx(i) = sss.l(i);


dLdx(j)..  q(j)+ r1 + r2 + s1 =n= 0;   x.fx(j) = x.l(j);



model nlpkkt / dLdttt.ttt , dLdsss.sss, dLdx.x / ;

nlpkkt.iterlim=0;

solve nlpkkt using MCP;

abort $(nlpkkt.objval >1e-5) 'We should start at a solution';