size(400,0);
srand(123);

string[] base = {"A", "C", "G", "T"};
pen[] colour = {red, heavygreen, blue, black};

int n=40;

int[] dna = new int[n];

for(int i=0; i<n; ++i) {
  dna[i] = floor(4*rand()/randMax);
}


for(int i=3; i<9; ++i) {
  dna[i+23] = dna[i];
}

picture dnapic;
for(int i=0; i<n; ++i) {
  label(base[dna[i]], (i, 0), colour[dna[i]]);
}

draw(box((2.5,-0.5), (9.5,0.6)), magenta);
draw(box((23+2.5,-0.5), (23+9.5,0.6)), magenta);

     
