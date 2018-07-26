variables
    con1_m 'marginal value for con1' /up 0/
    ;
Equations
    dLdh 'gradL wrt h'
    dLds 'gradL wrt s'
    ;

con1_m.l=con1.m;
dLdh.. - 200*(2/3) * ([h**(2/3)]/h)  * s**(1/3) - con1_m*(20) =n=0;
dLds.. - 200 * h**(2/3) * (1/3)*s**(-2/3) - con1_m*(170) =n=0;

*dLdh.. 37 =n=0 ; h.fx=h.L;
*dLds.. 37 =n=0;             s.fx=s.L;
model kkt /dLdh.h,dLds.s,con1.con1_m/;
kkt.iterlim=30;
solve kkt using MCP;

*abort $(kkt.objval >1e-5) 'We should start at a solution';

file factors /sd_kkt.log/
put factors;
put 'Maximum Revenue, R', R.l / 
    'Man hours, h', h.l/ 
    'Tons of raw material, s',s.l /
    ;