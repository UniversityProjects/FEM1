%clc
clear all
close all

plot = 'yes';
% plot = 'no';

% Arrays Definitions
N = [5, 10, 15, 20];
h = [0.01, 0.05, 0.15, 0.25];
omega = ['square1'; ... % h = 0.01
         'square2'; ... % h = 0.05
         'square3'; ... % h = 0.15
         'square4'; ... % h = 0.25
        ];
errL2_u = zeros(1,4);
errH1_u = zeros(1,4);
errL2_t = zeros(1,4);
errH1_t = zeros(1,4);
h_max = zeros(1,4);
h_avg = zeros(1,4);



% Uniform Mesh
for i=1:4
  disp(['Uniform mesh: N = ', num2str(N(i))]);
  [errL2_u(i), errH1_u(i), h_max(i), h_avg(i)] = fem2 ('uniform', N(i),'degree=3', 'no', 'yes', 'no');
  h_u(i) = h_avg(i);
end 

% Triangle NonUniform Mesh
for i=1:4
  disp(omega(i,:));
  [errL2_t(i), errH1_t(i), h_max(i), h_avg(i)] = fem2 (omega(i,:), h(i), 'degree=3', 'no', 'yes', 'no');
end 


disp(['N = ', num2str(N)]);
disp(['h_u = ', num2str(h_u)]);
disp(['errL2_u = ', num2str(errL2_u)]);
disp(['errH1_u = ', num2str(errH1_u)]);
disp(['h = ', num2str(h)]);
disp(['h_max = ', num2str(h_max)]);
disp(['h_avg = ', num2str(h_avg)]);
disp(['errL2_t = ', num2str(errL2_t)]);
disp(['errH1_t = ', num2str(errH1_t)]);
disp(' ');

if (strcmp(plot,'yes'))
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Uniform Mesh Plots
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  figure();
  title ('Uniform Mesh: ErrL2 - h^3');
  loglog (h_u, errL2_u, '-*r', h_u, h_u.^3,'-b');
  legend ('ErrL2', '(1/N) ^3');
  grid on;
  hold on;


  figure();
  title ('Uniform Mesh: ErrH1 - h^2');
  loglog (h_u, errH1_u, '-*r', h_u, h_u.^2,'-b');
  legend ('ErrH1', '(1/N) ^2');
  grid on;
  hold on;


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % NonUniform Mesh Plots
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  figure();
  title ('NonUniform Mesh: ErrL2 - h_max^3');
  loglog (h_max, errL2_t, '-*r', h_max, h_max.^3,'-b');
  legend ('ErrL2', 'h max ^3');
  grid on;
  hold on;


  figure();
  title ('NonUniform Mesh: ErrL2 - h_avg^3');
  loglog (h_avg, errL2_t, '-*r', h_avg, h_avg.^3,'-b');
  legend ('ErrL2', 'h avg ^3');
  grid on;
  hold on;


  figure();
  title ('NonUniform Mesh: ErrH1 - h_max^2');
  loglog (h_max, errH1_t, '-*r', h_max, h_max.^2,'-b');
  legend ('ErrH1', 'h max ^2');
  grid on;
  hold on;


  figure();
  title ('NonUniform Mesh: ErrH1 - h_avg^2');
  loglog (h_avg, errH1_t, '-*r', h_avg, h_avg.^2,'-b');
  legend ('ErrH1', 'h avg ^2');
  grid on;
  hold on;
  
end


