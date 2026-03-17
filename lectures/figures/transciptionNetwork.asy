size(500,0);

int sN = 6;
int tN = 5;
int gN = 8;

pair sPos(real i) {
  return (10*(i-sN/2), 30);
}

pair gPos(real i) {
  return (8*(i-gN/2), 0);
}

pair tPos(real i) {
  return (6*(i-tN/2), 15);
}

int[][] st = {{1,1},{2,2},{3,3},{4,3},{sN,tN}};
int[][] tg = {{1,1},{1,2},{1,3},{1,5},{2,2},{2,3},{2,4},{3,2},{3,5},{3,6},{tN,6},{tN,gN}};

for(int i=0; i<st.length; ++i) {
  draw(sPos(st[i][0])--tPos(st[i][1]), MidArrow);
}

for(int i=0; i<tg.length; ++i) {
  draw(tPos(tg[i][0])--gPos(tg[i][1])-(4,0), Arrow);
}


for(int i=1; i<=sN; ++i) {
  if (i == sN-1) {
    for(int j=-1; j<2; ++j) {
      dot(sPos(i)-3*j, linewidth(6));
    }
    continue;
  }
  string s = "Signal ";
  s += (i==sN)? "$N$":string(i);
  draw(Label(s, sPos(i)), ellipse, FillDraw(lightgray));
}


for(int i=1; i<=tN; ++i) {
  if (i == tN-1) {
    for(int j=-1; j<2; ++j) {
      dot(tPos(i)-2*j, linewidth(6));
    }
    continue;
  }
  string s = "$X_";
  s += (i==tN)? "m$":string(i)+"$";
  draw(Label(s, tPos(i)), ellipse, FillDraw(lightgray));
}

draw(gPos(0.3)--gPos(gN+0.5));

for(int i=1; i<=gN; ++i) {
  if (i == gN-1) {
    label("\ldots",gPos(i), 4S);
    continue;
  }
  string s = "gene ";
  s += (i==gN)? "$k$":string(i);
  label(s, gPos(i), 2S);
  draw(shift(gPos(i))*((-2,0)--(-2,1)--(1,1)), Arrow);
}

real x = sPos(-0.5).x;
label("Environment", (x, sPos(0).y));
label("Transciption", (x, tPos(0).y),0.5N);
label("factors", (x, tPos(0).y),0.5S);
label("Genes", (x, gPos(0).y));

draw((x,28)--(x,18), Arrow);
draw((x,12)--(x,2), Arrow);
draw((x+1,2)--(x+1,12), dashed, Arrow);
draw((x+2,2)..(x+6,15)..(x+2,28), dashed, Arrow);
