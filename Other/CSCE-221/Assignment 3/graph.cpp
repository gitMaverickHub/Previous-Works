// graph

#include "graph.h"

Graph::~Graph(){
    for (int i = 0; i < adj_list.size(); i++){
        (*(adj_list[i])).clear();
        delete adj_list[i];
    }
}

void Graph::buildGraph(ifstream &input){
    string line_of_input;
    while(getline(input, line_of_input)){       
        stringstream ss;
        ss << line_of_input;
        int vertex_label;
        ss >> vertex_label;
        node_list.push_back(vertex_label);
        ss >> vertex_label;
        list<int>* adjPush = new list<int>;
        while (vertex_label > 0){
            (*(adjPush)).push_back(vertex_label);
            ss >> vertex_label;
        }
        adj_list.push_back(adjPush);
    }
}

void Graph::displayGraph(){
    for (int i = 0; i < node_list.size(); i++){
        cout << node_list[i].label << " :";
        for (list<int>::iterator itr = (*(adj_list[i])).begin(); itr != (*(adj_list[i])).end(); itr++){
            cout << " " << *itr;
        }
        cout << "\n";
    }
}