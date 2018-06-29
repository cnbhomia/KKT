*This model restarts from the saved results of the NLP model 

variables
    con1_m 'marginal value for con1' /up 0/
    ;
Equations
    dLdh 'gradL wrt h'
    dLds 'gradL wrt s'
    ;
*assigninging marginal(.m) from NLP result to variable marginal con1_m
con1_m.l=con1.m;

*gradient equations
dLdh.. - 200*(2/3) * ([h**(2/3)]/h)  * s**(1/3) - con1_m*(20) =n=0;
dLds.. 37 + con1_m=n=0;
*s.fx=s.L;

*decalaring complementarity
model kkt /dLdh.h,dLds.s,con1.con1_m/;
kkt.iterlim=100;
solve kkt using MCP;

*abort $(kkt.objval >1e-5) 'We should start at a solution';
