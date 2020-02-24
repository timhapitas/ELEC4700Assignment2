addpath('./code/');
 
close all;
clear;
clc;

% ---------- 1 a) and b) ---------- %

Question1;

% ---------- 2 a) ---------- %
[currentLeft, currentRight] = Question2(1, 1, 1e-2, 1, 1/3, 1/3);

% ---------- 2 b) ---------- %
meshSize = [0.5 0.75 1 1.25 1.5];
currentLeftVec = zeros(1, length(meshSize));
currentRighVec = zeros(1, length(meshSize));

for i = 1:length(meshSize)
   
    [currentLeftVec(i), currentRighVec(i)] = Question2(meshSize(i), 1, 1e-2, 0, 1/3, 1/3);
    
end

figure;
plot(meshSize, currentLeftVec, 'r');
hold on;
plot(meshSize, currentRighVec, 'b');
hold off;
legend('Current through left contact', 'Current through right contact');
grid on;
title('Contact currents Vs. Mesh Size');
xlabel('Mesh size (m)');
ylabel('Current through contacts (A)');

% ---------- 2 c) ---------- %

bottleneckLength = [1/5 1/4 1/3 1/2];
bottleneckWidth = [1/5 1/4 1/3 1/2];
currentLeftVec = zeros(1, length(bottleneckLength));
currentRighVec = zeros(1, length(bottleneckLength));

% first vary bottleneck length
for i = 1:length(bottleneckLength)
   
    [currentLeftVec(i), currentRighVec(i)] = Question2(meshSize(i), 1, 1e-2, 0, bottleneckLength(i), 1/3);
    
end

figure;
plot(bottleneckLength, currentLeftVec, 'r');
hold on;
plot(bottleneckLength, currentRighVec, 'b');
hold off;
legend('Current through left contact', 'Current through right contact');
grid on;
title('Contact currents Vs. Bottleneck Length');
xlabel('Bottleneck Length (fraction of region length L)');
ylabel('Current through contacts (A)');

% then vary bottleneck width
for i = 1:length(bottleneckWidth)
   
    [currentLeftVec(i), currentRighVec(i)] = Question2(meshSize(i), 1, 1e-2, 0, 1/3, bottleneckWidth(i));
    
end

figure;
plot(bottleneckWidth, currentLeftVec, 'r');
hold on;
plot(bottleneckWidth, currentRighVec, 'b');
hold off;
legend('Current through left contact', 'Current through right contact');
grid on;
title('Contact currents Vs. Bottleneck Width');
xlabel('Bottleneck Width (fraction of region width W)');
ylabel('Current through contacts (A)');


% ---------- 2 d) ---------- %
% vary background sigma, hold resistive region sigma fixed

backgroundCondVec = [0.5, 0.75, 1, 1.25 1.5];
currentLeftVec = zeros(1, length(backgroundCondVec));
currentRighVec = zeros(1, length(backgroundCondVec));

for i = 1:length(backgroundCondVec)
   
    [currentLeftVec(i), currentRighVec(i)] = Question2(1, backgroundCondVec(i), 1e-2, 0, 1/3, 1/3);
    
end

figure;
plot(backgroundCondVec, currentLeftVec, 'r');
hold on;
plot(backgroundCondVec, currentRighVec, 'b');
hold off;
legend('Current through top contact', 'Current through bottom contact');
grid on;
title('Contact currents Vs. Background Conductivity of Region');
xlabel('Background Conductivity (\Omega^{-1})');
ylabel('Current through contacts (A)');

