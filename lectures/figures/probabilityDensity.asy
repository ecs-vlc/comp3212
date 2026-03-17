size(300,0);
import graph;

real a = 2;
real b = 6;

real beta(real x) {
  return 5x*(1-x)^(b-1);
}

filldraw(graph(beta,0,1)--cycle, red);
draw((0,0.4)--(0,0)--(1.2,0), Arrows);
label("$X(t)$", (1.2,0), E);
label("$f\!\left(\strut X(t)\right)$", (0.3,beta(0.3)), NE, red);
