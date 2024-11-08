// main function

#include "graph.h"

int main(int argc, const char * argv[])
{
  if ( argc != 2 ) {
    cout << "usage: " << argv[0] << " input filename\n";
    exit(1);
  }

  string input_name = argv[1];
  ifstream input(input_name);
  if (!input) {
    cout << "Wrong or nonexisting input file\n";
    exit(1);
  }
  try {
    Graph graph;
    graph.buildGraph(input);
    graph.displayGraph();
    graph.compute_indegree(); // Part 2
    graph.topological_sort(); // Part 2
    graph.print_top_sort();   // Part 2
  }
  catch(CycleFoundException){
    cout << "There are cycles in the graph.\n";
  }
  return 0;
}