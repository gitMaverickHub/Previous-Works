//
//  MatrixMultiplication.cpp
//  P7
//
//  Name: Maverick Boyle
//  UIN: 426005784

#include "MatrixMultiplication.h"

void matrixMult1(const std::vector<std::vector<int> >& a, const std::vector<std::vector<int> >& b, std::vector<std::vector<int> >& result, const int n){
    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++){
            for (int k =0; k < n; k++){
                result[i][j] += a[i][k]*b[k][j];
            }
        }
    }
}

void matrixMult2(const std::vector<std::vector<int> >& a, const std::vector<std::vector<int> >& b, std::vector<std::vector<int> >& result, const int n){
    for (int k = 0; k < n; k++){
        for (int i = 0; i < n; i++){
            for (int j = 0; j < n; j++){
                result[i][j] += a[i][k]*b[k][j];
            } 
        }
    }
}

void matrixMult3(const std::vector<std::vector<int> >& a, const std::vector<std::vector<int> >& b, std::vector<std::vector<int> >& result, const int n){
    for (int k = 0; k < n; k++){
        for (int j = 0; j < n; j++){
            for (int i = 0; i < n; i++){
                result[i][j] += a[i][k]*b[k][j];
            } 
        }
    }
}

void blockingMatrixMult(const std::vector<std::vector<int> >& a, const std::vector<std::vector<int> >& b, std::vector<std::vector<int> >& result, const int n, const int block_size){
    int sum = 0;
    for (int k = 0; k<n; k+=block_size){
        int m1 = min(k + block_size, n);
        for (int j = 0; j<n; j+=block_size) {           
            int m2 = min(j + block_size, n);
            for (int i = 0; i<n; i++){ 
                for (int i1 = k; i1< m1; i1++){
                    sum = 0;
                    for(int j1 = j; j1<m2; j1++){
                        sum += a[i][j1]*b[j1][i1];
                    }
                    result[i][i1] += sum;
                }
            }
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Extra Credit (OPTIONAL)

void matrixTranspose(const std::vector<std::vector<int>>& a, std::vector<std::vector<int>>& result, const int n){
    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++){
            result[i][j] = a[j][i];
        }
    }
}

void blockingMatrixTranspose(const std::vector<std::vector<int>>& a, std::vector<std::vector<int>>& result, const int n, const int block_size){

}
