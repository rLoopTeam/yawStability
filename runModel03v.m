color = 'b';

m = 320;        % kg
L = 3.8;        % m
R = 0.5;        % m
c = 1000;       % Ns/m
k = 111000*2;   % N/m
v0 = 120;       % m/s
% For moment of inertia, assume the pod is a solid cylinder
I = 1/4*m*R^2 + 1/12*m*L^2;     % kg m^2

% Force application distance vectors from CG in meters
rDx = 0;      % rDy is variable, equals to -lateral pos
rE1 = [0 0.5];
rE2 = [0 -0.5];
rB1 = [0 0.5];
rB2 = [0 -0.5];
rS1 = [-1.9 0];
rS2 = [1.9 0];

% Forces in Newtons
FD = [-645 0];   
FE1 = [120 0];    
FB2 = [0 0];

% Null Scenario: Coast with zero disturbances, flat line response
% Engine
FE2x = 120;
FE2t = 1000;    % never shut off engine
% Brake
FB1x = 0;
FB1t = 1000;    % never shut off brake
% Track bump
dy = 0;         
dyt1 = 1000;    % never hit bump
dyt2 = 1000;    % never hit bump

% Track Bump: Step input into wheels
dy = 0.001;         
dyt1 = .2;    
dyt2 = .2 + L/v0;    
sim('rigidBody2D03v.mdl')
figure(1)
subplot(211)
hold on
title('Track Bump, 1 mm step input at 0.2 sec')
plot(position.time,position.signals(2).values,color)
ylabel('Lateral Drift (m)')
subplot(212)
hold on
plot(position.time,position.signals(3).values*180/pi,color)
ylabel('Yaw (degrees)')
dy = 0;

% Engine Failure: One side thrust engines fail
FE2t = .2;
sim('rigidBody2D03v.mdl')
figure(2)
hold on
subplot(211)
hold on
title('Engine Failure, right side engines fail at 0.2 sec')
plot(position.time,position.signals(2).values,color)
ylabel('Lateral Drift (m)')
subplot(212)
hold on
plot(position.time,position.signals(3).values*180/pi,color)
ylabel('Yaw (degrees)')
FE2t = 1000;

% % Brake Failure: One side brake fail
FB2 = [-1600 0];
FB1x = -1600;
FB1t = .2;
sim('rigidBody2D03v.mdl')
figure(3)
subplot(211)
title('Brake Failure, left side brakes fail at 0.2 sec')
hold on
plot(position.time,position.signals(2).values,color)
ylabel('Lateral Drift (m)')
subplot(212)
hold on
plot(position.time,position.signals(3).values*180/pi,color)
ylabel('Yaw (degrees)')
