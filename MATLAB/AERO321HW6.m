% Problem 1 part b - side note: part c is done by looking at the graph of
% part b

syms xcg clwf clh

% given
xacwf = 0.25; % all x values non-dimensional for this problem
xach = 3;
cmacwf = -0.1;
xnp = 0.5;
shsw = 0.25;
nh = 1;

cm = 0 == -clwf*(xacwf-xcg) + nh*shsw*clh*(xcg-xach) + cmacwf;
cl = 0.5 == clwf+nh*shsw*clh;
cls = solve([cm,cl],[clwf,clh]); %solving for the coefficient of lifts for the the wing-fuselage and horizontal tail
clwf = 32/55 - (2*xcg)/11;
clh = (8*xcg)/11 - 18/55;
cd1 = .0325+.035*clwf.^2+.03*clh.^2; %this equation gives the equation below which will be plotted
cd = @(xcg) (3.*((8.*xcg)./11 - 18./55).^2)./100 + (7.*((2.*xcg)./11 - 32./55).^2)./200 + 13./400;

figure
xcg = 0.25:0.01:0.7;
plot(xcg,cd(xcg),'o')
title('Problem 1: Coefficient of Drag vs Location')
xlabel('location relative to the mean wing chord beginning at the leading edge of the wing')
ylabel('coefficient of drag')

% Problem 2 

syms sh

%given
cw = 5.7;
xacwf = .23*cw; %dimensional
nh = 0.9;
sw = 184;
claw = 4.44;
ARw = 6;
clah = 3.9;
xach = 17; %dimensional
e = 1;

downwashGrad = (2*claw)/(pi*e*ARw);
xnp = @(sh) (claw.*xacwf./cw + clah.*nh.*sh./sw.*xach./cw.*(1-downwashGrad))./(claw + clah*nh*sh/sw*(1-downwashGrad));
xcg = @(sh) 0.32 + .0007.*sh;

figure
sh = 0:80;
plot(sh,xnp(sh),'o')
hold on
title('Problem 2: Neutral Point Location vs Area of Horizontal Tail')
xlabel('Horizontal Tail (ft squared)')
ylabel('Location (nondimensional)')
plot(sh,xcg(sh));
legend('Neutral Point','Center of Gravity')

