function child = orderedCrossover(parent1, parent2)
nCities = length(parent1);
child = zeros(1, nCities);
% Select a random subset of the parent1 route
subsetStart = randi([1, nCities-1]);
subsetEnd = randi([subsetStart+1, nCities]);
subset = parent1(subsetStart:subsetEnd);

% Copy the subset to the child
child(subsetStart:subsetEnd) = subset;

% Copy the remaining cities from parent2 to the child
remainingCities = setdiff(parent2, subset);
remainingIndex = 1;
for i = 1:nCities
    if child(i) == 0
        child(i) = remainingCities(remainingIndex);
        remainingIndex = remainingIndex + 1;
    end
end
end