% Plot The Exact Solution Ue
% We consider only ue in the vertices

% Ue Computing
for iv=1:nver
    zv(iv) = ue(xv(iv), yv(iv));    
end

figure();
patch('Vertices',[xv yv zv], 'Faces', vertices, 'FaceColor','w');
view(3);