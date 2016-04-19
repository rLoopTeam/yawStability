% runModel04v.m - execute rPod Simulink models. Initialize first, then each
% scenario (split into MATLAB script cells) can run as independent code.

%% Initialize model
m = 320;        % Mass of pod - kg
L = 3.8;        % Length of pod - m
R = 0.5;        % Radius of pod - m
c = 5000;      % Damping constant - Ns/m
k = 111000*2;   % Spring constant (2 springs) - N/m
v0 = 120;       % Initial velocity - m/s
Nm = 24;        % Number of N42 magnets per side

% For moment of inertia, assume the pod is a solid cylinder
I = 1/4*m*R^2 + 1/12*m*L^2;     % kg m^2

% Force application distance vectors from CG in meters
rDx = 0;      % note: rDy is variable, equals to -lateral pos
rE1 = [0 0.5];
rE2 = [0 -0.5];
rB1 = [0 0.5];
rB2 = [0 -0.5];
rS1 = [-1.9 0];
rS2 = [1.9 0];

% Forces in Newtons
FD = [-645 0];  % Drag force - N 
FE1 = [120 0];  % Engine force (2 engines) - N  

% Load brake model
load('brakemodel04v.mat')

% Initialize system inputs to null effect
% Engine
FE2x = 120;     % Engine force at sim start (2 engines) - N
FE2t = 10000;   % Engine shutdown time - sec

% Brake
dBR = 0.008;    % Right brake application at time - m
dBRt = .2;      % Right brake time - sec
dBL = 0.008;    % Left brake application at time - m
dBLt = .2;      % Left brake time - sec

% Track bump
dy = 0;         % Track bump - m
dyt1 = 1000;    % Track bump time for front suspension - sec
dyt2 = 1000;    % Track bump time for brakes - sec
dyt3 = 1000;    % Track bump time for rear suspension - sec 

%% Null Scenario: Coast with zero disturbances, should have flat response
% Sim and plot
figure(1)
sim('rigidBody2D04v.mdl')
plotSim04v

%% Track Bump: track step input into shock absorbers and brake system
% Track bump
tL = L/v0;      
dy = 0.001;       
dyt1 = .2;     
dyt3 = .2+tL/2; 
dyt2 = .2+tL; 

% Sim and plot
figure(2)
sim('rigidBody2D04v.mdl')
plotSim04v

% Reset track bump
dy = 0;  
dyt1 = 1000;
dyt2 = 1000;
dyt3 = 1000;
 
%% Engine Failure: One side thrust engines fail
% Engine
FE2t = .2;

% Sim and plot
figure(3)
sim('rigidBody2D04v.mdl')
plotSim04v

% Reset engine
FE2t = 10000; 

%% Brake Failure: One side brake application
% Brake
dBR = 0.002;    

% Sim and plot
figure(4)
sim('rigidBody2D04v.mdl')
plotSim04v

% Reset Brake
dBR = 0.008;    

%% Brake Delay: One side brake application lags the other
% Brake 
dBR = 0.002;
dBL = 0.002;
dBLt = 0.4;

% Sim and plot
figure(5)
sim('rigidBody2D04v.mdl')
plotSim04v

% Reset brake
dBR = 0.008;
dBL = 0.008;
dBLt = 0.2;