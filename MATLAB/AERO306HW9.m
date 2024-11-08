syms P K L theta deltheta

delq = -L*cos(theta)*deltheta;
u = 2*L*cos(theta)-L;
delu = -2*L*sin(theta)*deltheta;
VW = P*delq - K*u*delu;
Peq = 2*K*(2*L*cos(theta)-L)*tan(theta);

K = -diff(VW, deltheta, theta);
Keq = subs(K, P, Peq);
eqn1 = 2*sin(theta).^2 + (cos(theta)+sin(theta)*tan(theta))*(1-2*cos(theta)) == 0;
condition = vpa(solve(eqn1, theta)*180/pi)