settings.outformat="pdf";
import myutil;

size(800,0);

int T = 9;
int n = 6;
real u = 8;
real v = 5;
real r = 1.5;
pen mygray = gray(0.5);

pair pos(real t, real i) {
  if (t==0)
    return (0,0);
  return (t*u, (i-(n-r)/2)*v);
}

draw(box(pos(0,0)-(1,r), pos(T,n)+(1,2)), white);
label("\Huge $v_i(t)=e_i(\xi_t)\, \max_j v_j(t-1)\, a_{ji}$, $\quad v_0(0)=1$", pos(T/2,n) +(0,2), S);


for(int i=0; i<n; ++i) {
  draw(pos(0,0)--pos(1,i), mygray);
}

filldraw(circle((0,0), r), white, mygray);

for(int t=1; t<T; ++t) {
  for(int i=0; i<n; ++i) {
    for(int j=0; j<n; ++j) {
      draw(pos(t,i)--pos(t+1,j), mygray);
    }
    filldraw(circle(pos(t,i), r), white, mygray);
  }
}

for(int i=0; i<n; ++i) {
  filldraw(circle(pos(T,i), r), white, mygray);
}

picture bg = new picture;
add(bg, currentpicture);

ship();

draw(circle(pos(0,0),r));
label("$v_0(0)$", pos(0,0));

int ndev() {return floor(n*(rand()/randMax));}

for(int t=1; t<=T; ++t) {
  label("$\xi_{"+string(t)+"}$", pos(t,n-0.5)); 
  for(int i=0; i<n; ++i) {
    int j = (t==1)? -1:ndev();
    draw(pos(t-1, j)--pos(t,i), linewidth(1), MidArrow);
    filldraw(circle(pos(t-1, j),r), white, black);
    filldraw(circle(pos(t, i),r), white, black);
    label("$v_{" + string(i+1) + "}(" + string(t) +")$", pos(t,i));
    label("$v_{" + string(j+1) + "}(" + string(t-1) +")$", pos(t-1,j));
  }
  ship();
}
