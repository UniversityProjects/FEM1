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
disp('--- Building Mesh ---');
makemesh;

% Read The Mesh
disp('--- Reading Mesh ---');
readmesh;

% Plot The Mesh
disp('--- Drawing Mesh ---');
drawmesh;

% Quadrature Formula
fdq = 'degree=5';

% (xhq, yhq) Quadrature's Nodes
% whq = pesi
disp('--- Quadrature Computation ---');
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
disp('--- Basis Functions Phi Computation ---');
for i=1:6
    for q=1:Nq
        phihq(i,q) = phih2(i,xhq(q),yhq(q));
    end
end

% Basis Functions Gradients Computation Loop
disp('--- Gradient Basis Functions Phi Computation ---');
for i=1:6
    for q=1:Nq
        [gx gy] = gradphih2(i,xhq(q),yhq(q));
        gphihqx(i,q) = gx;
        gphihqy(i,q) = gy;
    end
end

% A Matrix Definition
A = sparse(nver+nedge,nver+nedge);

% b Array Definition
b = zeros(nver+nedge,1);

% Main Computation Loop On Every Triangle
disp('--- A Matrix and b Array Computation ---');
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

% Recover Triangle's Edges
    l1 = edges(iele,1); % First Edge
    l2 = edges(iele,2); % Second Edge
    l3 = edges(iele,3); % Third Edge

% Global Degrees Of Freedon

    % Vertex i ---> i
    % Edge i   ---> nver
    % This array gives the current triangle's Global Degrees Of Freedom
    dofg = [v1 v2 v3 (nver+l1) (nver+l2) (nver+l3)];


% Global Matrix A Computation
    A(dofg,dofg) = A(dofg,dofg) + KE;
    
    
% FE Array Definition   
    FE = zeros(6,1);
    
% Actual Array Fe Computation Loop  
    for i=1:6
        for q=1:Nq
            % Image on T (current triangle) Of The Quadrature Node
            % tmp = (xq, yq) = (xhq(q),yhq(q))
            tmp = JF*[xhq(q); yhq(q)] + [x1; y1];
            xq = tmp(1); % Quadrature Node X Coordinate
            yq = tmp(2); % Quadrature Node Y Coordinate
            FE(i) = FE(i) + f(xq,yq)*phihq(i,q)*whq(q);        
        end
        FE(i) = 2*area*FE(i);
    end

% Global b Coefficient Computation
    b(dofg) = b(dofg) + FE;
    
    
end

% Spy A Matrix
disp('--- Spying A matrix ---');
figure();
spy(A);


 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Border Conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('--- Border Conditions ---');

% Free Nodes Array Definition
NL = [];

% Approximated Solution Array Definition
uh = zeros(nver+nedge,1);

for iv=1:nver
    % Check if the iv vertex is a border vertex
    if (vertexmarker(iv) == 1) % Dirichlet Condition
        uh(iv) = g(xv(iv),yv(iv));
        % Update Constant Term
        b = b - uh(iv)*A(:,iv);
    else % Free Node
        NL = [NL iv];
    end    
end


for iedge=1:nedge  
    % Border Degree Of Freedom
    dof = nver+iedge;  
    % Constant Term Update    
    if edgemarker(iedge)==1 % Border Edge
    % Edge Medium Point 
        % First Point
        v1 = endpoints(iedge,1);
        x1 = xv(v1);
        y1 = yv(v1);
        % Second Point
        v2 = endpoints(iedge,2);
        x2 = xv(v2);
        y2 = yv(v2);
        % Medium Point Computation
        xm = (x1 + x2) / 2;
        ym = (y1 + y2) / 2;
    % Constant Tern Update
        uh(dof) = g(xm,ym);
        b = b -uh(dof)*A(:,dof);
    else % Free Edge       
        NL = [NL dof];        
    end    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Approximate Solution Computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('--- Solution Computing ---');

% Exctract The True Kh Matrix On The Free Nodes
Kh = A(NL,NL);

% Exctract The True fh Array On The Free Nodes
fh = b(NL);

% Compute The Approximated Solution
uh(NL) = Kh\fh;

% Solution Plot
disp('--- Drawing Solution ---');
drawuh;

% Uh Max
disp(['--- Uh max: ' num2str(max(uh)) ' ---']);
    