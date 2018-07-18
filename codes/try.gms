set i / i1*i3/;

parameter c(i) / i1 1, i2 EPS /

scalar s1,s2,s3 ;

s1 = sum(i$c(i),1) ;
s2 = sum(i$(c(i)>0),1);
s3 = sum(i,1) ;

display c , s1,s2,s3;