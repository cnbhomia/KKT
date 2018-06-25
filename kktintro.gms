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
    ;
Equations
    con1 'constraint on budget'
    obj 'objective function'
    ;
obj.. R =e= - 200 * h**(2/3) * s**(1/3) ;
con1.. 20*h + 170*s =l= budget;

h.l=10;
s.l=10;
*option nlp=examiner;
model khan /con1,obj/;
solve khan using NLP minimizing R;
