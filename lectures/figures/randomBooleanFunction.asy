size(210,0);

string[] func = {"F,F", "F,T", "T,F", "T,T"};
draw((-1.5,1.5)--(-1.5,-15.5));
label("$k$", (-2,1));
draw((-2.5,0.5)--(10.5,0.5));
for(int j=0; j<4; ++j) {
  label("$f_k("+func[j]+")$", (3j, 1));
  draw((3j+1.5,1.5)--(3j+1.5,-15.5));
}
bool[] f = array(4, false);
for(int i=0; i<16; ++i) {
  label(string(i), (-2,-i));
  for(int k=0; k<4; ++k) {
    string sf = f[k]? "T":"F";
    label(sf, (3k,-i));
  }
  for(int j=0; j<4; ++j) {
    if (f[j]) {
      f[j] = false;
    } else {
      f[j] = true;
      break;
    }
  }
}
