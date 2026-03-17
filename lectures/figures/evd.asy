size(500,0);
import myutil;
import stats;
import graph;

int n = 10;

real normal(real x) {return exp(-0.5*x*x)/sqrt(2*pi);}

path g=graph(normal, -5, 5);
real u = 0.6;

picture bg = new picture;

for(int i=0; i<n; ++i) {
  draw(bg, (-5,i*u)--(5.2,i*u), Arrow(4));
  draw(bg, (0,i*u)--(0,u*(i+0.9)), Arrow(4));
  draw(bg, shift((0,i*u))*g, red);
  label(bg, "$X_{" + string(i)+"}$", (5.2,i*u), E);
}

dot(bg, (0,n*u+0.5), white);

add(bg);
ship();

real[] ev = new real[n];
for(int i=0; i<n; ++i) {
  ev[i] = Gaussrand();
  label(bg, "$\times$", (ev[i], u*i), gray);
}

void drawEV(int t) {
  erase();
  add(bg);
  label("$k=" + string(t) + "$", (0,n*u), N);
  for(int i=0; i<n; ++i) {
    label("$\bm{\times}$", (ev[i], u*i), blue);
  }
  ship();
}

drawEV(1);

int T = 100;
for(int t=2; t<=T; ++t) {
  for(int i=0; i<n; ++i) {
    real x = Gaussrand();
    label(bg, "$\times$", (x, u*i), gray);
    if (x>ev[i])
      ev[i] = x;
  }
  if (t<9 || t%10==0)
    drawEV(t);
}
    
