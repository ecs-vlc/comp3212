size(400,200, IgnoreAspect);
import myutil;
import gsl;

int PP = 100;
real s = 0.2;
real u = 0.005;
real v = 0.005;


real psm(int n) {
  return ((1-v)*(1+s)*n+u*(PP-n))/(PP+s*n);
}

real[] p = array(PP+1,0);
p[0] = 1;

real[][] WW = new real[PP+1][PP+1];

for(int i=0; i<=PP; ++i) {
  real pp = psm(i);
  real lp = log(pp);
  real lq = log1p(-pp);
  for(int j=0; j<=PP; ++j) {
    WW[j][i] = exp(lnchoose(PP,j)+j*lp+(PP-j)*lq);
  }
}

void axes() {
  label("$P="+string(PP)+",\,s="+string(s,2)+",\,u="+string(u,2)+",\,v="+string(v,2)+"$", (0.55*PP, 1), N);
  draw((0,1.1)--(0,0)--(1.1*PP,0), Arrows);
  label("Number of Mutants in Population, $n$", (0.55*PP, -0.15));
  label("$p_n(t)$", (0.1*PP, 0.55), W);
  for(int i=0; i<=PP+3; i+=10) {
    draw((i,0)--(i,-0.03));
    label(string(i), (i,-0.03), S);
  }
  bool show = true;
  for(real x=0.0; x<1.0001; x += 0.1) {
    if (show) {
      draw((0,x)--(-1,x));
      label(string(x,1), (-1,x), W);
    } else
      draw((0,x)--(-1,x));
  }
}

void drawPop(real[] p, pen col=blue+linewidth(1)) {
  guide g = (0,0);
  for(int i=0; i<=PP; ++i) {
    g = g--(i, p[i])--(i+1, p[i]);
  }
  g = g--(PP+1.0,0);
  draw(g, col);
}

real[] cnts = new real[PP+1];
for(int i=0; i<=PP; ++i) {
  cnts[i] = i;
}

int T = 100;
real[] mean;

for(int t=0; t<=T; ++t) {
  label("$t="+string(t)+"$", (0.55*PP,1),S);
  axes();
  drawPop(p);
  if (t<10 | t%10==0)
  ship();
  erase();
  drawPop(p, gray);
  mean.push(dot(cnts,p));
  p = WW*p;
}

erase();

label("$P="+string(PP)+",\,s="+string(s,2)+",\,u="+string(u,2)+",\,v="+string(v,2)+"$", (T/2,PP), N);

draw((0,1.05*PP)--(0,0)--(1.05*T,0), Arrows);
label("Generation, $t$", (T/2,-15));
label(rotate(90)*Label("Expected Number of Mutatnts"), (-10,0.5*PP));
for(int i=0; i<=T; i+=20) {
  draw((i,0)--(i,-1));
  label(string(i), (i,-1),S);
}

for(int p=0; p<=PP; p+=20) {
  draw((0,p)--(-1,p));
  label(string(p), (-1,p), W);
}

guide g=(0,0);
for(int i=0; i<mean.length; ++i) {
  g = g--(i, mean[i])--((i+1), mean[i]);
}

draw(g, red);

shipout("markov_full");
