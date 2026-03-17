
settings.outformat="pdf";
size(400,0);


draw(box((0,0),(2,1.1)));

bool show = true;
for(real t=0; t<=2.01; t+= 0.25) {
  if (show) {
    draw((t,0)--(t,0.02));
    draw((t,1.1)--(t,1.1-0.02));
    label(string(t,2), (t,0), S);
  } else {
    draw((t,0)--(t,0.01));
    draw((t,1.1)--(t,1.1-0.01));
  }
  show = ! show;
}

show = true;
for(real x=0; x<=1.21; x+= 0.25) {
  if (show) {
    draw((0,x)--(0.02,x));
    draw((2,x)--(2-0.02,x));
    label(string(x,2), (0,x), W);
  } else {
    draw((0,x)--(0.01,x));
    draw((2,x)--(2-0.01,x));
  }
  show = ! show;
}

label("$\displaystyle \frac{[X(t)]}{[X_{eq}]}$", (0, 0.75), 3W);
label("$\alpha\, t$", (1,-0.15));

import graph;
import myutil;

real simple(real t) {
  return 1-exp(-t);
}

real step(real t) {
    return (2*(1-exp(-t))<1)? 2*(1-exp(-t)): 1;
}

draw(graph(simple, 0, 2), heavygreen);
label("$\displaystyle \frac{[\hat{X}(t)]}{[\hat{X}_{eq}]}$",
      (1.5, simple(1.5)), SE, heavygreen);



real delta(real X, int n) {
  return 2/(1+X^n);
}


pen[] col = {black, red, cyan, gray, magenta};
pair[] pos = {(0,0), (1,0.76), (0.75, 0.76), (0,0), (0.5,0.86)};
real eps = 0.02;
for(int n=1; n<=4; n*=2) {
  real X=0;
  guide g = (0,0);
  for(real t=eps; t<=2.0001; t+=eps) {
    X += eps*(delta(X, n) - X);
    g = g--(t,X);
  }
  draw(g, col[n]);
  label("$n="+string(n)+"$", pos[n], col[n]);
  
}

draw(graph(step, 0, 2), blue);
label("step", (1, 1), N, blue);


draw((0,0.5)--(2,0.5), dashed+gray);
draw((log(2),0)--(log(2),0.5), dashed+heavygreen);
label("$\hat{T}_{\tfrac{1}{2}}$", (log(2),0), 0.7S, heavygreen);
draw((log(4/3),0)--(log(4/3),0.5), dashed+blue);
label("$T_{\tfrac{1}{2}}$", (log(4/3),0), 0.7S, blue);

