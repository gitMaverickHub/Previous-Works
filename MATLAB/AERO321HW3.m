%Problem 1

% dcm = [0 1/sqrt(2) 1/sqrt(2); 0 -1/sqrt(2) 1/sqrt(2); 1 0 0];
% 
% q = dcm2quat(dcm);
% 
% princAngRad = 2 * acos(q(1,1));
% princAngDeg = princAngRad * 180 / pi;
% 
% l = q/(sin(princAngRad/2));
% l(1,1) = 0;
% 
% eulRad = quat2eul(q);
% eulDeg = eulRad * 180 /pi;

% eulDeg/eulRad has 2 set of values that are true. For instace, 
% eulDeg = [90, -45, 90] or [-90, -135, -90]
% Also, princAng sign can be flipped if the princAxis is flipped.

%Problem 2

% r = 20 * pi /180; %roll in rad
% p = 5 * pi/180; %pitch in rad
% y = 0; %yaw in rad/deg
% 
% dcm2 = [cos(p)*cos(y) sin(r)*sin(p)*cos(y)-cos(r)*sin(y) cos(r)*sin(p)*cos(y)+sin(r)*sin(y);
%         cos(p)*sin(y) sin(r)*sin(p)*sin(y)+cos(r)*cos(y) cos(r)*sin(p)*sin(y)-sin(r)*cos(y);
%         -sin(p) sin(r)*cos(p) cos(r)*cos(p)];
% 
% vel = [500; 0; 40];
% 
% velInert = dcm2*vel;
% 
% dcmBFAngVel2EulAngRate = [1 tan(p)*sin(r) tan(p)*cos(r);
%                           0 cos(r) -sin(r);
%                           0 sin(r)*sec(p) cos(r)*sec(p)];
% 
% bfAngVelRad = (pi / 180) * [0; 10; 20];
% 
% eulAngRateDeg = dcmBFAngVel2EulAngRate * bfAngVelRad * 180 / pi;

%Problem 3

y0 = zeros(1,3);
tspan = [0 25];
options = odeset('RelTol',1e-11,'AbsTol',1e-11);
[t,y] = ode45('func321hw3',tspan,y0,options);
plot(t,y(:,1)*180/pi,'-o',t,y(:,2)*180/pi,'-o',t,y(:,3)*180/pi,'-o');
hold on
yline(-90);
title('Euler Angles vs Time');
xlabel('Time (seconds)');
ylabel('Angle (degrees)');
hold off
legend('phi (overlaps psi)', 'theta', 'psi', '-90 degrees');

%Problem 3 Part 2

figure
y0 = [1;0;0;0];
tspan = [0 25];
[t,y] = ode45('func321hw3p2',tspan,y0);
plot(t,y(:,1),'b',t,y(:,2),'r',t,y(:,3),'g',t,y(:,4),'y');
hold on
title('Euler Parameters vs Time');
xlabel('Time (seconds)');
ylabel('Euler Parameters');
hold off
legend('Euler Parameter 0', 'Euler Parameter 1', 'Euler Parameter 2', 'Euler Parameter 3');
