% Plot The Solution Uh

figure();
patch('Vertices',[xv yv uh], 'Faces', vertices, 'FaceColor','w');
view(3);