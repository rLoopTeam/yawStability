% plotSim04v.m - make plots for simulation run

% Drift plot
subplot(221)
hold on
plot(position.time,position.signals(2).values)
ylabel('Lateral Drift (m)')
% Yaw plot
subplot(222)
hold on
plot(position.time,position.signals(3).values*180/pi)
ylabel('Yaw (degrees)')
% Brake plot
subplot(223)
hold on
plot(rightBrake.time,rightBrake.signals(1).values)
plot(leftBrake.time,leftBrake.signals(1).values,'r')
legend('R','L')
ylabel('Brake Force (N)')
xlabel('Time (sec)')
% Suspension plot
subplot(224)
hold on
plot(suspension.time,suspension.signals(1).values)
plot(suspension.time,suspension.signals(2).values,'r')
legend('F','R')
ylabel('Spring Load (N)')
xlabel('Time (sec)')
