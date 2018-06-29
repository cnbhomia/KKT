$ontext

Here we have an NLP.  It has several useful properties when we
consider the question of writing down the KKT conditions for NLP:

  1. It is a minimization model.  The sign conventions work out nicely
     in that case.

  2. It contains a good mixture of variables: enough to show the
     utility of a structured technique but not so many as to be
     ponderous.

  3. It contains a good mixture of equations: enough but not too many,
     and also equations of all types (equality, <=, >=).

  4. There is some use of subsets and lags/leads in the formulation.
     That doesn't change the math at all, but it is another detail
     that could cause confusion, and we can demonstrate correct
     handling here.

$offtext


sets
  j  'variable indices' / j1 * j6 /
  j2(j)                 / j2, j4*j6 /
  i                     / i1 * i3 /
  i2(i)                 / i1, i2 /
  ;
scalar
  eMin / 2.5 /
  sLow / -100 /
  vMax / 20 /
  ;
parameter
  c(j) /
    j1   2
    j2  -2
    j3   2
    j4  -2
    j5   2
    j6  -2
  /
  s0(i) /
    i1    10
    i2    20
    i3   -10
  /
  ;
table A(i,j)
    j1    j2    j3    j4    j5    j6
i1   1     4     2                 2
i2               4     1     2
i3        -2    -2           -1    4   ;

variable
  z  'objective var'
  ttt(j)
  sss(i)
  ;
positive variable
  x(j)
  ;
equation
  objDef
  sssDef(i)
  tttDef(j)
  eSum
  sSum
  allBnd
  ;

objDef.. sum{j, c(j)*x(j)} + sum{i, sqr(sss(i)-s0(i))} =E= z;
sssDef(i).. sss(i) =E= sum{j, A(i,j) * ttt(j)};
tttDef(j).. ttt(j) =E= 4*x(j) + x(j+1);
eSum..      sum{j2(j), exp(x(j)-1)} =G= eMin;
sSum..      sum{i2(i), sss(i)} =G= sLow;
allBnd..    sum{j, x(j) + ttt(j)} + sum{i, sss(i)} =L= vMax;

model m 'NLP model' / all /;
option
    limrow =10;
solve m using nlp min z;
