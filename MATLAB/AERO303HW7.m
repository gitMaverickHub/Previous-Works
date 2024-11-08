% Problem 1 Part b
% 
% m1 = 6.93461;
% beta = 35.226971 *pi/180;
% p1 = 101325;
% T1 = 200;
% R = 287;
% 
% deltaDeg = vpa(Delta(beta, m1));
% delta = deltaDeg *pi/180;
% 
% m1n = sin(beta)*m1;
% m2n = sqrt((2+0.4*m1n.^2)/(2*1.4*m1n.^2-0.4));
% m2  = vpa(m2n/sin(beta-delta));
% 
% p2 = p1*(1+(2*1.4*(m1n.^2-1)/2.4));
% p02 = p2*(1+0.4*m2.^2/2).^(1.4/0.4);
% 
% T2 = T1*(1+2*(0.4)*(m1n.^2-1)*(1.4*m1n.^2+1)/((2.4).^2*(m1n.^2)));
% T02 = T1*(1+0.4*m1.^2/2);
% 
% p01 = p1*(T02/T1).^(1.4/0.4);
% s = vpa(-R*log(p02/p01));

% Problem 2
% 
% p1 = 101325;
% m1 = 5;
% adelta = 0;
% bdelta = 25;
% cdelta1 = bdelta;
% cdelta2 = 20;
% abeta = 90;
% bbeta = 36;
% cbeta1 = bbeta;
% cbeta2 = 43; 
% 
% aStagPDif = StagPDif(p1, adelta, abeta, m1);
% 
% bStagPDif1 = StagPDif(p1, bdelta, bbeta, m1);
% m2 = M1toM2(bdelta, bbeta, m1);
% p2 = P1toP2(p1, bbeta, m1);
% bStagPDif2 = StagPDif(p2, adelta, abeta, m2);
% bStagPDif = bStagPDif1 + bStagPDif2;
% 
% cStagPDif1 = bStagPDif1;
% cStagPDif2 = StagPDif(p2, cdelta2, cbeta2, m2);
% m3 = M1toM2(cdelta2, cbeta2, m2);
% p3 = P1toP2(p2, cbeta2, m2);
% cStagPDif3 = StagPDif(p3, adelta, abeta, m3);
% cStagPDif = cStagPDif1 + cStagPDif2 + cStagPDif3;
% 
% m2 = 2.21;
% p2 = 4935975;
% dStagPDif = StagPDif(p2, adelta, abeta, m2);

% Problem 7
% 
% m1 = 3;
% delta1 = 6;
% beta1 = 34;
% p1 = 101325;
% t1 = 500;
% 
% m2 = M1toM2(delta1, beta1, m1);
% beta2 = 56.5;
% m3 = M1toM2(delta1, beta2, m2);
% 
% p2 = P1toP2(p1, beta1, m1);
% p3 = P1toP2(p2, beta2, m2);
% 
% t2 = T1toT2(t1, beta1, m1)
% t3 = T1toT2(t2, beta2, m2)

% Problem 9
% 
% mach = 8;
% delta = 8.5;
% beta = 14;
% 
% m2 = M1toM2(delta, beta, mach)

% Functions for discontinuous corners

function m2 = M1toM2(delta, beta, mach)
   
    % assume gamma = 1.4

    syms x
    delta = delta *pi/180;
    beta = beta *pi/180;
    m1 = mach;

    m1n = m1*sin(beta);
    m1nm2neqn = x.^2 == (2+0.4*m1n.^2)/(2.8*m1n.^2-0.4);
    m2n = vpa(solve(m1nm2neqn, x));
    m2n = abs(m2n(1));

    m2 = m2n/sin(beta-delta);

end
function p2 = P1toP2(p1, beta, mach)

    beta = beta *pi/180;
    m1n = mach*sin(beta);
    p2 = p1 * (1+2.8*(m1n.^2-1)/2.4);

end
function t2 = T1toT2(t1, beta, mach)
    
    beta = beta *pi/180;
    m1n = mach*sin(beta);
    t2 = t1 * (1+0.8*(m1n.^2-1)*(1.4*m1n.^2+1)/(1.4.^2*m1n.^2));

end
function stagPDif = StagPDif(p1, delta, beta, mach)
    
    p2 = P1toP2(p1, beta, mach);
    mach2 = M1toM2(delta, beta, mach);
    p02 = p2 * (1+0.2*mach2.^2).^(1.4/0.4);
    p01 = p1 * (1+0.2*mach.^2).^(1.4/0.4);
    
    stagPDif = p01 - p02;

end
function delta = Delta(beta, mach)
    
    syms x
    deltaBetaMachRelation = x == (2*cot(beta))*(mach.^2*sin(beta).^2-1)/(mach.^2*(1.4+cos(2*beta))+2); % x = tan(delta)
    y = solve(deltaBetaMachRelation, x);
    delta = atan(y)*180/pi;

end