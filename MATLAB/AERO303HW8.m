% Problem 4 part 1

digits(5)

% l5 = 1;
% l2 = vpa(sqrt(.2.^2+.05.^2));
% l3 = .5;
% l4 = vpa(sqrt(.3.^2+.05.^2));
% 
% delta1 = vpa(atan(1/4));
% delta2 = vpa(atan(1/6));
% 
% alpha = vpa(3*pi/180);
% 
% cd2 = vpa(l2*sin(delta1-alpha));
% cd3 = vpa(l3*sin(-alpha));
% cd4 = vpa(-l4*sin(delta2+alpha));
% cd5 = vpa(l5*sin(alpha));
% 
% cl2 = vpa(l2*cos(delta1-alpha));
% cl3 = vpa(l3*cos(-alpha));
% cl4 = vpa(l4*cos(delta2+alpha));
% cl5 = vpa(-l5*cos(alpha));

% delta2 = vpa(4 *pi/180);
% delta3 = delta2;
% delta4 = 0;
% delta5 = delta2;
% delta6 = delta5;
% delta7 = 0;
% 
% l2 = vpa(.5/cos(delta2));
% l3 = l2;
% l4 = .3;
% l5 = vpa(.2/cos(delta5));
% l6 = l5;
% l7 = l4;
% 
% cd2 = vpa(l2*sin(delta2));
% cd3 = vpa(-l3*sin(delta3));
% cd4 = vpa(l4*sin(delta4));
% cd5 = vpa(l5*sin(delta5));
% cd6 = vpa(-l6*sin(delta6));
% cd7 = vpa(l7*sin(delta7));
% 
% cl2 = vpa(l2*cos(delta2));
% cl3 = vpa(l3*cos(delta3));
% cl4 = vpa(-l4);
% cl5 = vpa(-l5*cos(delta5));
% cl6 = vpa(-l6*cos(delta6));
% cl7 = vpa(-l7);

delta = vpa(10 *pi/180);
l = vpa(1/(2*cos(delta)));

cd2 = vpa(l2*sin(delta2-alpha))
cd3 = vpa(-l3*sin(delta3+alpha))
cd4 = vpa(l4*sin(delta4+alpha))
cd5 = vpa(-l5*sin(delta5-alpha))

cl2 = vpa(-l2*cos(delta2-alpha))
cl3 = vpa(-l3*cos(delta3+alpha))
cl4 = vpa(l4*cos(delta4+alpha))
cl5 = vpa(l5*cos(delta5-alpha))

gamma = 1.4;
M = 3.2;
p2 = 0.55971;
p3 = 0.079523;
p4 = 5.21174;
p5 = 1.5160;

Cd3 = vpa(2*(cd2*p2+cd3*p3+cd4*p4+cd5*p5)/(gamma*M.^2))
Cl3 = vpa(2*(cl2*p2+cl3*p3+cl4*p4+cl5*p5)/(gamma*M.^2))