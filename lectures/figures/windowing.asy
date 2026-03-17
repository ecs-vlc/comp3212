size(540,0);
import myutil;
usepackage("xcolor");

string proteinList = "ARNDCDEGHILKMFPSTWYVBJZX";


int randRes() {
  return floor((rand()/randMax)*20);
}

int n = 30;

string[] protein = new string[n+10];
int[] structure = new int[n];



pair proteinPos(int i) {
  return (i-n/2, 8);
}

picture bg = new picture;

for(int i=0; i<n+10; ++i) {
  if (i<5 || i>=n+5)
    protein[i] = ".";
  else
    protein[i] = substr(proteinList, randRes(), 1);
  label(bg, protein[i], proteinPos(i));
}

string[] class={"\textcolor{red}{$\alpha$}", "\textcolor{blue}{$\beta$}",
		"\textcolor{green}{$C$}"};

for(int i=0; i<n; ++i) {
  if (i<5)
    structure[i] = 2;
  else if (i<15)
    structure[i] = 0;
  else if (i<18)
    structure[i] = 2;
  else if (i<25)
    structure[i] = 1;
  else
    structure[i] = 2;
  label(bg, class[structure[i]], proteinPos(i+5)+(0,1));
}

dot(bg, proteinPos(0)-(1,0), white);
draw(bg, (-3,-6)--(-3,6)--(3,4)--(3,-4)--cycle, linewidth(2));
label(bg, "MLP", (0,0));
for(int i=0; i<3; ++i) {
  draw(bg, (3,2*i-2)--(4, 2*i-2), linewidth(2));
  label(bg, class[i],(3,2*i-2), W); 
}
       

void drawWindow(int i) {
  draw(box(proteinPos(i)-(0.5,0.5), proteinPos(i+10)+(0.5,0.5)), red+linewidth(1.5));
  draw(box(proteinPos(i+5)-(0.5,0.5), proteinPos(i+5)+(0.5,1.5)), red+linewidth(1.5));
  for(int j=i; j<i+11; ++j) {
    label(protein[j], (-4, j-i-5));
  }
  draw(box((-4.5,-5.5),(-3.5,5.5)), red+linewidth(1.5));
  draw(box((-4.5,-0.5),(-3.5,0.5)), red+linewidth(1.5));
  for(int j=0; j<3; ++j) {
    string o = (j==structure[i])? "1":"0";
    label(o, (4, 2*j-2), E);
  }
}

add(bg);
ship();
for(int i=0; i<10; ++i) {
  erase();
  add(bg);
  drawWindow(i);
  ship();
}
