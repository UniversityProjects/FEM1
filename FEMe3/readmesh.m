% Read the mesh contained in omega


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vertices Acquisition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Open File Identificator In Reading Mode
fid = fopen([omega '.node']);

% Read First Row As An Integer Array
tmp = fscanf(fid,'%d', 4);

% First Record Contains 
% Vertices Number - Dimension - 0 - Flag
% nnod -> Vertices Number
nver = tmp(1);

% Vertices Coordinates Arrays Definition
xv = zeros(nver,1);
yv = zeros(nver,1);

% Border Flag Array Definition
vertexmarker = zeros(nver,1);

% Read The Whole File To Acquisite The Mesh
for iv=1:nver
   
    % Read iv Row
    % point_number (iv) - x coordinate - y coordinate - border flag
    tmp = fscanf(fid,'%f', 4);
    
    % Filling The Arrays
    xv(iv) = tmp(2);
    yv(iv) = tmp(3);    
    vertexmarker(iv) = tmp(4);   
    
end

% Close File Identificator
fclose(fid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elements Acquisition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Open File Identificator In Reading Mode
fid = fopen([omega '.ele']);

% Read First Row As An Integer Array
tmp = fscanf(fid,'%d', 3);

% First Record Contains 
% Element Numbers - Dimension - 0 - Flag
% nel -> Element Number
nel = tmp(1);

% Elements Matrix Deinition
vertices = zeros(nel, 3);

% Read The Whole File To Acquisite The Elements
for iel=1:nel
   
    % Read iel Row
    % element_number (iv) - first vertex - second vertex - third vertex
    tmp = fscanf(fid,'%d', 4);
    
    % Filling The Arrays
    vertices(iel,1) = tmp(2); % First Vertex
    vertices(iel,2) = tmp(3); % Second Vertex
    vertices(iel,3) = tmp(4); % Third Vertex
    
end

% Close File Identificator
fclose(fid);





