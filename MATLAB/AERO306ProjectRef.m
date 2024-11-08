% Test ------------------------------------------------------------------

% '306ProjectReadIn.txt' was the name of the file I was using to test the
% code. Make sure to put the new .txt file as input for the functions below
% to test.

% The commented out lines: 15-18 and 154-260 are for part 2 of the project and
% should remain commented out to test part 1

Mesh = readMesh('306ProjectReadIn.txt')              
Properties = readProperties('306ProjectReadIn.txt')
Constraints = readConstraints('306ProjectReadIn.txt')
Loads = readLoads('306ProjectReadIn.txt')

% GSM = assembleGlobalStiffnessMatrix('306ProjectReadIn.txt')
% condensedK = imposeConstraints('306ProjectReadIn.txt')
% displacements = solver('306ProjectReadIn.txt')
% results = reportResults('306ProjectReadIn.txt')

% Part 1 ----------------------------------------------------------------

function Convertible = makeConvertible(inputFile)

    A = fileread(inputFile);
    B = convertCharsToStrings(A);
    Convertible = splitlines(B);

end
function Mesh = readMesh(inputFile)

    C = makeConvertible(inputFile);

    i = 1;
    Y = [];
    while C(i) ~= ""
        X = split(C(i));
        Y = [Y X];
        i = i+1;
    end
    
    Nodes = [];
    for i = 1:length(Y) % side note: Nodes(1) is the number of nodes
        Nodes(i,1) = str2num(Y(1,i));
    end
    
    NodeLocations = [];
    for i = 1:length(Y)  % side note: NodeLocations(1) is the number of elements
        NodeLocations(i,1) = str2num(Y(2,i));
    end

    Mesh = [Nodes NodeLocations];

end
function Properties = readProperties(inputFile)

    C = makeConvertible(inputFile);

    i = 0; % iterates when an empty line is met
    j = 0; % searches through C
    Y = [];
    while i ~= 3
        j = j+1;
        if C(j) == ""
            i = i+1;
        elseif i ~= 0 
            X = split(C(j));
            Y = [Y X];
        end
    end
    Y = transpose(Y);

    P = [];
    for i = 1:height(Y)
        P = [P; str2num(Y(i,1))];
    end
    Q = [];
    for i = 1:height(Y)
        Q = [Q; str2num(Y(i,2))];
    end
    R = [];
    for i = 1:height(Y)
        R = [R; str2num(Y(i,3))];
    end

    Properties = [P Q R];

end
function Constraints = readConstraints(inputFile)

    C = makeConvertible(inputFile);

    i = 0; % iterates when an empty line is met
    j = 0; % searches through C
    k = 0; % makes the while loop stop as soon as an answer is found
    Y = [];
    while k ~= 1
        j = j+1;
        if C(j) == ""
            i = i+1;
        end
        if i == 3 
            X = split(C(j+2));
            Y = [C(j+1); X];
            k = 1;
        end
    end

    Constraints = [];
    for i = 1:height(Y)
        Constraints = [Constraints; str2num(Y(i,1))];
    end

end
function Loads = readLoads(inputFile)

    C = [makeConvertible(inputFile); ""];

    i = 0; % iterates when an empty line is met
    j = 0; % searches through C
    k = 0; % a check to adjust the matrix for the number of point loads value
    Y = [];
    while i ~= 5
        j = j+1;
        if C(j) == ""
            i = i+1;
        elseif i == 4
            if k == 0
                Y = [C(j); 0];
                k = 1;
            else
                X = split(C(j));
                Y = [Y X];
            end
        end
    end
    Y = transpose(Y);

    DOFs = [];
    for i = 1:height(Y)
       DOFs = [DOFs; str2num(Y(i,1))];
    end

    Loads = [];
    for i = 1:height(Y)
       Loads = [Loads; str2num(Y(i,2))];
    end    

    Loads = [DOFs Loads];

end

% Part 2 ----------------------------------------------------------------

function GSM = assembleGlobalStiffnessMatrix(inputFile)

    Mesh = readMesh('306ProjectReadIn.txt');
    Properties = readProperties('306ProjectReadIn.txt');
    numberOfElements = height(Properties)-1;
    numberOfNodes = numberOfElements+1;
    n = numberOfNodes*numberOfElements;
%     x = 2*numberOfNodes;
%     y = 2*(numberOfElements-1);
%     z = 0;

    zeroMatrix = zeros(n);
    for i = 1:numberOfElements
        fprintf("Element %g's DOFs:", i); 
        q = getElementDOF(Properties,i)
        fprintf("Element %g's Stiffness Matrix:", i); 
        K = getElementK(Mesh, Properties,i)
%         zeroMatrix(4*(i-1)+1:4*i,4*(i-1)+1:4*i) = K;
    end

%     intermediateMatrix = zeros(n,x);
%     intermediateMatrix(1:n,1) = zeroMatrix(1:n,1);
%     intermediateMatrix(1:n,2) = zeroMatrix(1:n,2);
%     intermediateMatrix(1:n,x-1) = zeroMatrix(1:n,n-1);
%     intermediateMatrix(1:n,x) = zeroMatrix(1:n,n);
%     for i = 0:y
%         if mod(y,2) ~= 0 
%             intermediateMatrix(1:n,y+2) = zeroMatrix(1:n,2*y+1) + zeroMatrix(1:n,2*y+3);
%         else
%             intermediateMatrix(1:n,y+2) = zeroMatrix(1:n,2*y) + zeroMatrix(1:n,2*y+2);
%         end
%     end
% 
%     intermediateMatrix
% 
    GSM = 1;

end
function condensedK = imposeConstraints(inputFile)
    condensedK = 1;
end
function displacements = solver(inputFile)
    displacements = 1;
end
function results = reportResults(inputFile)
    results = 1;
end
function DOFs = getElementDOF(Properties, element)

    node1 = 0;
    node2 = 0;
    i = 0;
    k = 0; % terminates the while loop when the element is found
    while k ~= 1
        i = i+1;
        if element == Properties(i,1)
            node1 = Properties(i,2);
            node2 = Properties(i,3);
            k = 1;
        end
    end

    DOFs = [node1*2-1; node1*2; node2*2-1; node2*2];

end
function elementK = getElementK(Mesh, Properties, element)

    E = Properties(height(Properties),1);
    b = Properties(height(Properties),3);
    h = Properties(height(Properties),2);
    I = b*h.^3/12;

    node1 = 0;
    node2 = 0;
    i = 0;
    k = 0; % terminates the while loop when the element is found
    while k ~= 1
        i = i+1;
        if element == Properties(i,1)
            node1 = Properties(i,2);
            node2 = Properties(i,3);
            k = 1;
        end
    end

    x1 = 0;
    x2 = 0;
    i = 1;
    k = 0; % terminates the while loop when both nodes are found
    while k ~= 2
        i = i+1;
        if node1 == Mesh(i,1)
            x1 = Mesh(i,2);
            k = k+1;
        elseif node2 == Mesh(i,1)
            x2 = Mesh(i,2);
            k = k+1;
        end
    end
    L = abs(x2-x1);
    
    elementK = E*I/L.*[12/L.^2 6/L -12/L.^2 6/L;...
                       6/L 4 -6/L 2;...
                       -12/L.^2 -6/L 12/L.^2 -6/L;...
                       6/L 2 -6/L 4];

end