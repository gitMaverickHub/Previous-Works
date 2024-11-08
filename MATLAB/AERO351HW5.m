gamma = 1.34;
d = 0.19;
dcr = 0.16;
A = pi * (d/2).^2;
Acr = pi * (dcr/2).^2;

F = @(x) (1/x(1)) * ((2 / (gamma + 1))*(1 + ((gamma - 1) / 2)*x(1).^2)).^((gamma + 1)/(2 * (gamma - 1))) - (A/Acr);
x0 = 0.000000000000001;
M = fsolve(F,x0);