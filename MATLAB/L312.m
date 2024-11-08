syms x

phi1 = atan(2*0.1*x/(1-x^2))*360/pi;
phi2 = atan(2*0.2*x/(1-x^2))*360/pi;
phi3 = atan(2*0.3*x/(1-x^2))*360/pi;
phi4 = atan(2*0.4*x/(1-x^2))*360/pi;
phi5 = atan(2*0.5*x/(1-x^2))*360/pi;

hold on
grid on
box on
fplot (phi1, [0,4], 'o', 'LineWidth', 3)
fplot (phi2, [0,4], 'k', 'LineWidth', 3)
fplot (phi3, [0,4], 'y', 'LineWidth', 3)
fplot (phi4, [0,4], 'b', 'LineWidth', 3)
fplot (phi5, [0,4], 'p', 'LineWidth', 3)
fplot (180, [0,4], 'k', 'LineWidth', 1)
fplot (-180, [0,4], 'k', 'LineWidth', 1)
fplot (0, [0,4], 'k', 'LineWidth', 1)
fplot (90, [0,4], 'k', 'LineWidth', 1)
fplot (-90, [0,4], 'k', 'LineWidth', 1)
title('Phase vs \omega / \omega ^2')
legend('Damping Ratio = 0.1', 'Damping Ratio = 0.2', 'Damping Ratio = 0.3',...
	'Damping Ratio = 0.4', 'Damping Ratio = 0.5', 'Location', 'northeast')
xlabel('\omega / \omega ^2')
ylabel('Phase (degrees)')