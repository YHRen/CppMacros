vvi t2g(TreeNode* root){
  // convert leetcode tree to graph
  vvi g;
  int idx = 0;
  queue<pair<TreeNode*,int>> Q; Q.push(mp(root,idx));
  g.pb({});
  while(!Q.empty()){
    auto tmp = Q.front(); Q.pop();
    auto ptr = tmp.first;
    int  x   = tmp.second;
    if( ptr->left != NULL ){
      g.pb({x});
      idx++;
      g[x].pb(idx);
      Q.push(mp(ptr->left, idx));
    }
    if( ptr->right != NULL) {
      g.pb({x});
      idx++;
      g[x].pb(idx);
      Q.push(mp(ptr->right,idx));
    }
  }
  return g;
}
