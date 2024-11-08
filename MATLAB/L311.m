syms x

amp_fact1 = 1/sqrt((1-x^2)^2+(2*0.1*x)^2);
amp_fact2 = 1/sqrt((1-x^2)^2+(2*0.2*x)^2);
amp_fact3 = 1/sqrt((1-x^2)^2+(2*0.3*x)^2);
amp_fact4 = 1/sqrt((1-x^2)^2+(2*0.4*x)^2);
amp_fact5 = 1/sqrt((1-x^2)^2+(2*0.5*x)^2);

hold on
grid on
fplot (amp_fact1, [0,4], 'o--', 'LineWidth', 3)
fplot (amp_fact2, [0,4], 'k', 'LineWidth', 3)
fplot (amp_fact3, [0,4], 'y', 'LineWidth', 3)
fplot (amp_fact4, [0,4], 'b', 'LineWidth', 3)
fplot (amp_fact5, [0,4], 'p--', 'LineWidth', 3)
title('Amplification Factor vs \omega / \omega ^2')
legend('Damping Ratio = 0.1', 'Damping Ratio = 0.2', 'Damping Ratio = 0.3',...
	'Damping Ratio = 0.4', 'Damping Ratio = 0.5', 'Location', 'northeast')
xlabel('\omega / \omega ^2')
ylabel('Amplification Factor')