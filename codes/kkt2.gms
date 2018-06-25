*$ontext
scalar
    labor cost of labor dollar per hour /20/
    steel cost of steel per ton         /170/;

variables h /lo 1, up 50000/ ,s /lo 1, up 50000/;
variable R,lambda;
variable con1_m 'marginal value for con1';
Equations con1,obj,dLdh,dLds;

obj.. R =e= 200 * h**(2/3) * s**(1/3) ;
con1.. 20*h + 170*s =l= 20000;


dLdh.. 200*(2/3) * ([h**(2/3)]/h)  * s**(1/3) + con1_m*(20) =n=0;
dLds.. 200 * h**(2/3) * (1/3)*s**(-2/3) + con1_m*(170) =n=0;
*dLdlam.. 20*h +170*s-20000 =e=0;



h.l=600;
s.l=30;
*option nlp=examiner;
model khan /con1,obj/;
solve khan using NLP maximizing R;


*$exit
model kkt /dLdh.h,dLds.s,con1.con1_m/;
solve kkt using MCP;

display kkt.modelstat
display kkt.solvestat
*$offtext
$exit
variable x /lo 1, up 2/;
variable z;
equations dLdx,obj;
dLdx.. 2*x =n= 0 ;
obj.. z =e= sqr(x);
model opt /obj/;
solve opt using nlp minimizing z;

model kkt /dLdx.x/;
solve kkt using MCP;

