sets
  j  'variable indices' / j1 * j6 /
  j2(j)                 / j2, j4*j6 /


parameter
  c(j) /
    j1   2
    j2  -2
    j3   2
    j4  -2
    j5   2
    j6  -2 /
  c2(j2)/
    j2  22
    j4  44
    j5  55
    j6  66
    /
    r /1/;
display j, j2 , c , c2;

scalar z;
z =  sum(j2(j),c(j-1))$j2(j);
display z;

