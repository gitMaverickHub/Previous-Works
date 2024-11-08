%% This code was made in MATLAB to find BayesNet values and solve 4c

low_ppO2 = prob5(0.8, 0.7, 0.6, 0.8, 0.8);
nominal_ppO2 = prob5(0.2, 0.3, 0.4, 0.2, 0.2);
ppCO2 = prob_given_subset3(0.0001,0.001,0.0001,0.2,0.8,0.1,0.9,0.3,0.7);
nominal_humidity = prob5(0.4, 0.3, 0.3, 0.2, 0.3);
high_humidity = prob5(0.6, 0.7, 0.7, 0.8, 0.7);
cabin_fan1_rpm = prob_given_cabin(0.0001,0.01,0.9,0.1,0.9,0.1);
temperature = prob_given_subset4(0.0001,0.0001,0.01,0.01,0.4,0.6,0.4,0.6,0.2,0.8,0.2,0.8);
nominal_butanone = prob5(0.4, 0.4, 0.3, 0.3, 0.1);
high_butanone = prob5(0.6, 0.6, 0.7, 0.7, 0.9);
cabin_fan2_rpm = prob_given_cabin(0.0001,0.01,0.9,0.1,0.9,0.1);
pressure = prob_given_subset2(0.00001,0.00001,0.8,0.2,0.4,0.6);
ppN2 = prob_given_subset2(0.00001,0.00001,0.8,0.2,0.4,0.6);

posO2 = prob_of_subset5(0.0001,0.001,0.0001,0.00001,0.0001);
posCO2 = prob_of_subset3(0.001,0.001,0.001);
posHumidity = prob_of_subset5(0.0001,0.0001,0.0001,0.01,0.01);
posCF1 = prob_of_subset2(0.0001,0.01);
posTemp = prob_of_subset4(0.0001,0.0001,0.01,0.01);
posButanone = prob_of_subset5(0.0001,0.0001,0.01,0.01,0.001);
posCF2 = prob_of_subset2(0.0001,0.01);
posPres = prob_of_subset2(0.00001,0.00001);
posN2 = prob_of_subset2(0.00001,0.00001);

nppCO2 = ppCO2(1:2,:);
ncabin_fan1_rpm = cabin_fan1_rpm(2,:);
ntemperature = temperature(1:4,:);
ncabin_fan2_rpm = cabin_fan2_rpm(2,:);
npressure = pressure(2,:);
nppN2 = ppN2(2,:);

png_nominal_ppO2 = prob_nothing_given(posO2,nominal_ppO2);
png_nominal_ppCO2 = prob_nothing_given(posCO2,nppCO2);
png_nominal_humidity = prob_nothing_given(posHumidity,nominal_humidity);
png_nominal_pdu1_current = 0.1*0.0001;
png_nominal_cabin_fan1_rpm = prob_nothing_given(posCF1,ncabin_fan1_rpm);
png_nominal_temperature = prob_nothing_given(posTemp,ntemperature);
png_nominal_butanone = prob_nothing_given(posButanone,nominal_butanone);
png_nominal_pdu2_current = 0.1*0.0001;
png_nominal_cabin_fan2_rpm = prob_nothing_given(posCF2,ncabin_fan2_rpm);
png_nominal_fuel_cell_current = 0.2*0.0001;
png_nominal_pressure = prob_nothing_given(posPres,npressure);
png_nominal_ppN2 = prob_nothing_given(posN2,nppN2);
png_nominal_H2O = 0.1*0.0001;
%{
query4c = png_nominal_ppO2 * png_nominal_ppcO2 * png_nominal_humidity ...
    * png_nominal_pdu1_current * png_nominal_cabin_fan1_rpm ...
    * png_nominal_cabin_fan1_rpm * png_nominal_temperature ...
    * png_nominal_butanone * png_nominal_pdu2_current ...
    * png_nominal_cabin_fan2_rpm * png_nominal_fuel_cell_current ...
    * png_nominal_pressure * png_nominal_ppN2 * png_nominal_H2O;
%}

%% These functions were made in MATLAB to find BayesNet values and solve4c

function n = prob_nothing_given(probOfSubset, probGivenSubset)

    n = 0;
    dim = size(probOfSubset);

    for i = 1:dim(1)
        for j = 1:dim(2)
            n = n + probOfSubset(i,j)*probGivenSubset(i,j);
        end
    end

end

function arr = prob_given_subset2(prob1,prob2,given1,given2,given3,given4)

    arr = [0 given1 0 1-given1;
           1 (given2-prob2)/(1-prob2) (given3-prob1)/(1-prob1) 1-given2-(given3-prob1)/(1-prob1);
           0 0 given4 1-given4];

    %%% This function gives the low, nominal, and high node for the given
    %%% syptom from the top row to the bottom repectively.
    
    %%% Vaules from all columns = 1, a12+a14 = 1, a33+a34 = 1, a11 = a31 =
    %%% a13 = a32 = 0, g2 = a21P(B)+a22P(!B), g3 = a21P(A) + a23P(!A),
    %%% a23+a24 = 1-g2, and a22 + a24 = 1-g3

end

function arr = prob_given_cabin(prob1,prob2,given1,given2,given3,given4)

    A = [prob2 1-prob2 0 0 0 0 0 0;
         0 0 0 0 prob2 1-prob2 0 0;
         prob1 0 1-prob1 0 0 0 0 0;
         0 0 0 0 prob1 0 1-prob1 0;
         1 0 0 0 1 0 0 0;
         0 1 0 0 0 1 0 0;
         0 0 1 0 0 0 1 0;
         0 0 0 1 0 0 0 1];

    B = [given1; given2; given3; given4; 1; 1; 1; 1];

    A2 = A.'*A;

    B2 = A.'*B;

    X = pcg(A2,B2);

    arr = [X(1:4) X(5:8)]';

end

function arr = prob_given_subset3(prob1,prob2,prob3,given1,given2,given3,given4,given5,given6)

    prob_of_subset = prob_of_subset3(prob1,prob2,prob3);
    prob_of_subset = [prob_of_subset;prob_of_subset];

    A = [prob_of_subset(1,1)/prob1 prob_of_subset(1,2)/prob1 prob_of_subset(1,3)/prob1 prob_of_subset(1,4)/prob1 ...
         0 0 0 0 ...
         0 0 0 0 0 0 0 0;
         0 0 0 0 ...
         prob_of_subset(3,1)/prob1 prob_of_subset(3,2)/prob1 prob_of_subset(3,3)/prob1 prob_of_subset(3,4)/prob1 ...
         0 0 0 0 0 0 0 0;
         prob_of_subset(1,1)/prob2 prob_of_subset(1,2)/prob2 0 0 ...
         prob_of_subset(2,1)/prob2 prob_of_subset(2,2)/prob2 0 0 ...
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 ...
         prob_of_subset(3,1)/prob2 prob_of_subset(3,2)/prob2 0 0 ...
         prob_of_subset(4,1)/prob2 prob_of_subset(4,2)/prob2 0 0;
         prob_of_subset(1,1)/prob3 0 prob_of_subset(1,3)/prob3 0 ...
         prob_of_subset(2,1)/prob3 0 prob_of_subset(2,3)/prob3 0 ...
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0 ...
         prob_of_subset(3,1)/prob3 0 prob_of_subset(3,3)/prob3 0 ...
         prob_of_subset(4,1)/prob3 0 prob_of_subset(4,3)/prob3 0;
         1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0;
         0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0;
         0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0;
         0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0;
         0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0;
         0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0;
         0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0;
         0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1;
         0 0 0 0 ...
         prob_of_subset(2,1)/(1-prob1) prob_of_subset(2,2)/(1-prob1) prob_of_subset(2,3)/(1-prob1) prob_of_subset(2,4)/(1-prob1) ...
         0 0 0 0 0 0 0 0;
         0 0 0 0 ...
         prob_of_subset(4,1)/(1-prob1) prob_of_subset(4,2)/(1-prob1) prob_of_subset(4,3)/(1-prob1) prob_of_subset(4,4)/(1-prob1) ...
         0 0 0 0 0 0 0 0];

    B = [given1; given2; given3; given4; given5; given6;
         1; 1; 1; 1; 1; 1; 1; 1; 1-given1; 1-given2];

    A2 = A.'*A;

    B2 = A.'*B;

    X = pcg(A2,B2);

    arr = [X(1:4) X(5:8) X(9:12) X(13:16)]';
    
end

function arr = prob_given_subset4(prob1,prob2,prob3,prob4,given1,given2,given3,given4,given5,given6,given7,given8)
    
    pos = prob_of_subset4(prob1,prob2,prob3,prob4);
    pos = [pos;pos];

    A1 = [pos(1,1)/prob1 pos(1,2)/prob1 pos(1,3)/prob1 pos(1,4)/prob1 ...
          pos(2,1)/prob1 pos(2,2)/prob1 pos(2,3)/prob1 pos(2,4)/prob1 ...
          0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0];

    A2 = [0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0 ...
          pos(5,1)/prob1 pos(5,2)/prob1 pos(5,3)/prob1 pos(5,4)/prob1 ...
          pos(6,1)/prob1 pos(6,2)/prob1 pos(6,3)/prob1 pos(6,4)/prob1 ...
          0 0 0 0 0 0 0 0];

    A3 = [pos(1,1)/prob2 pos(1,2)/prob2 pos(1,3)/prob2 pos(1,4)/prob2 0 0 0 0 ...
          pos(3,1)/prob2 pos(3,2)/prob2 pos(3,3)/prob2 pos(3,4)/prob2 0 0 0 0 ...
          0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0];

    A4 = [0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0 ...
          pos(5,1)/prob2 pos(5,2)/prob2 pos(5,3)/prob2 pos(5,4)/prob2 0 0 0 0 ...
          pos(7,1)/prob2 pos(7,2)/prob2 pos(7,3)/prob2 pos(7,4)/prob2 0 0 0 0];

    A5 = [pos(1,1)/prob3 pos(1,2)/prob3 0 0 pos(2,1)/prob3 pos(2,2)/prob3 0 0 ...
          pos(3,1)/prob3 pos(3,2)/prob3 0 0 pos(4,1)/prob3 pos(4,2)/prob3 0 0 ...
          0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0];

    A6 = [0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0 ...
          pos(5,1)/prob3 pos(5,2)/prob3 0 0 pos(6,1)/prob3 pos(6,2)/prob3 0 0 ...
          pos(7,1)/prob3 pos(7,2)/prob3 0 0 pos(8,1)/prob3 pos(8,2)/prob3 0 0];

    A7 = [pos(1,1)/prob4 0 pos(1,3)/prob4 0 pos(2,1)/prob4 0 pos(2,3)/prob4 0 ...
          pos(3,1)/prob4 0 pos(3,3)/prob4 0 pos(4,1)/prob4 0 pos(4,3)/prob4 0 ...
          0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0];

    A8 = [0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0 ...
          pos(5,1)/prob4 0 pos(5,3)/prob4 0 pos(6,1)/prob4 0 pos(6,3)/prob4 0 ...
          pos(7,1)/prob4 0 pos(7,3)/prob4 0 pos(8,1)/prob4 0 pos(8,3)/prob4 0];

    A9 = [0 0 0 0 0 0 0 0 ...
          pos(3,1)/(1-prob1) pos(3,2)/(1-prob1) pos(3,3)/(1-prob1) pos(3,4)/(1-prob1) ...
          pos(4,1)/(1-prob1) pos(4,2)/(1-prob1) pos(4,3)/(1-prob1) pos(4,4)/(1-prob1) ...
          0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0];

    A10 = [0 0 0 0 0 0 0 0 ...
           0 0 0 0 0 0 0 0 ...
           0 0 0 0 0 0 0 0 ...
           pos(7,1)/(1-prob1) pos(7,2)/(1-prob1) pos(7,3)/(1-prob1) pos(7,4)/(1-prob1) ...
           pos(8,1)/(1-prob1) pos(8,2)/(1-prob1) pos(8,3)/(1-prob1) pos(8,4)/(1-prob1)];

    A11 = [0 0 0 0 pos(2,1)/(1-prob2) pos(2,2)/(1-prob2) pos(2,3)/(1-prob2) pos(2,4)/(1-prob2) ...
           0 0 0 0 pos(4,1)/(1-prob2) pos(4,2)/(1-prob2) pos(4,3)/(1-prob2) pos(4,4)/(1-prob2) ...
           0 0 0 0 0 0 0 0 ...
           0 0 0 0 0 0 0 0];

    A12 = [0 0 0 0 0 0 0 0 ...
           0 0 0 0 0 0 0 0 ...
           0 0 0 0 pos(6,1)/(1-prob2) pos(6,2)/(1-prob2) pos(6,3)/(1-prob2) pos(6,4)/(1-prob2) ...
           0 0 0 0 pos(8,1)/(1-prob2) pos(8,2)/(1-prob2) pos(8,3)/(1-prob2) pos(8,4)/(1-prob2)];

    A13 = [0 0 pos(1,3)/(1-prob3) pos(1,4)/(1-prob3) 0 0 pos(2,3)/(1-prob3) pos(2,4)/(1-prob3) ...
           0 0 pos(3,3)/(1-prob3) pos(3,4)/(1-prob3) 0 0 pos(4,3)/(1-prob3) pos(4,4)/(1-prob3) ...
           0 0 0 0 0 0 0 0 ...
           0 0 0 0 0 0 0 0];

    A14 = [0 0 0 0 0 0 0 0 ...
           0 0 0 0 0 0 0 0 ...
           0 0 pos(5,3)/(1-prob3) pos(5,4)/(1-prob3) 0 0 pos(6,3)/(1-prob3) pos(6,4)/(1-prob3) ...
           0 0 pos(7,3)/(1-prob3) pos(7,4)/(1-prob3) 0 0 pos(8,3)/(1-prob3) pos(8,4)/(1-prob3)];

    A15 = [0 pos(1,2)/(1-prob4) 0 pos(1,4)/(1-prob4) 0 pos(2,2)/(1-prob4) 0 pos(2,4)/(1-prob4) ...
           0 pos(3,2)/(1-prob4) 0 pos(3,4)/(1-prob4) 0 pos(4,2)/(1-prob4) 0 pos(4,4)/(1-prob4) ...
           0 0 0 0 0 0 0 0 ...
           0 0 0 0 0 0 0 0];

    A16 = [0 0 0 0 0 0 0 0 ...
           0 0 0 0 0 0 0 0 ...
           0 pos(5,2)/(1-prob4) 0 pos(5,4)/(1-prob4) 0 pos(6,2)/(1-prob4) 0 pos(6,4)/(1-prob4) ...
           0 pos(7,2)/(1-prob4) 0 pos(7,4)/(1-prob4) 0 pos(8,2)/(1-prob4) 0 pos(8,4)/(1-prob4)];

    A17 = zeros(16,32);

    for i = 1:16
        A17(i,i+16) = 1;
    end

    A = [A1; A2; A3; A4; A5; A6; A7; A8;
         A9; A10; A11; A12; A13; A14; A15; A16;
         A17];

    B = [given1;given2;given3;given4;given5;given6;given7;given8;
         1-given1;1-given2;1-given3;1-given4;1-given5;1-given6;1-given7;1-given8;
         1;1;1;1;1;1;1;1;
         1;1;1;1;1;1;1;1];

    AZ = A.'*A;

    BZ = A.'*B;

    X = pcg(AZ,BZ);

    arr = [X(1:4) X(5:8) X(9:12) X(13:16) X(17:20) X(21:24) X(25:28) X(29:32)]';

end

%{
function arr = prob_given_subset5(p1,p2,p3,p4,p5,given1,given2,given3,given4,given5,given6,given7,given8,given9,given10)
    
    % Couldn't get this to work, Used a simpler but incorrect method to
    % have some numerical values to show
    pos = prob_of_subset5(p1,p2,p3,p4,p5);
    pos = [pos;pos];

    syms a11 a12 a13 a14 a21 a22 a23 a24 ...
         a31 a32 a33 a34 a41 a42 a43 a44 ...
         a51 a52 a53 a54 a61 a62 a63 a64 ...
         a71 a72 a73 a74 a81 a82 a83 a84 ...
         a91 a92 a93 a94 a101 a102 a103 a104 ...
         a111 a112 a113 a114 a121 a122 a123 a124 ...
         a131 a132 a133 a134 a141 a142 a143 a144 ...
         a151 a152 a153 a154 a161 a162 a163 a164

    eqn1 = a11 + a91 == 1;
    eqn2 = a12 + a92 == 1;
    eqn3 = a13 + a93 == 1;
    eqn4 = a14 + a94 == 1;
    eqn5 = a21 + a101 == 1;
    eqn6 = a22 + a102 == 1;
    eqn7 = a23 + a103 == 1;
    eqn8 = a24 + a104 == 1;

    eqn9 = a31 + a111 == 1;
    eqn10 = a32 + a112 == 1;
    eqn11 = a33 + a113 == 1;
    eqn12 = a34 + a114 == 1;
    eqn13 = a41 + a121 == 1;
    eqn14 = a42 + a122 == 1;
    eqn15 = a43 + a123 == 1;
    eqn16 = a44 + a124 == 1;

    eqn17 = a51 + a131 == 1;
    eqn18 = a52 + a132 == 1;
    eqn19 = a53 + a133 == 1;
    eqn20 = a54 + a134 == 1;
    eqn21 = a61 + a141 == 1;
    eqn22 = a62 + a142 == 1;
    eqn23 = a63 + a143 == 1;
    eqn24 = a64 + a144 == 1;

    eqn25 = a71 + a151 == 1;
    eqn26 = a72 + a152 == 1;
    eqn27 = a73 + a153 == 1;
    eqn28 = a74 + a154 == 1;
    eqn29 = a81 + a161 == 1;
    eqn30 = a82 + a162 == 1;
    eqn31 = a83 + a163 == 1;
    eqn32 = a84 + a164 == 1;

    eqn33 = a11*pos(1,1)/p1+a12*pos(1,2)/p1+a13*pos(1,3)/p1*a14*pos(1,4)/p1 + ...
            a21*pos(2,1)/p1+a22*pos(2,2)/p1+a23*pos(2,3)/p1*a24*pos(2,4)/p1 + ...
            a31*pos(3,1)/p1+a32*pos(3,2)/p1+a33*pos(3,3)/p1*a34*pos(3,4)/p1 + ...
            a41*pos(4,1)/p1+a42*pos(4,2)/p1+a43*pos(4,3)/p1*a44*pos(4,4)/p1 == given1;

    eqn34 = a11*pos(1,1)/p2+a12*pos(1,2)/p2+a13*pos(1,3)/p2*a14*pos(1,4)/p2 + ...
            a21*pos(2,1)/p2+a22*pos(2,2)/p2+a23*pos(2,3)/p2*a24*pos(2,4)/p2 + ...
            a51*pos(5,1)/p2+a52*pos(5,2)/p2+a53*pos(5,3)/p2*a34*pos(5,4)/p2 + ...
            a61*pos(6,1)/p2+a62*pos(6,2)/p2+a63*pos(6,3)/p2*a44*pos(6,4)/p2 == given3;

    eqn35 = a11*pos(1,1)/p3+a12*pos(1,2)/p3+a13*pos(1,3)/p3*a14*pos(1,4)/p3 + ...
            a31*pos(3,1)/p3+a32*pos(3,2)/p3+a33*pos(3,3)/p3*a34*pos(3,4)/p3 + ...
            a51*pos(5,1)/p3+a52*pos(5,2)/p3+a53*pos(5,3)/p3*a54*pos(5,4)/p3 + ...
            a71*pos(7,1)/p3+a72*pos(7,2)/p3+a73*pos(7,3)/p3*a74*pos(7,4)/p3 == given5;

    eqn36 = a11*pos(1,1)/p4+a12*pos(1,2)/p4+a21*pos(2,1)/p4*a22*pos(2,2)/p4 + ...
            a31*pos(3,1)/p4+a32*pos(3,2)/p4+a41*pos(4,1)/p4*a42*pos(4,2)/p4 + ...
            a51*pos(5,1)/p4+a52*pos(5,2)/p4+a61*pos(6,1)/p4*a62*pos(6,2)/p4 + ...
            a71*pos(7,1)/p4+a72*pos(7,2)/p4+a81*pos(8,1)/p4*a82*pos(8,2)/p4 == given7;

    eqn37 = a11*pos(1,1)/p5+a13*pos(1,3)/p5+a21*pos(2,1)/p5*a23*pos(2,3)/p5 + ...
            a31*pos(3,1)/p5+a33*pos(3,3)/p5+a41*pos(4,1)/p5*a24*pos(4,3)/p5 + ...
            a51*pos(5,1)/p5+a53*pos(5,3)/p5+a61*pos(6,1)/p5*a63*pos(6,3)/p5 + ...
            a71*pos(7,1)/p5+a73*pos(7,3)/p5+a81*pos(8,1)/p5*a84*pos(8,3)/p5 == given9;

    eqn38 = a91*pos(9,1)/p1+a92*pos(9,2)/p1+a93*pos(9,3)/p1*a94*pos(9,4)/p1 + ...
            a101*pos(10,1)/p1+a102*pos(10,2)/p1+a103*pos(10,3)/p1*a104*pos(10,4)/p1 + ...
            a111*pos(11,1)/p1+a112*pos(11,2)/p1+a113*pos(11,3)/p1*a114*pos(11,4)/p1 + ...
            a121*pos(12,1)/p1+a122*pos(12,2)/p1+a123*pos(12,3)/p1*a124*pos(12,4)/p1 == given2;

    eqn39 = a91*pos(9,1)/p2+a92*pos(9,2)/p2+a93*pos(9,3)/p2*a94*pos(9,4)/p2 + ...
            a101*pos(10,1)/p2+a102*pos(10,2)/p2+a103*pos(10,3)/p2*a104*pos(10,4)/p2 + ...
            a131*pos(13,1)/p2+a132*pos(13,2)/p2+a133*pos(13,3)/p2*a134*pos(13,4)/p2 + ...
            a141*pos(14,1)/p2+a142*pos(14,2)/p2+a143*pos(14,3)/p2*a144*pos(14,4)/p2 == given4;

    eqn40 = a91*pos(9,1)/p3+a92*pos(9,2)/p3+a93*pos(9,3)/p3*a94*pos(9,4)/p3 + ...
            a111*pos(11,1)/p3+a112*pos(11,2)/p3+a113*pos(11,3)/p3*a114*pos(11,4)/p3 + ...
            a131*pos(13,1)/p3+a132*pos(13,2)/p3+a133*pos(13,3)/p3*a134*pos(13,4)/p3 + ...
            a151*pos(15,1)/p3+a152*pos(15,2)/p3+a153*pos(15,3)/p3*a154*pos(15,4)/p3 == given6;

    eqn41 = a91*pos(9,1)/p4+a92*pos(9,2)/p4+a101*pos(10,1)/p4*a102*pos(10,2)/p4 + ...
            a111*pos(11,1)/p4+a112*pos(11,2)/p4+a121*pos(12,1)/p4*a122*pos(12,2)/p4 + ...
            a131*pos(13,1)/p4+a132*pos(13,2)/p4+a141*pos(14,1)/p4*a142*pos(14,2)/p4 + ...
            a151*pos(15,1)/p4+a152*pos(15,2)/p4+a161*pos(16,1)/p4*a162*pos(16,2)/p4 == given8;

    eqn42 = a91*pos(9,1)/p5+a93*pos(9,3)/p5+a101*pos(10,1)/p5*a103*pos(10,3)/p5 + ...
            a111*pos(11,1)/p5+a113*pos(11,3)/p5+a121*pos(12,1)/p5*a123*pos(12,3)/p5 + ...
            a131*pos(13,1)/p5+a133*pos(13,3)/p5+a141*pos(14,1)/p5*a143*pos(14,3)/p5 + ...
            a151*pos(15,1)/p5+a153*pos(15,3)/p5+a161*pos(16,1)/p5*a163*pos(16,3)/p5 == given10;

    eqn43 = a51*pos(5,1)/(1-p1)+a52*pos(5,2)/(1-p1)+a53*pos(5,3)/(1-p1)+a54*pos(5,4)/(1-p1) + ...
            a61*pos(6,1)/(1-p1)+a62*pos(6,2)/(1-p1)+a63*pos(6,3)/(1-p1)+a64*pos(6,4)/(1-p1) + ...
            a71*pos(7,1)/(1-p1)+a72*pos(7,2)/(1-p1)+a73*pos(7,3)/(1-p1)+a74*pos(7,4)/(1-p1) + ...
            a81*pos(8,1)/(1-p1)+a82*pos(8,2)/(1-p1)+a83*pos(8,3)/(1-p1)+a84*pos(8,4)/(1-p1) == 1-given1;

    eqn44 = a31*pos(3,1)/(1-p2)+a32*pos(3,2)/(1-p2)+a33*pos(3,3)/(1-p2)+a34*pos(3,4)/(1-p2) + ...
            a41*pos(4,1)/(1-p2)+a42*pos(4,2)/(1-p2)+a43*pos(4,3)/(1-p2)+a44*pos(4,4)/(1-p2) + ...
            a71*pos(7,1)/(1-p2)+a72*pos(7,2)/(1-p2)+a73*pos(7,3)/(1-p2)+a74*pos(7,4)/(1-p2) + ...
            a81*pos(8,1)/(1-p2)+a82*pos(8,2)/(1-p2)+a83*pos(8,3)/(1-p2)+a84*pos(8,4)/(1-p2) == 1-given3;

    eqn45 = a21*pos(2,1)/(1-p3)+a22*pos(2,2)/(1-p3)+a23*pos(2,3)/(1-p3)+a24*pos(2,4)/(1-p3) + ...
            a41*pos(4,1)/(1-p3)+a42*pos(4,2)/(1-p3)+a43*pos(4,3)/(1-p3)+a44*pos(4,4)/(1-p3) + ...
            a61*pos(6,1)/(1-p3)+a62*pos(6,2)/(1-p3)+a63*pos(6,3)/(1-p3)+a64*pos(6,4)/(1-p3) + ...
            a81*pos(8,1)/(1-p3)+a82*pos(8,2)/(1-p3)+a83*pos(8,3)/(1-p3)+a84*pos(8,4)/(1-p3) == 1-given5;

    eqn46 = a13*pos(1,3)/(1-p4)+a14*pos(1,4)/(1-p4)+a23*pos(2,3)/(1-p4)+a24*pos(2,4)/(1-p4) + ...
            a33*pos(3,3)/(1-p4)+a34*pos(3,4)/(1-p4)+a43*pos(4,3)/(1-p4)+a44*pos(4,4)/(1-p4) + ...
            a53*pos(5,3)/(1-p4)+a54*pos(5,4)/(1-p4)+a63*pos(6,3)/(1-p4)+a64*pos(6,4)/(1-p4) + ...
            a73*pos(7,3)/(1-p4)+a74*pos(7,4)/(1-p4)+a83*pos(8,3)/(1-p4)+a84*pos(8,4)/(1-p4) == 1-given7;

    eqn47 = a12*pos(1,2)/(1-p5)+a14*pos(1,4)/(1-p5)+a22*pos(2,2)/(1-p5)+a24*pos(2,4)/(1-p5) + ...
            a32*pos(3,2)/(1-p5)+a34*pos(3,4)/(1-p5)+a42*pos(4,2)/(1-p5)+a44*pos(4,4)/(1-p5) + ...
            a52*pos(5,2)/(1-p5)+a54*pos(5,4)/(1-p5)+a62*pos(6,2)/(1-p5)+a64*pos(6,4)/(1-p5) + ...
            a72*pos(7,2)/(1-p5)+a74*pos(7,4)/(1-p5)+a82*pos(8,2)/(1-p5)+a84*pos(8,4)/(1-p5) == 1-given9;

    eqn48 = a131*pos(13,1)/(1-p1)+a132*pos(13,2)/(1-p1)+a133*pos(13,3)/(1-p1)+a134*pos(13,4)/(1-p1) + ...
            a141*pos(14,1)/(1-p1)+a142*pos(14,2)/(1-p1)+a143*pos(14,3)/(1-p1)+a144*pos(14,4)/(1-p1) + ...
            a151*pos(15,1)/(1-p1)+a152*pos(15,2)/(1-p1)+a153*pos(15,3)/(1-p1)+a154*pos(15,4)/(1-p1) + ...
            a161*pos(16,1)/(1-p1)+a162*pos(16,2)/(1-p1)+a163*pos(16,3)/(1-p1)+a164*pos(16,4)/(1-p1) == 1-given2;

    eqn49 = a111*pos(11,1)/(1-p2)+a112*pos(11,2)/(1-p2)+a113*pos(11,3)/(1-p2)+a114*pos(11,4)/(1-p2) + ...
            a121*pos(12,1)/(1-p2)+a122*pos(12,2)/(1-p2)+a123*pos(12,3)/(1-p2)+a124*pos(12,4)/(1-p2) + ...
            a151*pos(15,1)/(1-p2)+a152*pos(15,2)/(1-p2)+a153*pos(15,3)/(1-p2)+a154*pos(15,4)/(1-p2) + ...
            a161*pos(16,1)/(1-p2)+a162*pos(16,2)/(1-p2)+a163*pos(16,3)/(1-p2)+a164*pos(16,4)/(1-p2) == 1-given4;

    eqn50 = a101*pos(10,1)/(1-p3)+a102*pos(10,2)/(1-p3)+a103*pos(10,3)/(1-p3)+a104*pos(10,4)/(1-p3) + ...
            a121*pos(12,1)/(1-p3)+a122*pos(12,2)/(1-p3)+a123*pos(12,3)/(1-p3)+a124*pos(12,4)/(1-p3) + ...
            a141*pos(14,1)/(1-p3)+a142*pos(14,2)/(1-p3)+a143*pos(14,3)/(1-p3)+a144*pos(14,4)/(1-p3) + ...
            a161*pos(16,1)/(1-p3)+a162*pos(16,2)/(1-p3)+a163*pos(16,3)/(1-p3)+a164*pos(16,4)/(1-p3) == 1-given6;

    eqn51 = a93*pos(9,3)/(1-p4)+a94*pos(9,4)/(1-p4)+a103*pos(10,3)/(1-p4)+a104*pos(10,4)/(1-p4) + ...
            a113*pos(11,3)/(1-p4)+a114*pos(11,4)/(1-p4)+a123*pos(12,3)/(1-p4)+a124*pos(12,4)/(1-p4) + ...
            a133*pos(13,3)/(1-p4)+a134*pos(13,4)/(1-p4)+a143*pos(14,3)/(1-p4)+a144*pos(14,4)/(1-p4) + ...
            a153*pos(15,3)/(1-p4)+a154*pos(15,4)/(1-p4)+a163*pos(16,3)/(1-p4)+a164*pos(16,4)/(1-p4) == 1-given8;

    eqn52 = a92*pos(9,2)/(1-p5)+a94*pos(9,4)/(1-p5)+a102*pos(10,2)/(1-p5)+a104*pos(10,4)/(1-p5) + ...
            a112*pos(11,2)/(1-p5)+a114*pos(11,4)/(1-p5)+a122*pos(12,2)/(1-p5)+a124*pos(12,4)/(1-p5) + ...
            a132*pos(13,2)/(1-p5)+a134*pos(13,4)/(1-p5)+a142*pos(14,2)/(1-p5)+a144*pos(14,4)/(1-p5) + ...
            a152*pos(15,2)/(1-p5)+a154*pos(15,4)/(1-p5)+a162*pos(16,2)/(1-p5)+a164*pos(16,4)/(1-p5) == 1-given10;

    eqn53 = a81 == a82 + (1-a82)*a83;

    eqn54 = a161 == a162 + (1-a162)*a163;

    eqn55 = a73 == a74 + (1-a74)*a83;
    
    eqn56 = a153 == a154 + (1-a154*163);

    eqn57 = a72 == a74 + (1-a74)*a82;

    eqn58 = a152 == a154 + (1-a154)*a162;

    eqn59 = a71 == (a74+(1-a74)*a82) + (1-(a74+(1-a74)*a82))*a83;

    eqn60 = a151 == (a154+(1-a154)*a162) + (1-(a154+(1-a154)*a162))*a163;;

    eqn61 = a63 == a64 + (1-a64)*a83;

    eqn62 = a143 == a144 + (1-a144)*a163;

    eqn63 = a63 == a64 + (1-a64)*a82;

    eqn64 = a143 == a144 + (1-a144)*a162;

    [solvea11,solvea12,solve13,solvea14,solvea21,solvea22,solvea23,solvea24 ...
     solvea31,solvea32,solve33,solvea34,solvea41,solvea42,solvea43,solvea44 ...
     solvea51,solvea52,solve53,solvea54,solvea61,solvea62,solvea63,solvea64 ...
     solvea71,solvea72,solve73,solvea74,solvea81,solvea82,solvea83,solvea84 ...
     solvea91,solvea92,solve93,solvea94,solvea101,solvea102,solvea103,solvea104 ...
     solvea111,solvea112,solve113,solvea114,solvea121,solvea122,solvea123,solvea124 ...
     solvea131,solvea132,solve133,solvea134,solvea141,solvea142,solvea143,solvea144 ...
     solvea151,solvea152,solve153,solvea134,solvea161,solvea162,solvea163,solvea164] = solve(eqn1, ...
     eqn2,eqn3,eqn4,eqn5,eqn6,eqn7,eqn8,eqn9,eqn10,eqn11,eqn12,eqn13,eqn14,eqn15, ...
     eqn16,eqn17,eqn18,eqn19,eqn20,eqn21,eqn22,eqn23,eqn24,eqn25,eqn26,eqn27,eqn28,eqn29,eqn30, ...
     eqn31,eqn32,eqn33,eqn34,eqn35,eqn36,eqn37,eqn38,eqn39,eqn40,eqn41,eqn42,eqn43,eqn44,eqn45, ...
     eqn46,eqn47,eqn48,eqn49,eqn50,eqn51,eqn52,eqn53,eqn54,eqn55,eqn56,eqn57,eqn58,eqn59,eqn60, ...
     eqn61,eqn62,eqn63,eqn64)

    arr = [solvea11,solvea12,solve13,solvea14,solvea21,solvea22,solvea23,solvea24 ...
     solvea31,solvea32,solve33,solvea34,solvea41,solvea42,solvea43,solvea44 ...
     solvea51,solvea52,solve53,solvea54,solvea61,solvea62,solvea63,solvea64 ...
     solvea71,solvea72,solve73,solvea74,solvea81,solvea82,solvea83,solvea84 ...
     solvea91,solvea92,solve93,solvea94,solvea101,solvea102,solvea103,solvea104 ...
     solvea111,solvea112,solve113,solvea114,solvea121,solvea122,solvea123,solvea124 ...
     solvea131,solvea132,solve133,solvea134,solvea141,solvea142,solvea143,solvea144 ...
     solvea151,solvea152,solve153,solvea134,solvea161,solvea162,solvea163,solvea164];

end
%}

function arr = prob5(n1, n2, n3, n4, n5)
    
    % This function is incorrect. I made it intially under the assumption
    % that P(A|B) = P(A|B,C=0) rather than P(A|B) = P(A|B,C)P(C) +
    % P(A|B,C=0)P(C=0). I used it to have some numerical values to run the
    % rest of the code
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

function arr = prob_of_subset2(n1,n2)

    arr = zeros(1,4);

    for i = 1:2
        for j = 1:2
            if j == 1
                prob2 = n2;
            else
                prob2 = 1-n2; % i.e. probability of not n2
            end
            if i == 1
                arr(i,j) = n1*prob2;
            else
                arr(i-floor(i/2),j+2) = (1-n1)*prob2;
            end
        end
    end

end

function arr = prob_of_subset3(n1,n2,n3)

    arr = zeros(2,4);

    for i = 1:2
        for j = 1:2
            for k = 1:2
                if i == 1 
                    prob1 = n1;
                else 
                    prob1 = 1-n1;
                end
                if j == 1 
                    prob2 = n2;
                else 
                    prob2 = 1-n2;
                end
                if k == 1 
                    prob3 = n3;
                else 
                    prob3 = 1-n3;
                end
                arr(i,2*(j-1)+k) = prob1*prob2*prob3;
            end
        end
    end

end

function arr = prob_of_subset4(n1,n2,n3,n4)

    arr = zeros(4);

    for i = 1:2
        for j =1:2
            for k = 1:2
                for l = 1:2
                    if i == 1
                        prob1 = n1;
                    else
                        prob1 = 1-n1;
                    end
                    if j == 1
                        prob2 = n2;
                    else
                        prob2 = 1-n2;
                    end
                    if k == 1
                        prob3 = n3;
                    else
                        prob3 = 1-n3;
                    end
                    if l == 1
                        prob4 = n4;
                    else
                        prob4 = 1-n4;
                    end
                    arr(j+2*floor(i/2), 2*(k-1)+l) = prob1*prob2*prob3*prob4;
                end
            end
        end
    end

end

function arr = prob_of_subset5(n1,n2,n3,n4,n5)

    arr = zeros(8,4); 

    for i = 1:2
        for j = 1:2
            for k =1:2
                for l = 1:2
                    for m = 1:2
                        if i == 1
                            prob1 = n1;
                        else
                            prob1 = 1-n1;
                        end
                        if j == 1
                            prob2 = n2;
                        else
                            prob2 = 1-n2;
                        end
                        if k == 1
                            prob3 = n3;
                        else
                            prob3 = 1-n3;
                        end
                        if l == 1
                            prob4 = n4;
                        else
                            prob4 = 1-n4;
                        end
                        if m == 1
                            prob5 = n5;
                        else
                            prob5 = 1-n5;
                        end
                        arr(k+2*floor(j/2)+4*floor(i/2), 2*(l-1)+m) = prob1*prob2*prob3*prob4*prob5;
                    end
                end
            end
        end
    end
    
end