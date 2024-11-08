%% This code was made in MATLAB to find BayesNet values

low_ppO2 = prob5(0.8, 0.7, 0.6, 0.8, 0.8);
nominal_ppO2 = prob5(0.2, 0.3, 0.4, 0.2, 0.2);
nominal_ppCO2 = prob3(0.2, 0.1, 0.3);
high_ppCO2 = prob3(0.8, 0.9, 0.7);
nominal_humidity = prob5(0.4, 0.3, 0.3, 0.2, 0.3);
high_humidity = prob5(0.6, 0.7, 0.7, 0.8, 0.7);
nominal_cabin_fan1_rpm = prob2(0.1, 0.1);
nominal_temperature = prob4(0.4, 0.4, 0.2, 0.2);
high_temperature = prob4(0.6, 0.6, 0.8, 0.8);
nominal_butanone = prob5(0.4, 0.4, 0.3, 0.3, 0.1);
high_butanone = prob5(0.6, 0.6, 0.7, 0.7, 0.9);
nominal_cabin_fan2_rpm = prob2(0.1, 0.1);
nominal_pressure = prob2(0.2, 0.4);
nominal_ppN2 = prob2(0.2, 0.4);

%% This code was made in MATLAB to solve 4c

%% These functions were made in MATLAB to find BayesNet values
%%% They may be wrong depending on if (using burglary example)
%%% P(A|B) = P(A|B,!E)*P(!E) + P(A|B,E)*P(E) or if
%%% P(A|B) = P(A|B,!E) (functions based on 2nd eqn.)

function arr = prob5(n1, n2, n3, n4, n5)
    
    arr = zeros(8,4);

    arr(1,1) = n1;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n2;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n3;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n4;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n5;

    arr(1,2) = n1;
    arr(1,2) = arr(1,2) + (1-arr(1,2))*n2;
    arr(1,2) = arr(1,2) + (1-arr(1,2))*n3;
    arr(1,2) = arr(1,2) + (1-arr(1,2))*n4;

    arr(1,3) = n1;
    arr(1,3) = arr(1,3) + (1-arr(1,3))*n2;
    arr(1,3) = arr(1,3) + (1-arr(1,3))*n3;
    arr(1,3) = arr(1,3) + (1-arr(1,3))*n5;

    arr(1,4) = n1;
    arr(1,4) = arr(1,4) + (1-arr(1,4))*n2;
    arr(1,4) = arr(1,4) + (1-arr(1,4))*n3;

    arr(2,1) = n1;
    arr(2,1) = arr(2,1) + (1-arr(2,1))*n2;
    arr(2,1) = arr(2,1) + (1-arr(2,1))*n4;
    arr(2,1) = arr(2,1) + (1-arr(2,1))*n5;

    arr(2,2) = n1;
    arr(2,2) = arr(2,2) + (1-arr(2,2))*n2;
    arr(2,2) = arr(2,2) + (1-arr(2,2))*n4;

    arr(2,3) = n1;
    arr(2,3) = arr(2,3) + (1-arr(2,3))*n2;
    arr(2,3) = arr(2,3) + (1-arr(2,3))*n5;

    arr(2,4) = n1;
    arr(2,4) = arr(2,4) + (1-arr(2,4))*n2;

    arr(3,1) = n1;
    arr(3,1) = arr(3,1) + (1-arr(3,1))*n3;
    arr(3,1) = arr(3,1) + (1-arr(3,1))*n4;
    arr(3,1) = arr(3,1) + (1-arr(3,1))*n5;

    arr(3,2) = n1;
    arr(3,2) = arr(3,2) + (1-arr(3,2))*n3;
    arr(3,2) = arr(3,2) + (1-arr(3,2))*n4;

    arr(3,3) = n1;
    arr(3,3) = arr(3,3) + (1-arr(3,3))*n3;
    arr(3,3) = arr(3,3) + (1-arr(3,3))*n5;

    arr(3,4) = n1;
    arr(3,4) = arr(3,4) + (1-arr(3,4))*n3;

    arr(4,1) = n1;
    arr(4,1) = arr(4,1) + (1-arr(4,1))*n4;
    arr(4,1) = arr(4,1) + (1-arr(4,1))*n5;

    arr(4,2) = n1;
    arr(4,2) = arr(4,2) + (1-arr(4,2))*n4;

    arr(4,3) = n1;
    arr(4,3) = arr(4,3) + (1-arr(4,3))*n5;

    arr(4,4) = n1;

    arr(5,1) = n2;
    arr(5,1) = arr(5,1) + (1-arr(5,1))*n3;
    arr(5,1) = arr(5,1) + (1-arr(5,1))*n4;
    arr(5,1) = arr(5,1) + (1-arr(5,1))*n5;

    arr(5,2) = n2;
    arr(5,2) = arr(5,2) + (1-arr(5,2))*n3;
    arr(5,2) = arr(5,2) + (1-arr(5,2))*n4;

    arr(5,3) = n2;
    arr(5,3) = arr(5,3) + (1-arr(5,3))*n3;
    arr(5,3) = arr(5,3) + (1-arr(5,3))*n5;

    arr(5,4) = n2;
    arr(5,4) = arr(5,4) + (1-arr(5,4))*n3;

    arr(6,1) = n2;
    arr(6,1) = arr(6,1) + (1-arr(6,1))*n4;
    arr(6,1) = arr(6,1) + (1-arr(6,1))*n5;

    arr(6,2) = n2;
    arr(6,2) = arr(6,2) + (1-arr(6,2))*n4;

    arr(6,3) = n2;
    arr(6,3) = arr(6,3) + (1-arr(6,3))*n5;

    arr(6,4) = n2;

    arr(7,1) = n3;
    arr(7,1) = arr(7,1) + (1-arr(7,1))*n4;
    arr(7,1) = arr(7,1) + (1-arr(7,1))*n5;

    arr(7,2) = n3;
    arr(7,2) = arr(7,2) + (1-arr(7,2))*n4;

    arr(7,3) = n3;
    arr(7,3) = arr(7,3) + (1-arr(7,3))*n5;

    arr(7,4) = n3;

    arr(8,1) = n4;
    arr(8,1) = arr(8,1) + (1-arr(8,1))*n5;

    arr(8,2) = n4;

    arr(8,3) = n5;

end

function arr = prob4(n1,n2,n3,n4)

    arr = zeros(4);

    arr(1,1) = n1;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n2;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n3;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n4;

    arr(1,2) = n1;
    arr(1,2) = arr(1,2) + (1-arr(1,2))*n2;
    arr(1,2) = arr(1,2) + (1-arr(1,2))*n3;

    arr(1,3) = n1;
    arr(1,3) = arr(1,3) + (1-arr(1,3))*n2;
    arr(1,3) = arr(1,3) + (1-arr(1,3))*n4;

    arr(1,4) = n1;
    arr(1,4) = arr(1,4) + (1-arr(1,4))*n2;

    arr(2,1) = n1;
    arr(2,1) = arr(2,1) + (1-arr(2,1))*n3;
    arr(2,1) = arr(2,1) + (1-arr(2,1))*n4;

    arr(2,2) = n1;
    arr(2,2) = arr(2,2) + (1-arr(2,2))*n3;

    arr(2,3) = n1;
    arr(2,3) = arr(2,3) + (1-arr(2,3))*n4;

    arr(2,4) = n1;

    arr(3,1) = n2;
    arr(3,1) = arr(3,1) + (1-arr(3,1))*n3;
    arr(3,1) = arr(3,1) + (1-arr(3,1))*n4;

    arr(3,2) = n2;
    arr(3,2) = arr(3,2) + (1-arr(3,2))*n3;

    arr(3,3) = n2;
    arr(3,3) = arr(3,3) + (1-arr(3,3))*n4;

    arr(3,4) = n2;

    arr(4,1) = n3;
    arr(4,1) = arr(4,1) + (1-arr(4,1))*n4;

    arr(4,2) = n3;

    arr(4,3) = n4;

end

function arr = prob3(n1,n2,n3)

    arr = zeros(2,4);

    arr(1,1) = n1;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n2;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n3;

    arr(1,2) = n1;
    arr(1,2) = arr(1,2) + (1-arr(1,2))*n2;

    arr(1,3) = n1;
    arr(1,3) = arr(1,3) + (1-arr(1,3))*n3;

    arr(1,4) = n1;

    arr(2,1) = n2;
    arr(2,1) = arr(2,1) + (1-arr(2,1))*n3;

    arr(2,2) = n2;

    arr(2,3) = n3;

end

function arr = prob2(n1,n2)

    arr = zeros(1,4);

    arr(1,1) = n1;
    arr(1,1) = arr(1,1) + (1-arr(1,1))*n2;

    arr(1,2) = n1;

    arr(1,3) = n2;

end

%% These functions were made in MATLAB to solve 4c

function n = totprob2(n1, n2, arr)
    
    %prob11
    %prob10 (n1)
    %prob01 (n2)
    %prob00 %%This won't be necessary for final value, but will be good
    %check to see if prob11, 10, 01, and 00 = 1
    %I should put the probability of the cases in a matrix. That way I can
    %find n using a for loop which will make things much simpler for larger
    %number of variables
    %The code would be more compact and elegant if I created the matrix
    %using a for loop as well using i, and j from 0-1 (False or True) for
    % this one, and i,j,k,l, and m from 0-1 for the 5 variable problem

    n = arr(1,1)*prob11 + arr(1,2)*prob10 + arr(1,3)*prob01 + arr(1,4)*prob00

end