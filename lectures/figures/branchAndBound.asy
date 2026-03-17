size(400,0);
import evoGraph;
import myutil;

string[] nodeNames = {"A", "B", "C", "D", "E", "F"};
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
    c.counter = array(nl-3, -1);
    c.costs = array(nl-3, 0);
    c.counterMax = array(nl-3, 0);
    c.counterMax[0] = 3;
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
	costs[i] = floor(9*(rand()/randMax));
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
      label("\Large "+ nodeNames[i+3], pos+u*(0.5+i, 1.5));
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
    
while(true) {
  erase();
  draw(box((-30,-15),(15,15)), white);
  counter.draw((-29,11));
  int noNodes = 3 + counter.noActive();
  int internal = noNodes-2;
  string[] vertices = names(noNodes, internal);
  EvoGraph g = EvoGraph(vertices);
  int[][] edges = makeEdges(counter);
  /*
  write("---");
  write(counter.counter);
  write(vertices);
  write(edges);
  */
  g.addEdges(edges);
  g.relax();
  g.uncross();
  g.centre();
  g.rotate(0,1);
  g.centre();
  g.rescale(12);
  g.draw();
  g.labelEdgeNumber();
  ship();
  counter.increment();
  if (counter.end())
    break;
}
  
