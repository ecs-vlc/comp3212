size(300,0);

import myutil;
import ode;
import graph;

real k0 = 8;
real k1 = 1;
real k2 = 5;
int n = 2;

real[] func(real t, real[] X) {
  real[] dX = new real[2];
  dX[0] = k0 - k1*(1+(X[1])^n)*X[0];
  dX[1] = k1*(1+(X[1])^n)*X[0] - k2*X[1];
  return dX;
}

void plot(Solution sol) {
  guide g;
  for(int t=0; t<sol.t.length; ++t) {
    g = g--(sol.y[t][0], sol.y[t][1]);
  }
  draw(g, gray+linewidth(1), MidArrow(8));
}

draw(box((0,0),(4.0,4.0)));
bool show = true;

for(real x=0; x<=4.01; x+= 0.5) {
  if (show) {
    draw((0,x)--(0.08,x));
    draw((4.0,x)--(4.0-0.08,x));
    label(string(x,2), (0,x), W);
    draw((x,0)--(x,0.08));
    draw((x,4.0)--(x,4.0-0.08));
    label(string(x,2), (x,0), S);
  } else {
    draw((0,x)--(0.04,x));
    draw((4.0,x)--(4.0-0.04,x));
    draw((x,0)--(x,0.04));
    draw((x,4.0)--(x,4.0-0.04));
  }
  show = ! show;
}
label("Concentration, $X_1$", (2.25,0), 4S);
label(rotate(90)*Label("Concentration, $X_2$"), (0,2.25), 5W);

picture bg = new picture;
add(bg, currentpicture);


real[][] Xinit = {{2,0}, {0,1}, {0,3}};

for (real[] X0 : Xinit)
  plot(integrate(X0, func, 0, 10, h=0.02, RK4));

ship();

for(real x1=0.1; x1<4.0; x1+=0.2) {
  for(real x2=0.1; x2<4.0; x2+=0.2) {
    real[] X = {x1,x2};
    real[] f = func(0, X);
    pair a = 0.08*unit((f[0],f[1]));
    pair x = (x1,x2);
    draw(x-a--x+a, lightred, Arrow(5));
  }
}

ship();

real nullcline1(real X2) {
  return k0/(k1*(1+(X2)^n));
}

real up = 1;
real down = 0.5;
for(int i=0; i<20; ++i) {
  real mid = 0.5*(up+down);
  if (nullcline1(mid)>4)
    down = mid;
  else
    up = mid;
}


guide p = graph(nullcline1, up, 4.0);

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

real nullcline2(real X2) {
  return k2*X2/(k1*(1+(X2)^n));
}
p = graph(nullcline2, 0, 4.0);
guide f = flip(p);
draw(f,  blue+linewidth(1)+dashed);

dot((200/89,8/5), blue);
ship();
