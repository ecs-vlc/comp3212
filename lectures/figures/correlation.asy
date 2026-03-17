size(400,0);
import three;
import graph3;
import settings;
import myutil;
render=0;

currentprojection=perspective(3, 2, 1);

xaxis3("$X_i(t=1)$", 0, 5);
yaxis3("$X_i(t=2)$", 0, 5);
zaxis3("$X_i(t=3)$", 0, 5);

triple r1 = (5,2,3);
triple r2 = (2,3,4);
draw((0,0,0)--r1, red, Arrow3);
draw((0,0,0)--r2, red, Arrow3);
triple p1 = unit(r1);
triple p2 = unit(r2);
triple p3 = 1.1*unit(0.5*(p1+p2));
draw(p1..p3..p2, blue);

label("\Large$\theta$", 1.1*p3, W, blue);
label("\Large$\bm{X}_{1}$", r1, N, red);
label("\Large$\bm{X}_{2}$", r2, N, red);

label("
$q_{12}=\cos(\theta) = \frac{\av{(\bm{X}_1-\av{\bm{X}_1})^\tr (\bm{X}_{2} - \av{\bm{X}_2}){\av{\|\bm{X}_{1}-\av{\bm{X}_1}\|^2},\av{\|\bm{X}_{2}-\av{\bm{X}_2}\|^2}}$", (1,3.5,2), blue);
