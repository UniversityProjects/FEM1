% Plot The Approximated Solution Uh
% We consider only uh in the vertices

figure();
patch('Vertices',[xv yv uh(1:nver)], 'Faces', vertices, 'FaceColor','w');
title ('Approximated Solution On Vertices');
view(3);