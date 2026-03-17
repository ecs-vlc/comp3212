size(400,0);

struct Node
{
  Node left = null;
  Node right = null;
  real depth = 0;
  string name = "";
  
  static Node Node(string na, real d) {
    Node n= new Node;
    n.depth = d;
    n.name=na;
    return n;
  }
  
  static Node subTree(Node l, Node r, real d) {
    Node n= new Node;
    n.left = l;
    n.right = r;
    n.depth = d;
    return n;
  }

  int maxRight(Node node, int c) {
    if (node.right == null)
      return c;
    return min(maxRight(node.right, c+1), maxRight(node.left, c-1));
  }

  int maxLeft(Node node, int c) {
    if (node.right == null)
      return c;
    return min(maxLeft(node.right, c-1), maxLeft(node.left, c+1));
  }


  void draw(pair pos, real u=3) {
    if (depth<0) {
      depth *= -1;
      draw(pos--pos+(0,-depth));
    } else {
      draw(pos--pos+(0,-depth));
      label("\small " + string(depth), pos+(0,-0.5*depth), blue, UnFill);
    }
    pos -= (0, depth);
    dot(pos, linewidth(2));
    if (left==null) {
      label(name, pos, S);
      return;
    }
    pair l = pos + (-u+maxRight(left, -1)-0.5u, 0);
    pair r = pos + (-u*maxLeft(right, -1)+0.5u, 0);
    draw(l--r);
    left.draw(l);
    right.draw(r);
  }
}

from Node unravel Node;
from Node unravel subTree;


Node tree = subTree(subTree(subTree(Node("A",3), Node("B",3), 2), Node("C",5), 4), subTree(Node("D",6), Node("E", 6), 3), -1);
tree.draw((0,0));

label("root", (0,0), N);

string[] leaves = {"A", "B", "C", "D", "E"};
real[][] distances = {{0,3,5,9,9}, {3,0,5,9,9}, {5,5,0,9,9}, {9,9,9,0,6}, {9,9,9,6,0}};

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

makeTable(distances, leaves, (20,-2), (2, 2));
