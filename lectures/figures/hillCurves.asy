size(400,200,IgnoreAspect);

import graph;
import myutil;

draw(box((0,0),(4,1)));
for(int i=0; i<=4; ++i) {
  draw((i,0)--(i,0.02));
  draw((i,1)--(i,1-0.02));
  label(string(i), (i,0), S);
}


for(real y=0; y<1.0001; y+=0.2) {
  draw((0,y)--(0.02,y));
  draw((4,y)--(4-0.02,y));
  label(string(y,2), (0,y), W);
}

label("$[S_X]/K_X$", (2,-0.13));
label("$\displaystyle \frac{[C]}{[X_T]}$", (-0.4,0.5));

real hill(real s, int n) {
  return s^n/(1+s^n);
}

real hill1(real s) {return hill(s, 1);}
real hill2(real s) {return hill(s, 2);}
real hill3(real s) {return hill(s, 3);}
real hill4(real s) {return hill(s, 4);}

draw(graph(hill1,0,4), red);
label("$n=1$", (3,hill(3,1)), NW, red);
ship();

draw(graph(hill2,0,4), heavygreen);
label("$n=2$", (2.5,hill(2.5,2)), NW, heavygreen);
ship();

draw(graph(hill3,0,4), cyan);
label("$n=3$", (2,hill(2,3)), NW, cyan);
ship();

draw(graph(hill4,0,4), blue);
label("$n=4$", (1.5,hill(1.5,4)), NW, blue);
ship();

draw((0,0.5)--(1,0.5)--(1,0), dashed+gray);

ship();
