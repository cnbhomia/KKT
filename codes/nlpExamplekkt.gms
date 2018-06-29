variables
     p(i) 'multipler for equation sdef(i)'
     q(j) 'multipler for equations tdef(j)'
     r1 ' multipler for esum'
     r2 ' multipler for ssum'
     s1 ' multipler for allbnd'
     ;

equations
     dLdttt(i,j)
     dLdsss(i,j)
     dLdx(i,j)
     dLdx(i,j+1)
     ;
p(i).l=sdef.m(i);