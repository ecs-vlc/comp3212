settings.outformat="pdf";
import myutil;
size(25cm,15cm);

path bb = box((0,0),(25,15));

real x[] = {3.9,13.6};

for (int i=0; i<x.length; ++i) {
  draw(bb, white);
  filldraw(box((x[i],0),(25,15)), white, white);
  ship();
  erase();
}
draw(bb, white);
ship();
