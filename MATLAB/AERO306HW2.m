% Question 5 plot u

x = 0:10;
uExact = -10.^(-6) * ((3 / 2000) * x.^5 - 10 * x - 2004900);
uApprox = 2 - 5 * 10.^(-6) * (x - 10);
figure
plot(x,uExact);
hold on
plot(x,uApprox,'red');
title('Question 5 Graph: Displacements vs Location');
xlabel('Location');
ylabel('Displacement');
hold off
legend('Exact','Approximation')

% Question 5 plot f

x = 0:10;
fExact = -(3 / 400) * x.^4 + 10;
fApprox = -5;
figure
plot(x,fExact);
hold on
yline(fApprox, 'red');
title('Question 5 Graph: Internal Forces vs Location');
xlabel('Location');
ylabel('Force');
hold off
legend('Exact','Approximation')

% Question 6 plot u

x = 0:10;
uExact = -10.^(-6) * ((x.^2 / 10) - (x.^5 / 100));
uApprox = -10.^(-6) * x;
figure
plot(x,uExact);
hold on
plot(x,uApprox,'red');
title('Question 6 Graph: Displacements vs Location');
xlabel('Location');
ylabel('Displacement');
hold off
legend('Exact','Approximation')

% Question 6 plot f

x = 0:10;
fExact = (-x / 5) + (x.^4 / 20);
fApprox = -1;
figure
plot(x,fExact);
hold on
yline(fApprox, 'red');
title('Question 6 Graph: Internal Forces vs Location');
xlabel('Location');
ylabel('Force');
hold off
legend('Exact','Approximation')

% Question 7 plot u

x = 0:10;
uExact = -10.^(-6) * ((x.^2 / 10) - (x.^5 / 100) + 99 * x);
uApprox = -10.^(-6) * 6 * (-191.30952 * (x.^2 - (10 * x)) + 23.80952 * (x.^3 - (100*x)));
figure
plot(x,uExact);
hold on
plot(x,uApprox,'red');
title('Question 7 Graph: Displacements vs Location');
xlabel('Location');
ylabel('Displacement');
hold off
legend('Exact','Approximation')

% Question 7 plot f

x = 0:10;
fExact = (-x / 5) + (x.^4 / 20) - 99;
fApprox = 6 * (-467.85714 - (382.61905 * x) + (71.42857 * x.^2));
figure
plot(x,fExact);
hold on
plot(x,fApprox);
title('Question 7 Graph: Internal Forces vs Location');
xlabel('Location');
ylabel('Force');
hold off
legend('Exact','Approximation')