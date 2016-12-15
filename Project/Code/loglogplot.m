clc
clear all
close all

plot = 'yes';
% plot = 'no';

%N = [5, 10, 15, 20, 25, 30];
N = [30, 25, 20, 15, 10, 5];
h = [0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7];

omega = ['squar005'; ... % h = 0.05
         'square01'; ... % h = 0.1
         'square02'; ... % h = 0.2
         'square03'; ... % h = 0.3
         'square04'; ... % h = 0.4
         'square05'; ... % h = 0.5
         'square06'; ... % h = 0.6
         'square07'; ... % h = 0.7
        ];

% Uniform Mesh
for i=1:6
  disp(['Uniform mesh: N = ', num2str(N(i))]);
  [errL2_u(i), errH1_u(i), h_max(i), h_avg(i)] = fem2 ('uniform', N(i),'degree=5', 'no', 'yes', 'no');
  h_u(i) = 1/N(i);
  disp(['ErrL2: ', num2str(errL2_u(i))]);
  disp(['ErrH1: ', num2str(errH1_u(i))]);
  disp(' ');
end 

% Triangle NonUniform Mesh
for i=1:8
  disp(omega(i,:));
  [errL2_t(i), errH1_t(i), h_max(i), h_avg(i)] = fem2 (omega(i,:), h(i), 'degree=5', 'no', 'yes', 'no');
  disp(['ErrL2: ', num2str(errL2_t(i))]);
  disp(['ErrH1: ', num2str(errH1_t(i))]);
  disp(['h_max: ', num2str(h_max(i))]);
  disp(['h_avg: ', num2str(h_avg(i))]);
  disp(' ');
end 


N
errL2_u
errH1_u
h
errL2_t
errH1_t
disp(' ');

if (strcmp(plot,'yes'))
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Uniform Mesh Plots
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  figure();
  title ('Uniform Mesh: ErrL2 - h^3');
  loglog (h_u, errL2_u, '-r', h_u, h_u.^3,'-b');
  legend ('ErrL2', '(1/N) ^3');
  hold on;


  figure();
  title ('Uniform Mesh: ErrH1 - h^2');
  loglog (h_u, errH1_u, '-r', h_u, h_u.^2,'-b');
  legend ('ErrH1', '(1/N) ^2');
  hold on;


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % NonUniform Mesh Plots
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  figure();
  title ('NonUniform Mesh: ErrL2 - h_max^3');
  loglog (h_avg, errL2_t, '-r', h_max, h_max.^3,'-b');
  legend ('ErrL2', 'h max ^3');
  hold on;


  figure();
  title ('NonUniform Mesh: ErrL2 - h_avg^3');
  loglog (h_avg, errL2_t, '-r', h_avg, h_avg.^3,'-b');
  legend ('ErrL2', 'h avg ^3');
  hold on;


  figure();
  title ('NonUniform Mesh: ErrH1 - h_max^2');
  loglog (h_max, errH1_t, '-r', h_max, h_max.^2,'-b');
  legend ('ErrH1', 'h max ^2');
  hold on;


  figure();
  title ('NonUniform Mesh: ErrH1 - h_avg^2');
  loglog (h_avg, errH1_t, '-r', h_avg, h_avg.^2,'-b');
  legend ('ErrH1', 'h avg ^2');
  hold on;
end


