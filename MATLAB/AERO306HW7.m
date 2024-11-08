% Problem 5

% K = [5 -119 296 62 -744 456;...
%       -119 3125 104 -644 357 204;...     
%       296 104 125 -500 -350 287;...
%       62 -644 -500 10125 420 -600;...
%       -744 357 -350 420 3645 117;...
%       456 204 287 -600 117 1620];
% 
% Feq  = [10; 4; 2; 8; 26; 8];
% 
% q = [0; 0; 0; 1; 0; 1];
% 
% Fint = K*q-Feq;

% Problem 7

syms theta L
b = 1.5;
A = 1.5.^2;
E = 10.^7;
I = b.^4/12;
theta1 = atan(100/100);
theta2 = pi-atan(100/300);
L1 = sqrt(100.^2+100.^2);
L2 = sqrt(300.^2+100.^2);

K = (E/L).*[cos(theta).^2*A+12*sin(theta).^2*I/L.^2, cos(theta)*sin(theta)*A-12*sin(theta)*I*cos(theta)/L.^2....
            , -6*sin(theta)*I/L, -cos(theta).^2*A-12*sin(theta).^2*I/L.^2....
            , -cos(theta)*A*sin(theta)+12*sin(theta)*I*cos(theta)/L.^2, -6*sin(theta)*I/L;...
            cos(theta)*sin(theta)*A-12*sin(theta)*I*cos(theta)/L.^2, sin(theta).^2*A+12*cos(theta).^2*I/L.^2....
            , 6*cos(theta)*I/L, -cos(theta)*A*sin(theta)+12*sin(theta)*I*cos(theta)/L.^2....
            , -sin(theta).^2*A-12*cos(theta).^2*I/L.^2, 6*cos(theta)*I/L;...
            -6*sin(theta)*I/L, 6*cos(theta)*I/L....
            , 4*I, 6*sin(theta)*I/L....
            , -6*cos(theta)*I/L, 2*I;...
            -cos(theta).^2*A-12*sin(theta).^2*I/L.^2, -cos(theta)*A*sin(theta)+12*sin(theta)*I*cos(theta)/L.^2....
            , 6*sin(theta)*I/L, cos(theta).^2*A+12*sin(theta).^2*I/L.^2....
            , cos(theta)*A*sin(theta)-12*sin(theta)*I*cos(theta)/L.^2, 6*sin(theta)*I/L;...
            -cos(theta)*A*sin(theta)+12*sin(theta)*I*cos(theta)/L.^2, -sin(theta).^2*A-12*cos(theta).^2*I/L.^2....
            , -6*cos(theta)*I/L, cos(theta)*A*sin(theta)-12*sin(theta)*I*cos(theta)/L.^2....
            , sin(theta).^2*A+12*cos(theta).^2*I/L.^2, -6*cos(theta)*I/L;...
            -6*sin(theta)*I/L, 6*cos(theta)*I/L....
            , 2*I, 6*sin(theta)*I/L....
            , -6*cos(theta)*I/L, 4*I];

K1 = vpa(subs(K, [theta,L], [theta1,L1]));
K2 = vpa(subs(K, [theta,L], [theta2,L2]));

zeroMatrix = zeros(3);

Knew1 = [K1(:,1),K1(:,2),K1(:,3)];
Knew1(4,:) = [];
Knew1(4,:) = [];
Knew1(4,:) = [];

Knew2 = [K2(:,4),K2(:,5),K2(:,6)];
Knew2(1,:) = [];
Knew2(1,:) = [];
Knew2(1,:) = [];

Knew3 = [K1(:,4),K1(:,5),K1(:,6)];
Knew3(4,:) = [];
Knew3(4,:) = [];
Knew3(4,:) = [];

Knew4 = [K1(:,1),K1(:,2),K1(:,3)];
Knew4(1,:) = [];
Knew4(1,:) = [];
Knew4(1,:) = [];

Knew5 = [K1(:,4),K1(:,5),K1(:,6)];
Knew5(1,:) = [];
Knew5(1,:) = [];
Knew5(1,:) = [];

Knew6 = [K2(:,1),K2(:,2),K2(:,3)];
Knew6(4,:) = [];
Knew6(4,:) = [];
Knew6(4,:) = [];

Knew7 = [K2(:,4),K2(:,5),K2(:,6)];
Knew7(4,:) = [];
Knew7(4,:) = [];
Knew7(4,:) = [];

Knew8 = [K2(:,1),K2(:,2),K2(:,3)];
Knew8(1,:) = [];
Knew8(1,:) = [];
Knew8(1,:) = [];

Kfull = [Knew1,Knew3,zeroMatrix;...
     Knew4,Knew5+Knew6,Knew7;...
     zeroMatrix,Knew8,Knew2];

K = Kfull;

K(7,:) = [];
K(7,:) = [];
K(7,:) = [];
K(:,7) = [];
K(:,7) = [];
K(:,7) = [];


K(1,:) = [];
K(1,:) = [];
K(1,:) = [];
K(:,1) = [];
K(:,1) = [];
K(:,1) = [];

F = [5000;0;0];

q = K\F;

Fapplied = Kfull*[0;0;0;q(1);q(2);q(3);0;0;0];

T = [cos(theta) sin(theta) 0 0 0 0;...
     -sin(theta) cos(theta) 0 0 0 0;...
     0 0 1 0 0 0;...
     0 0 0 cos(theta) sin(theta) 0;...
     0 0 0 -sin(theta) cos(theta) 0;...
     0 0 0 0 0 1];

T1 = vpa(subs(T,theta,theta1));

T2 = vpa(subs(T,theta,theta2));

Fapplied1 = K1*[0;0;0;q(1);q(2);q(3)]; % These may be wrong bc the applied sum to
Fapplied2 = K2*[q(1);q(2);q(3);0;0;0];

F1 = transpose(T1)*Fapplied1;
F1 = [-F1(1);-F1(2);-F1(3);F1(4);F1(5);F1(6)]

F2 = transpose(T2)*Fapplied2;
F2 = [-F2(1);-F2(2);-F2(3);F2(4);F2(5);F2(6)]

% % Stresses in order [node1bottom;node1top;node1shear;node2bottom;node2top;node2shear]
% 
% element1Stresses = [F1(1)/A+F1(3)*(b/2)/I; F1(1)/A-F1(3)*(b/2)/I; F1(2)/A;F1(4)/A+F1(6)*(b/2)/I; F1(4)/A-F1(6)*(b/2)/I; F1(5)/A];
% 
% element2Stresses = [F2(1)/A+F2(3)*(b/2)/I; F2(1)/A-F2(3)*(b/2)/I; F2(2)/A;F2(4)/A+F2(6)*(b/2)/I; F2(4)/A-F2(6)*(b/2)/I; F2(5)/A];
