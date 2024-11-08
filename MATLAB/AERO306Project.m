% Tests ----------------------------------------------------------------

% These are to test my code using the specified input and output file
% names. I would recommend testing for accuracy using this method and
% looking in the command window. While I have output and labeled everything to the
% specified file, I couldn't organize the output as well as the output to
% the command window.

mesh = readMesh('306ProjectReadIn.txt','306ProjectOutput.txt')
properties = readProperties('306ProjectReadIn.txt','306ProjectOutput.txt')
constraints = readConstraints('306ProjectReadIn.txt','306ProjectOutput.txt')
loads = readLoads('306ProjectReadIn.txt','306ProjectOutput.txt')

gsm = assembleGlobalStiffnessMatrix('306ProjectReadIn.txt','306ProjectOutput.txt')
condensedK = imposeConstraints('306ProjectReadIn.txt','306ProjectOutput.txt')
displacements = solver('306ProjectReadIn.txt','306ProjectOutput.txt')
results = reportResults('306ProjectReadIn.txt','306ProjectOutput.txt')

element1K = getElementK(mesh, properties, 1)
element1DOF = getElementDOF(properties, 1)

% Functions -----------------------------------------------------------

function mesh = readMesh(inputFile,outputFile)

    fid = fopen(inputFile);
    a = 2; % number of nodes/when to end
    i = 1; % iterates through the lines
    j = 0; % tests if the number of nodes is found
    mesh = [];

    while i < a
        i = i + 1;
        row = fscanf(fid,'%g %g',[1 2]);
        if j == 0
            a = row(1) + 2;
            j = j + 1;
        else
            mesh = [mesh;row];
        end
    end

    fclose(fid);

    output = table(mesh(:,1),mesh(:,2),'VariableNames',["Node","Location"]);
    writetable(output,outputFile)

end
function properties = readProperties(inputFile,outputFile)

    fid = fopen(inputFile);
    a = 2; % when to end
    b = 0; % when to start
    i = 1; % iterates through the lines
    j = 0; % tests if the number of nodes is found
    properties = [];

    while i < a
        i = i + 1;
        if j == 0
            row = fscanf(fid,'%g %g',[1 2]);
            a = row(1) + row(1) + 2;
            b = row(1) + 2;
            j = 1;
        elseif i <= b
            row = fscanf(fid,'%g %g',[1 2]);
        else
            row = fscanf(fid,'%g %g %g', [1 3]);
            properties = [properties;row];
        end
    end
    
    fclose(fid);

    output = table(properties(:,1),properties(:,2),properties(:,3),'VariableNames',["Element","Node 1 Location","Node 2 Location"]);
    writetable(output,outputFile);
    lines = "Bottom Row Left to Right: Young's Modulus, Height, Width";
    writelines(lines,outputFile,WriteMode="append");

end
function constraints = readConstraints(inputFile,outputFile)
    
    fid = fopen(inputFile);
    a = 2; % when to end
    b = 0; % when to start reading properties
    c = 0; % when to start reading dof
    d = 0; % number of constraints
    i = 1; % iterates through the lines
    j = 0; % tests if the number of nodes is found
    constraints = [];

    while i < a
        i = i + 1;
        if j == 0
            row = fscanf(fid,'%g %g',[1 2]);
            a = row(1) + row(1) + 3;
            b = row(1) + 2;
            c = row(1) + row(1) + 2;
            j = 1;
        elseif i <= b
            row = fscanf(fid,'%g %g',[1 2]);
        elseif i <= c
            row = fscanf(fid,'%g %g %g', [1 3]);
        else
            d = fscanf(fid,'%g', [1 1]);
            constraints = fscanf(fid,'%g',[1 d]);
        end
    end
    
    fclose(fid);
    
    tableConstraints = transpose(constraints);
    output = table(tableConstraints,'VariableNames',"dof specified to be zero");
    writetable(output,outputFile);

end
function loads = readLoads(inputFile,outputFile)

    fid = fopen(inputFile);
    a = 2; % to end first while loop after dof
    b = 0; % when to start reading properties
    c = 0; % when to start reading dof
    d = 0; % number of constraints
    i = 1; % iterates through the lines
    j = 0; % tests if the number of nodes is found

    while i < a
        i = i + 1;
        if j == 0
            row = fscanf(fid,'%g %g',[1 2]);
            a = row(1) + row(1) + 3;
            b = row(1) + 2;
            c = row(1) + row(1) + 2;
            j = 1;
        elseif i <= b
            row = fscanf(fid,'%g %g',[1 2]);
        elseif i <= c
            row = fscanf(fid,'%g %g %g', [1 3]);
        else
            d = fscanf(fid,'%g', [1 1]);
            row = fscanf(fid,'%g',[1 d]);
        end
    end

    e = fscanf(fid,'%g',[1 1]); %number of point loads
    i=1;
    loads = [];
    
    while i < e + 2
        i = i + 1;
        row = fscanf(fid,'%g',[1 2]);
        loads = [loads;row];
    end

    fclose(fid);

    output = table(loads(:,1),loads(:,2),'VariableNames',["dof","load"]);
    writetable(output,outputFile);

end

function gsm = assembleGlobalStiffnessMatrix(inputFile,outputFile)

    mesh = readMesh(inputFile,outputFile);
    properties = readProperties(inputFile,outputFile);
    numberOfNodes = height(mesh);    
    gsm = zeros(2*numberOfNodes);
    i = 1;

    while i < numberOfNodes
        elementK = getElementK(mesh, properties, i);
        elementDOF = getElementDOF(properties, i);
            for j = 1:4
                for k = 1:4
                    gsm(elementDOF(j), elementDOF(k)) = ...
                                    gsm(elementDOF(j), elementDOF(k)) + ...
                                    elementK(j,k);
                end
            end
         i = i + 1;
    end
    
    writematrix(gsm,outputFile);
    lines = "DOFs in Order from Left to Right and Top to Bottom";
    writelines(lines,outputFile,WriteMode="append");


end
function condensedK = imposeConstraints(inputFile,outputFile)
    
    condensedK = assembleGlobalStiffnessMatrix(inputFile,outputFile);
    constraints = readConstraints(inputFile,outputFile);
    
    k = 0;
    for i = 1:length(constraints)
        if i > 1 && constraints(i) > constraints(i-1)
            k = k + 1;
        end
        condensedK(constraints(i)-k,:) = [];
        condensedK(:,constraints(i)-k) = [];
    end

    writematrix(condensedK,outputFile);
    lines = "DOFs in Order from Left to Right and Top to Bottom, Does Not include Constrained DOFs Listed Below";
    writelines(lines,outputFile,WriteMode="append");
    writematrix(constraints,outputFile,WriteMode="append");
    
end
function displacements = solver(inputFile,outputFile)
    
    numberOfNodes = fscanf(fopen(inputFile),'%g',[1 1]);
    Feq = sortrows(readLoads(inputFile,outputFile));
    FeqLong = zeros(2*numberOfNodes, 2);
    constraints = sort(readConstraints(inputFile,outputFile));
    k = 0;

    for i = 1:height(Feq)
        FeqLong(Feq(i),:) = Feq(i,:);
    end

    for i = 1:length(constraints)
        FeqLong(constraints(i)-k,:) = [];
        k = k + 1;
    end

    condensedFeq = FeqLong;
    condensedFeq(:,1) = [];
    
    displacements = imposeConstraints(inputFile,outputFile)\condensedFeq;

    output = table(displacements,'VariableNames',"Displacements");
    writetable(output,outputFile);

end
function results = reportResults(inputFile,outputFile)
    
    constraints = readConstraints(inputFile,outputFile);
    displacements = solver(inputFile,outputFile);
    numberOfNodes = (length(constraints) + height(displacements))/2;
    column1 = 1:numberOfNodes;
    column1 = transpose(column1);
    displacementNodes = [];
    column2 = zeros(height(column1),1);
    column3 = zeros(height(column1),1);

    for i = 1:2*numberOfNodes
        k = 0;
        for j = 1:length(constraints)
            if constraints(j) == i
                k = 1;
            end
        end
        if k == 0
            displacementNodes = [displacementNodes;i];
        end
    end

    displacements = [displacementNodes, displacements];

    k = 1;
    for i = 1:numberOfNodes
        if i*2-1 == displacements(k,1)
            column2(i) = displacements(k,2);
            k = k + 1;
        end
        if i*2 == displacements(k,1)
            column3(i) = displacements(k,2);
            k = k +1;
        end
    end

    results = table(column1,column2,column3,'VariableNames',["Node","Displacement","Rotation"]);
    writetable(results,outputFile)

end

function DOFs = getElementDOF(Properties, Element)

    node1 = 0;
    node2 = 0;
    i = 0;
    k = 0; % terminates the while loop when the element is found
    while k ~= 1
        i = i+1;
        if Element == Properties(i,1)
            node1 = Properties(i,2);
            node2 = Properties(i,3);
            k = 1;
        end
    end

    DOFs = [node1*2-1; node1*2; node2*2-1; node2*2];

end
function elementK = getElementK(Mesh, Properties, Element)

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
        if Element == Properties(i,1)
            node1 = Properties(i,2);
            node2 = Properties(i,3);
            k = 1;
        end
    end

    x1 = 0;
    x2 = 0;
    i = 0;
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