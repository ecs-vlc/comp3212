size(400,0);
import plain_boxes;

for(int i=0; i<3; ++i)
  draw((i,0)--(i+1,0), MidArrow);

draw((3.2,0){E}..{W}(2.5,0.2)--(1.5,0.2){W}..{E}(0.8,0), MidArrow);
draw((3.2,0){E}..{W}(2.5, -0.3)--(0.5,-0.3){W}..{E}(-0.1,0), MidArrow);
draw((0, 0.06)..(0, 0.2)..cycle, MidArrow);
draw((1, -0.06)..(1, -0.2)..cycle, MidArrow);
draw((2, -0.06)..(2, -0.2)..cycle, MidArrow);
draw((3, -0.06)..(3, -0.2)..cycle, MidArrow);

draw(Label("junk", (0,0)), ellipse, FillDraw(lightgray));
draw(Label("promoter", (1,0)), ellipse, FillDraw(lightgray));
draw(Label("TATA box", (2,0)), ellipse, FillDraw(lightgray));
draw(Label("coding", (3,0)), ellipse, FillDraw(lightgray));

