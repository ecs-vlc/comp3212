size(400,0);
import myutil;
import stats;
import graph;

int T = 10000;
int n = 10000;

real y2 = 2*log(T) - log(2*pi);
real y = sqrt(y2 - log(y2));

real f(real x) {return exp(-0.5*x*x)/(sqrt(2*pi)*x) - 1/T;}
real fp(real x) {return -exp(-0.5*x*x)*(1+1/(x*x))/sqrt(2*pi);}

for(int i=0; i<2; ++i) {
  write(f(y));
  y = y - f(y)/fp(y);
}



real gumbel(real x) {
  real z = x-y;
  return y*exp(-y*z-exp(-y*z));
}


real[] ev = new real[n];
for(int i=0; i<n; ++i) {
  ev[i] = Gaussrand();
}

for(int t=2; t<=T; ++t) {
  for(int i=0; i<n; ++i) {
    real x = Gaussrand();
    if (x>ev[i])
      ev[i] = x;
  }
}

histogram(ev, 2, 6, 40, normalize=true, low=0, lightred, black, bars=false);
draw(graph(gumbel, 2, 6), blue);
draw((2,1.3)--(2,0)--(6.1,0), Arrows);
label("$z$", (6.1,0), E);
label("$f(z)$", (2,1.3), N);
label("Extreme Value Distribution for " + string(n) + " normals", (4,1.5), S);
for(int i=2; i<=6; ++i) {
  draw((i,0)--(i,-0.05));
  label(string(i), (i,-0.05), S);
}
