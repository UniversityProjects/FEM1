% Plot The Solution Uh
% We consider only uh in the vertices

figure();
patch('Vertices',[xv yv uh(1:nver)], 'Faces', vertices, 'FaceColor','w');
view(3);