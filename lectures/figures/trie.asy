size(500,0);
import myutil;

defaultpen(Courier());

draw(box((-3.3,-2.8),(3,0.2)),white);
label("$\mathtt{\{A\$,\, ACCA\$,\, CA\$,\, CAA\$,\, CACA\$,\, TAC\$\}}$", (-3, 0.2), E);
ship();

picture nodepic;
picture edgepic;

void node(string str, pair pos) {
  draw(nodepic, str,ellipse, pos, FillDraw(white));
}

void leaf(string str, pair pos) {
  draw(nodepic, str,ellipse, pos, blue+linewidth(2), FillDraw(white));
}

void edge(pair pos1, pair pos2, string str="") {
  draw(edgepic, pos1--pos2);
  if (str!="")
    draw(edgepic, str, ellipse, (pos1+pos2)/2, white, FillDraw(white));
}

pair p0 = (0,0);
node("*", p0);
pair pa = p0+(-2.5,-0.5);
pair pb = p0+(0,-0.5);
pair pc = p0+(2.5,-0.5);
edge(p0, pa, "A");
edge(p0, pb, "C");
edge(p0, pc, "T");
node("A*", pa);
node("C*", pb);
node("T*", pc);

pair pae = pa+(-0.5,-0.5);
pair pab = pa+(0.5,-0.5);
pair pba = pb+(0,-0.5);
pair pca = pc+(0,-0.5);

edge(pa, pae, "\$");
edge(pa, pab, "C");
edge(pb, pba, "A");
edge(pc, pca, "A");
leaf("A\$", pae);
node("AC*", pab);
node("CA*", pba);
node("TA*", pca);

pair pabb = pab+(0,-0.5);
pair pbae = pba+(-1,-0.5);
pair pbaa = pba+(0,-0.5);
pair pbab = pba+(1,-0.5);
pair pcab = pca+(0,-0.5);
node("ACC*", pabb);
leaf("CA\$", pbae);
node("CAA*", pbaa);
node("CAC*", pbab);
node("TAC*", pcab);
edge(pab, pabb, "C");
edge(pba, pbae, "\$");
edge(pba, pbaa, "A");
edge(pba, pbab, "C");
edge(pca, pcab, "C");

pair pabba = pabb+(0,-0.5);
pair pbaae = pbaa+(0,-0.5);
pair pbaba = pbab+(0,-0.5);
pair pcabe = pcab+(0,-0.5);
node("ACCA*", pabba);
leaf("CAA\$", pbaae);
node("CACA*", pbaba);
leaf("TAC\$", pcabe);
edge(pabb, pabba, "A");
edge(pbaa, pbaae, "\$");
edge(pbab, pbaba, "A");
edge(pcab, pcabe, "\$");

pair pabbae = pabba+(0,-0.5);
pair pbabae = pbaba+(0,-0.5);
leaf("ACCA\$", pabbae);
leaf("CACA\$", pbabae);
edge(pabba, pabbae, "\$");
edge(pbaba, pbabae, "\$");



add(edgepic);
add(nodepic);

ship();

erase(edgepic);
erase(nodepic);
erase(currentpicture);

draw(box((-3.3,-2.8),(3,0.2)),white);
label("$\mathtt{\{A,\, ACCA,\, CA,\, CAA,\, CACA,\, TAC\}}$", (-3, 0.2), E);

node("*", p0);
edge(p0, pa, "A");
edge(p0, pb, "C");
edge(p0, pc, "TAC\$");
node("A*", pa);
node("C*", pb);
leaf("TAC\$", pc);

edge(pa, pae, "\$");
edge(pa, pab, "CAC\$");
edge(pb, pba, "A");
leaf("A\$", pae);
leaf("ACCA\$", pab);
node("CA*", pba);

leaf("CA\$", pbae);
leaf("CAA\$", pbaa);
leaf("CACA\$", pbab);
edge(pba, pbae, "\$");
edge(pba, pbaa, "A\$");
edge(pba, pbab, "CA\$");

add(edgepic);
add(nodepic);

ship();

erase(edgepic);
erase(nodepic);
erase(currentpicture);

draw(box((-3.3,-2.8),(3,0.2)),white);
label("$\mathtt{\{A,\, ACCA,\, CA,\, CAA,\, CACA,\, TAC\}}$", (-3, 0.2), E);

node("*", p0);
edge(p0, pa, "A");
edge(p0, pb, "CA");
edge(p0, pc, "TAC\$");
node("A*", pa);
node("CA*", pb);
leaf("TAC\$", pc);

edge(pa, pae, "\$");
edge(pa, pab, "CAC\$");
leaf("A\$", pae);
leaf("ACCA\$", pab);

pair pba = pb;
pair pbae = pb+(-1,-0.5);
pair pbaa = pb+(0,-0.5);
pair pbab = pb+(1,-0.5);

leaf("CA\$", pbae);
leaf("CAA\$", pbaa);
leaf("CACA\$", pbab);
edge(pba, pbae, "\$");
edge(pba, pbaa, "A\$");
edge(pba, pbab, "CA\$");

add(edgepic);
add(nodepic);

ship();
