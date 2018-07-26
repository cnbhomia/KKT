sets
  j     'set j'           / j1 * j6 /
  j2(j) 'subset for j'    / j2, j4*j6 /
  i     'set i'           / i1 * i3 /
  i2(i) 'subset for i'    / i1, i2 /
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
  z         'objective var'
  ttt(j)   'variable over set j'
  sss(i)   'variable over set i'
  ;
positive variable
  x(j)     'positive variable over set j'
  ;
equation
  objDef
  sssdef(i)
  tttdef(j)
  eSum
  sSum
  allBnd
  ;

objDef.. sum{j, c(j)*x(j)} + sum{i, sqr(sss(i)-s0(i))} =E= z;
sssdef(i).. sss(i) =E= sum{j, A(i,j) * ttt(j)};
tttdef(j).. ttt(j) =E= 4*x(j) + x(j+1);
eSum..      sum{j2(j), exp(x(j)-1)} - eMin =G= 0;
sSum..      sum{i2(i), sss(i)} - sLow =G= 0;
allBnd..    sum{j, x(j) + ttt(j)} + sum{i, sss(i)} -vMax =L= 0;

model nonlinear 'NLP model' / all /;
solve nonlinear using nlp min z;
