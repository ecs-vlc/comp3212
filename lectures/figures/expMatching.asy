settings.outformat="pdf";
import myutil;
size(500,0);


real u = 0.5;
for(int i=1; i<=20; ++i) {
  label("$a_{" + string(i) + "}$", (i,u), N);
  label("$b_{" + string(i) + "}$", (i,0), S);
}

picture bg = new picture;
add(bg, currentpicture);

ship();

int lastMatch = 0;
for(int i=1; i<4; ++i) {
  for(int j=lastMatch+1; j<lastMatch+5; ++j) {
    erase();
    add(bg);
    draw((i,u)--(j,0), blue);
    ship();
  }
  lastMatch += 3;
  draw(bg, (i,u)--(lastMatch,0), blue);
}
