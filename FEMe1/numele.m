%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write the triangle number in the mesh plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for iele=1:nel
    
    % Find The Vertices
    v1 = vertices(iele, 1);
    v2 = vertices(iele, 2);
    v3 = vertices(iele, 3);
    
    % First Vertex Coordinates
    x1 = xv(v1);
    y1 = yv(v1);
    
    % Second Vertex Coordinates
    x2 = xv(v2);
    y2 = yv(v2);
    
    % Third Vertex Coordinates
    x3 = xv(v3);
    y3 = yv(v3);
    
    % Baricenter
    xb = (x1 + x2 + x3)/3;
    yb = (y1 + y2 + y3)/3;
    
    % Plot triangle number
    text(xb, yb, num2str(iele), 'Color', 'b');
    
end