size(400,0);
import myutil;

int n0 = 12;
int n1 = 5;
int n2 = 3;
int n3 = n2;

int[] sizes = {n0, n1, n2, n3};
real[] squash = {0.7, 1, 1, 1};
real[] xpos = {0, 5, 10, 12};

pair pos(int layer, int i) {
  real u = 5;
  return (xpos[layer], squash[layer]*(i-sizes[layer]/2));
}

void node(pair p, bool sig=false) {
  real r = (sig)? 0.4:0.2;
  filldraw(circle(p,r), yellow);
  if (sig) {
    draw(shift(p)*((-0.2,-0.2)..(-0.1,-0.17)..(0,0)..(0.1,0.17)..(0.2,0.2)), red);
  }
}

draw(box(pos(0,0)-(1.5,2), (pos(3,0).x+2, pos(0,n0-1).y+0.5)), white);

for(int i=0; i<n0; ++i) {
  for(int j=0; j<n1; ++j) {
    draw(pos(0,i)--pos(1,j));
  }
  node(pos(0,i), false);
  if (i<3) {
    label("$x_{" + string(i+1) + "}$", pos(0,i)-(0.2,0), W);
  }
}
label("$x_{n}$", pos(0,n0-1)-(0.2,0), W);

for(int i=0; i<n1; ++i) {
  for(int j=0; j<n2; ++j) {
    draw(pos(1,i)--pos(2,j));
  }
  node(pos(1,i), true);
}

for(int i=0; i<n2; ++i) {
  draw(pos(2,i)--pos(3,i));
  node(pos(2,i), true);
  node(pos(3,i), false);
}

label(rotate(90)*Label("Input pattern, $\bm{x}$"), (-1,0));
ship();

label("Hidden Layer", pos(1,n1-1), 4N);

ship();

label("$\mat{W}$", 0.5*(pos(0,n0-1)+pos(1,n1-1)), N);

ship();

label("$g\!\left(\sum\limits_{j=1}^n W_{ij}\, x_j + b_j\right)$", pos(1,0), SE);

ship();

label("Output Layer", pos(2, n2-1), 4NE);

ship();

label("$\bar{\mat{W}}$", 0.5*(pos(2,n2-1)+pos(1,n1-1)), N);

ship();

for(int i=0; i<n3; ++i) {
  label("$f_" + string(i+1) + "\!\left(\bm{x}|\bm{\theta}\right)$", pos(3,i), 2E);
}

ship();

label("$f_i\!\left(\bm{x}|\bm{\theta}\right) = g\!\left(\sum\limits_{j=1}^{n_h} \bar{W}_{i,j}\,g\!\left(\sum\limits_{k=1}^n W_{ik}\, x_k + b_k\right) + \bar{b}_i\right)$", pos(0,0)-(0,2), NE);
ship();

label("$\bm{\theta} = \{\mat{W},\bm{b}, \bar{\mat{W}}, \bar{\bm{b}}\}$", pos(0,0)+(10,0), E);
ship();
