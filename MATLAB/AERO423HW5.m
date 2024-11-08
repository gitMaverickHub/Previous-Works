%% For All Problems
J2 = 1.082645e-3;
mu = 398600.4415;
RE = 6378.135;
%% Problem 1
%{
ra = RE + 39906;
i = 63.435 * pi/180;
argofper = 270 * pi/180;
T = 43082;

a = ((T/(2*pi))^2*mu)^(1/3);
rp = 2*a - ra;
e = (ra-rp)/(ra+rp);
p = a*(1-e^2);
n0 = sqrt(mu/a^3);
n = n0*(1 + 0.75*J2*(RE/p)^2*(2-3*sin(i)^2)*sqrt(1-e^2));

dargofperdt = ((3*J2*RE^2*n*(5*cos(i)^2-1))/(4*p^2)) * (24*3600) * (180/pi);
dRAANdt = (-(3*J2*RE^2*n*cos(i))/(2*p^2)) * (24*3600) * (180/pi);

deltaT = 2*pi/n - T;
%}
%% Problem 2
%{
a = 42164;
e = 0.24;
i = 70;      % degrees
omega = 270; % degrees
Isp = 300;
g = 9.81;
year = 365.25 * 24 * 3600;

p = a*(1-e^2);
deltavorbit = abs(e*sqrt(mu/p)*3*pi*J2*(RE/p)^2*(5*cosd(i)^2-1)/2);
T = 2*pi*sqrt(a^3/mu);
N = year/T;
deltavyear = N * deltavorbit;
deltamm0ratio = 1 - exp(-deltavyear/(g*Isp));
%}
%% Problem 3
%{
quat = [0.0921; 0.2306; 0.4191; 0.8733];
e = [0.1382; 0.4075; 0.9027];
phi = 61.1403;
Gibbs = [0.0890; 0.2976; 0.4994];
quatTRUE = [0.0742; 0.2363; 0.4418; 0.8623];
r = [0.1250; -0.5735; -0.8096];

quatvTRUE = quatTRUE(1:3);
I33 = eye(3);
skew_quatTRUE = [0, -quatTRUE(3), quatTRUE(2);
                 quatTRUE(3), 0, -quatTRUE(1);
                 -quatTRUE(2), quatTRUE(1), 0];
CTI = (quatTRUE(4)^2 - transpose(quatvTRUE)*quatvTRUE)*I33 + 2*quatvTRUE*transpose(quatvTRUE) ...
        - 2*quatTRUE(4)*skew_quatTRUE;
bT = CTI*r;
magbT = norm(bT);

% QUATERNION
skew_quat = [0, -quat(3), quat(2);
             quat(3), 0, -quat(1);
             -quat(2), quat(1), 0];
quatv = quat(1:3);
C_quat = (quat(4)^2 - transpose(quatv)*quatv)*I33 + 2*quatv*transpose(quatv) ...
        - 2*quat(4)*skew_quat;
att_error_quat = acosd((trace(CTI*transpose(C_quat)) - 1) / 2);
bEquat = C_quat*r;
dir_error_quat = acosd(dot(bT,bEquat)/(magbT*norm(bEquat)));

% PRINCIPAL AXIS AND ANGLE
skew_e = [0, -e(3), e(2);
          e(3), 0, -e(1);
          -e(2), e(1), 0];
C_principal = I33*cosd(phi) + (1-cosd(phi))*e*transpose(e) - skew_e*sind(phi);
att_error_principal = acosd((trace(CTI*transpose(C_principal)) - 1) / 2);
bE_principal = C_principal*r;
dir_error_principal = acosd(dot(bT,bE_principal)/(magbT*norm(bE_principal)));

% GIBBS
quat_from_Gibbs = (1/sqrt(1+transpose(Gibbs)*Gibbs))*[Gibbs;1];
skew_quat_from_Gibbs = [0, -quat_from_Gibbs(3), quat_from_Gibbs(2);
                        quat_from_Gibbs(3), 0, -quat_from_Gibbs(1);
                        -quat_from_Gibbs(2), quat_from_Gibbs(1), 0];
quatvGibbs = quat_from_Gibbs(1:3);
C_Gibbs = (quat_from_Gibbs(4)^2 - transpose(quatvGibbs)*quatvGibbs)*I33 + 2*quatvGibbs*transpose(quatvGibbs) ...
        - 2*quat_from_Gibbs(4)*skew_quat_from_Gibbs;
att_error_Gibbs = acosd((trace(CTI*transpose(C_Gibbs)) - 1) / 2);
bE_Gibbs = C_Gibbs*r;
dir_error_Gibbs = acosd(dot(bT,bE_Gibbs)/(magbT*norm(bE_Gibbs)));
%}
%% Problem 4

r1 = [0.1732; 0.3293; -0.9282];
r2 = [-0.4056; -0.5613; 0.7214];
b1 = [-0.3316; -0.3173; 0.8888];
b2 = [0.5563; 0.5208; -0.6475];
alpha = [1/3, 1/4];

I33 = eye(3);

% TRIAD Method ---------------------
testOrthogonalr = dot(r1,r2);
testOrthogonalb = dot(b1,b2);

% The vectors were not orthogonal, so I will use the final eqn. on the
% TRIAD slide

C_TRIAD = [b1, cross(b1,b2), cross(b1,cross(b1,b2))]/([r1, cross(r1,r2), cross(r1,cross(r1,r2))]);

% The code below to get q_TRIAD is from slides 12
tr = trace(C_TRIAD);
q0(1) = (1 + tr)/4;
q0(2) = (1 + 2*C_TRIAD(1,1) - tr)/4;
q0(3) = (1 + 2*C_TRIAD(2,2) - tr)/4;
q0(4) = (1 + 2*C_TRIAD(3,3) - tr)/4;

[~, imax] = max(abs(q0));
switch imax
    case 1
        q(4) = sqrt(q0(1));
        q(1) = (C_TRIAD(2,3) - C_TRIAD(3,2))/(4*q(4));
        q(2) = (C_TRIAD(3,1) - C_TRIAD(1,3))/(4*q(4));
        q(3) = (C_TRIAD(1,2) - C_TRIAD(2,1))/(4*q(4));
    case 2
        q(1) = sqrt(q0(2));
        q(4) = (C_TRIAD(2,3) - C_TRIAD(3,2))/(4*q(1));
        if q(4) < 0, q(1) = -q(1); q(4) = -q(4); end
        q(2) = (C_TRIAD(1,2) + C_TRIAD(2,1))/(4*q(1));
        q(3) = (C_TRIAD(3,1) + C_TRIAD(1,3))/(4*q(1));
    case 3
        q(1) = sqrt(q0(3));
        q(4) = (C_TRIAD(3,1) - C_TRIAD(1,3))/(4*q(2));
        if q(4) < 0, q(2) = -q(2); q(4) = -q(4); end
        q(1) = (C_TRIAD(1,2) + C_TRIAD(2,1))/(4*q(2));
        q(3) = (C_TRIAD(2,3) + C_TRIAD(3,2))/(4*q(2));
    case 4
        q(1) = sqrt(q0(4));
        q(4) = (C_TRIAD(1,2) - C_TRIAD(2,1))/(4*q(3));
        if q(4) < 0, q(3) = -q(3); q(4) = -q(4); end
        q(1) = (C_TRIAD(3,1) + C_TRIAD(1,3))/(4*q(3));
        q(2) = (C_TRIAD(2,3) + C_TRIAD(3,2))/(4*q(3));
end
q_TRIAD = q';

% Q-METHOD
B = alpha(1)*b1*transpose(r1) + alpha(2)*b2*transpose(r2);
K = [(B+transpose(B)-trace(B)*I33), (alpha(1)*cross(r1,b1) + alpha(2)*cross(r2,b2));
     (transpose(alpha(1)*cross(r1,b1) + alpha(2)*cross(r2,b2))), trace(B)];
[eigfunc, eigval] = eig(K);
eigvalmax = eigval(1,1);
j = 1;
for i = 1:4
    if eigvalmax < eigval(i,i)
        eigvalmax = eigval(i,i);
        j = i;
    end
end
qmax = eigfunc(:,j);
skew_qmax = [0, -qmax(3), qmax(2);
             qmax(3), 0, -qmax(1);
             -qmax(2), qmax(1), 0];
qvmax = qmax(1:3);
C_qmethod = (qmax(4)^2 - transpose(qvmax)*qvmax)*I33 + 2*qvmax*transpose(qvmax) ...
        - 2*qmax(4)*skew_qmax;
q_qmethod = qmax;
%}