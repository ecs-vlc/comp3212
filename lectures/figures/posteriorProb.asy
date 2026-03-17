size(600,0);
import myutil;
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
int T = 100;
int[] seq = new int[T];
string state;

for(int i=0; i<T; ++i) {
  seq[i] = (honest)? hdice():ddice();
  state = (honest)?  "\textcolor{blue}{H}":"\textcolor{red}{D}";
  label("\texttt{"+string(seq[i])+"}", (i+0.5,0));
  label("\texttt{"+state+"}", (i+0.5,-2));
  if (rand()<0.1*randMax)
    honest = ! honest;
}

real[][] v = new real[T+1][2];
int[][] ptr = new int[T][2];
v[0][0] = 0;
v[0][1] = -100000000;

real[][] alpha = new real[T+1][2];
alpha[0][0] = 0;
alpha[0][1] = 0;

real logAdd(real l1, real l2) {
  if (l1>l2) {
    return l1 + log1p(exp(l2-l1));
  } else {
    return l2 + log1p(exp(l1-l2));
  }
}

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
  real ldis = (seq[t]==6)? -log(2):logDishonest;
  alpha[t+1][0] = logHonest + logAdd(logStay + alpha[t][0],
				     logTran + alpha[t][1]);
  alpha[t+1][1] = ldis + logAdd(logStay + alpha[t][1],
				logTran + alpha[t][0]);
}

real lpSeq = logAdd(alpha[T][0], alpha[T][1]);

int[] viterbi = new int[T];
viterbi[T-1] = (v[T][0] > v[T][1])? 0:1;
for(int t=T-1; t>0; --t) {
  viterbi[t-1] = ptr[t][viterbi[t]];
}



string pred;
for(int t=0; t<T; ++t) {
  pred = (viterbi[t]==0)? "\textcolor{blue}{H}":"\textcolor{red}{D}";
  label("\texttt{"+pred+"}", (t+0.5,-4));
}


real[][] beta = new real[T+1][2];
beta[T][0] = 0;
beta[T][1] = 0;
for(int t=T; t>0; --t) {
  real ldis = (seq[t-1]==6)? -log(2):logDishonest;
  beta[t-1][0] = logAdd(logStay + logHonest + beta[t][0],
		      logTran + ldis + beta[t][1]);
  beta[t-1][1] = logAdd(logStay + ldis + beta[t][1],
		      logTran + logHonest + beta[t][0]);
}

real u = 10;
real offset = -22;
draw((0,offset+u+3)--(0,offset)--(T+1,offset), Arrows);
draw((0,offset)--(-1,offset));
draw((0,offset+u)--(-1,offset+u));
label("0", (-1,offset), W);
label("1", (-1,offset+u), W);
label("$\mathbb{P}\!\left(q_t=\text{H}\big| \bm{\xi},\, \bm{\theta}\right)$",
      (0,offset+u+3), E);
label("$t$", (T+1,offset),E);
guide g = (0,offset);
for(int t=0; t<T; ++t) {
  real l0 = alpha[t][0] + beta[t][0];
  real l1 = alpha[t][1] + beta[t][1];
  real p = exp(l0 - lpSeq);
  g = g--(t,u*p+offset)--(t+1,u*p+offset);
}

draw(g, red);

