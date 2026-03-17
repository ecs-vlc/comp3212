size(400,0);

int leafCount;
string[] alphabet = {"A", "T", "C", "G"};
real[][] substitution = {{0,1,2,2},{1,0,2,2},{2,2,0,1},{2,2,1,0}};
//real[][] substitution = {{0,1,1,1},{1,0,1,1},{1,1,0,1},{1,1,1,0}};

real computeCost(int[] s1, int[] s2) {
  real c = 0;
  for(int i=0; i<s1.length; ++i) {
    c += substitution[s1[i]][s2[i]];
  }
  return c;
}

void showSequence(int[] s, pair pos) {
  string st;
  for (int i=0; i<s.length; ++i) {
    st += alphabet[s[i]];
  }
  label(st, pos, 2S);
}

struct Info {
  pair pos;
  real cost;
}

struct Node
{
  Node left = null;
  Node right = null;
  int[] sequence;
  
  static Node Node(int[] s) {
    Node n= new Node;
    n.sequence = s;
    return n;
  }
  
  static Node subTree(Node l, Node r, int[] s) {
    Node n= new Node;
    n.left = l;
    n.right = r;
    n.sequence = s;
    return n;
  }

  bool isLeaf() {
    return left==null;
  }

  Info draw() {
    Info info;
    if (isLeaf()) {
      info.pos = (leafCount,0);
      ++leafCount;
      info.cost = 0;
    } else {
      Info l = left.draw();
      Info r = right.draw();
      info.pos = 0.5*(l.pos+r.pos) + (0,1);
      draw(l.pos--(l.pos+(0,1))--info.pos--(r.pos+(0,1))--r.pos);
      real lc = computeCost(sequence, left.sequence);
      real rc = computeCost(sequence, right.sequence);
      label(string(lc,2), l.pos+(0,0.5), blue, UnFill);
      label(string(rc,2), r.pos+(0,0.5), blue, UnFill);
      info.cost = l.cost + r.cost + lc + rc;
      label(string(info.cost,2), info.pos, NE, red);
    }
    dot(info.pos, linewidth(5));
    showSequence(sequence, info.pos);
    return info;
  }
}

from Node unravel Node;
from Node unravel subTree;

int[] AAG = {0,0,3};
int[] AAA = {0,0,0};
int[] GGA = {3,3,0};
int[] AGA = {0,3,0};
Node n1 = Node(AAG);
Node n2 = Node(AAA);
Node n3 = Node(GGA);
Node n4 = Node(AGA);

Node t1 = subTree(subTree(n1,n2,AAA), subTree(n3,n4,AGA), AAA);
t1.draw();

void makeTable(real[][] distances, string[] leaves, pair pos, pair sc=(1,1)) {
  transform s = scale(sc.x,sc.y);
  for(int i=0; i<leaves.length; ++i) {
    label(leaves[i], pos+s*(i, 1));
    label(leaves[i], pos+s*(-1,-i));
  }
  draw(shift(pos)*s*((-0.5,1.5)--(-0.5, -leaves.length+0.5)));
  draw(shift(pos)*s*((-1.5,0.5)--(leaves.length-0.5, 0.5)));
  for(int i=0; i<distances.length; ++i) {
    for(int j=0; j<distances[i].length; ++j) {
      label(string(distances[i][j],2), pos+s*(i,-j));
    }
  }
}
makeTable(substitution, alphabet, (-3,1.8), (0.6,0.6));
shipout("parsimonySeq");
erase();
size(500,0);

t1.draw();

Node t2 = subTree(subTree(n1,n4,AAA), subTree(n2,n3,AGA), AAA);
t2.draw();

Node t3 = subTree(subTree(n1,n3,AAA), subTree(n2,n4,AGA), AAA);
t3.draw();
shipout("parsimonyFull");
