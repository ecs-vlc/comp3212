size(300,0);

import myutil;
import ode;
import graph;

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

void plot(Solution sol) {
  guide g;
  for(int t=0; t<sol.t.length; ++t) {
    g = g--(sol.y[t][0], sol.y[t][1]);
  }
  draw(g, gray+linewidth(1), MidArrow(8));
}

draw(box((0,0),(2,2)));
bool show = true;

for(real x=0; x<=2.01; x+= 0.25) {
  if (show) {
    draw((0,x)--(0.02,x));
    draw((2,x)--(2-0.02,x));
    label(string(x,2), (0,x), W);
    draw((x,0)--(x,0.02));
    draw((x,2)--(x,2-0.02));
    label(string(x,2), (x,0), S);
  } else {
    draw((0,x)--(0.01,x));
    draw((2,x)--(2-0.01,x));
    draw((x,0)--(x,0.01));
    draw((x,2)--(x,2-0.01));
  }
  show = ! show;
}
label("Concentration, $X_1$", (1,0), 4S);
label(rotate(90)*Label("Concentration, $X_2$"), (0,1), 5W);

picture bg = new picture;
add(bg, currentpicture);


real[][] Xinit = {{0,0}, {0.5,0.5}, {0.25, 1.2}, {0.4,1.9}, {1.9,1.9}};

for (real[] X0 : Xinit)
  plot(integrate(X0, func, 0, 1.5, h=0.02, RK4));


for(real x1=0.05; x1<2; x1+=0.1) {
  for(real x2=0.05; x2<2; x2+=0.1) {
    real[] X = {x1,x2};
    real[] f = func(0, X);
    pair a = 0.04*unit((f[0],f[1]));
    pair x = (x1,x2);
    draw(x-a--x+a, pink, Arrow(5));
  }
}

ship();

real null1(real X2) {
  return k1/((k3+k5)*(1+(X2/K)^n));
}

real null2(real X1) {
  return (k2+k5*X1)/k2;
}

draw(graph(null2, 0, 2), blue+linewidth(2));
label("\Large $\frac{\mathrm{d} X_2}{\mathrm{d} t}=0$", (1.5, null2(1.5)), 0.2NW, blue);

ship();

real up = 1;
real down = 0.5;
for(int i=0; i<20; ++i) {
  real mid = 0.5*(up+down);
  if (null1(mid)>2)
    down = mid;
  else
    up = mid;
}

guide g;
for(real x=2; x>=up; x-=0.02) {
  g = g--(null1(x),x);
}
draw(g, heavygreen+linewidth(2));
label("\Large $\frac{\mathrm{d} X_1}{\mathrm{d} t}=0$", (null1(1.1),1.1), 0.2SW, heavygreen);
ship();

void fieldDir(real x1, real x2) {
  real[] X = {x1,x2};
  real[] f = func(0, X);
  pair a = 0.1*unit((f[0],f[1]));
  pair x = (x1,x2);
  draw(x-a--x+a, Arrow(8));
}

fieldDir(1.25, 0.5);
fieldDir(1.5, 1.1);
fieldDir(1,1.6);
fieldDir(0.25, 1.5);
ship();
