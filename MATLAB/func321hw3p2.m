% Function for the ode for PROBLEM 3
% PART 2 of AERO321HW3.m

function dydt = func321hw3p2(t,y)

aoaRad = 45 * pi/180;
omegaRad = 30 * pi/180;
p = omegaRad*cos(aoaRad);
r = omegaRad*sin(aoaRad);

% Equations from 'Quaternion/Euler Parameter Propogation' slide

dydt = zeros(4,1);
dydt(1) = (-p * y(2) - r * y(4));
dydt(2) = (p * y(1) + r * y(2));
dydt(3) = (p * y(4) - r * y(2));
dydt(4) = (-p * y(3) + r * y(1));

end