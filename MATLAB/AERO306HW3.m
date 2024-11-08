x = 0:100;
y = 0.0001269555*x.^2 + (1.1774*10.^(-7))*x.^3;
plot(x,y);
title('Displacement vs Location');
xlabel('Location (inches)');
ylabel('Displacement (inches)');