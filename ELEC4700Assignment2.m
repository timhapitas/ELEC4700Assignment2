Question1;

% ---------- 2 a) ---------- %
[currentTop, currentBottom] = Question2(1, 1, 1e-2, 1);

% ---------- 2 b) ---------- %
meshSize = [0.5 0.75 1 1.25 1.5];
currentTopVec = zeros(1, length(meshSize));
currentBotVec = zeros(1, length(meshSize));

for i = 1:length(meshSize)
   
    [currentTopVec(i), currentBotVec(i)] = Question2(meshSize(i), 1, 1e-2, 0);
    
end

figure;
plot(meshSize, currentTopVec, 'r');
hold on;
plot(meshSize, currentBotVec, 'b');
hold off;
legend('Current through top contact', 'Current through bottom contact');
grid on;
title('Contact currents Vs. Mesh Size');
xlabel('Mesh size (m)');
ylabel('Current through contacts (A)');

% ---------- 2 c) ---------- %


% ---------- 2 d) ---------- %
% vary background sigma, hold resistive region sigma fixed

backgroundCondVec = [0.5, 0.75, 1, 1.25 1.5];
currentTopVec = zeros(1, length(backgroundCondVec));
currentBotVec = zeros(1, length(backgroundCondVec));

for i = 1:length(meshSize)
   
    [currentTopVec(i), currentBotVec(i)] = Question2(1, backgroundCondVec(i), 1e-2, 0);
    
end

figure;
plot(backgroundCondVec, currentTopVec, 'r');
hold on;
plot(backgroundCondVec, currentBotVec, 'b');
hold off;
legend('Current through top contact', 'Current through bottom contact');
grid on;
title('Contact currents Vs. Background Conductivity of Region');
xlabel('Background Conductivity (\Omega^{-1})');
ylabel('Current through contacts (A)');

