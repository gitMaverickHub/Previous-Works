%problem 5 part a
syms x
L = 10;
h = L/3;
E = 10.^7;
A = 1/10;
Ntrans = [1-11/20*x+9/100*x.^2-9/2000*x.^3;...
          9/10*x-9/40*x.^2+27/2000*x.^3;...
          -9/20*x+9/50*x.^2-27/2000*x.^3;...
          1/10*x-9/2000*x.^2+9/2000*x.^3];
f = [0;200*(1-x/L);400/3*(1-x/L);200/3*(1-x/L)];
fNi = f.*Ntrans;
Feq = int(fNi,x,0,h);
Feq = Feq(2:end);
Kprecoeff = [2 -1 0; -1 2 -1; 0 -1 1];
K = E*A/h.*Kprecoeff;
q = K\Feq;
%q = vpa(qsym) %used to get in decimals q was the variable qsym
%verify = K*q;

%problem 5 part b
syms a b c d
c = (q(2) - 2*q(1) - 1/27*(9*L.^3)*d)/((3*L.^2)/9);
eqn = q(3) == 3*(q(1) - c*L.^2/9 + d*L.^3/27) + c*L + d*L.^3;
dsym = solve(eqn);
d = vpa(dsym);
c = (q(2) - 2*q(1) - 1/27*(9*L.^3)*d)/((3*L.^2)/9);
b = 3/L*(q(1) - c*L.^2/9 + d*L.^3/27);
uxFe = @(x) b*x + c*x.^2 + d*x.^3;
x = 0:10;
figure
plot(x,uxFe(x))
hold on
title('Displacement vs Location Problem 5');
xlabel('x');
ylabel('u(x)');
uxExact = @(x) 1/(E*A)*(-200*(x.^2/2 - x.^3/(6*L)) + 1000*x);
plot(x,uxExact(x))
legend('Finite Element','Exact');
hold off

%Problem 7
K7 = E*A.*[1/10 -1/10; -1/10 4/30];
F7 = [-35; 125];
q7 = K7\F7;

syms e f g % a b c on paper
f = (q7(2) - q7(1) - 100*g)/10;
eqn7 = 0 == q7(1) + 40*f + 1600*g;
gsym7 = solve(eqn7);
g = vpa(gsym7);
f = (q7(2) - q7(1) - 100*g)/10;
e = q7(1);
uxFe7 = @(x) e + f*x + g*x.^2;
figure
x = 0:40;
plot(x,uxFe7(x))
hold on
title('Displacement vs Location Problem 7');
xlabel('x');
ylabel('u(x)');
uxExact71 = @(x) 1/(E*A) * (-5/2*x.^2 + 60*x +2350);
uxExact72 = @(x) 1/(E*A) * (-90*x + 3600);
plot(x,uxExact71(x),x,uxExact72(x))
legend('Finite Element','Exact when x < 10', 'Exact when x > 10');
hold off

FxFe7 = @(x) E*A*(f + 2*g*x);
x = 0:40;
figure
plot(x,FxFe7(x))
hold on
title('Internal Force vs Location');
xlabel('x');
ylabel('F(x)');
FxExact71 = @(x) -5*x + 60;
FxExact72 = @(x) 0*x -90;
plot(x,FxExact71(x),x,FxExact72(x));
legend('Finite Element','Exact when x < 10', 'Exact when x > 10');
hold off

%Problem 9 task 3
syms x9
alpha = 10.^(-6);
T = 500;

G9 = [1 x9 x9.^2 x9.^3];
H9 = [1 0 0 0;...
     1 5 25 125;...
     1 8 64 512;...
     1 10 100 1000];
Ntrans9 = transpose(G9/H9);
Ntrans9diff = diff(Ntrans9,x9);

f9 = 200*(1-(x9/L).^3);
Feq9 = [int(f9.*Ntrans9(1),x9,0,0);...
       int(f9.*Ntrans9(2),x9,0,5);...
       int(f9.*Ntrans9(3),x9,0,3);...
       int(f9.*Ntrans9(4),x9,0,2)];
Feq9 = vpa(Feq9);

thermCoeff = E*A*alpha*T;
Ft = [int(thermCoeff*Ntrans9diff(1),x9,0,0);...
      int(thermCoeff*Ntrans9diff(2),x9,0,5);...
      int(thermCoeff*Ntrans9diff(3),x9,0,3);...
      int(thermCoeff*Ntrans9diff(4),x9,0,2)];
Ft = vpa(Ft);

K9 = E*A.*[(1/5)+(1/3) -1/3 0;...
           -1/3 (1/2)+(1/3) -1/2;...
           0 -1/2 1/2];
Feq9 = Feq9(2:end);
Ft = Ft(2:end);
Fbc = [0;0;-500];

q9 = K9\(Feq9+Ft+Fbc);

%Problem 9 task 4
syms b9 c9 d9 b92

eqnb = q(1) == 5*b9 + 25*c9 + 125*d9;
b9 = solve(eqnb,b9);
eqnc = q(2) == 8*b9 + 64*c9 + 512*d9;
c9 = solve(eqnc,c9);
b9 = 3667/14580000 - 25*d9 - 5*c9;
eqnd = q(3) == 10*b9 + 100*c9 + 1000*d9;
d9 = solve(eqnd,d9);
d9 = vpa(d9);
c9 = - 13*d9 - 6593/174960000;
b9 = 40*d9 + 2218480382202110153221/5042878661150348673024000;

x = 0:10;
uxfe9 = @(x) b9*x + c9*x.^2 + d9*x.^3;
strainfe9 = @(x) b9 + 2*c9*x + 3*d9*x.^2;
uxExact9 = @(x) 1/(E*A)*(alpha*T*x - 200*(x.^2/2 - x.^5/(20*L.^3)) + 500*x);
strainExact9 = @(x) 1/(E*A)*(alpha*T - 200*(x - x.^4/(4*L.^3)) + 500);

figure
plot(x,uxfe9(x),x,uxExact9(x))
hold on
title('Displacement vs Location');
xlabel('x');
ylabel('u(x)');
legend('Finite Element', 'Exact');
hold off

figure
plot(x,strainfe9(x),x,strainExact9(x))
hold on
title('Strain vs Location');
xlabel('x');
ylabel('strain(x)');
legend('Finite Element', 'Exact');
hold off

% figure
% intForce = @(x) alpha*T - 200*(x - x.^4/(4*L.^3)) + 500;
% plot(x,intForce(x))
% hold on
% x = 10;
% plot(x,-500,'*');
% title('Internal Force vs Location');
% xlabel('x');
% ylabel('F(x)');
% hold off