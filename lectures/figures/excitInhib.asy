size(300,0);

import myutil;

dot((38,0),white);
draw((0,0)--(5,0), linewidth(0.8));
draw((8,0)--(13,0), linewidth(0.8));
draw((4,0)--(4,2)--(9,2)--(9,0.2), linewidth(0.8), Arrow(7));
draw((12,0)--(12,2)--(18,2), linewidth(0.8), Arrow(7));
label("Excitation", (8, 3), N);
ship();

draw((20,0)--(25,0), linewidth(0.8));
draw((28,0)--(33,0), linewidth(0.8));
draw((24,0)--(24,2)--(29,2)--(29,0.3)--(28.5,0.3)--(29.5,0.3), linewidth(0.8));
draw((32,0)--(32,2)--(38,2), linewidth(0.8), Arrow(7));
label("Inhibition", (28, 3), N);
ship();
