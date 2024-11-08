%Problem 1

%coefficients
a = [-1.943367*10.^(-2); 2.136104*10.^(-1); -2.903457*10.^(-1); -3.348641*10.^(-3); -2.060504*10.^(-1); 6.988016*10.^(-1); -9.035381*10.^(-1)];
b = [4.833383*10.^(-1); 8.644627; 1.131098*10; -7.422961*10; 6.075776*10];
f = [-1.378278*10.^(-1); -4.211369; 4.775187; -1.026225*10; 8.399763; -4.35400*10.^(-1)];
g = [-3.054956*10; -4.132305*10; 3.292788*10.^2; -6.848038e+02; 4.080244*10.^2];
m = [-2.029370*10.^(-2); 4.660702*10.^(-2); -6.012308*10.^(-1); -8.062977*10.^(-2); 8.320429*10.^(-2); 5.018538*10.^(-1); 6.378864*10.^(-1); 4.226356*10.^(-1)]; 
n = [-5.159153; -3.554716; -3.598636*10; 2.247355*10.^2; -4.120991*10.^2; 2.411750*10.^2];

%knowns
rho = 0.002377;
grav = 32.2;
sw = 300;
velocityNought = 500;
q = 0.5 * rho * velocityNought.^2;
weight = 20500;
mass = weight / grav;
chord = 11.32;
xref = 0.35 * chord;
cg = 0.3 * chord;

%solve
F = @(x) [q * sw * (a(1) + a(2) * x(1) + a(3) * x(2).^2 + a(4) * x(2) + a(5) * x(1) * x(2) + a(6) * x(1).^2 + a(7) * x(1).^3) ...
            + x(3) - mass * grav * sin(x(1));
          q * sw * (f(1) + f(2) * x(1) + f(3) * x(1).^2 + f(4) * x(1).^3 + f(5) * x(1).^4 + f(6) * x(2)) + ...
            mass * grav * cos(x(1));
          q * sw * (m(1)  + m(2) * x(1) + m(3) * x(2) + m(4) * x(1) * x(2) + m(5) * x(2).^2 + m(6) * x(1).^2 * x(2) + m(7) * x(2).^3 + m(8) * x(1) * x(2).^2 ...
            + (f(1) + f(2) * x(1) + f(3) * x(1).^2 + f(4) * x(1).^3 + f(5) * x(1).^4 + f(6) * x(2)) * (xref - cg) / chord)];
x0 = [0,0,0];
options = optimoptions(@fsolve, 'MaxFunctionEvaluations', 100000000, 'MaxIterations', 100000000);
x = fsolve(F,x0,options);

aoa = x(1);
edef = x(2);
t = x(3);
aoadeg = aoa * 180 / pi;
edeg = edef * 180 / pi;
cx = a(1) + a(2) * aoa + a(3) * edef.^2 + a(4) * edef + a(5) * aoa * edef + a(6) * aoa.^2 + a(7) * aoa.^3;
cz = f(1) + f(2) * x(1) + f(3) * x(1).^2 + f(4) * x(1).^3 + f(5) * x(1).^4 + f(6) * x(2);

% %Problem 3

uNought = velocityNought * cos(aoa);
wNought = velocityNought * sin(aoa);

dqdu = rho*uNought;
dcxdu = 0;
xu = (sw/mass) * (dqdu * cx + dcxdu * q);

dqde = 0;
dcxde = 2*a(3)*edef + a(4) + a(5)*aoa;
xe = (sw/mass) * (dqde * cx + dcxde * q);

dqdalpha = rho * aoa * uNought.^2;
dcxdalpha = a(2) + a(5)*edef + 2*a(6)*aoa + 3*a(7)*aoa.^2;
xalpha = (sw/mass) * (dqdalpha * cx + dcxdalpha * q);

dczdu = 0;
zu = (sw/mass) * (dqdu * cz + dczdu * q);

dczdalpha = f(2) + 2*f(3)*aoa + 3*f(4)*aoa.^2 + 4*f(5)*aoa.^3;
zalpha = (sw/mass) * (dqdalpha * cz + dczdalpha * q);

dczde = f(6);
ze = (sw/mass) * (dqde * cz + dczde * q);

cm = m(1)  + m(2) * x(1) + m(3) * x(2) + m(4) * x(1) * x(2) + m(5) * x(2).^2 + ...
        m(6) * x(1).^2 * x(2) + m(7) * x(2).^3 + m(8) * x(1) * x(2).^2 + cz*(xref-cg)/chord;
dcmdu = 0;
mu = (sw/mass) * (dqdu * cm + dcmdu * q);

dcmdalpha = m(2) + m(4)*edef + 2*m(6)*aoa*edef + m(8)*edef.^2 + ...
        dczdalpha*(xref-cg)/chord;
malpha = (sw/mass) * (dqdalpha * cm + dcmdalpha * q);

dcmde = m(3) + m(4)*aoa + 2*m(5)*edef + m(6)*aoa.^2 + 3*m(7)*edef.^2 + 2*m(8)*aoa*edef + ...
        dczde*(xref-cg)/chord;
me = (sw/mass) * (dqde * cm + dcmde * q);

dqdq = 0;
dcmdq = n(1) + n(2)*aoa + n(3)*aoa.^2 + n(4)*aoa.^3 + n(5)*aoa.^4 + n(6)*aoa.^5 + ...
        (g(1) + g(2)*aoa + g(3)*aoa.^2 + g(4)*aoa.^3 + g(5)*aoa.^4)*(xref-cg)/chord;
mq = (sw/mass) * (dqdq * cm + dcmdq * q);
 
task3 = [dcxdu xu; dcxdalpha xalpha; dcxde xe; dczdu zu; dczdalpha zalpha; ...
         dczde ze; dcmdu mu; dcmdalpha malpha; dcmde me;dcmdq, mq];
 
%Problem 5

a4eig = 1;
b4eig = -((zalpha-grav*sin(aoa)) / uNought + mq);
dczdq = g(1) + g(2)*aoa + g(3)*aoa.^2 + g(4)*aoa.^3 + g(5)*aoa.^4;
zq = (sw/mass) * (dqdq * cz + dczdq * q);
c4eig = mq*(zalpha-grav*sin(aoa))/uNought - malpha*(zq/uNought-1);
p = ([a4eig, b4eig, c4eig]);
[wn, zeta, eigs] = damp(p);
tconst = -1./transpose(eigs);
dw = wn.*sqrt(1-zeta.^2);
realComponent = -wn.*zeta;
halfLife = 0.693./abs(transpose(realComponent));

%Problem 6

dcxdq = b(1) + b(2)*aoa + b(3)*aoa.^2 + b(4)*aoa.^3 + b(5)*aoa.^4;
xq = (sw/mass) * (dqdq * cx + dcxdq * q);

A = [xu xalpha xq-wNought -grav*cos(aoa);...
     zu/uNought zalpha/uNought zq/uNought-1 -grav*sin(aoa)/uNought;...
     mu malpha mq 0;...
     0 0 1 0];
[Avecs, Aeigs] = eig(A);

short = [(zalpha-grav*sin(aoa))/uNought zq/uNought-1;...
          malpha mq];
[shortVecs, shortEigs] = eig(short);

phug = [xu -grav*cos(aoa);...
        zu/uNought -grav*sin(aoa)/uNought];
[phugVecs, PhugEigs] = eig(phug);

aphug = 1;
bphug = -(xu - grav*sin(aoa)/uNought);
cphug = (zu*grav*cos(aoa) - xu*grav*sin(aoa))/uNought;
pphug = ([aphug, bphug, cphug]);
[wnphug, zetaphug, eigsphug] = damp(pphug);
tconstphug = -1./transpose(eigsphug);
dwphug = wnphug.*sqrt(1-zetaphug.^2);
realComponentphug = -wnphug.*zetaphug;
halfLifephug = 0.693./abs(transpose(realComponentphug));

