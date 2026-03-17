settings.outformat="pdf";

size(200,200,IgnoreAspect);

import graph;
import myutil;

draw(box((0,0),(2,1)));
for(int i=0; i<=2; ++i) {
  draw((i,0)--(i,0.02));
  draw((i,1)--(i,1-0.02));
  label(string(i), (i,0), S);
}


for(real y=0; y<1.0001; y+=0.5) {
  draw((0,y)--(0.02,y));
  draw((2,y)--(2-0.02,y));
}
label("$\beta$", (0,1), W);
label("$\displaystyle \frac{\beta}{2}$", (0,0.5), W);
label("$0$", (0,0), W);



label("$[X]/K$", (2,0), NW);
label("$f(X)$", (0,1), SE);

real hill(real s, int n) {
  return s^n/(1+s^n);
}

real hill1(real s) {return hill(s, 1);}
real hill2(real s) {return hill(s, 2);}
real hill3(real s) {return hill(s, 3);}
real hill4(real s) {return hill(s, 4);}

draw(graph(hill1,0,2), red);
label("$n=1$", (2,hill(2,1)), NW, red);

draw(graph(hill2,0,2), heavygreen);
label("$n=2$", (1.7,hill(1.7,2)), 1.7N, heavygreen);

draw(graph(hill4,0,2), blue);
label("$n=4$", (0.5,hill(0.5,4)), E, blue);

draw((0,0)--(1,0)--(1,1)--(2,1), linewidth(2)+cyan);
label("step function", (1,0.75), NW, cyan);

picture activator = new picture;
size(activator, 200,200,IgnoreAspect);
add(activator, currentpicture);
erase();
size(200,200,IgnoreAspect);

draw(box((0,0),(2,1)));
for(int i=0; i<=2; ++i) {
  draw((i,0)--(i,0.02));
  draw((i,1)--(i,1-0.02));
  label(string(i), (i,0), S);
}


for(real y=0; y<1.0001; y+=0.5) {
  draw((0,y)--(0.02,y));
  draw((2,y)--(2-0.02,y));
}
label("$\beta$", (0,1), W);
label("$\displaystyle \frac{\beta}{2}$", (0,0.5), W);
label("$0$", (0,0), W);



label("$[X]/K$", (2,0), NW);
label("$f(X)$", (0,1), SE);

real hill(real s, int n) {
  return 1/(1+s^n);
}

real hill1(real s) {return hill(s, 1);}
real hill2(real s) {return hill(s, 2);}
real hill3(real s) {return hill(s, 3);}
real hill4(real s) {return hill(s, 4);}

draw(graph(hill1,0,2), red);
label("$n=1$", (1.6,hill(1.6,1)), NE, red);


draw(graph(hill2,0,2), heavygreen);
label("$n=2$", (1.6,hill(1.6,2)), 0.6NE, heavygreen);


draw(graph(hill4,0,2), blue);
label("$n=4$", (1.6,hill(1.6,4)), NE, blue);


draw((0,1)--(1,1)--(1,0)--(2,0), linewidth(2)+cyan);
label("step function", (1,0.75), NE, cyan);



picture repressor = new picture;
size(repressor, 200, 200, IgnoreAspect);

add(repressor, currentpicture);
erase();


size(500,300,IgnoreAspect);
add(activator.fit(),(0,0));
add(repressor.fit(),(100,0));
