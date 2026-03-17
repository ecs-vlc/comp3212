size(300,0);

import myutil;
import graph;


real f1(real x) {
  return 3 + 0.5*sqrt(x-2);
}

real f2(real x) {
  return 2-0.5*sqrt(5-x);
}

real f3(real x) {
  return 2.5 + 0.5*(- sqrt(x-2)/sqrt(3)  + sqrt(5-x)/sqrt(3));
}

draw((0,0)--(10,0), Arrow);
draw((0,0)--(0,6), Arrow);

draw(graph(f1, 2, 9.7), red);
draw(graph(f2, 0, 5), red);
draw(graph(f3, 2, 5), red+dashed);

label("input parameter", (5,0), 1.5S);
label(rotate(90)*Label("steady state concentration"), (0, 3), 1.5*W);

ship();

picture bg = new picture;
add(bg, currentpicture);

for(real x = 0.99; x<6; x+=0.2) {
  erase();
  add(bg);
  real y = (x<5)? f2(x) : f1(x);
  dot((x,y), linewidth(3)+blue);
  ship();
};

for(real x = 5.81; x>1; x-=0.2) {
  erase();
  add(bg);
  real y = (x>2)? f1(x) : f2(x);
  dot((x,y), linewidth(3)+blue);
  ship();
};

erase();
add(bg);
draw(graph(f2, 2, 5), blue, MidArrow);
draw((5,f2(5))--(5,f1(5)), blue, MidArrow);
draw(graph(f1, 5, 2), blue, MidArrow);
draw((2,f1(2))--(2,f2(2)), blue, MidArrow);
label("hysteresis loop", (5, 0.5*(f1(5)+f2(5))), E, blue);
ship();
