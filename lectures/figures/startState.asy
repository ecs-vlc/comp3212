size(430,0);
import myutil;
texpreamble("\renewcommand*{\arraystretch}{1.5}");
usepackage("color");
srand(2);



void startState(bool highlight) {
  pen fillCol = (highlight)? pink:gray(0.9);
  pen Outline = (highlight)? red+linewidth(2):gray(0.1);
  draw(Label("Start",(0.5,0.35)), roundbox,FillDraw(fillCol,Outline), xmargin=3);
}


void dice1(bool highlight) {
  pen fillCol = (highlight)? pink:gray(0.9);
  pen Outline = (highlight)? red+linewidth(2):gray(0.1);
  draw(Label("$\begin{matrix}p_1=\tfrac{1}{6}\\p_2=\tfrac{1}{6}\\p_3=\tfrac{1}{6}\\p_4=\tfrac{1}{6}\\p_5=\tfrac{1}{6}\\p_6=\tfrac{1}{6}\end{matrix}$",(0.0)), roundbox,FillDraw(fillCol,Outline), xmargin=3);
}

void dice2(bool highlight) {
  pen fillCol = (highlight)? pink:gray(0.9);
  pen Outline = (highlight)? red+linewidth(2):gray(0.1);
  draw(Label("$\begin{matrix}p_1=\tfrac{1}{10}\\p_2=\tfrac{1}{10}\\p_3=\tfrac{1}{10}\\p_4=\tfrac{1}{10}\\p_5=\tfrac{1}{10}\\p_6=\tfrac{1}{2}\end{matrix}$",(1.0)), roundbox,FillDraw(fillCol,Outline), xmargin=3);
}

void s1(bool highlight) {
  pen Outline = (highlight)? red+linewidth(2):gray(0.3);
  draw((0.5,0.35)--(0,0.2), Outline, MidArrow(7));
  label("$\tfrac{1}{2}$", (0.25,0.28), N);
}

void s2(bool highlight) {
  pen Outline = (highlight)? red+linewidth(2):gray(0.3);
  draw((0.5,0.35)--(1,0.2), Outline, MidArrow(7));
  label("$\tfrac{1}{2}$", (0.75,0.28), N);
}

void tran11(bool highlight) {
  pen Outline = (highlight)? red+linewidth(2):gray(0.3);
  draw((-0.06,0)..(-0.15,0)..cycle, Outline, MidArrow(7));
  label("$\tfrac{9}{10}$", (-0.15,0), W);
}

void tran22(bool highlight) {
  pen Outline = (highlight)? red+linewidth(2):gray(0.3);
  draw((1.06,0)..(1.15,0)..cycle, Outline, MidArrow(7));
  label("$\tfrac{9}{10}$", (1.15,0), E);
}


void tran12(bool highlight) {
  pen Outline = (highlight)? red+linewidth(2):gray(0.3);
  draw((0,0.1)..(0.5,0.2)..(1,0.1), Outline, MidArrow(7));
  label("$\tfrac{1}{10}$", (0.5,0.2), N);
}

void tran21(bool highlight) {
  pen Outline = (highlight)? red+linewidth(2):gray(0.3);
  draw((1,-0.1)..(0.5,-0.2)..(0,-0.1), Outline, MidArrow(7));
  label("$\tfrac{1}{10}$", (0.5,-0.2), S);
}


int hdice() {return floor(6*rand()/(1.0+randMax))+1;}
int ddice() {
  int o = floor(10*rand()/(1.0+randMax))+1;
  if (o>6)
    return 6;
  return o;
}

draw(box((-0.2, -0.35),(1.2,0.39)),white);

s1(false);
s2(false);
tran11(false);
tran12(false);
tran21(false);
tran22(false);
dice1(false);
dice2(false);
startState(true);

ship();




erase();
draw(box((-0.2, -0.35),(1.2,0.39)),white);

bool honest = true;
string seq = string(hdice());
string states = "\textcolor{blue}{H}";
s1(true);
s2(false);
tran11(false);
tran12(false);
tran21(false);
tran22(false);
dice1(true);
dice2(false);
startState(true);
label("\texttt{"+states+"}", (-0.2,-0.31), SE);

ship();
erase();
draw(box((-0.2, -0.35),(1.2,0.39)),white);

bool honest = true;
string seq = string(hdice());
string states = "\textcolor{blue}{H}";
s1(false);
s2(false);
tran11(false);
tran12(false);
tran21(false);
tran22(false);
dice1(true);
dice2(false);
startState(false);

label("\texttt{"+seq+"}", (-0.2,-0.31), NE);
label("\texttt{"+states+"}", (-0.2,-0.31), SE);

ship();

for(int i=0; i<5; ++i) {
  bool old = honest;
  if (rand()<0.1*randMax)
    honest = ! honest;
  erase();
  draw(box((-0.2, -0.35),(1.2,0.39)),white);
  states += (honest)?  "\textcolor{blue}{H}":"\textcolor{red}{D}";
  s1(false);
  s2(false);
  tran11((honest)&&(old));
  tran12((!honest)&&(old));
  tran21((honest)&&(!old));
  tran22((!honest)&&(!old));
  dice1(honest);
  dice2(!honest);
  startState(false);
  label("\texttt{"+states+"}", (-0.2,-0.31), SE);
  if (i<3) {
    label("\texttt{"+seq+"}", (-0.2,-0.31), NE);
    ship();
  }
  seq += string((honest)? hdice():ddice());
  label("\texttt{"+seq+"}", (-0.2,-0.31), NE);
  if (i<20)
    ship();
  else if (honest!=old)
    ship();
}
