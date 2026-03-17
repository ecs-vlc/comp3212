size(200,0);
import evoGraph;

string[] nodeNames = {"$i$", "$j$", "$k$", "$\ell$", "", "", "", "", "", "", "", "", "", ""};
EvoGraph g = EvoGraph(nodeNames);

real[][] edges = {{0,2,1}, {1,4,1}, {5,4,1}, {2,4,1}, {2,6,1}, {6,7,0.5},
		  {6,8,1}, {8,3,0.5}, {8,9,0.5}, {7,10,0.5}, {7,11,0.5}, {9,12,0.5}, {9,13,0.5}};

g.addEdges(edges);
g.relax();
g.rotate(2,8);
g.draw();
