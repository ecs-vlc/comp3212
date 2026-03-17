size(300,0);

import myutil;
import ode;
import graph;

real K1 = 1;
real K2 = 1;
real k1 = 20;
real k2 = 20;
real k3 = 5;
real k4 = 5;
int n1 = 4;
int n2 = 4;

real[] func(real t, real[] X) {
  real[] dX = new real[2];
  dX[0] = k1/(1+(X[1]/K2)^n1) - k3*X[0];
  dX[1] = k2/(1+(X[0]/K1)^n2) - k4*X[1];
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

draw(box((0,0),(4.4,4.4)));
bool show = true;

for(real x=0; x<=4.41; x+= 0.5) {
  if (show) {
    draw((0,x)--(0.02,x));
    draw((4.4,x)--(4.4-0.02,x));
    label(string(x,2), (0,x), W);
    draw((x,0)--(x,0.02));
    draw((x,4.4)--(x,4.4-0.02));
    label(string(x,2), (x,0), S);
  } else {
    draw((0,x)--(0.01,x));
    draw((4.4,x)--(4.4-0.01,x));
    draw((x,0)--(x,0.01));
    draw((x,4.4)--(x,4.4-0.01));
  }
  show = ! show;
}
label("Concentration, $X_1$", (2.25,0), 4S);
label(rotate(90)*Label("Concentration, $X_2$"), (0,2.25), 5W);

picture bg = new picture;
add(bg, currentpicture);


real[][] Xinit = {{0.05,0}, {0.5,0}, {1.5,0}, {4.4, 0.5}, {4.4, 1.5}, {4.4, 2.5}, {4.4, 3.5}, {4.4, 4.3}, {4.3,4.4}, {3.5,4.4}, {2.5,4.4}, {1.5,4.4}, {0.5,4.4}, {0,1.5}, {0,0.5}, {0,0.05}};

for (real[] X0 : Xinit)
  plot(integrate(X0, func, 0, 1.5, h=0.02, RK4));

ship();

for(real x1=0.1; x1<4.4; x1+=0.2) {
  for(real x2=0.1; x2<4.4; x2+=0.2) {
    real[] X = {x1,x2};
    real[] f = func(0, X);
    pair a = 0.08*unit((f[0],f[1]));
    pair x = (x1,x2);
    draw(x-a--x+a, lightred, Arrow(5));
  }
}

ship();

real nullcline(real X2) {
  return k1/(k3*(1+(X2/K2)^n1));
}

guide p = graph(nullcline, 0, 4.4);
draw(p, blue+linewidth(1)+dashed);

guide flip(guide g) {
  guide f;
  for(int i=0; i<length(g); ++i) {
    pair p = point(g, i);
    f = f--(p.y, p.x);
  }
  return f;
}

guide f = flip(p);
draw(f,  blue+linewidth(1)+dashed);


ship();

real lower = 1.1;
real upper = 1.3;
for(int i=0; i<20; ++i) {
  real mid = 0.5*(upper+lower);
  if (mid > nullcline(mid)) {
    upper = mid;
  } else {
    lower = mid;
  }
}

path fp = (-0.1,0)--(0,-0.1)--(0.1,0)--(0,0.1)--cycle;

filldraw(shift((4,0.01))*fp);
filldraw(shift((0.01,4))*fp);
ship();
draw(shift((lower,lower))*fp, linewidth(2));

ship();
