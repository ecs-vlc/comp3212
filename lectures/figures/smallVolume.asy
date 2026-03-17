settings.outformat="pdf";
import myutil;

size(270,0);

pair bmax = (200,100);
real r = 5;

draw(box((-r,-r), bmax+(r,r)), linewidth(2));

pair p = (80,40);
filldraw(circle(p, 2r), yellow);
label("$\delta V$", p);
label("$V$", bmax, SW);
