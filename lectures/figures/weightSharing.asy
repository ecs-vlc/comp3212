size(500,0);

int alphabet = 10;
int window = 7;
string proteinList = "ARNDCDEGHILKMFPSTWYVBJZX";
int randRes() {
  return floor((rand()/randMax)*20);
}

void encoder(int i) {
  pair pos = ((alphabet+5)*i,0);
  draw(shift(pos)*(-0.5*((alphabet+2),0)--(0.5*(alphabet+2),0)--(0.5*(alphabet+2), 5)--(-0.5*(alphabet+2),5)--cycle), gray+linewidth(2));
  for(int j=0; j<=alphabet; ++j) {
    draw(pos+(j-0.5*alphabet,1)--pos+(j-0.5*alphabet,-1));
    for(int k=0; k<3; ++k) {
      draw(pos+(j-0.5*alphabet,1)--pos+(k-1,4));
      filldraw(circle(pos+(j-0.5*alphabet,1), 0.3), white);
    }
  }
  for(int k=0; k<3; ++k) {
    draw(pos+(k-1,4)--pos+(k-1,7));
    filldraw(circle(pos+(k-1,4), 0.3), white);
  }
  label(substr(proteinList, randRes(), 1), pos+(0,-3));
}

for(int i=0; i<window; ++i) {
  encoder(i);
}

real redge = (alphabet+5)*(window-1)+4;
draw( (-4,7)--(redge,7)--(redge-5,12)--(1,12)--cycle, linewidth(2));
real mid = 0.5*(redge-4);
label("\Large MLP", (mid, 9.5));

string[] class={"\textcolor{red}{$\alpha$}", "\textcolor{blue}{$\beta$}",
                "\textcolor{green}{$C$}"};

for(int i=0; i<3; ++i) {
  draw((mid+3*(i-1),12)--(mid+3*(i-1), 14));
  label(class[i], (mid+3*(i-1), 15.2)); 
}
 
