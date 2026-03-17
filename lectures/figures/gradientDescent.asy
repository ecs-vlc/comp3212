import graph3;
import settings;
render=0;
size(300,0);
import myutil;
currentprojection=perspective(5,4,2);
real f(pair z) {return 0.1*(z.x^2+2*z.y^2-z.x*z.y-0.2*z.x+0.3*z.y)+0.1;}
pair gradf(pair z) {return 0.1*(2*z.x-z.y-0.2, 4*z.y-z.x+0.3);}
surface func = surface(f,(-1.5,-1.5),(1.5,1.5),nx=10);

triple f3(pair z) { return (z.x, z.y, f(z)+0.02); }

picture bg = new picture;
void store() {
  add(bg, currentpicture);
  ship();
}

void restore() {
  erase();
  add(bg);
}

draw(func,lightgray+opacity(0.9),meshpen=black+thick(),nolight,render(merge=true));
xaxis3(Label("$\theta_1$",2.5),red,Arrow3);
yaxis3(Label("$\theta_2$",2.5),red,Arrow3);
zaxis3(Label("$L(\bm{\theta}, \mathcal{D})$",2.5),red,Arrow3);

pair x = (1,-1);
dot(f3(x), red+linewidth(3));

store();

for (int i=0; i<5; ++i) {
  pair x1 = x-gradf(x);
  draw(f3(x)--f3(x1), blue, Arrow3);
  if (i<2)
    label("$-r\bm{\nabla}L(\bm{\theta}, \mathcal{D})$", f3(x-1.3*gradf(x)), blue);
  ship();
  restore();
  x = x1;
  dot(f3(x), red+linewidth(3));
  store();
}


/*
real x(real t) {return t;}
real y(real t) {return 0.5*(t-3);}
real z(real t) {return 0.1*(t^2 + 2*y(t)^2 -t*y(t));}
real zero(real t) {return 0;}

draw(graph(x,y,z,-1,2,operator..), red+linewidth(2));
//draw(graph(x,y,zero,-1,2,operator..), red+dashed+linewidth(2));

triple opt = (3/4,-9/8, 6.3/16);

pair grad = 1*(2*opt.x-opt.y, 4*opt.y-opt.x);
triple grad3 = 0.1*(grad.x, grad.y, f(opt+grad)-f(opt));

draw(opt--opt+grad3, heavygreen+linewidth(2), Arrow(10));

dot(opt, blue+linewidth(5));

label("$\nabla f(\mathbf{x})$", opt+grad3, 4N, heavygreen);
*/
