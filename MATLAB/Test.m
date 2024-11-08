syms x C1 C2

numElem = 3;
elemLengths = [10/3, 10/3, 10/3];
elemDOFs = [1,2 ; 2,3 ; 3,4];
elemCoords = [0, elemLengths(1), elemLengths(1) + elemLengths(2), elemLengths(1) + elemLengths(2) + elemLengths(3)];
Elem_mid = [5/3, 5, 25/3];

dispBCs = [1,0];
forceBCs = [];

E = 10^7;
A = 0.1;
L = 10;
f_dist = 200*(1-x/L);

K_global = zeros(numElem + 1, numElem + 1);
Q_global = zeros(numElem + 1, 1);
Q_FBC = zeros(numElem + 1, 1);

for i=1:size(forceBCs,1)
	Q_global(forceBCs(i,1)) = forceBCs(i,2);
end

for i=1:numElem
	K = E*A/elemLengths(i)*[1, -1; -1, 1];
	Q_dist = [subs(f_dist, x, Elem_mid(i))*elemLengths(i)/2; subs(f_dist, x, Elem_mid(i))*elemLengths(i)/2];
	for j = 1:2
		for k = 1:2
			K_global(elemDOFs(i,j), elemDOFs(i,k)) = K_global(elemDOFs(i,j), elemDOFs(i,k)) + K(j,k);
		end
		Q_global(elemDOFs(i,j)) = Q_global(elemDOFs(i,j)) + Q_dist(j);
	end
end

for i = 1:size(dispBCs,1)
	K_global(dispBCs(i,1), dispBCs(i,1)) = K_global(dispBCs(i,1), dispBCs(i,1))*1E15;
	Q_global(dispBCs(i,1)) = dispBCs(i,2)*K_global(dispBCs(i,1), dispBCs(i,1));
end

q_global_3 = inv(K_global)*Q_global
K_global_3 = K_global
Q_global_3 = Q_global

numElem = 6;
elemLengths = [10/6, 10/6, 10/6, 10/6, 10/6, 10/6];
elemDOFs = [1,2; 2,3 ; 3,4; 4,5; 5,6; 6,7];
elemCoords = [0, 10/6, 20/6, 30/6, 40/6, 50/6, 60/6];
Elem_mid = [5/6, 5/2, 25/6, 35/6, 15/2, 55/6];

dispBCs = [1, 0];
forceBCs = [];

E = 10^7;
A = 0.1;
L = 10;
f_dist = 200*(1-x/L);

K_global = zeros(numElem + 1, numElem + 1);
Q_global = zeros(numElem + 1, 1);
Q_FBC = zeros(numElem + 1, 1);

for i=1:size(forceBCs, 1)
	Q_global(forceBCs(i,1)) = forceBCs(i,2);
end

for i=1:numElem
	K = E*A/elemLengths(i)*[1, -1; -1, 1];
	Q_dist = [subs(f_dist, x, Elem_mid(i))*elemLengths(i)/2; subs(f_dist,x, Elem_mid(i))*elemLengths(i)/2];
	for j = 1:2
		for k = 1:2
			K_global(elemDOFs(i,j), elemDOFs(i,k)) = K_global(elemDOFs(i,j), elemDOFs(i,k))+K(j,k);
		end
		Q_global(elemDOFs(i,j)) = Q_global(elemDOFs(i,j))+Q_dist(j);
	end
end

for i=1:size(dispBCs,1)
	K_global(dispBCs(i,1), dispBCs(i,1)) = K_global(dispBCs(i,1), dispBCs(i,1))*1E15;
	Q_global(dispBCs(i,1)) = dispBCs(i,2)*K_global(dispBCs(i,1), dispBCs(i,1));
end

q_global_6 = inv(K_global)*Q_global
K_global_6 = K_global
Q_global_6 = Q_global

u_exact = int(int(-f_dist)+C1)/(E*A)+C2;
force = E*A*diff(u_exact);

eqn1 = subs(u_exact,x,0) == 0;
eqn2 = subs(force,x,L) == 0;
sol = solve([eqn1,eqn2], [C1, C2]);

u_exact = subs(u_exact, [C1, C2], [sol.C1, sol.C2]);

elemCoords_3  = [0, 10/3, 20/3, 30/3];
elemCoords_6 = [0, 10/6, 20/6, 30/6, 40/6, 50/6, 60/6];
figure
hold on
box on
grid on
fplot (u_exact, [0,10], 'k', 'LineWidth', 3)
plot(elemCoords_3, transpose(q_global_3), 'b--', 'LineWidth', 3)
plot(elemCoords_6, transpose(q_global_6), 'o--', 'LineWidth', 3)
legend('Exact Solution', '3 Element Approximation', '6 Element Approximation',...
	'Location', 'southeast')
set(findall(gcf, 'property', 'FontSize'),...
	'FontSize', 16, 'FontName', 'times')
set(gcf, 'Units', 'inches', 'Position', [4.5,2.5,9.5,7.5])
xlabel('\it{x}', 'FontSize', 20, 'FontName', 'times', 'FontWeight', 'bold')
ylabel('\it{y}', 'FontSize', 20, 'FontName', 'times', 'FontWeight', 'bold')
