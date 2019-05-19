static constexpr const int ALPH_SZ = 27;
struct Trie {
  int val;
  vector<Trie*> children;
  Trie(){ 
    children.resize(ALPH_SZ, nullptr);
    val = -1;
  }
  ~Trie(){
    for(auto & ptr : children ) if( ptr ) delete(ptr)
    children.clear();
  }
};
