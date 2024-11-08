%Problem 14
syms x y

L1 = 20;
L2 = 10;
h = 0.5;
b = 0.4;
E = 10.^7;
alpha = 13*10.^(-6);
deltaT = -400*y/h;
P = 200;
f11 = 10;
f12 = 10;
f21 = 0;
f22 = 10;
I = b*h.^3/12;

L = L1; %finding matrices for first element
f1 = f11;
f2 = f12;

K1 = E*I/L.*[12/L.^2 6/L -12/L.^2 6/L;...
            6/L 4 -6/L 2;...
            -12/L.^2 -6/L 12/L.^2 -6/L;...
            6/L 2 -6/L 4];

Feq1 = [L*(7*f1+3*f2)/20;...
        L.^2*(3*f1+2*f2)/60;...
        L*(3*f1+7*f2)/20;...
        -L.^2*(2*f1+3*f2)/60];

Fbc1 = [0;...
        0;...
        P;...
        0];

d2Ni1 = [-6/L.^2+12*x/L.^3;...
         -4/L+6*x/L.^2;...
         6/L.^2-12*x/L.^3;...
         -2/L+6*x/L.^2];
fThermal = b*E*alpha*deltaT*y;
Ft1 = -int(int(fThermal.*d2Ni1,y,-h/2,h/2),x,0,L);

L = L2; %finding matrices for second element
f1 = f21;
f2 = f22;

K2 = E*I/L.*[12/L.^2 6/L -12/L.^2 6/L;...
            6/L 4 -6/L 2;...
            -12/L.^2 -6/L 12/L.^2 -6/L;...
            6/L 2 -6/L 4];

Feq2 = [L*(7*f1+3*f2)/20;...
        L.^2*(3*f1+2*f2)/60;...
        L*(3*f1+7*f2)/20;...
        -L.^2*(2*f1+3*f2)/60];

Fbc2 = [P;...
        0;...
        0;...
        0];

d2Ni2 = [-6/L.^2+12*x/L.^3;...
         -4/L+6*x/L.^2;...
         6/L.^2-12*x/L.^3;...
         -2/L+6*x/L.^2];
Ft2 = -int(int(fThermal.*d2Ni2,y,-h/2,h/2),x,0,L);

%find global matrices and q matrix, kin. constraints, conitinuity, and
%equilibrium already imposed

K = [K1(3,3)+K2(1,1) K1(3,4)+K2(1,2);...
     K1(4,3)+K2(2,1) K1(4,4)+K2(2,2)];
Feq = [Feq1(3)+Feq2(1); Feq1(4)+Feq2(2)];
Fbc  = [Fbc1(3)+Fbc2(1); Fbc1(4)+Fbc2(2)];
Ft = [Ft1(3)+Ft2(1); Ft1(4)+Ft2(2)];
q = K\(Feq+Fbc+Ft);
q5 = q(1);
q6 = q(2);

%solving for a b c d e f
A = [400 8000 160000 3200000;...
     40 1200 32000 800000;...
     900 27000 810000 24300000;...
     60 2700 108000 4050000];
B = [q5;q6;0;0];
a = A\B;
c = vpa(a(1));
d = vpa(a(2));
e = vpa(a(3));
f = vpa(a(4));

%making the plots

vx = @(x) c*x.^2 + d*x.^3 + e*x.^4 + f*x.^5;
x = 0:30;
figure
plot(x,vx(x))
hold on
title('Transverse Displacement vs Location for Problem 14')
xlabel('Location (inches)')
ylabel('Displacement (inches)')
hold off

Mx = @(x) E*I*(2*c + 6*d*x + 12*e*x.^2 + 20*f*x.^3) - int(b*E*alpha*deltaT*y,y,-h/2,h/2);
figure
plot(x,Mx(x))
hold on
title('Internal Moment vs Location for Problem 14')
xlabel('Location (inches)')
ylabel('Internal Moment (pounds*inch)')
hold off

Vx = @(x) E*I*(6*d + 24*e*x + 60*f*x.^2);
figure
plot(x,Vx(x))
hold on
title('Internal Shear vs Location for Problem 14')
xlabel('Location (inches)')
ylabel('Internal Shear (pounds)')
hold off

%Problem 17
syms x

L1 = 5;
L2 = 5;
h = 2;
b = 1;
alpha = 10.^(-5);
deltaT = 200*y/h;
P = 100;
I = b*h.^3/12;

L = L1; %finding matrices and for first element

K1 = E*I/L.*[12/L.^2 6/L -12/L.^2 6/L;...
            6/L 4 -6/L 2;...
            -12/L.^2 -6/L 12/L.^2 -6/L;...
            6/L 2 -6/L 4];

Fbc1 = [0;...
        0;...
        0;...
        0];

d2Ni1 = [-6/L.^2+12*x/L.^3;...
         -4/L+6*x/L.^2;...
         6/L.^2-12*x/L.^3;...
         -2/L+6*x/L.^2];
fThermal = b*E*alpha*deltaT*y;
Ft1 = -int(int(fThermal.*d2Ni1,y,-h/2,h/2),x,0,L);

L = L2; %finding matrices for second element, 
        % *Note: the matrices are the same for element 2 as element 1
        % except for Fbc1 and Fbc2

K2 = E*I/L.*[12/L.^2 6/L -12/L.^2 6/L;...
            6/L 4 -6/L 2;...
            -12/L.^2 -6/L 12/L.^2 -6/L;...
            6/L 2 -6/L 4];

Fbc2 = [0;...
        0;...
        -100;...
        0];

d2Ni2 = [-6/L.^2+12*x/L.^3;...
         -4/L+6*x/L.^2;...
         6/L.^2-12*x/L.^3;...
         -2/L+6*x/L.^2];
Ft2 = -int(int(fThermal.*d2Ni2,y,-h/2,h/2),x,0,L);

%find global matrices and q matrix, kin. constraints, conitinuity, and
%equilibrium already imposed

K = [K1(3,3)+K2(1,1) K1(3,4)+K2(1,2) K2(1,3) K2(1,4);...
     K1(4,3)+K2(2,1) K1(4,4)+K2(2,2) K2(2,3) K2(2,4);...
     K2(3,1) K2(3,2) K2(3,3) K2(4,4);...
     K2(4,1) K2(4,2) K2(4,3) K2(4,4);];
Fbc = [0;0;0;0];
Fbc = [Fbc1(3)+Fbc2(1); Fbc1(4)+Fbc2(2); Fbc2(3); Fbc(4)];
        %Ft = [0;0;0;0]; % *Note: Ft doesn't need to be resized like Fbc
        %for some reason
Ft = [Ft1(3)+Ft2(1); Ft1(4)+Ft2(2); Ft2(3); Ft2(4)];

q = K\(Fbc+Ft);
q1 = q(1);
q2 = q(2);
q5 = q(3);
q6 = q(4);

%solving for a b c d e f
A = [25 125 625 3125;...
     10 75 500 3125;...
     100 1000 10000 100000;...
     20 300 4000 50000];
B = [q1;q2;q5;q6];
a = A\B;
c = vpa(a(1));
d = vpa(a(2));
e = vpa(a(3));
f = vpa(a(4));

%making the plots

vx = @(x) c*x.^2 + d*x.^3 + e*x.^4 + f*x.^5;
x = 0:10;
figure
plot(x,vx(x))
hold on
title('Transverse Displacement vs Location for Problem 17')
xlabel('Location (inches)')
ylabel('Displacement (inches)')
hold off

Mx = @(x) E*I*(2*c + 6*d*x + 12*e*x.^2 + 20*f*x.^3) - int(b*E*alpha*deltaT*y,y,-h/2,h/2);
figure
plot(x,Mx(x))
hold on
title('Internal Moment vs Location for Problem 17')
xlabel('Location (inches)')
ylabel('Internal Moment (pounds*inch)')
hold off

Vx = @(x) E*I*(6*d + 24*e*x + 60*f*x.^2);
figure
plot(x,Vx(x))
hold on
title('Internal Shear vs Location for Problem 17')
xlabel('Location (inches)')
ylabel('Internal Shear (pounds)')
hold off