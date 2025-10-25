function result = runTwoParallelLinkSim(K,p,N)
% Simulates transmissions through two parallel links (either link succeeds).

simResults = zeros(1,N);

for i = 1:N
    txCount = 0;
    successCount = 0;

    while successCount < K
        txCount = txCount + 1;
        r1 = rand; r2 = rand;
        if (r1 > p || r2 > p)
            successCount = successCount + 1;
        end
    end

    simResults(i) = txCount;
end

result = mean(simResults);
end
