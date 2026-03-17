size(500,0);

import myutil;
import ode;

real K = 1;
real k1 = 20;
real k2 = 5;
real k3 = 5;
real k4 = 5;
real k5 = 2;
int n = 4;

real[] func(real t, real[] X) {
  real[] dX = new real[2];
  dX[0] = k1/(1+(X[1]/K)^n) - k3*X[0] - k5*X[0];
  dX[1] = k2 + k5*X[0] - k4*X[1];
  return dX;
}

real[] X0 = {0,0};

Solution sol = integrate(X0, func, 0, 1.5, h=0.02, RK4);

pair s = (2,0);

draw(box((0,0),(1.5,2)));
draw(shift(s)*box((0,0),(2,2)));
bool show = true;
for(real t=0; t<=1.51; t+= 0.25) {
  if (show) {
    draw((t,0)--(t,0.02));
    draw((t,2)--(t,2-0.02));
    label(string(t,2), (t,0), S);
  } else {
    draw((t,0)--(t,0.01));
    draw((t,2)--(t,2-0.01));
  }
  show = ! show;
}

show = true;
for(real x=0; x<=2.01; x+= 0.25) {
  if (show) {
    draw((0,x)--(0.02,x));
    draw((1.5,x)--(1.5-0.02,x));
    label(string(x,2), (0,x), W);
    draw(s+(0,x)--s+(0.02,x));
    draw(s+(2,x)--s+(2-0.02,x));
    label(string(x,2), s+(0,x), W);
  } else {
    draw((0,x)--(0.01,x));
    draw((1.5,x)--(1.5-0.01,x));
    draw(s+(0,x)--s+(0.01,x));
    draw(s+(2,x)--s+(2-0.01,x));
  }
  show = ! show;
}

show = true;
for(real t=0; t<=2.01; t+= 0.25) {
  if (show) {
    draw(s+(t,0)--s+(t,0.02));
    draw(s+(t,2)--s+(t,2-0.02));
    label(string(t,2), s+(t,0), S);
  } else {
    draw(s+(t,0)--s+(t,0.01));
    draw(s+(t,2)--s+(t,2-0.01));
  }
  show = ! show;
}

label("time, $t$", (0.75,0), 4S);
label(rotate(90)*Label("Concentration, $\textcolor{red}{X_1},\, \textcolor{blue}{X_2}$"), (-0.3, 1));
label("Concentration, $X_1$", s+(1,0), 4S);
label(rotate(90)*Label("Concentration, $X_2$"), s+(0,1), 5W);

picture bg = new picture;
add(bg, currentpicture);

guide g1;
guide g2;
guide g12;
pair x1 = (0,0);
pair x2 = (0,0);
pair x12 = (0,0);
for(int t=0; t<sol.t.length; ++t) {
  g1 = g1--(sol.t[t], sol.y[t][0]);
  g2 = g2--(sol.t[t], sol.y[t][1]);
  g12 = g12--(sol.y[t][0], sol.y[t][1]);
  real d1 = length(x1-(sol.t[t], sol.y[t][0]));
  real d2 = length(x2-(sol.t[t], sol.y[t][1]));
  real d12 = length(x12-(sol.y[t][0], sol.y[t][1]));
  if (d1+d2+d12>0.1) {
    erase();
    add(bg);
    draw(g1, red);
    draw(g2, blue);
    draw(shift(s)*g12, heavygreen);
    x1 = (sol.t[t], sol.y[t][0]);
    x2 = (sol.t[t], sol.y[t][1]);
    x12 =(sol.y[t][0], sol.y[t][1]);
    dot(x1, red);
    dot(x2, blue);
    dot(s+x12, heavygreen);
    ship();
  }
}
