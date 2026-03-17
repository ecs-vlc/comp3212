size(600,0);

import myutil;
import ode;
import graph;

real K1 = 1;
real K2 = 1;
real k1 = 20;
real k2 = 20;
real k3 = 5;
real k4 = 5;
int n1 = 2;
int n2 = 2;

real[] func(real t, real[] X) {
  real[] dX = new real[2];
  dX[0] = k1/(1+(X[1]/K2)^n1) - k3*X[0];
  dX[1] = k2/(1+(X[0]/K1)^n2) - k4*X[1];
  return dX;
}

real[] X0 = {0,0};


pair s = (10,0);

draw(box((0,0),(7,7)));

bool show = true;

for(real x=0; x<=7.01; x+= 0.5) {
  if (show) {
    draw((0,x)--(0.08,x));
    draw((7,x)--(7-0.08,x));
    label(string(x,2), (0,x), W);
    draw((x,0)--(x,0.08));
    draw((x,7)--(x,7-0.08));
    label(string(x,2), (x,0), S);
  } else {
    draw((0,x)--(0.04,x));
    draw((7,x)--(7-0.04,x));
    draw((x,0)--(x,0.04));
    draw((x,7)--(x,7-0.04));
  }
  show = ! show;
}


label("Concentration, $X_1$", (3.5,0), 4S);
label(rotate(90)*Label("Concentration, $X_2$"), (0,3.5), 5W);

draw(box(s,s+(7,7)));
show = true;
for(real x=0; x<=7.01; x+= 0.5) {
  if (show) {
    draw(s+(0,x)--s+(0.08,x));
    draw(s+(7,x)--s+(7-0.08,x));
    label(string(x,2), s+(0,x), W);
    draw(s+(x,0)--s+(x,0.08));
    draw(s+(x,7)--s+(x,7-0.08));
    label(string(5*x,2), s+(x,0), S);
  } else {
    draw(s+(0,x)--s+(0.04,x));
    draw(s+(7,x)--s+(7-0.04,x));
    draw(s+(x,0)--s+(x,0.04));
    draw(s+(x,7)--s+(x,7-0.04));
  }
  show = ! show;
}

label("$k_1$", s+(3.5,0), 4S);
label(rotate(90)*Label("Steady-State Concentration, $X_1$"), s+(0,3.5), 5W);


ship();


real nullcline1(real X2) {
  return k1/(k3*(1+(X2/K2)^n1));
}

real nullcline2(real X1) {
  return k2/(k4*(1+(X1/K1)^n2));
}

guide p = graph(nullcline2, 0, 7);
draw(p, blue+linewidth(1)+dashed);

picture bg = new picture;
add(bg, currentpicture);

ship();
guide flip(guide g) {
  guide f;
  for(int i=0; i<length(g); ++i) {
    pair p = point(g, i);
    f = f--(p.y, p.x);
  }
  return f;
}


real fp(real x) {
  real xOld = 100;
  while(fabs(x-xOld)>0.00001) {
    xOld = x;
    real x2 = nullcline2(x);
    x = nullcline1(x2);
  }
  return x;
}

real unstableFP() {
  real high = 2.1;
  real low = 0.5;
  for(int i=0; i<20; ++i) {
    real mid = 0.5*(high+low);
    real x = nullcline1(nullcline2(mid));
    if (x>mid) {
      high = mid;
    } else
      low = mid;
  }
  return 0.5*(high+low);
}


path diamond = (-0.08,0)--(0,-0.08)--(0.08,0)--(0,0.08)--cycle;

guide s1 = (0,0);
guide s2 = (16.2/5, 2.2)--(16.2/5, 2.3)--(16.5/5, 2.6);
guide us = (16.2/5, 2.2)--(16.2/5, 2.1);



for(k1=5; k1<=35.01; k1+=1.0) {
  erase();
  add(bg);
  label("$k_1="+string(k1,2)+"$", (2.8,6), E);
  guide p = graph(nullcline1, 0, 7);
  guide f = flip(p);
  draw(f,  blue+linewidth(1)+dashed);
  if (k1<29) {
    real x1 = fp(0.1);
    s1 = s1--(k1/5, x1);
    filldraw(shift((x1,nullcline2(x1)))*diamond, red, red);
  }
  if (k1>16) {
    real x1 = fp(nullcline1(0.1));
    s2 = s2--(k1/5, x1);
    filldraw(shift((x1,nullcline2(x1)))*diamond, red, red);
    draw(shift(s)*s2, red);
    if (k1<29) {
      real x1 = unstableFP();
      us = us--(k1/5, x1);
      draw(shift((x1,nullcline2(x1)))*diamond, red);
    }
    if (k1==29) {
      s1 = s1--(28.9/5,0.57)--(28.9/5,0.6);
      us = us--(28.9/5,0.63)--(28.9/5,0.6);
    }
    draw(shift(s)*us, red+dashed);
  }
  draw(shift(s)*s1, red);
  ship();
}

