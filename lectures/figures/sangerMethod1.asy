settings.outformat="pdf";
size(140,0);
import myutil;
usepackage("xcolor");


string[] bases={"{green}{A}", "{blue}{C}", "{black}{G}", "{orange}{T}"};

int randBase() {return floor(4.0*rand()/(1.0+randMax));}

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
