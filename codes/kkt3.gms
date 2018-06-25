$ontext
The model below showcases using GAMS to identify / modify the KKT conditions for a given
NLP formulation. Our starting point is a basic minimization NLP model.



$offtext


scalar
    labor 'cost of labor dollar per hour' /20/
    steel 'cost of steel per ton'         /170/
    budget 'total budget for production' /20000/
    ;
variables
    h 'man hours in production' /lo 1, up 50000/
    s 'tons of raw material' /lo 1, up 50000/
    R 'Revenue'
    con1_m 'marginal value for con1' /up 0/
    ;
Equations
    con1 'constraint on budget'
    obj 'objective function'
    dLdh 'gradL wrt h'
    dLds 'gradL wrt s'
    ;
obj.. R =e= - 200 * h**(2/3) * s**(1/3) ;
con1.. 20*h + 170*s =l= budget;

h.l=10;
s.l=10;
*option nlp=examiner;
model khan /con1,obj/;
solve khan using NLP minimizing R;


con1_m.l=con1.m;
dLdh.. - 200*(2/3) * ([h**(2/3)]/h)  * s**(1/3) - con1_m*(20) =n=0;
dLds.. - 200 * h**(2/3) * (1/3)*s**(-2/3) - con1_m*(170) =n=0;

model kkt /dLdh.h,dLds.s,con1.con1_m/;
solve kkt using MCP;

abort $(kkt.iterUsd >0) 'We should start at a solution';
