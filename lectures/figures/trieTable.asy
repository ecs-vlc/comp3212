import myutil;
size(30cm,0);

real u = 4;
string[] alphabet = {" ", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};


string[] words = {"A", "AND", "ARE", "AS", "AT", "BE", "BUT", "BY", "FOR", "FROM", "HAD", "HAVE", "HE", "HER", "HIS", "I", "IN", "IS", "IT", "NOT", "OF", "ON", "OR", "THAT", "THE", "THIS", "WAS", "WHICH", "WITH", "YOU"};


for(int i=0; i<100; ++i) { 
  int w1 = floor((rand()/randMax)*words.length);
  int w2 = floor((rand()/randMax)*words.length);
  string w = words[w1];
  words[w1] = words[w2];
  words[w2] = w;
}
  
//string[] swords = sort(words);

string allwords;

for(int i=0; i<words.length-1; ++i) {
  allwords += words[i] + ", ";
}
allwords += words[words.length-1];
write(allwords);

int key(string str, int index) {
  if (index>=length(str)) {
    return 0;
  }
  int i = search(alphabet, substr(str, index, 1));
  if (i==-1) {
    write("can't find " + substr(str, index, 1) + " in " + str);
  }
  return i;
}

struct Column {
  string[] word;
  int[] address;
  
  static Column Column() {
    Column col = new Column;
    col.word = array(alphabet.length, "");
    col.address = array(alphabet.length, 0);
    return col;
  }
}

from Column unravel Column;

struct Trie {
  Column[] column;

  int size() {
    return this.column.length;
  }

  static Trie Trie() {
    Trie trie = new Trie;
    trie.column = new Column[];
    return trie;
  }

  string word(int col, int row) {
    return this.column[col].word[row];
  }

  int address(int col, int row) {
    return this.column[col].address[row];
  }

  void add(string word, int col, int letterPos) {
    if (col>=size()) {
      this.column.push(Column());
    }
    write(word);
    write(col, letterPos);
    int k = key(word, letterPos);
    if (this.word(col,k) != '') {
      int i=1;
      for(; i<length(this.word(col,k)); ++i) {
	if (substr(this.word(col,k),i,1) != substr(word,i,1))
	  break;
      }
      if (i==length(this.word(col,k)) && this.address(col,k)!=0) {
	add(word, this.address(col,k), letterPos+i);
      } else {
	string currentWord = this.word(col,k);
	this.column[col].word[k] = substr(word,0,i);
	int newCol = this.size();
	this.column[col].address[k] = newCol;
	write(currentWord + " " + word);
	write(newCol, letterPos, i);
	add(currentWord, newCol, i);
	add(word, newCol, i);
      }
    } else {
      this.column[col].word[k] = word;
    }
  }
  
  
  void draw() {
    draw((-u, 0.5)--(this.size()*u,0.5));
    label("\$", (-0.5u, -1));
    for(int i=0; i<alphabet.length; ++i) {
      draw((-u,-i-0.5)--(this.size()*u,-i-0.5));
      label(alphabet[i], (-0.5u, -i-1));
    }
    draw((-u, -alphabet.length-0.5)--(this.size()*u,-alphabet.length-0.5));
    draw((0,0.5)--(0, -alphabet.length-0.5));
    
    for(int i=0; i<this.size(); ++i) {
      label(string(i), (i*u+0.5u, 0));
      draw((i*u+u,0.5)--(i*u+u, -alphabet.length-0.5));
    }
    for(int col=0; col<this.size(); ++col) {
      for(int i=0; i<this.column[col].word.length; ++i) {
	if(this.word(col,i) != "") {
	  string str = this.word(col,i);
	  if (this.address(col,i)!= 0) {
	    str += "* (" + string(this.address(col,i)) + ")";
	  } else {
	    str += "\$";
	  }
	  label(str,(col*u+0.5*u,-i-1));
	}
      }
    }
  }
};

from Trie unravel Trie;

Trie trie = Trie();
dot((u*11,2), white);
//label("Add words: $\{$" + allwords + "$\}$", (u*n/2, 1.5));
trie.draw();
ship();


for(int i=0; i<words.length; ++i) {
  dot((u*11,2),white);
  trie.draw();
  label("\large \texttt{add(\"" +words[i] + "\")}", (u*12/2, 1.5));
  ship();
  erase();
  dot((u*11,2), white);
  label("\large \texttt{add(\"" +words[i] + "\")}", (u*12/2, 1.5));
  trie.add(words[i], 0, 0);
  trie.draw();
  ship();
  erase();
}

