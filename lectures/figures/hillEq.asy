settings.outformat="pdf";
size(400,0);
include myutil;

path bb = box((-4,-1.5),(4,1));


string beg = "$\displaystyle ";

string lhs;
string rhs;

void eqn() {
  pair pos=(-0.5,0);
  erase();
  draw(bb,white);
  label(beg+lhs+"$", pos, 2W);
  label("$=$", pos);
  label(beg+rhs+"$", pos, 2E);
}

string comment;

void addComment() {
  label(comment, (0,-1));
  ship();
}

void moveLeft(real x) {
  x -= 0.5;
  draw((x,0.2)..(x-0.2, 0.4)..(-0.7, 0.4), blue, Arrow);
}

void moveRight(real x) {
  x -= 0.5;
  draw((x,0.2)..(x+0.2, 0.4)..(-0.3, 0.4), blue, Arrow);
}


string kon = "k_{\text{\tiny on}}";
string koff = "k_{\text{\tiny off}}";
lhs = "\frac{\mathrm{d} [C]}{\mathrm{d} t}";
rhs = kon + "\, [X] \, [S_X]^n - " + koff + "\, [C]";

// dc/dt
eqn();
ship();

// dc/dt = 0

comment = "This equation reaches an equilibrium in a few milli-seconds";

addComment();

rhs += "=0";
eqn();
addComment();

// kof C = kon X S^n

comment = "Adding " + beg + koff + "\,[C]$ to both sides";
eqn();
moveLeft(1.8);
addComment();

rhs = kon + "\, [X] \, [S_X]^n";
lhs = koff + "\, [C]";
eqn();
addComment();

// Replace [X] by [X_T]-[C]

comment = "But number of $X$ and $C$ remain constant, $[X]+[C]=[X_T]$";
eqn();
addComment();

rhs = kon + "\, ([X_T]-[C]) \, [S_X]^n";
eqn();
addComment();

// Divide through by kon

comment = "Dividing through by $" + kon + "$";
eqn();
moveLeft(0.2);
addComment();

lhs = "\frac{" + koff + "}{" + kon + "}\,[C]";
rhs = "([X_T]-[C]) \, [S_X]^n";
eqn();
addComment();

// Defin K_X^n

comment = "Defining  " + beg + "K_X^n = \frac{" + koff + "}{" + kon + "}$";
eqn();
addComment();

lhs = "K_X^n \,[C]";
eqn();
addComment();

// Add [C] [S_X]^n to both sides

comment = "Adding $[C]\,[S_X]^n$ to both sides";
eqn();
moveLeft(1.1);
addComment();

lhs = "(K_X^n+[S_X]^n) \, [C]";
rhs = "[X_T] \, [S_X]^n";
eqn();
addComment();

// Dividing through by K_X^n+[S_X]^n

comment = "Dividing through by $K_X^n+[S_X]^n$";
eqn();
moveRight(-1.1);
addComment();

lhs = "[C]";
rhs = "\frac{[X_T] \, [S_X]^n}{K_X^n+[S_X]^n}";
eqn();
addComment();

// Dividing through by $[X_T]$

comment="Dividing through by $[X_T]$";

eqn();
moveLeft(0.5);
addComment();


lhs = "\frac{[C]}{[X_T]}";
rhs = "\frac{[S_X]^n}{K_X^n+[S_X]^n}";
eqn();
addComment();

// Finish

comment = "This is known as the \textbf{Hill Equation}!";
eqn();
addComment();
ship();
