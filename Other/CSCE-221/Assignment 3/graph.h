#ifndef GRAPH_H
#define GRAPH_H

#include <iostream>
#include <vector>
#include <list>
#include <queue>
#include <fstream>
#include <sstream>
#include <exception>

using namespace std;

class CycleFoundException{};

struct Vertex {
  int label; // unique int for a vertex
  int indegree; // Part 2
  int top_num; // Part 2: topological sorting number
  Vertex(int l) : label(l){}
  Vertex(int l, int ind) : label(l), indegree(ind){} //Part 2
};

class Graph {
private:
  vector<Vertex> node_list;
  vector<list<int>*> adj_list;
public:
  Graph() {};  // default constructor
  ~Graph();
  // build a graph
  void buildGraph(ifstream &input);
  // display the graph
  void displayGraph();
  // topological sort
  void topological_sort(); // Part 2
  // find indegree
  void compute_indegree(); // Part 2
  // print topological sort
  void print_top_sort();  // Part 2
};

#endif
