% Plot The Function On The Mesh

% Array Definition
vh = zeros(nver, 1);

for iv=1:nver
    
    % Vertex Coordinates
    x = xv(iv);
    y = yv(iv);
    
    % Function Computation On The Basis
    vh(iv) = sin(5*x)*cos(8*x);

end

figure();
patch('Vertices',[xv yv vh], 'Faces', vertices, 'FaceColor','w');
view(3);