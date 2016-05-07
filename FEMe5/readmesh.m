% STRUTTURA DATI

% iv: generico vertice                iv=1:    nver
% iele: generico triangolo (elemento) iele=1:  nele
% iedge: generico edge (lato)         iedge=1: nedge

% (xv(iv),yv(iv)) = coordinate del vertice iv=1:nver
% vertexmarker(iv) = flag iv=1:nver
    
% vertices(iele,:) = vertici del triangolo iele [v1 v2 v3], iele=1:nele
% edges(iele,:) = edges del triangolo iele = [e1 e2 e3], iele=1:nele
% endpoints(iedge,:) = vertici dell'edge iedge = [v1 v2]
%
%         e2
%   v1 --------- v3               v1
%     \         /                  |
%      \  iele /                   | iedge orientato v1 --> v2
%    e3 \     /e1                  |   
%        \   /                     V
%         \ /                     v2
%         v2

% Read the mesh contained in omega


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vertices Acquisition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Open File Identificator In Reading Mode
fid = fopen([omega '.node']);

% Read First Row As An Integer Array
tmp = fscanf(fid,'%d',4);

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
nele = tmp(1);

% Elements Matrix Deinition
vertices = zeros(nele, 3);

% Read The Whole File To Acquisite The Elements
for iele=1:nele
   
    % Read iele Row
    % element_number (iv) - first vertex - second vertex - third vertex
    tmp = fscanf(fid,'%d', 4);
    
    % Filling The Arrays
    vertices(iele,1) = tmp(2); % First Vertex
    vertices(iele,2) = tmp(3); % Second Vertex
    vertices(iele,3) = tmp(4); % Third Vertex
    
end

% Close File Identificator
fclose(fid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Neigh Acquisition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open File Identificator In Reading Mode
fid = fopen([omega '.neigh']);

% Read First Row As An Integer Array
tmp = fscanf(fid,'%d',2);

% First Record Contains 
% Element Numbers - Neigh
% nele -> Element Number
nele = tmp(1);

% Neigh Tridimensional Matrix Definition
neigh = zeros(nele,3);

% Read The Whole File To Acquisite The Neighs
for iele=1:nele
    
  % Read iele Row
  % element_number (iv) - first neigh - second neigh - third neigh
  tmp = fscanf(fid,'%d',4);
  
  % Filling The Arrays
  neigh(iele,1) = tmp(2); % First Neigh
  neigh(iele,2) = tmp(3); % Second Neight
  neigh(iele,3) = tmp(4); % Third Neigh
end


% Close File Identificator
fclose(fid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edge Data Structure Creation: Author Alessandro Russo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


S = sparse(nele,nele);
T = sparse(nele,3);

nedge = 0;

endpoints = zeros(1,2);
edgemarker = zeros(2,1);

for iele=1:nele
    for i=1:3
        ielen = neigh(iele,i);
        if ielen==-1
            nedge = nedge + 1;
            T(iele,i) = nedge;
            endpoints(nedge,1:2) = setdiff(vertices(iele,:),vertices(iele,i));
            edgemarker(nedge) = 1;
        else
            if ~S(iele,ielen)
                nedge = nedge + 1;
                S(iele,ielen) = nedge;
                S(ielen,iele) = nedge;
                endpoints(nedge,1:2) = intersect(vertices(iele,:),vertices(ielen,:));
                edgemarker(nedge) = 0;
            end
        end
    end
end

edges1 = zeros(nele,3);
edges = zeros(nele,3);

for iele=1:nele
    fS = full(S(iele,:));
    fT = full(T(iele,:));
    edges1(iele,:) = [fS(find(fS)) fT(find(fT))];
end

for iele=1:nele
    v1 = vertices(iele,1);
    v2 = vertices(iele,2);
    v3 = vertices(iele,3);
    for i=1:3
        e = edges1(iele,i);
        v = endpoints(e,:);
        if length(intersect([v1 v2],v))==2
            edges(iele,3) = e;
        elseif length(intersect([v2 v3],v))==2
            edges(iele,1) = e;
        elseif length(intersect([v3 v1],v))==2
            edges(iele,2) = e;
        end
    end
end
    
