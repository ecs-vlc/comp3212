size(400,0);
srand(123);
import myutil;

string[] base = {"A", "C", "G", "T"};
pen[] colour = {red, heavygreen, blue, black};

int n=40;

int[] dna = new int[n];

for(int i=0; i<n; ++i) {
  dna[i] = floor(4*rand()/randMax);
}

picture dnapic;
for(int i=0; i<n; ++i) {
  label(dnapic, base[dna[i]], (i, 0), colour[dna[i]]);
}

add(dnapic);

draw(box((-1,1),(n,-23)),white);
     
ship();

for(int j=0; j<5; ++j) {
  add(shift((0,-2*j))*dnapic);
}

ship();

int k = 30;
int[] contig = new int[k];

int p = 0;
int q = -14;
for(int i=0; i<k; ++i) {
  contig[i] = floor((n-4)*rand()/randMax);
  for(int j=0; j<5; ++j) {
    int m = contig[i]+j;
    label(base[dna[m]], (p+j, q), colour[dna[m]]);
  }
  p += 7;
  if (p+5 > n) {
    p = 0;
    q -= 2;
  }
}

ship();
int piccnt=3;

picture oldpic;
add(oldpic, currentpicture);

for (int c=0; c<n-4; ++c) {
  erase(currentpicture);
  add(oldpic);
  bool exist = false;
  int p = 0;
  int q = -14;
  for(int i=0; i<k; ++i) {
    if (contig[i]==c) {
      exist = true;
      filldraw(box((p-0.5,q-0.5),(p+4.5,q+0.5)), lightgray,gray);
      fill(oldpic, box((p-0.5,q-0.5),(p+4.5,q+0.5)), gray);
    }
    p += 7;
    if (p+5 > n) {
      p = 0;
      q -= 2;
    }
  }
  if (exist) {
    for(int j=0; j<5; ++j) {
      int m = c+j;
      label(base[dna[m]], (m, -11), colour[dna[m]]);
      label(oldpic, base[dna[m]], (m, -11), colour[dna[m]]);
    }
    draw(box((c-0.5,-11.5),(c+4.5,-10.3)), magenta);
    draw(oldpic, box((c-0.5,-11.5),(c+4.5,-10.3)), cyan);
    ship();
  }
}

