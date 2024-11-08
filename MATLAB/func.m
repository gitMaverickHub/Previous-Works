function ydot = func(t,y)
a = 0.00678125;
b = 0.025725;
c = 0.25725;
ydot(1) = y(2);
ydot(2) = (-1 / a) * (b * y(2) + c * (4 * y(1).^3 - 7 * y(1).^2 + 3.5 * y(1) - 0.5));
ydot = ydot';
end