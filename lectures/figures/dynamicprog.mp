verbatimtex
\documentclass{article}
\begin{document}
etex

u=5mm;

n=8;

def rectangle(expr xl,xh,yl,yh)=
  (xl,yl)--(xl,yh)--(xh,yh)--(xh,yl)--cycle
enddef;

def frame=
  rectangle(-1.5u,(n+0.5)*u,(-n/2-1.5)*u,(n/2+0.5)*u)
enddef;

numeric wu[][];
numeric wd[][];
def lattice=
  fill frame withcolor white;
  draw (0,0) withpen pencircle scaled 3;
  draw (n*u,0) withpen pencircle scaled 3;
  for i:=0 upto n/2:
    draw (i,i)*u--(n/2+i,-n/2+i)*u;
    draw (i,-i)*u--(n/2+i,n/2-i)*u;
  endfor
  for i:=0 upto n:
    label(decimal(i),(i,-n/2-1)*u);
    label(decimal(n/2-i),(-1,n/2-i)*u);
  endfor
  for i:=0 upto n/2-1:
    for j:=-i step 2 until i:
      wu[i][j] := floor(uniformdeviate 9)+1;
      label(decimal(wu[i][j]),1/2[(i,j)*u,(i+1,j+1)*u]) withcolor red;
      wd[i][j] := floor(uniformdeviate 9)+1;
      label(decimal(wd[i][j]),1/2[(i,j)*u,(i+1,j-1)*u]) withcolor red;
      show((n-i-1,j+1));
      wd[n-i-1][j+1] := floor(uniformdeviate 9)+1;
      show(wd[n-i-1][j+1]);
      label(decimal(wd[n-i-1][j+1]),1/2[(n-i,j)*u,(n-i-1,j+1)*u]) withcolor red;
      wu[n-i-1][j-1] := floor(uniformdeviate 9)+1;
      label(decimal(wu[n-i-1][j-1]),1/2[(n-i,j)*u,(n-i-1,j-1)*u]) withcolor red;
      endfor
  endfor
enddef;

figno:=0;
beginfig(figno)
  lattice;
endfig;
figno := figno + 1;

numeric c[][];
c[0][0]=0;
beginfig(figno)
  draw frame withcolor white;
  label.rt(decimal(c[0][0]),(0,0)) withcolor blue;
endfig;
figno := figno + 1;

for i:=1 upto n:
  beginfig(figno)
    draw frame withcolor white;
    if (i<=n/2):
      c[i][i] := c[i-1][i-1]+wu[i-1][i-1];
      c[i][-i] := c[i-1][-i+1]+wd[i-1][-i+1];
      for j:=-i+2 step 2 until i-2:
	c[i][j] = min(c[i-1][j-1]+wu[i-1][j-1],c[i-1][j+1]+wd[i-1][j+1]);
      endfor
      for j:=-i step 2 until i:
	label.rt(decimal(c[i][j]),(i,j)*u) withcolor blue;
      endfor
    else:
      for j:=-(n-i) step 2 until n-i:
	show((i,j));
	show((c[i-1][j-1],wu[i-1][j-1]));
	show((c[i-1][j+1],wd[i-1][j+1]));
	c[i][j] = min(c[i-1][j-1]+wu[i-1][j-1],c[i-1][j+1]+wd[i-1][j+1]);
	label.rt(decimal(c[i][j]),(i,j)*u) withcolor blue;
      endfor      
    fi
  endfig;
  figno := figno + 1;
endfor;

pair current, next;
current:=(n,0);
for i:=n step -1 until 1:
  j := ypart current;
  if j=i:
    next:=current+(-1,-1);
  elseif j=-i:
    next:=current+(-1,1);
  elseif c[i-1][j-1]+wu[i-1][j-1]=c[i][j]:
    next:=current+(-1,-1);
  else:
    next:=current+(-1,1);
  fi
  beginfig(figno)
    draw frame withcolor white;
    draw current*u--next*u withpen pencircle scaled 2 withcolor blue;
  endfig;
  figno := figno + 1;
  current := next;
endfor  



end
