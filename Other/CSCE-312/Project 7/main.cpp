//
//  main.cpp
//  P7
//
//  Name: Maverick Boyle
//  UIN: 426005784

#include "MatrixMultiplication.h"

int main(int argc, const char * argv[]) {
    
    // File Read Operation

    ifstream in;
    //insert the name of the file being tested below in in.open
    in.open("testcase_500.in");
    int dimensions;
    in >> dimensions;
    vector<vector<int> > A;
    for (int i = 0; i < dimensions; i++){
        vector<int> a;
        for (int j = 0; j < dimensions; j++){
            int element;
            in >> element;
            a.push_back(element);
        }
        A.push_back(a);
    }
    vector<vector<int> > B;
    for (int i = 0; i < dimensions; i++){
        vector<int> b;
        for (int j = 0; j < dimensions; j++){
            int element;
            in >> element;
            b.push_back(element);
        }
        B.push_back(b);
    }

    // Matrix Mult 1

    vector<vector<int> > C(dimensions,vector<int> (dimensions));
    std::clock_t start;
    double duration; start = std::clock();

    matrixMult1(A,B,C,dimensions);
    // for (int i = 0; i < C.size(); i++) { 
    //     for (int j = 0; j < C[i].size(); j++) 
    //         cout << C[i][j] << " "; 
    //     cout << endl; 
    // } 

    duration = ( std::clock() - start) / (double) CLOCKS_PER_SEC; std::cout<<"Matrix Mult Dot Product Duration: "<< duration <<'\n';
    
    // Matrix Mult 2

    vector<vector<int> > D(dimensions,vector<int> (dimensions));
    start = std::clock();

    matrixMult2(A,B,D,dimensions);
    // for (int i = 0; i < D.size(); i++) { 
    //     for (int j = 0; j < D[i].size(); j++) 
    //         cout << D[i][j] << " "; 
    //     cout << endl; 
    // } 

    duration = ( std::clock() - start) / (double) CLOCKS_PER_SEC; std::cout<<"Matrix Mult Row Duration: "<< duration <<'\n';
    
    // Matrix Mult 3

    vector<vector<int> > E(dimensions,vector<int> (dimensions));
    start = std::clock();

    matrixMult3(A,B,E,dimensions);
    // for (int i = 0; i < E.size(); i++) { 
    //     for (int j = 0; j < E[i].size(); j++) 
    //         cout << E[i][j] << " "; 
    //     cout << endl; 
    // } 

    duration = ( std::clock() - start) / (double) CLOCKS_PER_SEC; std::cout<<"Matrix Mult Column Duration: "<< duration <<'\n';

    // Matrix Mult Blocking

    vector<vector<int> > F(dimensions,vector<int> (dimensions));
    start = std::clock();

    blockingMatrixMult(A,B,F,dimensions,50);
    // for (int i = 0; i < F.size(); i++) { 
    //     for (int j = 0; j < F[i].size(); j++) 
    //         cout << F[i][j] << " "; 
    //     cout << endl; 
    // } 

    duration = ( std::clock() - start) / (double) CLOCKS_PER_SEC; std::cout<<"Matrix Mult Blocking Duration: "<< duration <<'\n';

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // Extra Credit (OPTIONAL)

    // Matrix Transpose

    vector<vector<int> > G(dimensions,vector<int> (dimensions));
    start = std::clock();

    matrixTranspose(A,G,dimensions);
    // for (int i = 0; i < G.size(); i++) { 
    //     for (int j = 0; j < G[i].size(); j++) 
    //         cout << G[i][j] << " "; 
    //     cout << endl; 
    // } 

    duration = ( std::clock() - start) / (double) CLOCKS_PER_SEC; std::cout<<"Matrix Transpose Duration: "<< duration <<'\n';
    
    // // Matrix Transpose Blocking

    // vector<vector<int> > H(dimensions,vector<int> (dimensions));
    // start = std::clock();

    // blockingMatrixTranspose();
    // for (int i = 0; i < H.size(); i++) { 
    //     for (int j = 0; j < H[i].size(); j++) 
    //         cout << H[i][j] << " "; 
    //     cout << endl; 
    // } 

    // duration = ( std::clock() - start) / (double) CLOCKS_PER_SEC; std::cout<<"Matrix Transpose Blocking Duration: "<< duration <<'\n';
    
    return 0;
}
