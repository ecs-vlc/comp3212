size(500,0);
import contour;
import myutil;

real[][] S = {{2,1}, {1,3}};
real[][] T = {{0,0}, {0,4}};

/*
real f(real T11, real T12) {
  T[0][0] = T11;
  T[0][1] = T[1][0] = T12;
  real[][] M = T*S;
  real detT = T[0][0]*T[1][1] - T[0][1]*T[1][0];
  if (detT<=0) {
    return 10.0;
  }
  return -0.5*(M[0][0] + M[1][1]) - log(detT);
}
*/

real f(real x, real y) {
  return (x-0.2)*(x-0.2) + (y-0.6)*(y-0.6) - x*y;
}

pair lower = (-3,-2);
pair upper = (3,2);

draw(1.1*(lower.x,0)--1.1*(upper.x,0), Arrow);
draw(1.1*(0,lower.y)--1.1*(0,upper.y), Arrow);
real[] c = {0.125,0.25,0.5,1,2,4,8};
Label[] Labels=sequence(new Label(int i) {
return Label(c[i] != 0 ? (string) c[i] : "",Relative(unitrand()),(0,0),
UnFill(1bp));
},c.length);
draw(Labels, contour(f, lower, upper, c), blue);
label("\Huge $\bm{\times}$", (0.7,1.1), blue);
ship();

real reg(real x, real y) {
  return 0.5*(abs(x) + abs(y));
}

draw(contour(reg, lower, upper, new real[] {0.5, 1, 1.5, 2, 3}), red);
ship();

real combined(real x, real y) {
  return reg(x,y) + f(x,y);
}

draw(Labels, contour(combined, lower, upper, c), heavygreen);
ship();
erase();
draw(1.1*(lower.x,0)--1.1*(upper.x,0), Arrow);
draw(1.1*(0,lower.y)--1.1*(0,upper.y), Arrow);
draw(Labels, contour(combined, lower, upper, c), heavygreen);
ship();

pair opt = (0,0.7);
label("\Huge $\bm{\times}$", opt, darkgreen);
ship();
write(combined(opt.x, opt.y));
write(combined(opt.x-0.01,opt.y));
write(combined(opt.x, opt.y+0.01));
