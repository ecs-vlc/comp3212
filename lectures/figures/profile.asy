size(600,0);

void drawState(pair pos, string s, real r=1, pen col=black) {
  filldraw(circle(pos, r), white, col+linewidth(2));
  label(s, pos, col);
}

void arrow(guide g, real f = 0.5) {
  if (f==0.5)
    draw(g, red+linewidth(1), MidArrow(10));
  else
    draw(g, red+linewidth(1), Arrow(10, position=f));
}

real u = 4;
real v = 3;
int n = 5;

arrow((-u+1,0)--(-1,0));
for(int i = 0; i<n; ++i) {
  arrow((u*i-u,0)--(u*i,-v),0.7);
  arrow((u*i,-v)--(u*i+u,0),0.7);
  if (i<n-1)
    arrow((u*i,-v)--(u*i+u,-v));
  drawState((u*i, -v), "delete");
}

for(int i = 0; i<n; ++i) {
  arrow((u*i+1,0)--(u*i+u-1,0));
  if (i<n-1) {
    arrow((u*i,0)--(u*i+0.5u,v));
    arrow((u*i+0.5u,v)--(u*i+u,0));
    pair pos = (u*i+0.5*u, v) + 0.5*(-1,1);
    arrow(pos..pos+0.8*(-1,1)..cycle);
    drawState((u*i+0.5*u, v), "insert");
  }
  drawState((u*i, 0), "match");
}



drawState((-u,0), "start");
drawState((n*u,0), "end");
