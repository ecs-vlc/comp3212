size(200,0);
import evoGraph;
srand(1);

string[] nodeNames = {"$a$", "$b$", "$c$", "$d$", "", ""};

real[][] edges = {{0,4,1}, {1,4,4}, {2,5,1}, {3,5,4}, {4,5,1}};

EvoGraph g = EvoGraph(nodeNames);
g.addEdges(edges);
g.relax();
g.rotate(1,3);
g.show(false);
