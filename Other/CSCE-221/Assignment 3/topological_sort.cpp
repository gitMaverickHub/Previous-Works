// topological sort

#include "graph.h"

void Graph::compute_indegree(){
  for (int i = 0; i < adj_list.size(); i++){
    for (auto j: *adj_list[i]){
      node_list[j-1].indegree++;
    }
  }
}

void Graph::topological_sort(){
  queue<Vertex> q; 
  int counter = 0;
  //for each Vertex v
  for (auto v : node_list){
    if( v.indegree == 0 ){
      q.push( v );
    }
  }
  while( !q.empty( ) ) {
    Vertex v = q.front( );
    q.pop();
    node_list[v.label-1].top_num = ++counter; // Assign next number
    for (auto w : *(adj_list[v.label-1])){   //For each Vertex w adjacent to v
      if( --(node_list[w-1].indegree) == 0 ){
        q.push( node_list[w-1] );
      }
    }
  }
  if( counter != node_list.size() ) throw CycleFoundException();
}

void Graph::print_top_sort(){
  for (int i = 1; i < node_list.size()+1; i++){
    for (int j = 0; j < node_list.size(); j++){
      if (node_list[j].top_num == i){
        cout << node_list[j].label << " ";
      }
    }
  }
}
