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

% legge la mesh contenuta in omega

fid = fopen([omega '.node']);

% leggo la prima riga

tmp = fscanf(fid,'%d',4); % tmp = vettore
nver = tmp(1);

xv = zeros(nver,1); % vettore colonna di nver zeri
yv = zeros(nver,1);
vertexmarker = zeros(nver,1);

% leggiamo le coord e i flag dei nodi

for iv=1:nver
    %
    tmp = fscanf(fid,'%f',4);
    %
    xv(iv) = tmp(2);         % coord x
    yv(iv) = tmp(3);         % coord y
    %
    vertexmarker(iv) = tmp(4); % flag
    %
end

fclose(fid); % chiudo il file dei nodi

fid = fopen([omega '.ele']);
tmp = fscanf(fid,'%d',3);

nele = tmp(1);
vertices = zeros(nele,3);

for iele=1:nele
  tmp = fscanf(fid,'%d',4);
  vertices(iele,1) = tmp(2);
  vertices(iele,2) = tmp(3);
  vertices(iele,3) = tmp(4);
end

fclose(fid);

fid = fopen([omega '.neigh']);
tmp = fscanf(fid,'%d',2);

nele = tmp(1);
neigh = zeros(nele,3);

for iele=1:nele
  tmp = fscanf(fid,'%d',4);
  neigh(iele,1) = tmp(2);
  neigh(iele,2) = tmp(3);
  neigh(iele,3) = tmp(4);
end

fclose(fid);

% crea struttura edge

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
    
