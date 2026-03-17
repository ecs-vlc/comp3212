size(400,0);
import myutil;

draw(box((-1,-10),(100,51)), white);
draw((0,0)--(100,0));
draw((50,0)--(50,10)--(65,10), Arrow);
filldraw(box((20,-1.5),(28,1.5)), gray);
label("Gene Y", (55,0), SE);

picture bg = new picture;
add(bg, currentpicture);

draw((0,10)--(2,11)--(21,11)--(22,12)--(23,11)--(42,11)--(44,10));
label("Promoter Region", (22,12), N);

ship();

path rnaPoly = (-5,0)::(-4,2)::(0,4)::(9,2)::(10,0)::(9,-1)::(2,-3)::(-1,-1)::(-3,-3)::cycle;

void promoter(pair pos) {
  filldraw(shift(pos)*rnaPoly, darkgreen);
  label("\small RNA", pos+(2,2), yellow);
  label("\small polymerase", pos+(2,0), yellow);
}

pair trajectory(path p, int i, int n=10) {
  real t = i*length(p)/n;
  return point(p, t);
}

path p = (10,40)..(30,20)..(21,2);

for(int i=0; i<10; ++i) {
  erase();
  add(bg);
  promoter(trajectory(p, i));
  ship();
}

for(int i=0; i<10; ++i) {
  erase();
  add(bg);
  promoter(trajectory((23,2)--(90,2), i));
  ship();
}

path rna = (50,15)..(55,17)..(61,13)..(65,17)..(69,13)..(76,16)..(80,13)..(85,17)..(88,15);

void Yprotein(pair pos) {
  draw(Label("$Y$", pos), ellipse, FillDraw(yellow));
}


draw((65,0)--(75,10), dashed, Arrow);
label("Transcription", (75,9), E);
draw(rna, linewidth(3));
ship();
draw((78,18)--(88,28), dashed, Arrow);
label("Translation", (83,22), E);
Yprotein((90,32));
ship();

erase();
add(bg);
ship();


void Xprotein(pair pos, bool active=false) {
  string s = active? "$X^*$":"$X$";
  draw(Label(s, pos), ellipse, FillDraw(red));
}

filldraw(bg, box((12,-1.5),(17,1.5)), lightgray);
erase();
add(bg);
label("X Binding Site", (14.5, -1.5), S);
Xprotein((20,20));
ship();

void sx(pair pos) {
  draw(Label("\tiny $S_X$", pos), ellipse, FillDraw(yellow));
}

path ps = (3,43)..(20,35)..(20,20);

for(int i=0; i<10; ++i) {
  erase();
  add(bg);
  sx(trajectory(ps, i));
  Xprotein((20,20));
  ship();
}

for(int i=0; i<=10; ++i) {
  erase();
  add(bg);
  Xprotein(trajectory((20,20)..(15,2), i), true);
  ship();
}

for (int j=0; j<2; ++j) {
  for(int i=0; i<10; ++i) {
    erase();
    add(bg);
    promoter(trajectory(p, i));
    Xprotein((15,2), true);
    label("Excititory Transcription Factor", (50,50), S);
    ship();
  }
  for(int i=0; i<10; ++i) {
    erase();
    add(bg);
    promoter(trajectory((23,2)--(90,2), i));
    label("Excititory Transcription Factor", (50,50), S);
    Xprotein((15,2), true);
    ship();
  }
  draw((65,0)--(75,10), dashed, Arrow);
  label("Transcription", (75,9), E);
  draw(rna, linewidth(3));
  ship();
  draw((78,18)--(88,28), dashed, Arrow);
  label("Translation", (83,22), E);
  Yprotein((90,32));
  ship();
}

void Zprotein(pair pos, bool active=false) {
  string s = active? "$Z^*$":"$Z$";
  draw(Label(s, pos), ellipse, FillDraw(red));
}

void sz(pair pos) {
  draw(Label("\tiny $S_Z$", pos), ellipse, FillDraw(yellow));
}


filldraw(bg, box((32,-1.5),(38,1.5)), pink);
erase();
add(bg);
label("Z Binding Site", (35, -1.5), S);
Zprotein((20,20));
ship();



for(int i=0; i<10; ++i) {
  erase();
  add(bg);
  sz(trajectory(ps, i));
  Zprotein((20,20));
  ship();
}

for(int i=0; i<=10; ++i) {
  erase();
  add(bg);
  Zprotein(trajectory((20,20)..(35,2), i), true);
  ship();
}

path p = (10,40)..(30,20)..(21,5)..(16,10);
for(int i=0; i<10; ++i) {
  erase();
  add(bg);
  promoter(trajectory(p, i));
  Zprotein((35,2), true);
  label("Inhibitory Transcription Factor", (50,50), S);
  ship();
}
