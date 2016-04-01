clear all
close all

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
drawmesh;

% Domain Area
area = 0;

% General Matrix Definition As A Sparse Matrix (Without Border Conditions)
% Full(M) Transform The Sparse Matrix M In A Full Matrix
Ah = sparse(nver, nver);

% Constant Term Definition (Without Border Conditions)
bh = zeros(nver, 1);

% Main Computation Loop On Every Triangle
for iele=1:nel
    
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
    
    
% Triangles Definition
    
    % Triangle Barycenter
    xb = (x1 + x2 + x3)/3;
    yb = (y1 + y2 + y3)/3;
    
    %  Segment Between 3 and 2 
    e1 = [x3 - x2, y3 - y2];
    
    %  Segment Between 1 and 3 
    e2 = [x1 - x3, y1 - y3];
    
    %  Segment Between 2 and 1 
    e3 = [x2 - x1, y2 - y1];
    
    % Medium Pont Segment 23
    M1x = (x2 + x3)/2;
    M1y = (y2 + y3)/2;
    
    % Medium Pont Segment 13
    M2x = (x1 + x3)/2;
    M2y = (y1 + y3)/2;
    
    % Medium Pont Segment 12
    M3x = (x1 + x2)/2;
    M3y = (y1 + y2)/2;
    
    % Triangle Area With The Determinant Formula
    T = 0.5*det([1  1  1
                 x1 x2 x3
                 y1 y2 y3]);
                      
    % Total Domain Area
    area = area + T;
    
    % KhT Element Matrix         
    KhT = (1/(4*T))*[dot(e1,e1) dot(e2,e1) dot(e3,e1)
                    dot(e1,e2) dot(e2,e2) dot(e3,e2)
                    dot(e1,e3) dot(e2,e3) dot(e3,e3)]; 
    
    % General Diffusion Term c(x,y)            
    KhT = c(xb,yb)*KhT;
    
    
    % Adding Reaction Term With Medium Point
    % KhT = KhT + (T/9)*[alfa(x1,y1) 0 0 % Trapezoid Method
    %                    0 alfa(x2,y2) 0 
    %                    0 0 alfa(x3,y3)]  
    KhT = KhT + (T/9)*alfa(xb,yb)*ones(3,3); % Midpoint Method
                
    % K Matrix Computation
    % Kh(v1,v1) = Kh(v1,v1) + KhT(1,1)
    % Kh(v1,v2) = Kh(v1,v2) + KhT(1,2) 
    % .
    % .
    % .
    % We Can Directly Use The Matlab Matrix Summation Rule
    Ah([v1 v2 v3], [v1 v2 v3]) = Ah([v1 v2 v3], [v1 v2 v3]) + KhT;
    
    % Elementary Constant Term fhT Computation
    fhT_t = (T/3) *[f(x1,y1) f(x2,y2) f(x3,y3)]'; % Trapezoid Method
    fhT_b = (T/3) * f(xb,yb) * [1 1 1]'; % Midpoint (Barycenter) Method
    fhT_m = (T/6) * [f(M2x,M2y) + f(M3x,M3y) % Second Order Method 
                     f(M1x,M1y) + f(M3x,M3y) % With Evaluation On The 
                     f(M1x,M1y) + f(M2x,M2y)]; % Midpoints
    % Generak Constant Term fh Computation With The Trapezoid Method
    bh([v1 v2 v3]) = bh([v1 v2 v3]) + fhT_t;
    
    
end

% Free Vertices Array Definition
VL = [];

% Solution Array
uh = zeros(nver,1);

% Border Conditions
for iv=1:nver
    
    % Border Vertex
    if vertexmarker(iv) > 0 % Dirichlet, > 0, Neumann < 0
        
        x = xv(iv);
        y = yv(iv);
        
        % Border Function Value g Interpolation
        uh(iv) = g(x,y);
        
        % Constant Term Variation Computation
        % Ah(:,iv) -> iv Column Of Ah Matrix
        bh = bh - uh(iv)*Ah(:,iv);
    
    % Inside Vertex, vertexmarker = 0    
    else 
        
        % Builds Free Vertices Array
        VL = [VL iv]; 
    
    end
    
end

% Kh Definition With Border Conditions
% (Consider Only Inside Vertices)
Kh = Ah(VL, VL);

% fh Definition With Border Conditions
% (Consider Only Inside Vertices)
fh = bh(VL);


% Solution Computation
uh(VL) = Kh\fh;


% Solution Plot
drawuh;



% Errors Computing

% Max Error Tmp Variable
errmax = 0;

% Error Computing Loop
for iv=1:nver
    
    % Exact Solution In Each Vertex iv
    ueiv = ue(xv(iv), yv(iv));
    
    % Error In Each Vertex iv
    erriv = abs(uh(iv)-ueiv);
    
    % Max Error Computation
    if erriv > errmax
       
        errmax = erriv;
        
    end
    
end

disp('Errmax = '),disp(errmax);


