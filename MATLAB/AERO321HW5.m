% Problem 1

syms a r phi

Cyb = -0.59;
Clb = -0.13;
Cnb = 0.12;
Cya = 0;
Cla = 0.156;
Cna = -0.012;
Cyr = 0.144;
Clr = .0087;
Cnr = -0.15;

Cllevel = Clb*b + Clr*r;
b = 5 *pi/180;

A = [;...
     ;...
     ];
B = [-Cyb*b; -Clb*b; -Cnb*b];

x = A\B;