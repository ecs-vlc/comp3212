import myutil;

size(500,0);

pair bmax = (200,100);


real udev() {return rand()/randMax;}

pair brand() {return (bmax.x*udev(), bmax.y*udev());}

srand(12);
int T = 20;
int nX = 12;
int nY = 15;
real r = 8;

void drawX(pair X) {
  filldraw(circle(X,r), red);
  label("X", X, black);
}

pair[] Xpos;
for(int i=0; i<nX; ++i) {
  Xpos.push(brand());
}

void drawY(pair Y) {
  filldraw(circle(Y,r), blue);
  label("Y", Y, white);
}

pair[] Ypos;
for(int i=0; i<nY; ++i) {
  Ypos.push(brand());
}

pair bounce(pair X) {
  real x = abs(X.x);
  real y = abs(X.y);
  if (x>bmax.x)
    x = 2*bmax.x - x;
  if (y>bmax.y)
    y = 2*bmax.y - y;
  return (x,y);
}

void update(pair[] pos) {
  for(int i=0; i<pos.length; ++i) {
    pos[i] = bounce(pos[i]+10*(udev()+udev()-1,udev()+udev()-1));
  }
}

void drawParticles() {
  for(int i=0; i<Xpos.length; ++i) {
    drawX(Xpos[i]);
  }
  for(int i=0; i<Ypos.length; ++i) {
    drawY(Ypos[i]);
  }
}

for(int t= 0; t<T; ++t) {
  draw(box((-r,-r), bmax+(r,r)), linewidth(2));
  update(Xpos);
  update(Ypos);
  drawParticles();
  ship();
  for(int i=0; i<Ypos.length; ++i) {
    int cnt=0;
    for(int j=0; j<Xpos.length; ++j) {
      if (length(Ypos[i] - Xpos[j])<2*r)
	++cnt;
      if (cnt==2) {
	Xpos.push(Ypos[i]);
	filldraw(circle(Ypos[i],r), paleblue);
	label("Y", Ypos[i]);
	ship();
	drawX(Ypos[i]);
	ship();
	Ypos.delete(i);
	--nY;
	break;
      }
    }
  }
  erase();
}
