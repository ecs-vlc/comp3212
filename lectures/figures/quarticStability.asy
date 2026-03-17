size(200,0);

import graph;

real func(real x) {
  return 0.3*(x^4-4x^2);
}

draw(graph(func, -2, 2), linewidth(1));


pair grad(real x) {
  return unit((-1.2*x*(x*x-2), 1));
}

void ball(real x) {
  filldraw(circle((x,func(x))+0.15*grad(x), 0.15), red);
}

ball(0);
ball(sqrt(2));
ball(-sqrt(2));
ball(1.92);
ball(-1.92);
ball(0.6);
ball(-0.6);

void arrow(real x) {
  real eps = 0.001;
  real dy = 0.5*(func(x+eps)-func(x-eps));
  if (dy>0) {
    eps *= -1;
    dy *= -1;
  }
  pair pos = (x,func(x))+0.15*grad(x);
  draw(pos-0.15*unit((eps,dy))--pos+0.15*unit((eps,dy)), Arrow);
}

arrow(1.81);
arrow(-1.81);
arrow(0.82);
arrow(-0.82);

label("stable", (sqrt(2),func(sqrt(2))), S);
label("stable", (-sqrt(2),func(sqrt(2))), S);
label("unstable", (0,func(0)), 3S);
