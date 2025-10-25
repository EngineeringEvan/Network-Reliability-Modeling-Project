function result = runCompoundNetworkSim(K,p,N)
% Simulates a compound network: two parallel links followed by one in series.

simResults = zeros(1,N);

for i = 1:N
    txCount = 0;
    successCount = 0;

    while successCount < K
        txCount = txCount + 1;

        % Parallel section
        r1 = rand; r2 = rand;
        parallelSuccess = (r1 > p || r2 > p);

        % Series link
        r3 = rand;

        if (parallelSuccess && r3 > p)
            successCount = successCount + 1;
        end
    end

    simResults(i) = txCount;
end

result = mean(simResults);
end
