size(200,0);

void node(string s, pair pos) {
  label("\large $"+s+"$", pos);
  draw(circle(pos, 1), linewidth(2));
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
