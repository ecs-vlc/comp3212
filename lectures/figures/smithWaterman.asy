size(600,0);
import myutil;

string aString = "HEAGAWGHEE";
string bString = "PAWHEAE";

string proteins = "ARNDCQEGHILKMFPSTWYVBJZX";

int[] toInt(string s) {
  int[] list;
  for(int i=0; i<length(s); ++i) {
    list.push(find(proteins, substr(s, i, 1)));
  }
  return list;
}

int[][] blosum50 = {
  {5,-2,-1,-2,-1,-1,-1,0,-2,-1,-2,-1,-1,-3,-1,1,0,-3,-2,0,-2,-2,-1,-1,-5},
  {-2,7,-1,-2,-4,1,0,-3,0,-4,-3,3,-2,-3,-3,-1,-1,-3,-1,-3,-1,-3,0,-1,-5},
  {-1,-1,7,2,-2,0,0,0,1,-3,-4,0,-2,-4,-2,1,0,-4,-2,-3,5,-4,0,-1,-5},
  {-2,-2,2,8,-4,0,2,-1,-1,-4,-4,-1,-4,-5,-1,0,-1,-5,-3,-4,6,-4,1,-1,-5},
  {-1,-4,-2,-4,13,-3,-3,-3,-3,-2,-2,-3,-2,-2,-4,-1,-1,-5,-3,-1,-3,-2,-3,-1,-5},
  {-1,1,0,0,-3,7,2,-2,1,-3,-2,2,0,-4,-1,0,-1,-1,-1,-3,0,-3,4,-1,-5},
  {-1,0,0,2,-3,2,6,-3,0,-4,-3,1,-2,-3,-1,-1,-1,-3,-2,-3,1,-3,5,-1,-5},
  {0,-3,0,-1,-3,-2,-3,8,-2,-4,-4,-2,-3,-4,-2,0,-2,-3,-3,-4,-1,-4,-2,-1,-5},
  {-2,0,1,-1,-3,1,0,-2,10,-4,-3,0,-1,-1,-2,-1,-2,-3,2,-4,0,-3,0,-1,-5},
  {-1,-4,-3,-4,-2,-3,-4,-4,-4,5,2,-3,2,0,-3,-3,-1,-3,-1,4,-4,4,-3,-1,-5},
  {-2,-3,-4,-4,-2,-2,-3,-4,-3,2,5,-3,3,1,-4,-3,-1,-2,-1,1,-4,4,-3,-1,-5},
  {-1,3,0,-1,-3,2,1,-2,0,-3,-3,6,-2,-4,-1,0,-1,-3,-2,-3,0,-3,1,-1,-5},
  {-1,-2,-2,-4,-2,0,-2,-3,-1,2,3,-2,7,0,-3,-2,-1,-1,0,1,-3,2,-1,-1,-5},
  {-3,-3,-4,-5,-2,-4,-3,-4,-1,0,1,-4,0,8,-4,-3,-2,1,4,-1,-4,1,-4,-1,-5},
  {-1,-3,-2,-1,-4,-1,-1,-2,-2,-3,-4,-1,-3,-4,10,-1,-1,-4,-3,-3,-2,-3,-1,-1,-5},
  {1,-1,1,0,-1,0,-1,0,-1,-3,-3,0,-2,-3,-1,5,2,-4,-2,-2,0,-3,0,-1,-5},
  {0,-1,0,-1,-1,-1,-1,-2,-2,-1,-1,-1,-1,-2,-1,2,5,-3,-2,0,0,-1,-1,-1,-5},
  {-3,-3,-4,-5,-5,-1,-3,-3,-3,-3,-2,-3,-1,1,-4,-4,-3,15,2,-3,-5,-2,-2,-1,-5},
  {-2,-1,-2,-3,-3,-1,-2,-3,2,-1,-1,-2,0,4,-3,-2,-2,2,8,-1,-3,-1,-2,-1,-5},
  {0,-3,-3,-4,-1,-3,-3,-4,-4,4,1,-3,1,-1,-3,-2,0,-3,-1,5,-3,2,-3,-1,-5},
  {-2,-1,5,6,-3,0,1,-1,0,-4,-4,0,-3,-4,-2,0,0,-5,-3,-3,6,-4,1,-1,-5},
  {-2,-3,-4,-4,-2,-3,-3,-4,-3,4,4,-3,2,1,-3,-3,-1,-2,-1,2,-4,4,-3,-1,-5},
  {-1,0,0,1,-3,4,5,-2,0,-3,-3,1,-1,-4,-1,0,-1,-2,-2,-3,1,-3,5,-1,-5},
  {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-5},
  {-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,-5,1}};

int d = -8;

int[] a = toInt(aString);
int[] b = toInt(bString);

void writeChar(int i, pair pos) {
  label(substr(proteins, i, 1), pos);
}


for(int i=-2; i<a.length; ++i) {
  draw((i+0.5, 2.5)--(i+0.5, -b.length+0.5));
  if (i>=0)
    writeChar(a[i], (i, 2));
}

for(int j=-2; j<b.length; ++j) {
  draw((-2.5, -j+0.5)--(a.length-0.5, -j+0.5));
  if (j>=0)
    writeChar(b[j], (-2,-j));
}

label("$F_{i,j} = \max \left\{\begin{matrix} 0\\ F_{i-1,j-1} + s(a_i, b_j)\\F_{i-1,j} -8\\F_{i,j-1} -8\end{matrix}\right.$", (a.length-0.5, 1-b.length/3), E);

ship();

int[][] F = new int[a.length+1][b.length+1];
F[0][0] = 0;


label(string(F[0][0]), (-1,1));
ship();

void showCost(int i, int j, bool bold=false) {
  if (!bold)
    label(string(F[i+1][j+1]), (i,-j));
  else {
    label("\textbf{" + string(F[i+1][j+1]) + "}", (i,-j), blue);
    draw(circle((i,-j), 0.25),  blue);
  }
}

void leftArrow(int i, int j, bool bold=false) {
  pen lt = red;
  if (bold)
    lt = blue+linewidth(1.5);
  draw((i-0.3,-j)--(i-0.7,-j), lt, Arrow(10));
}

void upArrow(int i, int j, bool bold=false) {
  pen lt = red;
  if (bold)
    lt = blue+linewidth(1.5);
  draw((i,-j+0.3)--(i,-j+0.7), lt, Arrow(10));
}

void diagArrow(int i, int j, bool bold=false) {
  pen lt = red;
  if (bold)
    lt = blue+linewidth(1.5);
  draw((i-0.3,-j+0.3)--(i-0.7,-j+0.7), lt, Arrow(10));
}

struct Best {
  int value;
  int i;
  int j;
  static Best Best(int v, int ii, int jj) {
    Best b = new Best;
    b.value = v;
    b.i = ii;
    b.j = jj;
    return b;
  }
}

from Best unravel Best;

Best best = Best(0,0,0);

for(int j=-1; j<b.length; ++j) {
  for(int i=-1; i<a.length; ++i) {
    if (j==-1) {
      if(i==-1)
	continue;
      F[i+1][0] = 0;
      showCost(i, j);
      if (i<1)
	ship();
    } else {
      if (i==-1) {
	F[0][j+1] = 0;
      } else {
	int l = F[i][j+1] + d;
	int u = F[i+1][j] + d;
	int s = F[i][j] + blosum50[a[i]][b[j]];
	if (s<0 && u<0 && l<0) {
	  F[i+1][j+1] = 0;
	} else if (s>=u && s>=l) {
	  F[i+1][j+1] = s;
	  if (s>0)
	    diagArrow(i,j);
	} else if (l>=u) {
	  F[i+1][j+1] = l;
	  leftArrow(i, j);
	} else {
	  F[i+1][j+1] = u;
	  upArrow(i,j);
	}
      }
      if (F[i+1][j+1] > best.value) {
	best = Best(F[i+1][j+1], i+1, j+1);
      }
      showCost(i,j);
      if ((j==1 || j==2)  && i<6)
	ship();
    }
  }
  if (j<4)
    ship();
}
ship();

int i = best.i;
int j = best.j;
int cnt = 0;
showCost(i-1,j-1,true);
ship();

int m = max(i,j);

void aMatch(int i, string s) {
  label(s, (a.length + 0.2 + 0.3*(m-i), -b.length/3-1));
}

void bMatch(int i, string s) {
  label(s, (a.length + 0.2 + 0.3*(m-i), - b.length/3-2));
}


while (i>0 || j>0) {
  ++cnt;
  bool aP = true;
  bool bP = true;
  if (F[i][j]==0)
    break;
  if (i==0) {
    aP=false;
    upArrow(i-1,j-1,true);
    --j;
    continue;
  } else if (j==0) {
    bP=false;
    leftArrow(i-1, j-1, true);
    --i;
  } else if (F[i][j] == F[i-1][j-1] + blosum50[a[i-1]][b[j-1]]) {
    diagArrow(i-1, j-1, true);
    --i;
    --j;
  } else if (F[i][j] == F[i][j-1] + d) {
    upArrow(i-1,j-1,true);
    aP =false;
    --j;
  } else {
    bP = false;
    leftArrow(i-1, j-1,true);
    --i;
  }
  showCost(i-1,j-1,true);
  string aChar = (aP)? substr(proteins, a[i], 1):"-";
  string bChar = (bP)? substr(proteins, b[j], 1):"-";
  aMatch(cnt, aChar);
  bMatch(cnt, bChar);
  if (cnt<6)
    ship();
}
ship();
