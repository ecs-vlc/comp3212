size(600,0);
import myutil;


void DNAStrand(pair pos, string X) {
  filldraw(shift(pos)*box((-15,0),(15,1)), gray);
  filldraw(shift(pos)*box((-5,0),(-1,1)), blue);
  filldraw(shift(pos)*box((-1,0),(7,1)), heavygreen);
  label("gene " + X, pos+(3,0.5));
}

void hugeArrow(pair pos, string str) {
  path ha = (0,3)--(-5,-0.7)--(-2,-0.7)--(-2,-1.7)--(2,-1.7)--(2,-0.7)--(5, -0.7)--cycle;
  draw(shift(pos)*ha, gray(0.5));
  label(str, pos);
}

pair proteinProduction(pair pos, string X) {
  DNAStrand(pos, X);
  DNAStrand(pos+(0,-1.5), X);
  label("regulatory", pos+(-1.5,-1.5), SW, blue);
  label("coding", pos+(-0.5,-1.5), SE, heavygreen);
  ship();
  pos += (3,4);
  hugeArrow(pos, "transcription");
  pos += (0,4);
  filldraw(shift(pos)*box((-5,0),(5,0.5)), green);
  label("mRNA", pos+(5,0.25), E);
  ship();
  pos += (0,4);
  hugeArrow(pos, "translation");
  pos += (0,4);
  filldraw(shift(pos)*box((-2,0),(2,2)),red);
  label("protein " + X, pos+(2,1), E, red);
  ship();
  return pos;
}

draw(box((-17,-5),(56,25)), white);

pair p1 = proteinProduction((0,0), "1");
proteinProduction((40,0), "2");

picture bgPic = new picture;
add(bgPic, currentpicture);

pair start = (-15, 22);
pair end = p1+(0,2.5);
for(real x=0; x<=1.0001; x+=0.2) {
  erase();
  add(currentpicture,bgPic);
  pair pos = (1-x)*start+x*end;
  filldraw(circle(pos,0.5), yellow);
  label("signal", pos+(1,0), E, yellow);
  ship();
}
draw(p1+(2,2)..p1+(4,2.5)..(37,1), gray(0.6), Arrow);
ship();

