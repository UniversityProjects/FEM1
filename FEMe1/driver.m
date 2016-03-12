clear all
close all

omega = 'square1';
% omega = 'square2';
% omega = 'square3';

% Create the mesh with the triangle application
makemesh;

% Import the mesh in matlab data structures
readmesh;

% Plot the mesh
drawmesh;

% Add triangle numbers
% numele;

% Add certices numbers
% numver;

% Plot Solution
drawsol;

% Plot Draw Phy
drawphy;