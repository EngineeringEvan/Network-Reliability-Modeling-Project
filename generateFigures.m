% generateFigures.m
clear; close all; clc;

Ks = [1, 5, 15, 50, 100];
ps = 0:0.05:0.95;
N = 1000;

%% =======================
%  Task 1 – Single Link
%  =======================
disp('Running Single Link Simulations...');

% --- Individual Figures for each K ---
for K = Ks
    simRes = arrayfun(@(p) runSingleLinkSim(K,p,N), ps);
    calcRes = K ./ (1 - ps); % Analytical expected transmissions

    figure;
    semilogy(ps, calcRes, '-', 'LineWidth', 1.5, 'DisplayName','Calculated');
    hold on;
    semilogy(ps, simRes, 'o', 'DisplayName','Simulated');
    xlabel('Failure Probability (p)');
    ylabel('Average Number of Transmissions');
    title(['Single Link Network - K = ', num2str(K)]);
    legend('show', 'Location', 'northwest');
    grid on;
end

% --- Combined Figure for all K values ---
figure;
hold on;
for K = Ks
    simRes = arrayfun(@(p) runSingleLinkSim(K,p,N), ps);
    calcRes = K ./ (1 - ps);

    semilogy(ps, calcRes, '-', 'LineWidth', 1.5, ...
        'DisplayName', sprintf('Calc K=%d', K));
    semilogy(ps, simRes, 'o', ...
        'DisplayName', sprintf('Sim K=%d', K));
end
xlabel('Failure Probability (p)');
ylabel('Average Number of Transmissions');
title('Single Link Network – All K Values');
legend('show', 'Location', 'northwest');
grid on;
hold off;


%% =======================
%  Task 2 – Two Series Links
%  =======================
disp('Running Two Series Link Simulations...');

% --- Individual Figures for each K ---
for K = Ks
    simRes = arrayfun(@(p) runTwoSeriesLinkSim(K,p,N), ps);
    calcRes = K ./ ((1 - ps).^2); % Analytical expectation for 2 series links

    figure;
    semilogy(ps, calcRes, '-', 'LineWidth', 1.5, 'DisplayName','Calculated');
    hold on;
    semilogy(ps, simRes, 'o', 'DisplayName','Simulated');
    xlabel('Failure Probability (p)');
    ylabel('Average Number of Transmissions');
    title(['Two Series Links - K = ', num2str(K)]);
    legend('show', 'Location', 'northwest');
    grid on;
end

% --- Combined Figure for all K values ---
figure;
hold on;
for K = Ks
    simRes = arrayfun(@(p) runTwoSeriesLinkSim(K,p,N), ps);
    calcRes = K ./ ((1 - ps).^2);

    semilogy(ps, calcRes, '-', 'LineWidth', 1.5, ...
        'DisplayName', sprintf('Calc K=%d', K));
    semilogy(ps, simRes, 'o', ...
        'DisplayName', sprintf('Sim K=%d', K));
end
xlabel('Failure Probability (p)');
ylabel('Average Number of Transmissions');
title('Two Series Link Network – All K Values');
legend('show', 'Location', 'northwest');
grid on;
hold off;


%% =======================
%  Task 3 – Two Parallel Links
%  =======================
disp('Running Two Parallel Link Simulations...');
for K = Ks
    simRes = arrayfun(@(p) runTwoParallelLinkSim(K,p,N), ps);
    figure;
    semilogy(ps, simRes, 'o');
    xlabel('Failure Probability (p)');
    ylabel('Avg Transmissions');
    title(['Two Parallel Links - K = ', num2str(K)]);
    grid on;
end


%% =======================
%  Task 4 – Compound Network
%  =======================
disp('Running Compound Network Simulations...');
for K = Ks
    simRes = arrayfun(@(p) runCompoundNetworkSim(K,p,N), ps);
    figure;
    semilogy(ps, simRes, 'o');
    xlabel('Failure Probability (p)');
    ylabel('Avg Transmissions');
    title(['Compound Network - K = ', num2str(K)]);
    grid on;
end


%% =======================
%  Task 5 – Custom Compound Network
%  =======================
disp('Running Custom Compound Network Simulations...');
Kvals = [1, 5, 10];
pRange = 0.01:0.05:0.99;

configs = {
    [0.10 0.60 NaN],  % p3 varies
    [0.60 0.10 NaN],
    [0.10 NaN 0.60],
    [0.60 NaN 0.10],
    [NaN 0.10 0.60],
    [NaN 0.60 0.10]
};

for c = 1:length(configs)
    cfg = configs{c};
    figure;
    hold on;
    for K = Kvals
        simRes = zeros(size(pRange));
        for i = 1:length(pRange)
            p1 = cfg(1); p2 = cfg(2); p3 = cfg(3);
            if isnan(p1), p1 = pRange(i); end
            if isnan(p2), p2 = pRange(i); end
            if isnan(p3), p3 = pRange(i); end
            simRes(i) = runCustomCompoundNetworkSim(K,p1,p2,p3,N);
        end
        semilogy(pRange, simRes, 'o', 'DisplayName',['K=',num2str(K)]);
    end
    xlabel('Variable p (failure probability)');
    ylabel('Avg Transmissions');
    title(['Custom Compound Network - Config ', num2str(c)]);
    legend show; grid on;
end

disp('All simulations complete!');
