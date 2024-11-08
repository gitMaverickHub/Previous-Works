% Function for the ode for PROBLEM 3
% of AERO321HW3.m

function dydt = func321hw3(t,y)

aoaRad = 45 * pi/180;
omegaRad = 30 * pi/180;

p = omegaRad*cos(aoaRad);
r = omegaRad*sin(aoaRad);

% y(1) = phi, dydt(1) = phi dot
% y(2) =theta, dydt(2) = theta dot
% y(3) = psi, dydt(3) = psi dot

% Derivation of diff. eqns. from 'Aero Vehicle
% Angular Velocity Vector' slide which relates P,
% Q, and R to Euler Angle Rates. *Note: Q = 0 in
% the given problem.

dydt = zeros(3,1);
dydt(1) = p + r * tan(y(2))*cos(y(1));
dydt(2) = -r * sin(y(1));
dydt(3) = r * cos(y(1)) * sec(y(2));

end