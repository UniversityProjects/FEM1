% Plot Mesh

figure();
title = ['Mesh - ' omega];
patch('Vertices',[xv yv], 'Faces', vertices, 'FaceColor','w');
