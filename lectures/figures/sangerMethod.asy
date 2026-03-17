settings.outformat="pdf";
size(900, 0);
import myutil;
import graph;
usepackage("xcolor");
srand(2);

string[] bases={"{green}{A}", "{blue}{C}", "{black}{G}", "{orange}{T}"};
string[] cbases={"{orange}{T}", "{black}{G}", "{blue}{C}", "{green}{A}"};


int randBase() {return floor(4.0*rand()/(1.0+randMax));}

real udev() {return rand()/randMax;}


string writeDNA(int[] dna, int t=0) {
  if (t>dna.length)
    t = dna.length;
  string s = "\textbf{";
  for(int i=0; i<t; ++i) {
    s += "\textcolor"+bases[dna[i]];
  }
  s += "}";
  return s;
}

string writecDNA(int[] dna, int t=0) {
  if (t>dna.length)
    t = dna.length;
  string s = "\textbf{";
  for(int i=0; i<t; ++i) {
    s += "\textcolor"+cbases[dna[i]];
  }
  s += "}";
  return s;
}

int[] dna;
int n = 14;

int[][][] sample = new int[4][][];
for(int i=0; i<n; ++i) {
  int base = randBase();
  while(sample[base].length>4)
    base = randBase();
  dna.push(base);
  sample[base].push(copy(dna));
}


pair randpos[] = new pair[30];
for(int i=0; i<randpos.length; ++i) {
  pair p;
  while (true) {
    p = (-2,7.8) + (4*udev(), 2*udev());
    bool sep = true;
    for (int j=0; j<i; ++j) {
      if (length(p-randpos[j])<0.4) {
	sep = false;
	break;
      }
    }
    if (sep)
      break;
  }
  randpos[i] = p;
}


path tt = (-1.1,13)..(-1,12.8)--(-1,12)--(-3,8)--(-3,0)--(3,0)--(3,8)--(1,12)--(1,12.8)--(1.1,13);

path top = xscale(0.1)*yscale(0.1)*graph(cos, -20, 20); 

real u = 1.5;
for(int t=0; t<=dna.length; ++t) {
  erase();
  for(int b=0; b<4; ++b) {
    real x = 9*b;
    draw(shift((x,0))*tt, linewidth(2));
    draw(shift((x,10))*top);
    for(int i=0; i<5; ++i) {
      label(writecDNA(dna, dna.length)+"\ldots", (x-3,7-u*i), E);
    }
    for(int i=0; i<sample[b].length; ++i) {
      string s = (t>=sample[b][i].length)? "*":"";
      label(writeDNA(sample[b][i], t)+s, (x-3,7.5-u*i), E);
    }
    for(int i=sample[b].length; i<5; ++i) {
      label(writeDNA(dna,t), (x-3,7.5-u*i), E);
    }
    int k=0;
    for(int bb=0; bb<4; ++bb) {
      int[] base = {bb};
      string s = writeDNA(base,1);
      for(int i=0; i<4; ++i, ++k)
	label(s, (x,0)+randpos[k]);
    }
    int[] base = {b};
    string s = writeDNA(base,1) + "*";
    for(int i=0; i<2; ++i, ++k)
      label(s, (x,0)+randpos[k]);
    int[] base = {b};
    string s = "\huge " + writeDNA(base,1) + "*";
    label(s, (x,-0.5));
  }
  ship();
}

shipout("sangerMethod");

erase();
size(140,0);

draw(box((-1,-1.8),(4,13.5)), linewidth(1));

pen[] col = {heavygreen, blue, black, magenta};

for(int b=0; b<4; ++b) {
  int[] base = {b};
  label(writeDNA(base,1), (b, -1));
  draw(circle((b, -1), 0.4), linewidth(1)+col[b]);
  for(int i=0; i<sample[b].length; ++i) {
    int l = sample[b][i].length;
    draw((b-0.5,14-l)--(b+0.5,14-l), linewidth(3)+col[b]);
  }
}

for(int i=0; i<dna.length; ++i) {
  int[] base = {dna[i]};
  label(writeDNA(base,1), (4.2, 13-i), E);
}

draw((-1.5,0)--(-1.5, 13), linewidth(1), Arrow(10));
label(rotate(90)*Label("smaller fragments move furthest"), (-1.5, 13/2), W);
shipout("sangerMethod1");



