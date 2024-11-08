% Problem 1 ---------------------------------------------------------

pInf = 101325; %Pa
ReInf = 287; %J/(kg*K)
TInf = 288.15; %K
rhoInf = pInf/(ReInf*TInf);
muRef = 1.716*10.^(-5); %kh/(m*s)
TRef = 273.15; %K
S = 110.6; %K
muInf =  muRef*((TRef+S)/(TInf+S))*(TInf/TRef).^(1.5);
Re1 = 10000000; 
UInf = Re1*muInf/rhoInf;

NozzleLength = 30; % meters
Amin = NozzleLength/250; % meters
Me = 6;
Aratio = 53.18;

% Problem 4 -------------------------------------------------------------

% waves10 = Problem4(10);
% waves20 = Problem4(20);
% waves30 = Problem4(30);
% waves50 = Problem4(50);
% waves70 = Problem4(70);
% waves100 = Problem4(100);


function Plocation = Problem4(N)

    M = 2;
    height = 1;
    delta = -12;
    syms Mach x

    deltaSection = [];
    for i = 1:N
        deltaSection = [deltaSection delta*(i-1)/(N-1)];
    end

    mu = asin(1/M(1))*180/pi;
    sigma = deltaSection(1)+mu;
    nu = (sqrt(6)*atan(sqrt((M(1).^2-1)*(1/6)))-atan(sqrt(M(1).^2-1)))*180/pi;
    K = nu-deltaSection(1);


    for i = 2:N
        nu = [nu nu(1)-deltaSection(i)];
        eqn = nu(i) == (sqrt(6)*atan(sqrt((Mach.^2-1)*(1/6)))-atan(sqrt(Mach.^2-1)))*180/pi;
        M = [M abs(solve(eqn,Mach))];
        mu = [mu vpa(asin(1/M(i))*180/pi)];
        sigma = [sigma vpa(deltaSection(i)+mu(i))];
        K = [K nu(i)-deltaSection(i)];
    end
    
    K = [K K];

    xloc = [];
    yloc = [];

    z = 1;
    x2 = zeros(1,N);
    b2 = zeros(1,N);
    for i = 1:N

        sigma1 = 0;
        x1 = x;
        b1 = 1;
        q = 1; % tests if a wall node

        for j = 1:N-i+1

            sigma2 = sigma(i+j-1);
            m1 = abs(tan(sigma1*pi/180));
            m2 = abs(tan(sigma2*pi/180));
            eqn = -m1*(x-x1)+b1 == m2*(x-x2(j))+b2(j);
            xloc(z) = solve(eqn,x);
            yloc(z) = -m1*(xloc(z)-x1)+b1;

            x1 = xloc(z);
            b1 = yloc(z);
            
            if j > 1
                x2(j-1) = x1;
                b2(j-1) = b1;
            end

            if q == 1
                nutemp = K(i);
            else
                nutemp = (K(i+j-1)+K(i+N))/2;
            end
            eqn = nutemp == (sqrt(6)*atan(sqrt((Mach.^2-1)*(1/6)))-atan(sqrt(Mach.^2-1)))*180/pi;
            Mtemp = abs(solve(eqn,Mach));
            mutemp = vpa(asin(1/Mtemp)*180/pi);
            sigma1 = vpa(deltaSection(j) - mutemp);
            if q == 0
                sigma(i+j-1) = vpa(deltaSection(j) + mutemp);
            end
            
            q = 0;
            z = z+1;

        end
    end
    
    Plocation = [xloc(z-1),yloc(z-1)];

end