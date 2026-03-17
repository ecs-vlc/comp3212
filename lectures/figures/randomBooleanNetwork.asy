size(500,0);
import myutil;
srand(4);
struct NodeData {
  int in1;
  int in2;
  int type;
  bool state;
  static NodeData NodeData(int i1, int i2, int t, bool s) {
    NodeData nd = new NodeData;
    nd.in1 = i1;
    nd.in2 = i2;
    nd.type = t;
    nd.state = s;
    return nd;
  }
}

from NodeData unravel NodeData;

string pairToString(pair p) {
  string s = "(";
  s += string(p.x,2) + ",";
  s += string(p.y,2) + ")";
  return s;
}


int orientation(pair p, pair q, pair r)
{
  int val = floor((q.y - p.y) * (r.x - q.x) -
		  (q.x - p.x) * (r.y - q.y));
 
    if (val == 0) return 0;  // colinear
 
    return (val > 0)? 1: 2; // clock or counterclock wise
}

bool doIntersect(pair p1, pair q1, pair p2, pair q2)
{
    // Find the four orientations needed for general and
    // special cases
    int o1 = orientation(p1, q1, p2);
    int o2 = orientation(p1, q1, q2);
    int o3 = orientation(p2, q2, p1);
    int o4 = orientation(p2, q2, q1);
 
    // General case
    if (o1 != o2 && o3 != o4)
        return true;
 
    return false; // Doesn't fall in any of the above cases
}

struct EvoGraph {
  pair[] node;
  string[] nodeName;
  int[][] edge;
  real[] distance;
  
  void addEdge(int i, int j, real d) {
    int[] e = {i,j};
    edge.push(e);
    distance.push(d);
  }

  void addEdges(real[][] e) {
    for(int i=0; i<e.length; ++i) {
      addEdge(floor(e[i][0]), floor(e[i][1]), e[i][2]);
    }
  }
  
  int size() {
    return node.length;
  }
  
  static EvoGraph EvoGraph(string[] names) {
    EvoGraph g = new EvoGraph;
    g.node = new pair[names.length];
    for(int i=0; i<g.size(); ++i) {
      g.node[i] = (rand(),rand())/randMax;
      g.nodeName[i] = names[i];
    }
    return g;
  }
  
  void drawNodes(NodeData[] nd, pair pos=(0,0)) {
    for(int i=0; i<nd.length; ++i) {
      filldraw(circle(pos+node[i], 0.4), (nd[i].state? blue:red));
    }
  }

  void highlightNode(int i, pair pos=(0,0)) {
      draw(circle(pos+node[i], 0.6), linewidth(2));
  }
 
  void draw(NodeData[] nd, pair pos=(0,0)) {
    draw(box((-18.5,-16),(18.5,20)), white);
    for(int i=0; i<edge.length; ++i) {
      draw(pos+node[edge[i][1]]--pos+node[edge[i][0]], MidArrow);
    }
    for(int i=0; i<size(); ++i) {
      if (length(nodeName[i]) == 0)
	filldraw(circle(pos+node[i], 0.4), white);
      else {
	filldraw(circle(pos+node[i], 1.2), white);
	label(nodeName[i], pos+node[i], blue);
      }
    }
    drawNodes(nd);
  }
 
  void debug(pair pos=(0,0)) {
    for(int i=0; i<edge.length; ++i) {
      draw(pos+node[edge[i][0]]--pos+node[edge[i][1]]);
    }
    for(int i=0; i<size(); ++i) {
      if (length(nodeName[i]) == 0) {
	filldraw(circle(pos+node[i], 0.3), white);
	label(pairToString(node[i]), node[i]+pos, 3W, red);
      } else {
	filldraw(circle(pos+node[i], 0.8), white);
	label(nodeName[i], pos+node[i], blue);
	label(pairToString(node[i]), node[i]+pos, 8W, red);
      }
    }
  }
  

  void labelEdges(pair pos=(0,0)) {
    for(int e=0; e<edge.length; ++e) {
      pair mid = 0.5*(node[edge[e][0]]+node[edge[e][1]]);
      label(string(distance[e]), mid, red, UnFill);
    }
  }

  void labelEdgeNumber(pair pos=(0,0)) {
    for(int e=0; e<edge.length; ++e) {
      pair mid = 0.5*(node[edge[e][0]]+node[edge[e][1]]);
      label(string(e), mid, red, UnFill);
    }
  }

  void centre() {
    pair cog = (0,0);
    for(int i=0; i<size(); ++i) {
      cog += node[i];
    }
    cog /= size();
    real totalDist = 0.0;
    for(int i=0; i<size(); ++i) {
      node[i] -= cog;
      totalDist += length(node[i]);
    }
    real s = 10*size()/totalDist;
    for(int i=0; i<size(); ++i) {
      node[i] *= s;
    }
  }

  pair edgeNode(int e, int j) {
    return node[edge[e][j]];
  }

  bool shareNode(int e1, int e2) {
    return edge[e1][0] == edge[e2][0] || edge[e1][0] == edge[e2][1]
      || edge[e1][1] == edge[e2][0] || edge[e1][1] == edge[e2][1];
  }

  void relax() {
    real spring = 0.1;
    real viscosity = 0.8;
    real dt = 0.5;
    pair[] vel = array(size(), (0.0,0.0));
    int T = 200;
    for (int t=0; t<T; ++t) {
      pair[] accel = new pair[size()];
      if (t==T-40)
	spring += 0.05;
      for(int i=0; i<size(); ++i) {
	accel[i] = (0,0);
	for(int j=0; j<size(); ++j) {
	  if (i==j)
	    continue;
	  pair r = node[i]-node[j];
	  accel[i] += r/(0.001 + length(r)^3);
	}
      }
      for(int e=0; e<edge.length; ++e) {
	pair r = node[edge[e][0]]-node[edge[e][1]];
	pair s = -r*spring*(length(r)-distance[e]);
	accel[edge[e][0]] += s;
	accel[edge[e][1]] += -s;
      }
      for(int i=0; i<size(); ++i) {
	if (length(accel[i])>1) {
	  accel[i] = unit(accel[i]);
	  //	  write(i, node[i], vel[i], accel[i]);
	}
	vel[i] = viscosity*vel[i] + dt*accel[i];
	node[i] += dt*vel[i];
      }
    }
    centre();
  }

  
  void uncross() {
    for(int i=0; i<edge.length; ++i) {
      for(int j=i+1; j<edge.length; ++j) {
	if (shareNode(i,j))
	    continue;
	if (doIntersect(edgeNode(i,0), edgeNode(i,1),
			edgeNode(j,0), edgeNode(j,1))) {
	  int n = min(edge[i][0], edge[i][1], edge[j][0], edge[j][1]);
	  int e = (n == edge[i][0] || n == edge[i][1])? i:j;
	  int end = (n==edge[e][0])? 0:1;
	  node[n] = 2*edgeNode(e,1-end) - edgeNode(e,end);
	  relax();
	  break;
	}
      }
    }
  }

}

from EvoGraph unravel EvoGraph;



int n = 50;

string[] nodes = array(n, "");

real[][] edges = new real[][];

NodeData[] nodeData = new NodeData[n];

for(int i=0; i<n; ++i) {
  int m = floor(n*(rand()/randMax));
  while(m==i) {
    m = floor(n*(rand()/randMax));
  }
  real[] e = {i,m,1};
  edges.push(e);
  int m1 = floor(n*(rand()/randMax));
  while(m1==i || m1==m) {
    m1 = floor(n*(rand()/randMax));
  }
  real[] e1 = {i,m1,1};
  edges.push(e1);
  bool s = (rand()>0.5*randMax);
  nodeData[i] = NodeData(m, m1, floor(16*(rand()/randMax)), s);
}

EvoGraph g = EvoGraph(nodes);
g.addEdges(edges);
g.relax();
g.draw(nodeData);

bool[] f4 = array(4, false);
bool[][][] f = new bool[16][][];
for(int i=0; i<16; ++i) {
  int k=0;
  bool[][] ff = new bool[2][2];
  for(int i1=0; i1<2; ++i1) {
    for(int i2=0; i2<2; ++i2) { 
      ff[i1][i2] = f4[k];
      ++k;
    }
  }
  f[i] = ff;
  for(int j=0; j<4; ++j) {
    if (f4[j]) {
      f4[j] = false;
    } else {
      f4[j] = true;
      break;
    }
  }
}


int toInt(bool b) {return b? 1:0;}

int update(NodeData[] nd) {
  bool[] newState = new bool[nd.length];
  for(int i=0; i<nd.length; ++i) {
    newState[i] = f[nd[i].type][toInt(nd[nd[i].in1].state)][toInt(nd[nd[i].in2].state)];
  }
  int cnt = 0;
  for(int i=0; i<nd.length; ++i) {
    if (nd[i].state!=newState[i]) {
      ++cnt;
      g.highlightNode(i);
    }
    nd[i].state = newState[i];
  }
  return cnt;
}

ship();
for(int i=0; i<20; ++i) {
  erase();
  int cnt = update(nodeData);
  write(i, cnt);
  g.draw(nodeData);
  if (cnt==0)
    break;
  ship();
}
