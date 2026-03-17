size(420,0);
usepackage("color");
srand(4);

int hdice() {return floor(6*rand()/(1.0+randMax))+1;}
int ddice() {
  int o = floor(10*rand()/(1.0+randMax))+1;
  if (o>6)
    return 6;
  return o;
}

bool honest = true;
string seqStr;
string states;
int T = 100;
int[] seq = new int[T];

for(int i=0; i<T; ++i) {
  seq[i] = (honest)? hdice():ddice();
  states += (honest)?  "\textcolor{blue}{H}":"\textcolor{red}{D}";
  seqStr += string(seq[i]);
  if (rand()<0.1*randMax)
    honest = ! honest;
}

label("\texttt{"+seqStr+"}", (0,0), E);
label("\texttt{"+states+"}", (0,-15), E);

real[][] v = new real[T+1][2];
int[][] ptr = new int[T][2];
v[0][0] = 0;
v[0][1] = -100000000;

real logStay = log(0.9);
real logTran = log(0.1);
real logHonest = -log(6.0);
real logDishonest = -log(10.0);
for(int t=0; t<T; ++t) {
  v[t+1][0] = logHonest + max(v[t][0] + logStay, v[t][1] + logTran);
  v[t+1][1] = logDishonest + max(v[t][0] + logTran, v[t][1] + logStay);
  if (seq[t] == 6)
    v[t+1][1] += log(5);
  ptr[t][0] = (v[t][0] + logStay > v[t][1] + logTran)? 0:1;
  ptr[t][1] = (v[t][0] + logTran > v[t][1] + logStay)? 0:1;
}

int[] viterbi = new int[T];
viterbi[T-1] = (v[T][0] > v[T][1])? 0:1;
for(int t=T-1; t>0; --t) {
  viterbi[t-1] = ptr[t][viterbi[t]];
}

string pred;
for(int t=0; t<T; ++t) {
  pred += (viterbi[t]==0)? "\textcolor{blue}{H}":"\textcolor{red}{D}";
}

label("\texttt{"+pred+"}", (0,-30), E);
