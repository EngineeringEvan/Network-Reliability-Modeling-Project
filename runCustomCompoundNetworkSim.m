function result = runCustomCompoundNetworkSim(K,p1,p2,p3,N)
% Simulates compound network with different per-link probabilities.
%
% Topology:
% (p1, p2) parallel links -> (p3) series link

simResults = zeros(1,N);

for i = 1:N
    txCount = 0;
    successCount = 0;

    while successCount < K
        txCount = txCount + 1;

        r1 = rand; r2 = rand; r3 = rand;
        if ((r1 > p1 || r2 > p2) && r3 > p3)
            successCount = successCount + 1;
        end
    end

    simResults(i) = txCount;
end

result = mean(simResults);
end
