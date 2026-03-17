size(400,0);
import evoGraph;
import myutil;

string[] nodeNames = {"A", "B", "C", "D", "E"};
int noLeaves = nodeNames.length;

string[] names(int leaves, int internals) {
  string[] n = new string[leaves+internals];
  for(int i=0; i<leaves; ++i) {
    n[i] = nodeNames[i];
  }
  for(int i=leaves; i<leaves+internals; ++i) {
    n[i] = string(i-leaves);;
  }
  return n;
}

struct Counter {
  int[] counter;
  int[] counterMax;
  int[] costs;
  int cost;
  int bestCost = 1000;

  
  static Counter Counter(int nl) {
    Counter c = new Counter;
    c.counter = array(nl-2, -1);
    c.counterMax = array(noLeaves-2, 0);
    c.counterMax[0] = 2;
    c.cost = 5;
    for(int i=1; i<c.counter.length; ++i) {
      c.counterMax[i] = c.counterMax[i-1]+2;
    }
    return c;
  }

  void increment() {
    if (cost>=bestCost && counter[counter.length-1]==-1) {
      for(int i=counter.length-1; i>=0; --i) {
	if (counter[i]==-1 && i>0)
	  continue;
	++counter[i];
	costs[i] = floor(9*(rand()/randMax));
	if (counter[i] == counterMax[i])
	  counter[i] = -1;
	else
	  break;
      }
    } else {
      for(int i=counter.length-1; i>=0; --i) {
	if (counter[i]==-1 && i>0 && counter[i-1]==-1)
	  continue;
	++counter[i];
	costs[i] = floor(9*(rand()/randMax))+1;
	if (counter[i] == counterMax[i])
	  counter[i] = -1;
	else
	  break;
      }
    }
    cost = 5;
    int i;
    for(i=0; i<counter.length; ++i) {
      if (counter[i]==-1)
	break;
      cost += costs[i];
    }
    if (i==counter.length && cost<bestCost) {
      bestCost = cost; 
    }
  }


  void draw(pair pos) {
    real u =1.5;
    draw(box(pos, pos+u*(counter.length, 1)));
    draw(box(pos-(0.1,0.1), pos+u*(counter.length, 2)+(0.1,0.1)));
    for(int i=0; i<counter.length; ++i) {
      if (counter[i]==-1)
	label("$\cdot$", pos+u*(0.5+i, 0.5));
      else
	label("\Large "+ string(counter[i]), pos+u*(0.5+i, 0.5));
      draw(pos+u*(i,0)--pos+u*(i,2));
      label("\Large "+ nodeNames[i+2], pos+u*(0.5+i, 1.5));
    }
    label("current cost = " + string(cost), pos+(0,-1), E);
    label("best cost = " + string(bestCost), pos+(0,-2), E);
  }

  bool end() {return counter[0]==-1;}

  int noActive() {
    int i;
    for(i=0; i<counter.length; ++i) {
      if (counter[i]==-1)
	break;
    }
    return i;
  }
}

from Counter unravel Counter;

Counter counter = Counter(noLeaves);

int[][] makeEdges(Counter counter) {
  int noNodes = 3 + counter.noActive();
  int internal = noNodes;

  int[][] edges = {{0,internal,1},{1,internal,1},{2,internal,1}};
  for(int i=0; i<noNodes-3; ++i) {
    ++internal;
    int n1 = edges[counter.counter[i]][0];
    int n2 = edges[counter.counter[i]][0];
    edges[counter.counter[i]][0] = internal;
    int[] e1 = {n2, internal, 1};
    edges.push(e1);
    int[] e2 = {i+3, internal,1};
    edges.push(e2);
  }
  return edges;
}

struct Edge {
  int n1;
  int n2;
  int edgeLabel;
  static Edge Edge(int node1, int node2, int l) {
    Edge e = new Edge;
    e.n1 = node1;
    e.n2 = node2;
    e.edgeLabel = l;
    return e;
  }
}

from Edge unravel Edge;



void drawGraph(Counter counter) {
  pair pos[] = {(0,8),(-20,-10),(20,-10)};
  string[] nodeName = {"", "A", "B"};
  Edge[] edges = {Edge(0,1,0), Edge(0,2,1)};
  
  for(int i=0; i<counter.noActive(); ++i) {
    int newInter = 3+2*i;
    int newLeaf = 3+2*i+1;
    nodeName.push("");
    nodeName.push(nodeNames[2+i]);
    int onEdge = counter.counter[i];
    int n1 = edges[onEdge].n1;
    int n2 = edges[onEdge].n2;
    edges[onEdge] = Edge(n1, newInter, onEdge);
    edges.push(Edge(newInter, n2, 2+2*i));
    edges.push(Edge(newInter, newLeaf, 2+2*i+1));
    pos.push(0.5*(pos[n1]+pos[n2]));
    int next1 = n2;
    if (pos[n2].x<pos[n1].x) {
      while(pos[next1].y>-10) {
	int next2 = -1;
	for(int j=0; j<edges.length; ++j) {
	  if (edges[j].n1==next1 && (next2<0 || pos[edges[j].n2].x>pos[next2].x))
	    next2 = edges[j].n2;
	}
	if (next2<0) {
	  write("help");
	  write(next1, next2);
	  write(pos[next1], pos[next2]);
	  for(int k=0; k<pos.length; ++k) {
	    write(string(k) + " (" + string(pos[k].x) + "," + string(pos[k].y) + "): " + nodeName[k]);
	  }
	  for(int k=0; k<edges.length; ++k) {
	    write(k, edges[k].n1, edges[k].n2, edges[k].edgeLabel);
	    write(nodeName[edges[k].n1], nodeName[edges[k].n2]);
	  }	  
	  exit();
	}
	next1 = next2;
      }
      real nextx = 20;
      for(int i=0; i<pos.length; ++i) {
	if (pos[i].y==-10 && pos[i].x>pos[next1].x && pos[i].x<nextx) {
	  nextx = pos[i].x;
	}
      }
      pos.push((0.5*(pos[next1].x+nextx), -10));
    } else {
      while(pos[next1].y>-10) {
	int next2 = -1;
	for(int j=0; j<edges.length; ++j) {
	  if (edges[j].n1==next1 && (next2<0 || pos[edges[j].n2].x<pos[next2].x))
	    next2 = edges[j].n2;
	}
	if (next2<0) {
	  write("help");
	  write(next1, next2);
	  write(pos[next1], pos[next2]);
	  for(int k=0; k<pos.length; ++k) {
	    write(string(k) + " (" + string(pos[k].x) + "," + string(pos[k].y) + "): " + nodeName[k]);
	  }
	  for(int k=0; k<edges.length; ++k) {
	    write(k, edges[k].n1, edges[k].n2, edges[k].edgeLabel);
	    write("n1=" + nodeName[edges[k].n1] + " n2=" + nodeName[edges[k].n2]);
	  }	  
	  exit();
	}
	next1 = next2;
      }
      real nextx = -20;
      for(int i=0; i<pos.length; ++i) {
	if (pos[i].y==-10 && pos[i].x<pos[next1].x && pos[i].x>nextx) {
	  nextx = pos[i].x;
	}
      }
      pos.push((0.5*(pos[next1].x+nextx), -10));
    }
  }
  
  for(int i=0; i<edges.length; ++i) {
    draw(pos[edges[i].n1]--pos[edges[i].n2]);
    label(string(edges[i].edgeLabel), 0.5*(pos[edges[i].n1]+pos[edges[i].n2]),
	  red, UnFill);
  }

  for(int i=0; i<pos.length; ++i) {
    if (nodeName[i]=="") {
      filldraw(circle(pos[i],0.3), white, black);
    } else {
      filldraw(circle(pos[i],0.7), white, black);
      label(nodeName[i], pos[i], blue);
    }
  }
}



void drawGraph3(Counter counter) {
  pair pos[] = new pair[4];
  pos[0] = (0,0);
  pos[1] = 10*(-Cos(30), Sin(30));
  pos[2] = 10*(Cos(30), Sin(30));
  pos[3] = 10*(0, -1);
  string[] nodeName = new string[4];
  nodeName[0] = "0";
  nodeName[1] = "A";
  nodeName[2] = "B";
  nodeName[3] = "C";
  
  Edge[] edges;
  edges.push(Edge(0,1,0));
  edges.push(Edge(0,2,1));
  edges.push(Edge(0,3,2));

  for(int i=0; i<counter.noActive(); ++i) {
    int newInter = 4+2*i;
    int newLeaf = 4+2*i+1;
    nodeName.push(string(i+1));
    nodeName.push(nodeNames[3+i]);
    int onEdge = counter.counter[i];
    int n1 = edges[onEdge].n1;
    int n2 = edges[onEdge].n2;
    edges[onEdge] = Edge(n1, newInter, onEdge);
    edges.push(Edge(newInter, n2, 3+2*i));
    edges.push(Edge(newInter, newLeaf, 3+2*i+1));
    pos.push(0.5*(pos[n1]+pos[n2]));
    pair d = pos[n1]-pos[n2];
    pair np = 0.5*(pos[n1]+pos[n2]) + 0.8^(i+1)*(-d.y,d.x);
    pos.push(np);
  }
  
  for(int i=0; i<edges.length; ++i) {
    draw(pos[edges[i].n1]--pos[edges[i].n2]);
    label(string(edges[i].edgeLabel), 0.5*(pos[edges[i].n1]+pos[edges[i].n2]),
	  red, UnFill);
  }

  for(int i=0; i<pos.length; ++i) {
    filldraw(circle(pos[i],0.7), white, black);
    label(nodeName[i], pos[i], blue);
  }
}

while(true) {
  erase();
  draw(box((-20.5,-11),(13,12)), white);
  counter.draw((-20,5));
  drawGraph(counter);

  write("---");
  write(counter.counter);

  ship();
  counter.increment();
  if (counter.end())
    break;
}
