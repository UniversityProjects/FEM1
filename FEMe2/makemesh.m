% Generates the mesh from the .poly file
% Uses the software triangle: https://www.cs.cmu.edu/~quake/triangle.html

% Triangle Options
% -p Triangulates a .poly file
% -q Quality mesh generation with no angles smaller than 20 degrees. 
% -a Imposes a maximum triangle area constraint (Read from the .poly file)
% -I Suppresses mesh iteration numbers
% -Q No output except for errors

% Generate the mesh specified in the .poly file
system(['triangle -pqaIQ ' omega '.poly']);