size(500,0);

import myutil;
import ode;

real r = 1000;
real K = r*1;
real k1 = 20;
real k2 = 5;
real k3 = 5/r;
real k4 = 5/r;
real k5 = 2/r;
int n = 4;

real[] func(real t, real[] X) {
  real[] dX = new real[2];
  dX[0] = k1/(1+(X[1]/K)^n) - k3*X[0] - k5*X[0];
  dX[1] = k2 + k5*X[0] - k4*X[1];
  return dX;
}

real[] X0 = {0,0};

real T = r;
real xmax = 2*r;
real u = xmax/T;

Solution sol = integrate(X0, func, 0, T, h=T*0.02, RK4);

pair s = (1.2*u*T,0);

draw(box((0,0),(u*T,xmax)));
draw(shift(s)*box((0,0),(xmax,xmax)));
bool show = true;
for(real t=0; t<=1.01*T; t+= T/10) {
  if (show) {
    draw((u*t,0)--(u*t,0.02));
    draw((u*t,2)--(u*t,2-0.02));
    label(string(t,4), (u*t,0), S);
  } else {
    draw((u*t,0)--(u*t,0.01));
    draw((u*t,2)--(u*t,2-0.01));
  }
  show = ! show;
}

show = true;
for(real x=0; x<=1.01*xmax; x+= xmax/10) {
  if (show) {
    draw((0,x)--(0.02,x));
    draw((xmax,x)--(xmax-0.02,x));
    label(string(x,4), (0,x), W);
    draw(s+(0,x)--s+(0.02,x));
    draw(s+(xmax,x)--s+(xmax-0.02,x));
    label(string(x,4), s+(0,x), W);
  } else {
    draw((0,x)--(0.01,x));
    draw((xmax,x)--(xmax-0.01,x));
    draw(s+(0,x)--s+(0.01,x));
    draw(s+(2,x)--s+(2-0.01,x));
  }
  show = ! show;
}

show = true;
for(real x=0; x<=xmax; x+= xmax/10) {
  if (show) {
    draw(s+(x,0)--s+(x,0.02));
    draw(s+(x,2)--s+(x,2-0.02));
    label(string(x,4), s+(x,0), S);
  } else {
    draw(s+(x,0)--s+(x,0.01));
    draw(s+(x,2)--s+(x,2-0.01));
  }
  show = ! show;
}

label("time, $t$", (0.5*T*u,0), 4S);
label(rotate(90)*Label("Concentration, $\textcolor{red}{X_1},\, \textcolor{blue}{X_2}$"), (-0.3, xmax/2), 6W);
label("Concentration, $X_1$", s+(xmax/2,0), 4S);
label(rotate(90)*Label("Concentration, $X_2$"), s+(0,xmax/2), 6W);

picture bg = new picture;
add(bg, currentpicture);


real[] X = {0.0, 0.0, 0.0};

real[] propensities(real[] X) {
  real[] lambda = new real[6];
  lambda[0] = lambda[1] = k1/(1+(X[2]/K)^n);
  lambda[0] += lambda[2] = k3*X[1];
  lambda[0] += lambda[3] = k5*X[1];
  lambda[0] += lambda[4] = k2;
  lambda[0] += lambda[5] = k4*X[2];
  return lambda;
}

real nextEventTime(real lambda) {
  return -log(1-(rand()/randMax))/lambda;
}

int nextEvent(real[] lambda) {
  real r = lambda[0]*(rand()/randMax);
  for(int i=1; i<lambda.length; ++i) {
    r -= lambda[i];
    if (r<=0) {
      return i;
    }
  }
  return 1;
}

real Gillt= 0.0;
guide g1;
guide g2;
guide g12;
pair x1 = (0,0);
pair x2 = (0,0);
pair x12 = (0,0);
guide gg1;
guide gg2;
guide gg12;

real told = 0;
real[] Xold = {0,0};
bool bigjump(real[] X) {
  if (abs(X[0]-Xold[0]) + abs(X[1]-Xold[1])>5) {
    Xold[0] = X[0];
    Xold[1] = X[1];
    return true;
  } else
    return false;
}

for(int t=0; t<sol.t.length; ++t) {
  write(t, sol.t[t], sol.y[t][0], sol.y[t][1]);
  g1 = g1--(u*sol.t[t], sol.y[t][0]);
  g2 = g2--(u*sol.t[t], sol.y[t][1]);
  g12 = g12--(sol.y[t][0], sol.y[t][1]);
  real d1 = length(x1-(u*sol.t[t], sol.y[t][0]));
  real d2 = length(x2-(u*sol.t[t], sol.y[t][1]));
  real d12 = length(x12-(sol.y[t][0], sol.y[t][1]));
  while(Gillt<sol.t[t]) {
    real[] lambda = propensities(X);
    Gillt += nextEventTime(lambda[0]);
    int reaction = nextEvent(lambda);
    if (reaction==1) {
      X[1] += 1;
    } else if (reaction==2) {
      X[1] -= 1;
    } else if (reaction==3) {
      X[1] -= 1;
      X[2] += 1;
    } else if (reaction==4) {
      X[2] += 1;
    } else  if (reaction==5) {
      X[2] -= 1;
    }
    if (bigjump(X)) {
	gg1 = gg1--(u*Gillt, X[1]);
	gg2 = gg2--(u*Gillt, X[2]);
	gg12 = gg12--(X[1],X[2]);
    }
  }
  
  if (sol.t[t]-told>=0.025*T) {
    told += 0.025*T;
    erase();
    add(bg);
    draw(g1, red+dashed+linewidth(1.5));
    draw(gg1, red);
    draw(g2, blue+dashed+linewidth(1.5));
    draw(gg2, blue);
    draw(shift(s)*g12, heavygreen+dashed+linewidth(1.5));
    draw(shift(s)*gg12, heavygreen);
    x1 = (u*sol.t[t], sol.y[t][0]);
    x2 = (u*sol.t[t], sol.y[t][1]);
    x12 =(sol.y[t][0], sol.y[t][1]);
    dot(x1, red);
    dot(x2, blue);
    dot(s+x12, heavygreen);
    ship();
  }
}
