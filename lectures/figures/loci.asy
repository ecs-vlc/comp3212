import myutil;
size(300,0);

string s = "abcdefghijkl";
string[] sa = array(s);

draw((-0.5,0)--(14.5,0));
draw((-0.5,1)--(14.5,1));

label("$\cdots$", (0.5,0.5));
draw((0,0)--(0,1));

for(int i=0; i<sa.length; ++i) {
  label(sa[i], (i+1.5,0.5));
  draw((i+1,0)--(i+1,1));
}

draw((13,0)--(13,1));
label("$\cdots$", (13.5,0.5));
draw((14,0)--(14,1));

draw((9,1.5)..(8,1.3)..(7.5,1), Arrow);
label("locus", (9,1.5), E, red);

real h = -1;
real p = h;
guide g = (-0.5,p);
for(real r=0; r<14.51; r+=1) {
  p += (rand()/randMax-0.5) - 0.2*(p-h);
  g = g..(r, p);
}

draw(g, linewidth(3)+gray(0.7));

real l = length(g);
real t = 0.0;
for(int i=0; i<sa.length; ++i) {
  t += max(0.7, 1.7*l*rand()/(1.0*sa.length*randMax));
  real len = 0.07 + 0.13*rand()/randMax;
  draw(subpath(g, t-len, t+len), red+linewidth(3));
  label(sa[i], point(g,t), N);
}
