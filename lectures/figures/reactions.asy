settings.outformat="pdf";
size(300,0);
import myutil;
usepackage("amssymb");
srand(4);

int A = 4;
int B = 7;
int C = 0;
real k1 = 0.05;
real k2= 0.03;
real k3 = 0.005;
real k4 = 0.01;

real T = 100;
int nmax = 15;
real u = 4;

picture bg = new picture;

draw(bg, (0,1.05*u*nmax)--(0,0)--(1.05*T,0), Arrows);
bool show = true;
for(int i=0; i<=T; i+=10) {
  if (show) {
    draw(bg, (i,0)--(i,-2));
    label(bg, string(i), (i,-2), S);
  } else {
    draw(bg, (i,0)--(i,-1));
  }
  show = ! show;
}

for (int i=0; i<=nmax; ++i) {
  if (i%5==0) {
    draw(bg, (0,u*i)--(-2,u*i));
    label(bg, string(i), (-2,u*i), W);
  } else {
    draw(bg, (0,u*i)--(-1,u*i));
  }
}

label(bg, "$t$", (1.05*T,0), E);
label(bg, rotate(90)*Label("Number of Molecules"), (-8,0.5*u*nmax), W);

real[] lambda = new real[4];

real told = 0;
real lt;
int cnt=0;
add(bg);
dot((0,u*A), red);
dot((0,u*B), blue);
dot((0,u*C), heavygreen);

label("$A$", (0,u*A), E, red);
label("$B$", (0,u*B), E, blue);
label("$C$", (0,u*C), E, heavygreen);
ship();
while (true) {
  ++cnt;
  if (cnt>50)
    break;
  erase();
  lt = lambda[0] = k1;
  lt += (lambda[1] = k2);
  lt += (lambda[2] = k3*A*B);
  lt += (lambda[3] = k4*C);
  real t = told -log(1-(rand()/randMax))/lt;
  if (t>T)
    t = T;
  draw(bg, (told,u*A)--(t,u*A), red);
  draw(bg, (told,u*B)--(t,u*B), blue);
  draw(bg, (told,u*C)--(t,u*C), heavygreen);
  if (t==T)
    break;
  real r = lt*(rand()/randMax);
  int i;
  for(i=0; i<3; ++i) {
    r -= lambda[i];
    if (r<=0) {
      break;
    }
  }
  real t0 = t;
  if (t0<10)
    t0 = 10;
  if (t0>T-10)
    t0 = T-10;
  if (i==0) {
    draw(bg, (t,u*A)--(t,u*A+u), red);
    A = A+1;
    label("$\varnothing\longrightarrow A$",  (T/2, u*14), N);
  } else if (i==1) {
    draw(bg, (t,u*B)--(t,u*B+u), blue);
    B = B+1;
    label("$\varnothing\longrightarrow B$",  (T/2, u*14), N);
  } else if (i==2) {
    draw(bg, (t,u*C)--(t,u*C+u), heavygreen);
    draw(bg, (t,u*A)--(t,u*A-u), red);
    draw(bg, (t,u*B)--(t,u*B-u), blue);
    A = A-1;
    B = B-1;
    C = C+1;
    label("$A + B \longrightarrow C$",  (T/2, u*14), N);
  } else {
    draw(bg, (t,u*C)--(t,u*C-u), heavygreen);
    draw(bg, (t,u*A)--(t,u*A+u), red);
    draw(bg, (t,u*B)--(t,u*B+u), blue);
    A = A+1;
    B = B+1;
    C = C-1;
    label("$C \longrightarrow A + B$",  (T/2, u*14), N);
  }
  add(bg);
  label("$A$", (t,u*A), E, red);
  label("$B$", (t,u*B), E, blue);
  label("$C$", (t,u*C), E, heavygreen);
  ship();
  told = t;
}
add(bg);

label("$A$", (T,u*A), E, red);
label("$B$", (T,u*B), E, blue);
label("$C$", (T,u*C), E, heavygreen);
ship();
