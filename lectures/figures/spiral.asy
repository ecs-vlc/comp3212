size(700,0);
import myutil;

string myround(real x) {
  return string(round(1000*x)/1000,4);
}

string makeMatrix(pair[][] M) {
  string s = "\begin{pmatrix}";
  for(int i=0; i<2; ++i) {
    for(int j=0; j<2; ++j) {
      int pr = 0;
      if (abs(M[i][j].x) > 1e-6) {
	s += " " + myround(M[i][j].x);
	++pr;
      }
      if (abs(M[i][j].y) > 1e-6) {
	if (pr==1 && M[i][j].y>0)
	  s += "+";
	s += " " + myround(M[i][j].y) + "\mathrm{i}";
	++pr;
      }
      if (pr==0)
	s += " 0";
      if (j==0)
        s += "&";
    }
    if (i==0)
      s += "\\";
  }
  s += "\end{pmatrix}";
  return s;
}

pair[][] L = {{-0.6845 + 4.1631I, 0},
	      {0, -0.6845 - 4.1631I}};

pair[][] V = {{0.81784 + 0.00000I,   0.81784 - 0.00000I},
	      {-0.32704 - 0.47348I,  -0.32704 + 0.47348I}};

pair[][] invV = {{0.61136 + 0.42228I,  -0.00000 + 1.05602I},
		 {0.61136 - 0.42228I,   0.00000 - 1.05602I}};

	
string J = "$\mat{J} =
 \begin{pmatrix} \frac{-89}{25} & \frac{-640}{89}\\ \frac{89}{25} & \frac{195}{89}\end{pmatrix} =
\mat{V} \mat{\Lambda} \mat{V}^{-1} =" + makeMatrix(V) + makeMatrix(L) + makeMatrix(invV) + "$";

label(J, (0, 0.72), N);
draw((-1,0)--(1,0), Arrow);
draw((0,-0.5)--(0,0.7), Arrow);

pair[] multi(pair[][] M, pair[] x) {
  pair[] y = {M[0][0]*x[0] + M[0][1]*x[1], M[1][0]*x[0] + M[1][1]*x[1]};
  return y;
}

picture bg = new picture;
add(bg, currentpicture);

pair x = (0, 0.6);
dot(x, red);
pair[] x0 = {0, 0.6};
pair[] xh = multi(invV,x0);

guide g;
for(real t=0; t<5.01; t+=0.1) {
  erase();
  add(bg);
  pair[][] T = {{exp(L[0][0]*t),0},{0,exp(L[1][1]*t)}};
  pair[] Tx = multi(T,xh);
  pair[] xx = multi(V,Tx);
  x = (xx[0].x, xx[1].x);
  g = g..x;
  draw(g, red+dashed);
  dot(x, red);
  label("$\epsilon(" + string(t,3) + ")$", x, E);
  ship();
}
