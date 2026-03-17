settings.outformat="pdf";
size(700,0);
import myutil;

int n = 20;
int T = 40;
for(int s=11; s<30; ++s) {
  write(s);
  srand(s);
  int cnt = 0;
  int[][] parent = new int[T][n];
  bool[][] visit = new bool[T][n];

  for(int i=0; i<n; ++i) {
    parent[0][i] = -1;
    visit[0][i] = false;
  }

  /* Forward Algorithm */
  
  for(int t=1; t<T; ++t) {
    for(int i=0; i<n; ++i) {
      visit[t][i] = false;
      int p = floor(n*(rand()/randMax));
      parent[t][i] = p;
    }
  }

  /* Backward Algorithm */
  
  for(int i=0; i<n; ++i) {
    int c = i;
    visit[T-1][i] = true;
    for(int t=T-1; t>0; --t) {
      int p = parent[t][c];
      if (i==1)
	++cnt;
      if (visit[t-1][p])
	break;
      visit[t-1][p] = true;
      c = p;
    }
  }

  if (cnt<10) {
    cnt = 0;
    for(int i=0; i<n; ++i) {
      if (visit[0][i])
	++cnt;
    }
    if (cnt==1) {
      srand(s);
      break;
    }
  }
}

draw(box((-0.5,-0.5),(T-0.5,n-0.5)), white);

int[][] parent = new int[T][n];
bool[][] visit = new bool[T][n];

for(int i=0; i<n; ++i) {
  dot((0,i), linewidth(4));
  parent[0][i] = -1;
  visit[0][i] = false;
}
ship();

/* Forward Algorithm */

for(int t=1; t<T; ++t) {
  for(int i=0; i<n; ++i) {
    visit[t][i] = false;
    int p = floor(n*(rand()/randMax));
    draw((t-1, p)--(t, i), green+linewidth(2));
    dot((t, i), linewidth(4));
    dot((t-1, p), linewidth(4));
    parent[t][i] = p;
    if (t==1 && i<4)
      ship();
  }
  if (t<4)
    ship();
}
ship();

/* Backward Algorithm */

for(int i=0; i<n; ++i) {
  int c = i;
  visit[T-1][i] = true;
  for(int t=T-1; t>0; --t) {
    int p = parent[t][c];
    draw((t,c)--(t-1,p), red+linewidth(1.5));
    dot((t, c), red+linewidth(4));
    dot((t-1, p), red+linewidth(4));
    if (i==0 && t>T-5)
      ship();
    if (i==1)
      ship();
    if (visit[t-1][p])
      break;
    visit[t-1][p] = true;
    c = p;
  }
  if (i<5)
    ship();
}
ship();
