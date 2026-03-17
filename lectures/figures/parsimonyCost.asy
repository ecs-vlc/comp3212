import myutil;

srand(4);

string[] alphabet = {"A", "T", "C", "G"};

real[][] substitution = {{0,1,2,2},{1,0,2,2},{2,2,0,1},{2,2,1,0}};

void showCost(pair pos, real[] costs) {
  string s = "\small $[";
  for(int i=0; i<costs.length; ++i) {
    if (costs[i] > 50)
      s += "\cdot";
    else
      s += string(costs[i], 2);
    if (i<costs.length-1)
      s += ",\,";
  }
  s += "]$";
  label(s, pos, blue, UnFill);
}

int leafCount = 0;

struct Node {
  Node left;
  Node right;
  int value;

  static Node Node(int x) {
    Node n = new Node;
    n.value = x;
    n.left = n.right = null;
    return n;
  }

  static Node subTree(Node l, Node r) {
    Node n= new Node;
    n.left = l;
    n.right = r;
    n.value = -1;
    return n;
  }

  bool isLeaf() {
    return left==null;
  }

  pair draw() {
    real u = 1;
    pair pos;
    if (isLeaf()) {
      pos = (u*leafCount,0);
      ++leafCount;
      dot(pos, linewidth(5));
      label(alphabet[value], pos, 2S);
    } else {
      pair l = left.draw();
      pair r = right.draw();
      pos = 0.5*(l+r) + (0,1);
      draw(l--pos--r);
      dot(pos, linewidth(5));
    }
    return pos;
  }

  real[] cost() {
    real[] c = array(alphabet.length, 1000);
    if (isLeaf()) {
      c[value] = 0;
    } else {
      real[] l = left.cost();
      real[] r = right.cost();
      for(int i=0; i<alphabet.length; ++i) {
	real minCost=1000;
	for(int j=0; j<alphabet.length; ++j) {
	  real cost = l[j] + substitution[i][j];
	  if (cost<minCost) {
	    minCost = cost;
	  }
	}
	c[i] = minCost;
	minCost=1000;
	for(int j=0; j<alphabet.length; ++j) {
	  real cost = r[j] + substitution[i][j];
	  if (cost<minCost) {
	    minCost = cost;
	  }
	}
	c[i] += minCost;
      }
    }
    return c;
  }

  
  pair backward(real cost, int x) {
    real u = 1;
    pair pos;
    if (isLeaf()) {
      pos = (u*leafCount,0);
      ++leafCount;
      dot(pos, linewidth(5));
      label(alphabet[value], pos, 2S);
    } else {
      real[] lc = left.cost();
      real[] rc = right.cost();
      int lv;
      int rv;
      for(int i=0; i<alphabet.length; ++i) {
	for(int j=0; j<alphabet.length; ++j) {
	  if (cost == substitution[i][x]+lc[i]+substitution[j][x]+rc[j]) {
	    lv = i;
	    rv = j;
	    break;
	  }
	}
      }
      pair l = left.backward(lc[lv], lv);
      pair r = right.backward(rc[rv], rv);
      pos = 0.5*(l+r) + (0,1);
      draw(l--pos--r);
      dot(pos, linewidth(5));
      label(alphabet[x], pos, 2*S);
      label(string(substitution[x][lv]), 0.5*(l+pos), blue, UnFill);
      label(string(substitution[x][rv]), 0.5*(r+pos), blue, UnFill);
      label(string(cost), pos , 2W, red);
    }
    return pos;
  }

  pair showCost(picture pic) {
    real u = 1;
    pair pos;
    real[] c = array(alphabet.length, 1000);
    add(pic);
    if (isLeaf()) {
      pos = (u*leafCount,0);
      ++leafCount;
      dot(pos, linewidth(5));
      label(alphabet[value], pos, 2S);
      c[value] = 0;
    } else {
      real[] lc = left.cost();
      real[] rc = right.cost();
      for(int i=0; i<alphabet.length; ++i) {
	real minCost=1000;
	for(int j=0; j<alphabet.length; ++j) {
	  real cost = lc[j] + substitution[i][j];
	  if (cost<minCost) {
	    minCost = cost;
	  }
	}
	c[i] = minCost;
	minCost=1000;
	for(int j=0; j<alphabet.length; ++j) {
	  real cost = rc[j] + substitution[i][j];
	  if (cost<minCost) {
	    minCost = cost;
	  }
	}
	c[i] += minCost;
      }
      pair l = left.showCost(pic);
      pair r = right.showCost(pic);
      pos = 0.5*(l+r) + (0,1);
      draw(l--pos--r);
      dot(pos, linewidth(5));
    }
    showCost(pos, c);
    ship();
    return pos;
  }

}

from Node unravel Node;
from Node unravel subTree;

Node tree;
int depth = 3;
int n = 2^depth;
Node[] nodes = new Node[];
for(int i=0; i<n; ++i) {
  nodes.push(Node(floor(alphabet.length*(rand()/randMax))));
}
while(nodes.length>1) {
  Node[] nextLayer = new Node[];
  for(int i=0; ; ++i) {
    if (2i+1>=nodes.length)
      break;
    nextLayer.push(subTree(nodes[2*i], nodes[2*i+1]));
  }
  nodes = nextLayer;
  write(nodes.length);
}

Node tree = nodes[0];

draw(box((-0.8,-0.50),(7.5,3.2)), white);
size(400,0);
tree.draw();
ship();
picture bg = new picture;
add(bg, currentpicture);
erase();
leafCount = 0;
tree.showCost(bg);
ship();
erase();
real cost[] = tree.cost();
real c = 1000;
int v = -1;
for(int i=0; i<cost.length; ++i) {
  if (cost[i] < c) {
    c = cost[i];
    v = i;
  }
}
draw(box((-0.8,-0.50),(7.5,3.2)), white);
leafCount = 0;
write(c,v);
pair pos = tree.backward(c,v);
ship();
erase();
size(100,0);

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
makeTable(substitution, alphabet, (0,0));
shipout("parsimonySub");
