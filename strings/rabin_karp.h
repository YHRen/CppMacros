/* return first matching position of repeating length L substrings */
int find_repeating_substring_of_length( int L, const string & str ){
  typedef unsigned long long ull;
  ull run = 0, lpow=1;
  unordered_set<ull> dic;
  forall(i,0,L-1) { lpow = lpow*26; }
  forall(i,0,L){ run = (run*26 + (str[i]-'a')); }
  dic.insert(run);
  forall(i,L,n){
    run = (run - lpow*(str[i-L]-'a'))*26+(str[i]-'a');
    if( dic.find(run) != dic.end() ) return i-L+1;
    dic.insert(run);
  }
  return -1;
}
