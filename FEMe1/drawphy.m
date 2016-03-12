% Plot The Function On The Mesh

% Array Definition
phi = zeros(nver, 1);

phi(10) = 1;

figure();
patch('Vertices',[xv yv phi], 'Faces', vertices, 'FaceColor','w');
title = 'phy';
view(3);