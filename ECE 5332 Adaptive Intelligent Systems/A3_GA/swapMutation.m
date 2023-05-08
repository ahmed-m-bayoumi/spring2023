function mutatedRoute = swapMutation(route)
    nCities = length(route);
    % Select two random cities to swap
    i = randi([1, nCities]);
    j = randi([1, nCities]);
    % Swap the cities
    temp = route(i);
    route(i) = route(j);
    route(j) = temp;
    mutatedRoute = route;
end