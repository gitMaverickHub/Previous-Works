% Problem 1

syms x L rho A g theta y0

Ni = [1-x/L; x/L];
faxial = rho*A*g*(x*sin(theta)+y0)*sin(theta);
fnormal = rho*A*g*(x*sin(theta)+y0)*cos(theta);

Faxial = int(faxial.*Ni,x,0,L);
Fnormal = int(fnormal.*Ni,x,0,L);

Fold = [Faxial(1); Fnormal(1); Faxial(2); Fnormal(2)];

TTrans = [cos(theta) -sin(theta) 0 0;...
          sin(theta) cos(theta) 0 0;...
          0 0 cos(theta) -sin(theta);...
          0 0 sin(theta) cos(theta)];

Feq = TTrans*Fold;

% Problem 3

L = 100*sqrt(2);
rho = 0.3;
A = 2;
g = 9.8 *39.3701;
theta = 45 *pi/180;
y0 = 0;

Ni = [1-x/L; x/L];
faxial = rho*A*g*(x*sin(theta)+y0)*sin(theta);
fnormal = rho*A*g*(x*sin(theta)+y0)*cos(theta);

Faxial = int(faxial.*Ni,x,0,L);
Fnormal = int(fnormal.*Ni,x,0,L);

Fold = [Faxial(1); Fnormal(1); Faxial(2); Fnormal(2)];

TTrans = [cos(theta) -sin(theta) 0 0;...
          sin(theta) cos(theta) 0 0;...
          0 0 cos(theta) -sin(theta);...
          0 0 sin(theta) cos(theta)];

Feq1 = vpa((TTrans*Fold));

L = 100*sqrt(2);
rho = 0.3;
A = 2;
g = 9.8 *39.3701;
theta = 135 *pi/180;
y0 = 0;

Ni = [1-x/L; x/L];
faxial = rho*A*g*(x*sin(theta)+y0)*sin(theta);
fnormal = rho*A*g*(x*sin(theta)+y0)*cos(theta);

Faxial = int(faxial.*Ni,x,0,L);
Fnormal = int(fnormal.*Ni,x,0,L);

Fold = [Faxial(1); Fnormal(1); Faxial(2); Fnormal(2)];

TTrans = [cos(theta) -sin(theta) 0 0;...
          sin(theta) cos(theta) 0 0;...
          0 0 cos(theta) -sin(theta);...
          0 0 sin(theta) cos(theta)];

Feq2 = vpa(TTrans*Fold);

E = 30*10.^6;
L = 200*sqrt(2);

K = (E*A/L).*[2 0; 0 2];
F = [500; Feq1(4)+Feq2(4)];

q = K\F;

K1 = (E*A/L).*[1 1 -1 -1; 1 1 -1 -1; -1 -1 1 1; -1 -1 1 1];
q1 = [0;0;q(1);q(2)];

K2 = (E*A/L).*[1 -1 -1 1; -1 1 1 -1; -1 1 1 -1; 1 -1 -1 1];
q2 = [0; 0; q(1); q(2)];

Fbc1 = K1*q1-Feq1;
Fbc2 = K2*q1-Feq2;

T = transpose(TTrans);

locFbc1 = vpa(T*Fbc1);
locFbc2 = vpa(T*Fbc2);

stress1 = locFbc1./A;
stress2 = locFbc2./A;

strain1 = stress1./E;
strain2 = stress2./E;

% Problem 6 

% other sections commented out to test

syms x g theta w p

r1 = -30;
r2 = 60;
L = r2-r1;
Ni = [1-x/L; x/L];
fx = p*w.^2*x;
y = (1/9)*x+10/3;
fy = p*g*y;

c = 8100/sqrt(8200);
s = 100/sqrt(8200);

faxial = fx*c+fy*s;
fnormal = -fx*s+fy*c;

Faxial = int(faxial.*Ni,x,r1,r2);
Fnormal = int(fnormal.*Ni,x,r1,r2);

Fold = [Faxial(1); Fnormal(1); Faxial(2); Fnormal(2)];

TTrans = [c -s 0 0;...
          s c 0 0;...
          0 0 c -s;...
          0 0 s c];

Feq = TTrans*Fold;