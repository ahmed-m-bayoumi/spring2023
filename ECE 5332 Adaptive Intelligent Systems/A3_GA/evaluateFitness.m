function fitness = evaluateFitness(route, cities)
    nCities = length(route);
    fitness = 0;
    for i = 1:nCities-1
        fitness = fitness + norm(cities(route(i+1), :) - cities(route(i), :));
    end
    fitness = fitness + norm(cities(route(1), :) - cities(route(nCities), :));
end