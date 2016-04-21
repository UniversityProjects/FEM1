%%%%%%%%%%%%%%%%%%%
% FEM for k = 2
%%%%%%%%%%%%%%%%%%%

clear all
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mesh Creation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Domain Definition
omega = 'square'; % Unit Square
% omega = 'squareN'; % Unit Square With Neumann Conditions On A Border
% omega = 'igloo'; % Unit Square With Neumann Conditions On Half Border
% omega = 'squareCdisc'; % Unit Square With Neumann Conditions On Half Border

% Build The Mesh
makemesh;

% Read The Mesh
readmesh;

% Plot The Mesh
% drawmesh;

% Quadrature Formula
fdq = 'degree=5';

% (xhq, yhq) Quadrature's Nodes
% whq = pesi
[xhq,yhq,whq] = quadrature(fdq);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kh Matrix Assembling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Basis Function Computed On The Quadrature Nodes Of The Riferement Element

Nq = length(xhq); % Number Of Quadrature Nodes
phihq = zeros(6,Nq); % Phihq Definition
gphihqx = zeros(6,Nq); % Gradphihq Definition
gphihqy = zeros(6,Nq); % Gradphihq Definition

% Basis Functions Computation Loop
for i=1:6
    for q=1:Nq
        phihq(i,q) = phih2(i,xhq(q),yhq(q));
    end
end

% Basis Functions Gradients Computation Loop
for i=1:6
    for q=1:Nq
        [gx gy] = gradphih2(i,xhq(q),yhq(q));
        gphihqx(i,q) = gx;
        gphihqy(i,q) = gy;
    end
end

% Main Computation Loop On Every Triangle
for iele=1:nele
    
% Acquire Informations From The iele Elements
    
    % Vertices Acquisition
    v1 = vertices(iele,1);
    v2 = vertices(iele,2);
    v3 = vertices(iele,3);
    
    
    % Vextx 1 Coordinates
    x1 = xv(v1);
    y1 = yv(v1);
    
    % Vextx 2 Coordinates
    x2 = xv(v2);
    y2 = yv(v2);
    
    % Vextx 3 Coordinates
    x3 = xv(v3);
    y3 = yv(v3);  
    
    
 % Jacobian Matrix Computation
 
    % F Jacobian
    JF = [x2 - x1   x3 - x1
          y2 - y1   y3 - y1];
      
    % F Jacobian Inverse
    JFI = inv(JF);
    
    % F Jacobian Inverse Transpost
    JFIT = JFI';
    
    
% Single Element Area
    area = 0.5*det(JF);
    
% KE Matrix Definition   
    KE = zeros(6,6);
    
% Actual Matrix KE Computation Loop    
    for i=1:6
        for j=1:i-1 % Loop That Use Matrix Symmetry To Halve The Computations
            KE(i,j) = KE(j,i);
        end
        for j = i:6
            for q=1:Nq
                % Image on T (current triangle) Of The Quadrature Node
                % tmp = (xq, yq) = (xhq(q),yhq(q))
                tmp = JF*[xhq(q); yhq(q)] + [x1; y1];
                xq = tmp(1); % Quadrature Node X Coordinate
                yq = tmp(2); % Quadrature Node Y Coordinate
                KE(i,j) = KE(i,j) + c(xq,yq)*dot(...
                                                JFIT*[gphihqx(j,q);...
                                                      gphihqy(j,q)],...
                                                JFIT*[gphihqx(i,q);...
                                                      gphihqy(i,q)]...
                                                )*whq(q);
            
            end
            KE(i,j) = 2*area*KE(i,j);
        end
    end
    

% Global Matrix K Computation
    
    
end
    
    
    
    
    