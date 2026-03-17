size(200,0);
import myutil;

srand(123);
draw(box((-0.2,-0.08),(1,1.05)), white);

real drand() { return rand()/randMax;}

pair[] data;
bool[] label;
for(int i=0; i<20; ++i) {
  pair r = (drand(), drand());
  data.push(r);
  if (r.x+r.y + drand()>1.5) {
    label.push(true);
    filldraw(circle(r,0.02), blue);
  } else {
    label.push(false);
    filldraw(shift(r-(0.015,0.015))*scale(0.03)*unitsquare, heavyred);
  }
}


void cross(pair x, pen p=black) {
  draw(x-(-0.02,-0.02)--x-(0.02,0.02),p+linewidth(2));
  draw(x-(-0.02,0.02)--x-(0.02,-0.02),p+linewidth(2));
}

ship();
pair x = (0.35, 0.63);
cross(x);

ship();

real[] dist;
for(int i=0; i<20; ++i) {
  dist.push(length(x-data[i]));
}

real[] sorted = sort(dist);

void knn(int K) {
  int cnt=0;
  for(int i=0; i<20; ++i) {
    if (dist[i]<sorted[K]) {
      draw(x--data[i], purple);
      if(label[i])
	++cnt;
    }
  }

  if (cnt>K/2)
    cross(x, blue);
  else
    cross(x,heavyred);
}

knn(3);

ship();

erase();

picture datapic;

draw(datapic, box((-0.2,-0.08),(1,1.05)), white);

for(int i=0; i<20; ++i) {
  if (label[i]) {
    filldraw(datapic, circle(data[i],0.02), blue);
  } else {
    filldraw(datapic, shift(data[i]-(0.015,0.015))*scale(0.03)*unitsquare, heavyred);
  }
}

add(datapic);

erase();

pen[] mypalette()
{
  pen[] p={heavyred, 0.666*heavyred+0.333*blue, 0.33*heavyred+0.66*blue, blue};
  return p;
}

int K=3;
real knn3(real x, real y) {
  real[] dist;
  for(int i=0; i<20; ++i) {
    dist.push(length((x,y)-data[i]));
  }
  real[] sorted = sort(dist);
  int cnt=0;
  for(int i=0; i<20; ++i) {
    if (dist[i]<sorted[K]) {
      if(label[i])
	++cnt;
    }
  }
  return cnt/K;
}

import palette;
import contour;

image(knn3, (0,-0.08), (1,1.05), mypalette());
real[] c={0.5};
draw(contour(knn3, (0,0.0), (1,1), c));
add(datapic);
label("3-NN", (-0.2, 0.5), E);

ship();
erase();
add(datapic);

ship();
knn(5);

ship();


erase();

pen[] mypalette()
{
  pen[] p={heavyred, 0.8*heavyred+0.2*blue, 0.6*heavyred+0.4*blue,
	   0.4*heavyred+0.6*blue, 0.2*heavyred+0.8*blue, blue};
  return p;
}

int K=5;
real knn5(real x, real y) {
  real[] dist;
  for(int i=0; i<20; ++i) {
    dist.push(length((x,y)-data[i]));
  }
  real[] sorted = sort(dist);
  int cnt=0;
  for(int i=0; i<20; ++i) {
    if (dist[i]<sorted[K]) {
      if(label[i])
	++cnt;
    }
  }
  return cnt/K;
}

import palette;

image(knn5, (0,-0.08), (1,1.05), mypalette());
draw(contour(knn5, (0,0.0), (1,1), c));
add(datapic);
label("5-NN", (-0.2, 0.5), E);


ship();
