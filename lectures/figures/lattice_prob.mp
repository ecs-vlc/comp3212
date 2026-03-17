verbatimtex
\documentclass{article}
\begin{document}
etex

u=5mm;

n=8;

figno:=-1;
beginfig(figno)
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
      r := floor(uniformdeviate 9)+1;
      label(decimal(r),1/2[(i,j)*u,(i+1,j+1)*u]) withcolor red;
      r := floor(uniformdeviate 9)+1;
      label(decimal(r),1/2[(i,j)*u,(i+1,j-1)*u]) withcolor red;
      r := floor(uniformdeviate 9)+1;
      label(decimal(r),1/2[(n-i,j)*u,(n-i-1,j+1)*u]) withcolor red;
      r := floor(uniformdeviate 9)+1;
      label(decimal(r),1/2[(n-i,j)*u,(n-i-1,j-1)*u]) withcolor red;
      endfor
  endfor
  
endfig;

figno := figno + 1;


end
