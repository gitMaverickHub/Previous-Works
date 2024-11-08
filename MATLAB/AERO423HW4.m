%% Problem 2a
%{
r = 6778;
delrnaught = [0;-2;0.5];
delvnaughtneg = [0;0;5];

mu = 3.986*10^5;

T = 2*pi*sqrt(r^3/mu);
t = T/3;
v = sqrt(mu/r);
n = v/r;

gammarr = [4-3*cos(n*t), 0, 0;
           6*(sin(n*t)-n*t), 1, 0;
           0, 0, cos(n*t)];

gammarv = [sin(n*t)/n, (2*(1-cos(n*t)))/n, 0;
           (2*(cos(n*t)-1))/n, (4*sin(n*t)-3*n*t)/n, 0;
           0, 0, sin(n*t)/n];

gammavr = [3*n*sin(n*t), 0, 0;
           6*n*(cos(n*t)-1), 0, 0;
           0, 0, -n*sin(n*t)];

gammavv = [cos(n*t), 2*sin(n*t), 0;
           -2*sin(n*t), 4*cos(n*t)-3, 0;
           0, 0, cos(n*t)];

delvnaughtpos = -gammarv\gammarr*delrnaught;

delvfneg = gammavr*delrnaught + gammavv*delvnaughtpos;

delvfpos = [0;0;0];

deltavnaught = delvnaughtpos - delvnaughtneg;
deltavf = delvfpos - delvfneg;
deltavnaughtmag = sqrt(deltavnaught(1)^2 + deltavnaught(2)^2 + deltavnaught(3)^2);
deltavfmag = sqrt(deltavf(1)^2 + deltavf(2)^2 + deltavf(3)^2);
deltavtotal = deltavnaughtmag + deltavfmag;

%% Problem 2b

r = 6778;
t = 5*3600;

mu = 3.986*10^5;

theta = 5/r;
b = r*sin(theta);
c = r*cos(theta);
a = r - c;
delrnaughtgeo = [a;-b;0];
R = [c;b;0];
V = sqrt(mu/r);
Vxhat = -sqrt(b^2/(b^2+c^2));
Vyhat = sqrt(1-Vxhat^2);
ihat = R/r;
jhat = [Vxhat; Vyhat; 0];
khat = cross(ihat,jhat);
QXx = transpose([ihat,jhat,khat]);
delrnaught = QXx*delrnaughtgeo;
vVector = [0;V;0];
VVector = V*jhat;
n = V/r;
omegaISS = n*khat;
delvnaughtneggeo = vVector - VVector - cross(omegaISS,delrnaughtgeo);
delvnaughtneg = QXx*delvnaughtneggeo;

v = V;
gammarr = [4-3*cos(n*t), 0, 0;
           6*(sin(n*t)-n*t), 1, 0;
           0, 0, cos(n*t)];

gammarv = [sin(n*t)/n, (2*(1-cos(n*t)))/n, 0;
           (2*(cos(n*t)-1))/n, (4*sin(n*t)-3*n*t)/n, 0;
           0, 0, sin(n*t)/n];

gammavr = [3*n*sin(n*t), 0, 0;
           6*n*(cos(n*t)-1), 0, 0;
           0, 0, -n*sin(n*t)];

gammavv = [cos(n*t), 2*sin(n*t), 0;
           -2*sin(n*t), 4*cos(n*t)-3, 0;
           0, 0, cos(n*t)];

delvnaughtpos = -gammarv\gammarr*delrnaught;

delvfneg = gammavr*delrnaught + gammavv*delvnaughtpos;

delvfpos = [0;0;0];

deltavnaught = delvnaughtpos - delvnaughtneg;
deltavf = delvfpos - delvfneg;
deltavnaughtmag = sqrt(deltavnaught(1)^2 + deltavnaught(2)^2 + deltavnaught(3)^2);
deltavfmag = sqrt(deltavf(1)^2 + deltavf(2)^2 + deltavf(3)^2);
deltavtotal = deltavnaughtmag + deltavfmag;

%% Plot for 2b

T = 2*pi*sqrt(r^3/mu);
t0 = 0;
tf = 5*T;
ts = [t0 tf];
dels = [delrnaught; delvnaughtpos];
prob2b(ts,dels,R,VVector);
title('Plot for 2b')
%}
%% Plots for 3a

% THIS CODE HAS BEEN MODIFIED TO TRY TO CREATE DIFFERENT PLOTS FOR 
% PROBLEM 3 BECAUSE THEY SEEMED WRONG BUT NO MATTER WHAT I DO I GET
% THE SAME RESULT

%% Functions

function prob2b(ts, dels, R0, V0)

global mu

mu = 3.986*10^5;

[t,y] = rkf45(@rates, ts, dels);

plotit

return

function dydt = rates(t,f)

[R,V] = rv_from_r0v0(R0, V0, t);

X = R(1); Y = R(2); Z = R(3);
VX = V(1); VY = V(2); VZ = V(3);

R_ = norm([X Y Z]);
RdotV = dot([X Y Z], [VX VY VZ]);
h = norm(cross([X Y Z], [VX VY VZ]));

dx = f(1); dy = f(2); dz = f(3);
dvx = f(4); dvy = f(5); dvz = f(6);

dax = (2*mu/R_^3+h^2/R_^4)*dx- 2*RdotV/R_^4*h*dy + 2*h/R_^2*dvy;
day =-(mu/R_^3-h^2/R_^4)*dy + 2*RdotV/R_^4*h*dx- 2*h/R_^2*dvx;
daz =-mu/R_^3*dz;

dydt = [dvx dvy dvz dax day daz]';

end

function plotit

hold on
plot(y(:,2), y(:,1))
axis on
axis equal
axis([-6 4 -1 1])
xlabel('y (km)')
ylabel('x (km)')
grid on
box on
text(y(1,2), y(1,1), 'o')
text(y(1,2), y(1,1), '\leftarrow Start')

end

end

function prob3a1

days = 24*3600;
r12 = 384748;
m1 = 5974e21;
m2 = 7348e19;

M = m1+m2;
pi_1 = m1/M;
pi_2 = m2/M;

mu1 = 398600.44;
mu2 = 4904.87;

W = 2.662*10^(-6);
x1 = -pi_2*r12;
x2 = pi_1*r12;

t0 = 0;
tf = 100*days;
 
r2 = 20*x2;

x = 1.05*r2;
y = 0;
z = 0;

r1 = x - x1;

vx =  0;
vy = -3;
vz = 0.05;
f0 = [x;y;z;vx;vy;vz];

[t,f] = rkf45(@rates, [t0,tf], f0 );
x = f(:,1);
y = f(:,2);
z = f(:,3);
vx = f(:,4);
vy = f(:,5);
vz = f(:,6);

plotit

return

function dfdt = rates(t,f)

x = f(1);
y = f(2);
z = f(3);
vx = f(4);
vy = f(5);
vz = f(6);

r1 =  norm([x + pi_2*r12, y, z]);
r2= norm([x- pi_1*r12, y, z]);

ax = 2*W*vy + W^2*x- mu1*(x- x1)/r1^3- mu2*(x- x2)/r2^3;
ay = -2*W*vx + W^2*y- (mu1/r1^3 + mu2/r2^3)*y;
az = - (mu1/r1^3 + mu2/r2^3)*z;

dfdt = [vx vy vz ax ay az]';

end

function plotit

figure
plot3(x,y,z)
grid on
box on
view(3)

end

end

function [R,V] = rv_from_r0v0(R0, V0, t)

mu = 3.986*10^5;

r0 = norm(R0);
v0 = norm(V0);

vr0 = dot(R0, V0)/r0;

alpha = 2/r0 - v0^2/mu;

x = kepler_U(t, r0, vr0, alpha);

[f,g] = f_and_g(x,t,r0,alpha);

R = f*R0 + g*V0;

r = norm(R);

[fdot,gdot] = fDot_and_gDot(x,r,r0,alpha);

V = fdot*R0 + gdot*V0;

end

function x = kepler_U(dt, ro, vro, a)

mu = 3.986*10^5;

error = 1.e-8;
nMax = 1000;

x = sqrt(mu)*abs(a)*dt;

n = 0;
ratio = 1;
while abs(ratio) > error && n <= nMax
    n = n + 1;
    C = stumpC(a*x^2);
    S = stumpS(a*x^2);
    F = ro*vro/sqrt(mu)*x^2*C + (1- a*ro)*x^3*S + ro*x- sqrt(mu)*dt;
    dFdx = ro*vro/sqrt(mu)*x*(1- a*x^2*S) + (1- a*ro)*x^2*C + ro;
    ratio = F/dFdx;
    x = x - ratio;
end
if n > nMax
    fprintf('\n **No. iterations of Keplers equation = %g', n)
    fprintf('\n F\dFdx = %g\n', F\dFdx)
end
end

function c = stumpC(z)

if z > 0
    c = (1 - cos(sqrt(z)))/z;
elseif z < 0
    c = (cosh(sqrt(-z)) - 1)/(-z);
else
    c = 1/2;
end

end

function s = stumpS(z)

if z > 0
    s = (sqrt(z)- sin(sqrt(z)))/(sqrt(z))^3;
elseif z < 0
    s = (sinh(sqrt(-z))- sqrt(-z))/(sqrt(-z))^3;
else
    s = 1/6;
end

end

function [f,g] = f_and_g(x,t,ro,a)

mu = 3.986*10^5;

z = a*x^2;

f = 1 - x^2/ro*stumpC(z);

g = t - 1/sqrt(mu)*x^3*stumpS(z);

end

function [fdot,gdot] = fDot_and_gDot(x,r,ro,a)

mu = 3.986*10^5;

z = a*x^2;

fdot = sqrt(mu)/r/ro*(z*stumpS(z) - 1)*x;

gdot = 1 - x^2/r*stumpC(z);

end

function [tout, yout] = rkf45(ode_function, tspan, y0, tolerance)

a = [0 1/4 3/8 12/13 1 1/2];

b = [ 0 0 0 0 0
      1/4 0 0 0 0
      3/32 9/32 0 0 0
      1932/2197 -7200/2197 7296/2197 0 0
      439/216 -8 3680/513 -845/4104 0
      -8/27 2 -3544/2565 1859/4104 -11/40];

c4 = [25/216 0 1408/2565 2197/4104 -1/5 0];
c5 = [16/135 0 6656/12825 28561/56430 -9/50 2/55];

if nargin < 4
    tol = 1.e-8;
else
    tol = tolerance;
end

t0 = tspan(1);
tf = tspan(2);
t = t0;
y = y0;
tout = t;
yout = y';
h = (tf - t0)/100;

while t < tf
    hmin = 16*eps(t);
    ti = t;
    yi = y;
    for i = 1:6
        t_inner = ti + a(i)*h;
        y_inner = yi;
        for j = 1:i-1
            y_inner = y_inner + h*b(i,j)*f(:,j);
        end
        f(:,i) = feval(ode_function, t_inner, y_inner);
    end
    
    te = h*f*(c4' - c5');
    te_max = max(abs(te));
    ymax = max(abs(y));
    te_allowed = tol*max(ymax,1.0);
    delta = (te_allowed/(te_max + eps))^(1/5);

    if te_max <= te_allowed
        h = min(h,tf-t);
        t = t + h;
        y = yi + h*f*c5';
        tout = [tout;t];
        yout = [yout;y'];
    end

    h = min(delta*h, 4*h);
    if h < hmin
        fprintf(['\n\n Warning: Step size fell below its minimum\n'...
            ' allowable value (%g) at time %g. \n\n'], hmin, t)
        return
    end
end

end

function [r,v] = sv_from_coe(coe,mu)

h = coe(1);
e = coe(2);
RA = coe(3);
incl = coe(4);
w = coe(5);
TA = coe(6);

rp = (h^2/mu) * (1/(1 + e*cos(TA))) * (cos(TA)*[1;0;0] + sin(TA)*[0;1;0]);
vp = (mu/h) * (-sin(TA)*[1;0;0] + (e + cos(TA))*[0;1;0]);

R3_W = [cos(RA) sin(RA) 0
        -sin(RA) cos(RA) 0
        0   0   1];

R1_i = [1 0 0;
        0 cos(incl) sin(incl)
        0 -sin(incl) cos(incl)];

R3_w = [cos(w) sin(w) 0
        -sin(w) cos(w) 0
        0   0   1];

Q_pX = (R3_w*R1_i*R3_W);

r = Q_pX*rp;
v = Q_pX*vp;

r = r';
v = v';

end
