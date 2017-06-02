%% Computational Fluid Dynamics 2016 | Coursework 2: Section 1
%NAME: Von Neumann Analysis of the two-step Lax-Friedrichs scheme for the linear advection equation
%GOAL: For the linear advection equation, discretised using the two-step Lax-Friedrichs stencil, the behaviour of the phase and diffusion errors with frequency will be plotted. For various values of the Courant (sigma) number.
%Created by: SERGIU PETRE ILIEV. Date: 30.I.2015
%Imperial College London | Aeronautical Engineering | Dr Georgios Papadakis | AE3-414 Computational Fluid Dynamics | Coursework II

%% Clean and prepare workspace
clear               % Clear all variables
clc                 % Clear the window
close all           % Close figures


%% Initialise parameters
n=1800;                             % Number of phase increments to consider (i.e. resolution of the graph)
phi=0:(2*pi()/(n-1)):2*pi();        % Define the phase vector between 0 and pi with resolution (n) specified above

CFL=[0.1, 0.5, 0.8, 1, 1.2, 1.5];   % Define the values to be considered for CFL number, at least one must be defined, the graph is defined for exactly six.
Gm=zeros(n,size(CFL,2));            % Preallocate an array for the amplification factor magnitude that is to be calculated for all phase increments (rows) and CFL cases (columns) to be considered

%% Determine the values of the amplification factor magnitude (Gm)
% Switch between the CFL numbers we are interested in observing and calculate Gm for each
for i=1:1:size(CFL,2)
      Gm(:,i)=sqrt( ((1-CFL(i)^2)/2 + ((1+CFL(i)^2)/2).*cos(phi)).^2 + (CFL(i).*sin(phi)).^2 );        % Algorithm from equation (18) in the report
end

%% Plot graphs
set(0,'defaulttextinterpreter','latex')                                                     % Use the LaTeX interpreter for all of the

% Set axes limits and formatting
axes1 = axes('Parent',figure,'YMinorTick','on','XMinorTick','on',...
    'XTick',[0 0.5 1 1.5 2 2.5 3 3.1415]);
xticklabels({'0','0.5','1','2','2.5','3','\pi'})
xlim(axes1,[0 3.1415]);
grid(axes1,'on');
hold(axes1,'on');

% Create the rest of the graph
title('Variation of the amplification factor magnitude with phase for various values of the CFL')
plot(phi, Gm(:,1),'k:',  'LineWidth',1.0);
plot(phi, Gm(:,2),'m-.', 'LineWidth',1.0);
plot(phi, Gm(:,3),'b--', 'LineWidth',1.0);
plot(phi, Gm(:,4),'r-', 'LineWidth',1.5);
plot(phi, Gm(:,5),      'LineWidth',1.0);
plot(phi, Gm(:,6),'g',  'LineWidth',1.1);
ylabel('Amplification Factor $\mid G \mid$','interpreter','latex');                         % Label the y axis
xlabel('Phase Angle $\phi_{m}$ (radians)','interpreter','latex');                           % Label the x axis
legend('\lambda=0.1', '\lambda=0.5', '\lambda=0.8', '\lambda=1', '\lambda=1.2', '\lambda=1.5', 'Location','northwest')      % Specify the legend and its position