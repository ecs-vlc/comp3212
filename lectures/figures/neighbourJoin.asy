size(200,0);

int noLeaf = 6;

int[][] edges = {{0,10,4},{1,10,3},{10,11,2},{3,11,4},{11,12,5},{12,13,2},
		 {4,13,2}, {5,13,4},{2,12,3}};

int pathLength(int current, int target, int lastVisited) {
  for(int i=0; i<edges.length; ++i) {
    if (edges[i][0]==current) {
      if (edges[i][1] == lastVisited)
	continue;
      if (edges[i][1]==target) {
	return edges[i][2];
      }
      if (edges[i][1]>=10) {
	int d = pathLength(edges[i][1], target, current);
	if (d<0)
	  continue;
	return edges[i][2] + d;
      }
    } else if (edges[i][1]==current) {
      if (edges[i][0] == lastVisited)
	continue;
      if (edges[i][0]==target) {
	return edges[i][2];
      }
      if (edges[i][0]>=10) {
	int d = pathLength(edges[i][0], target, current);
	if (d<0)
	  continue;
	return edges[i][2] + d;
      }
    }
  }
  return -1;
}

real[][] leafTable = new real[noLeaf][noLeaf];

for(int i=0; i<noLeaf; ++i) {
  leafTable[i][i] = 0;
  for(int j=i+1; j<noLeaf; ++j) {
    int d = pathLength(i, j, -1);
    if (d<0) {
      string w = "error no path found from node " +string(i);
      w += " to node " + string(j);
      write(w);
      exit();
    }
    leafTable[i][j] = leafTable[j][i] = d;
  }
}

real[] r = array(noLeaf, 0.0);
for(int i=0; i<noLeaf; ++i) {
  for(int j=0; j<noLeaf; ++j) {
    r[i] += leafTable[i][j];
  }
  r[i] /= noLeaf-2;
  write(i+1, r[i]);
}

real[][] adjLeafTable =  new real[noLeaf][noLeaf];

for(int i=0; i<noLeaf; ++i) {
  adjLeafTable[i][i] = 0.0;
  for(int j=i+1; j<noLeaf; ++j) {
    adjLeafTable[j][i] = adjLeafTable[i][j] = leafTable[i][j] - r[i] - r[j];
  }
}

string[] leafName = {"1", "2", "3", "4", "5", "6"};

void makeTable(picture pic, real[][] distances, string[] leaves, string h) {
  label(pic, h, (-1,1));
  for(int i=0; i<leaves.length; ++i) {
    label(pic, leaves[i], (i, 1));
    label(pic, leaves[i], (-1,-i));
  }
  draw(pic, (-0.5,1.5)--(-0.5, -leaves.length+0.5));
  draw(pic, (-1.5,0.5)--(leaves.length-0.5, 0.5));
  for(int i=0; i<distances.length; ++i) {
    for(int j=0; j<distances[i].length; ++j) {
      label(pic, string(distances[i][j],3), (i,-j));
    }
  }
}

picture distTablePic = new picture;
size(distTablePic, 250, 0);
makeTable(distTablePic, leafTable, leafName, "$d_{ij}$");
shipout("distanceTable", distTablePic);
picture distTableSmallPic = new picture;
size(distTableSmallPic, 150, 0);
makeTable(distTableSmallPic, leafTable, leafName, "$d_{ij}$");
shipout("distanceSmallTable", distTableSmallPic);

picture adjDistTablePic = new picture;
size(adjDistTablePic, 250, 0);
makeTable(adjDistTablePic, adjLeafTable, leafName, "$D_{ij}$");
shipout("D_Table", adjDistTablePic);
import evoGraph;

string[] innerNodeName = array(4, "");
string[] nodeNames;
nodeNames.append(leafName);
nodeNames.append(innerNodeName);


for(int i=0; i<edges.length;++i) {
  if (edges[i][0]>=10) {
    edges[i][0]-=4;
  }
  if (edges[i][1]>=10) {
    edges[i][1]-=4;
  }
  write(edges[i][0], edges[i][1], edges[i][2]);
}
EvoGraph g = EvoGraph(nodeNames);
g.addEdges(edges);
g.show();
shipout();


