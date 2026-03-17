size(300,0);
import myutil;

void node(string s, pair pos, bool highlight=false) {
  pen col = (highlight)? paleblue : white;
  filldraw(circle(pos, 1), col, linewidth(2));
  label("\large $"+s+"$", pos);
}

real u = 5;
pair pM = (0,0);
pair pIa = (u*sqrt(0.5), 0.5*u);
pair pIb = (u*sqrt(0.5), -0.5*u);

node("M", pM);
node("I_a", pIa);
node("I_b", pIb);

pair pos(pair centre, real angle) {
  return centre + (Sin(90-angle), Cos(90-angle));
}

pair myPerp(pair a, pair b, real x) {
  pair mid = 0.5*(a+b);
  pair dir = b-a;
  pair p = unit((dir.y,-dir.x));
  return mid + x*p;
}

draw(pos(pM, 15)..myPerp(pM,pIa,0.7)..pos(pIa,235), red, Arrow);
draw(pos(pIa,205)..myPerp(pM,pIa,-0.7)..pos(pM, 45), red, Arrow);
label("$s(a_i,b_j)$", myPerp(pM,pIa,-0.6), NW);
label("$d$", myPerp(pM,pIa,0.5), SE);

draw(pos(pM, -15)..myPerp(pM,pIb,-0.7)..pos(pIb,135), red, Arrow);
draw(pos(pIb, 165)..myPerp(pM,pIb,0.7)..pos(pM, -45), red, Arrow);
label("$s(a_i,b_j)$", myPerp(pM,pIb,0.6), SW);
label("$d$", myPerp(pM,pIb,-0.5), NE);

draw(pos(pM, 190)..2.5*pos(pM, 180)-1.5*pM..pos(pM, 170), red, Arrow);
label("$s(a_i,b_j)$", 2.5*pos(pM, 180)-1.5*pM, W);

draw(pos(pIa, 50)..2.5*pos(pIa, 60)-1.5*pIa..pos(pIa, 70), red, Arrow);
label("$e$", 2.6*pos(pIa, 70)-1.6*pIa, E);

draw(pos(pIb, -50)..2.5*pos(pIb, -60)-1.5*pIb..pos(pIb, -70), red, Arrow);
label("$e$", 2.6*pos(pIb, -70)-1.6*pIb, E);

picture fsaPic = new picture;


string aString = "VLSPAD-K";
string bString = "HL--AESK";

void aLetter(int i, bool bold) {
  pair pos = (u+0.7*i+1, 0.5);
  if (bold)
    label("\textbf{" + substr(aString, i, 1) + "}", pos, blue);
  else
    label(substr(aString, i, 1), pos);
}

void bLetter(int i, bool bold) {
  pair pos = (u+0.7*i+1, -0.5);
  if (bold)
    label("\textbf{" + substr(bString, i, 1) + "}", pos, blue);
  else
    label(substr(bString, i, 1), pos);
}

for(int i=0; i<length(aString); ++i) {
  aLetter(i, false);
  bLetter(i, false);
}


add(fsaPic, currentpicture);

ship();

node("M", pM, true);
aLetter(0, true);
bLetter(0, true);
int state = 0;
ship();

for(int i=1; i<length(aString); ++i) {
  int oldState = state;
  erase();
  add(fsaPic);
  aLetter(i, true);
  bLetter(i, true);
  if (substr(bString, i, 1)=="-") {
    node("I_a", pIa, true);
    state = 1;
  } else if (substr(aString, i, 1)=="-") {
    node("I_b", pIb, true);
    state = 2;
  } else {
    node("M", pM, true);
    state = 0;
  }
  if (oldState == 0) {
    if (state == 0) {
      draw(pos(pM, 190)..2.5*pos(pM, 180)-1.5*pM..pos(pM, 170), blue, Arrow);
      label("$s(a_i,b_j)$", 2.5*pos(pM, 180)-1.5*pM, W, blue);
    } else if (state ==1) {
      draw(pos(pM, 15)..myPerp(pM,pIa,0.7)..pos(pIa,235), blue, Arrow);
      label("$d$", myPerp(pM,pIa,0.5), SE, blue);
    } else {
      draw(pos(pM, -15)..myPerp(pM,pIb,-0.7)..pos(pIb,135), blue, Arrow);
      label("$d$", myPerp(pM,pIb,-0.5), NE, blue);
    }
  } else if (oldState == 1) {
    if (state ==0) {
      draw(pos(pIa,205)..myPerp(pM,pIa,-0.7)..pos(pM, 45), blue, Arrow);
      label("$s(a_i,b_j)$", myPerp(pM,pIa,-0.6), NW, blue);
    } else {
      draw(pos(pIa, 50)..2.5*pos(pIa, 60)-1.5*pIa..pos(pIa, 70), blue, Arrow);
      label("$e$", 2.6*pos(pIa, 70)-1.6*pIa, E, blue);
    }
  } else {
    if (state ==0) {
      draw(pos(pIb, 165)..myPerp(pM,pIb,0.7)..pos(pM, -45), blue, Arrow);
      label("$s(a_i,b_j)$", myPerp(pM,pIb,0.6), SW, blue);
    } else {
      draw(pos(pIb, -50)..2.5*pos(pIb, -60)-1.5*pIb..pos(pIb, -70), blue, Arrow);
      label("$e$", 2.6*pos(pIb, -70)-1.6*pIb, E, blue);
    }
  }
  ship();
}
