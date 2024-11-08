% Question 3 plot

x = 0:60;
y = (-0.28 / 0.05) * (4 * (x * pi / 180).^3 - 7 * (x * pi / 180).^2 + 3.5 * (x * pi / 180) - 0.5);
figure
plot(x,y);
title('Question 3 Graph');
xlabel('Theta (degrees)');
ylabel('Pitching Moment Coefficient');

% Question 6 Plot 1

[t,y] = ode45('func',[0 10],[0.1 0]);
figure;
plot (t,y(:,1)*180/pi);
title('Question 6 Graph i');
xlabel('Time (seconds)');
ylabel('Theta (degrees)');

% Question 6 Plot 2

[t,y] = ode45('func',[0 10],[0.5 1*10.^(-4)]);
figure;
plot (t,y(:,1)*180/pi);
title('Question 6 Graph ii');
xlabel('Time (seconds)');
ylabel('Theta (degrees)');

% Question 6 Plot 3

[t,y] = ode45('func',[0 10],[0 1]);
figure;
plot (t,y(:,1)*180/pi);
title('Question 6 Graph iii');
xlabel('Time (seconds)');
ylabel('Theta (degrees)');