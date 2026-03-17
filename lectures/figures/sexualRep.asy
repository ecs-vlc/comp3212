import myutil;
import stats;

size(600,0);

struct Cell {
  pair centre;
  real radius;
  void operator init(pair c, real r) {
    this.centre = c;
    this.radius =r;
  }
  void label(string str) {
    label(centre-(0,radius), str, S);
  }
}

path connect(Cell c1, Cell c2, real m=0.1) {
  pair diff = unit(c2.centre-c1.centre);
  return c1.centre+(c1.radius+m)*diff--c2.centre-(c2.radius+m)*diff;
}

guide chromoShape() {
  guide g;
  for(int i=-5; i<=5; i+=2) {
    g = g..(0.05*Gaussrand(),0.14*i);
  }
  return g;
}

int noChromo = 10;
guide[] genome;
pair[] chromoPos = {(-2,-2), (0,-2), (2, -2),
		    (-3,0), (-1,0), (1,0), (3,0),
		    (-2,2), (0,2), (2, 2)};

for(int i=0; i<noChromo; ++i) {
  genome.push(chromoShape());
}

struct Chromo {
  guide g;
  int number;
  pen[] col;
  real[] time;
  real start;
  real end;

  int find(real x) {
    if (x<1) {
      for(int i=1; i<time.length; ++i) {
	if (time[i]>x)
	  return i-1;
      }
    }
    return time.length-2;
  }
  

  void init(int n) {
    number = n;
    g = genome[n];
    start = arctime(g,0);
    end = arctime(g,5);
  }

  static Chromo Chromo(pen col, int n) {
    Chromo ch = new Chromo;
    ch.init(n);
    ch.col.push(col);
    ch.time.push(0.0);
    ch.time.push(1.0);
    return ch;
  }
  
  real tot(real t) {
    return start + t*(end-start);
  }
  
  void draw(pair pos) {
    for(int i=0; i<col.length; ++i) {
      draw(shift(pos)*subpath(g, tot(time[i]), tot(time[i+1])), col[i]+linewidth(1));
    }
  }
  
  void print() {
    string timeStr = " (" + string(time[0],3);
    for(int i=1; i<time.length; ++i) {
      timeStr +=  ", " + string(time[i],3);
    }
    timeStr += ")";
    write("Chromosome " + string(number) + timeStr);
  }
}

from Chromo unravel Chromo;

Chromo meiosis(Chromo c1, Chromo c2, real avLen) {
  real time = 0;
  Chromo child = new Chromo;
  child.init(c1.number);
  child.time.push(0);
  if (2.0*rand()>randMax) {
    Chromo swap = c2;
    c2 = c1;
    c1 = swap;
  }
  int cpt1 = 0;
  int cpt2 = 0;
  int n;
  while(true) {
    real u = rand()/randMax;
    real dt = -avLen*log(u);
    time += dt;
    n = c1.find(time);
    for(int i=cpt1; i<n; ++i) {
      child.col.push(c1.col[i]);
      child.time.push(c1.time[i+1]);
    }
    child.col.push(c1.col[n]);
    if (time>1.0) {
      child.time.push(1.0);
      return child;
    }
    child.time.push(time);
    Chromo swap = c2;
    c2 = c1;
    c1 = swap;
    cpt1 = c1.find(time);
    cpt2 = n;
  }
  return child;
}
    

struct Haploid {
  Cell Cell;
  Chromo[] chromo;
  static Haploid Haploid(pen col) {
    Haploid h = new Haploid;
    for(int i=0; i<noChromo; ++i) {
      h.chromo.push(Chromo(col, i));
    }
    return h;
  }
  void draw(pair pos, string s) {
    draw(circle(pos,4), gray+linewidth(2));
    for(int i=0; i<noChromo; ++i) {
      chromo[i].draw(pos+chromoPos[i]);
    }
    Cell.operator init(pos, 4);
    Cell.label(s);
  }
  void print() {
    for(int i=0; i<noChromo; ++i) {
      chromo[i].print();
    }
  }
}

from Haploid unravel Haploid;
Cell operator cast(Haploid Haploid) {return Haploid.Cell;}

struct Diploid {
  Cell Cell;
  Haploid father;
  Haploid mother;
  static Diploid Diploid(pen motherCol, pen fatherCol) {
    Diploid d = new Diploid;
    d.mother = Haploid(motherCol);
    d.father = Haploid(fatherCol);
    return d;
  }
  void draw(pair pos, string s) {
    draw(circle(pos,4), gray+linewidth(2));
    for(int i=0; i<noChromo; ++i) {
      mother.chromo[i].draw(pos+chromoPos[i]+(-0.2,0));
      father.chromo[i].draw(pos+chromoPos[i]+(0.2,0));
    }
    Cell.operator init(pos, 4);
    Cell.label(s);
  }
  Haploid egg(real avLen) {
    Haploid eg = new Haploid;
    for(int i=0; i<noChromo; ++i) {
      eg.chromo.push(meiosis(mother.chromo[i], father.chromo[i], avLen));
    }
    return eg;
  }
  void print() {
    for(int i=0; i<noChromo; ++i) {
      mother.chromo[i].print();
      father.chromo[i].print();
    }
  }
}

from Diploid unravel Diploid;

Cell operator cast(Diploid Diploid) {return Diploid.Cell;}

Diploid sex(Haploid ova, Haploid sperm) {
  Diploid child = new Diploid;
  child.mother = ova;
  child.father = sperm;
  return child;
}


draw(box((-4.2,-11.7),(52.2,10.2)), white);

Diploid mother0 = Diploid(heavyred, orange);
Diploid father0 = Diploid(lightblue, purple);
mother0.draw((0,6), "Mother");
father0.draw((0,-6), "Father");
ship();

Haploid ova0 = mother0.egg(0.6);
Haploid sperm0 = father0.egg(1.2);
ova0.draw((12,6), "Ovum");
sperm0.draw((12,-6), "Sperm");
draw(connect(mother0, ova0), MidArrow);
draw(connect(father0, sperm0), MidArrow);
ship();

Diploid daughter = sex(ova0, sperm0);
daughter.draw((24,6), "Daughter");

draw(connect(ova0, daughter), MidArrow);
draw(connect(sperm0, daughter), MidArrow);
ship();


Diploid mother1 = Diploid(heavygreen, green);
Diploid father1 = Diploid(cyan, magenta);
Haploid ova1 = mother1.egg(0.6);
Haploid sperm1 = father1.egg(1.2);
Diploid partner = sex(ova1, sperm1);
partner.draw((24,-6), "Partner");
ship();


Haploid ova2 = daughter.egg(0.6);
Haploid sperm2 = partner.egg(1.2);
ova2.draw((36,6), "Ovum");
sperm2.draw((36,-6), "Sperm");

draw(connect(daughter, ova2), MidArrow);
draw(connect(partner, sperm2), MidArrow);
ship();

Diploid granddaughter = sex(ova2, sperm2);
granddaughter.draw((48,0), "Granddaughter");

draw(connect(ova2, granddaughter), MidArrow);
draw(connect(sperm2, granddaughter), MidArrow);
ship();



