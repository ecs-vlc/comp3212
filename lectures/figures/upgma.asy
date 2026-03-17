size(400,0);
import myutil;

int cntLeaf = 0;

struct Node
{
  Node left = null;
  Node right = null;
  real depth = 0;
  string name = "";
  int count = 1;
  pair position;
  bool root;
  
  static Node Node(string na, pair p) {
    Node n= new Node;
    n.depth = 0;
    n.name = na;
    n.count = 1;
    n.position =p;
    n.left = null;
    n.right = null;
    n.root = true;
    return n;
  }
  
  static Node subTree(Node l, Node r, string na, real d) {
    l.root = r.root = false;
    Node n= new Node;
    n.root = true;
    n.name = na;
    n.left = l;
    n.right = r;
    n.count = l.count + r.count;
    n.position = (l.position*l.count + r.position*r.count)/n.count;
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

  void leaves(Node[] list) {
    if (left==null) {
      list.push(this);
    } else {
      left.leaves(list);
      right.leaves(list);
    }
  }

  static real maxDepth(Node n) {
    if (n.left==null)
      return n.depth;
    return n.depth + maxDepth(n.left) + maxDepth(n.right);
  }

  int countChildren() {
    if (left==null)
      return 1;
    else
      return left.countChildren() + right.countChildren();
  }

  pair drawTree(picture pic) {
    real u = 1;
    pair pos;
    if (left!=null) {
      pair posLeft = left.drawTree(pic);
      pair posRight = right.drawTree(pic);
      pair posLeftup = (posLeft.x, u*depth);
      pair posRightup = (posRight.x, u*depth);
      draw(pic, posLeft--posLeftup--posRightup--posRight);
      pos = 0.5*(posLeftup+posRightup);
    } else {
      pos = (cntLeaf, 0);
      ++cntLeaf;
    }
    label(pic, name, pos, S);
    dot(pic, pos, linewidth(2));
    return pos;
  }

  void drawPosition(picture pic, pair pos, real g=0.5) {
    if (left!=null) {
      //      draw(pic, shift(pos)*(left.position--position--right.position));
      left.drawPosition(pic, pos, g*0.7);
      right.drawPosition(pic, pos, g*0.7);
      draw(pic, circle(pos+position, 0.8*depth), gray(1-g)+linewidth(2));
      dot(pic, pos+position, gray);
    } else {
      label(pic, "\large$\bm{\times}$", pos+position, blue);
    }
    label(pic, name, pos+position, S);
  }
}

from Node unravel Node;
from Node unravel subTree;


void drawForest(Node[] forest) {
  static int cnt = 0;
  picture treePic = new picture;
  picture posPic = new picture;
  size(treePic, 200, 0);
  size(posPic, 200, 0);
  draw(treePic, box((-0.5,-0.5), (5,5)), white);
  draw(posPic, box((-6,-6), (6,6)), white);
  cntLeaf = 0;
  for(int i=0; i<forest.length; ++i) {
    forest[i].drawPosition(posPic, (0,0));
    forest[i].drawTree(treePic);
  }
  erase();
  add(treePic.fit(),(0,0),E);
  add(posPic.fit(),(0,0),W);
  ship();
  ++cnt;
}


struct pairDistance {
  real d;
  Node n1;
  Node n2;
  static pairDistance pairDistance(real d_, Node n1_, Node n2_) {
    pairDistance pD = new pairDistance;
    pD.d = d_;
    pD.n1 = n1_;
    pD.n2 = n2_;
    return pD;
  }
}

from pairDistance unravel pairDistance;

struct Heap
{
  pairDistance[] list;

  int size() {return list.length;}

  bool empty() {return list.length==0;}

  void add(pairDistance v) {
    list.push(v);
    int child = list.length-1;
    int parent;
    while(child>0) {
      parent = quotient(child-1,2);
      if (list[parent].d<=list[child].d)
        break;
      pairDistance tmp = list[child];
      list[child] = list[parent];
      list[parent] = tmp;
      child = parent;
    }
  }
  
  pairDistance removeMin() {
    pairDistance minElem = list[0];
    list[0] = list[list.length-1];
    list.pop();
    int parent = 0;
    int child = 1;
    while (child<list.length) {
      if (child<list.length-1 && list[child+1].d<list[child].d)
        child += 1;
      if (list[child].d>=list[parent].d)
        break;
      pairDistance tmp = list[child];
      list[child] = list[parent];
      list[parent] = tmp;
      parent = child;
      child = 2*parent+1;
    }
    return minElem;
  }
}

int noNodes = 7;

pair randomPos() {
  return 10*((rand(), rand())/randMax-(0.5,0.5));
}

Node[] forest;
pair[] positions;
pair pos = randomPos();
forest.push(Node("1", pos));
positions.push(pos);

for(int i=1; i<noNodes; ++i) {
  real minDist = 0;
  while(minDist<1) {
    pos = randomPos();
    minDist = 1000;
    for(int j=0; j<positions.length; ++j) {
      real d = length(pos-positions[j]);
      minDist = min(d,minDist);
    }
  }
  Node n = Node(string(i+1), pos);
  forest.push(n);
  positions.push(pos);
}


drawForest(forest);

Heap heap = new Heap;

for(int i=0; i<forest.length; ++i) {
  for(int j=i+1; j<forest.length; ++j) {
    real d = length(forest[i].position-forest[j].position);
    pairDistance pD = pairDistance(d, forest[i], forest[j]);
    heap.add(pD);
  }
}


while (forest.length>1) {
  pairDistance next = null;
  do {
    next = heap.removeMin();
  } while (!next.n1.root || !next.n2.root);
  for (int i=0; i<forest.length; ++i) {
    if (forest[i] == next.n1 || forest[i] == next.n2) {
      forest.delete(i);
      --i;
    }
  }
  Node node = subTree(next.n1, next.n2, string(noNodes+1), next.d);
  ++noNodes;
  forest.push(node);
  Node[] l1 = {};
  node.leaves(l1);
  for(int i=0; i<forest.length-1; ++i) {
    Node[] l2 = {};
    forest[i].leaves(l2);
    real d = 0.0;
    for(int j=0; j<l1.length; ++j) {
      for(int k=0; k<l2.length; ++k) {
	d += length(l1[j].position-l2[k].position);
      }
    }
    d /= l1.length*l2.length;
    pairDistance pD = pairDistance(d, forest[i], node);
    heap.add(pD);
  }
  drawForest(forest);
}
