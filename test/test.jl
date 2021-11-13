include("ABBA.jl")
using .ABBA

Seed = 0;
Random.seed!(Seed);

std = 0.5;
time_series = rand(Normal(0.0, std), 100);

symbols, model = fit_transform(time_series,20, 0.1);
r_time_series = inverse_transform(symbols, model, time_series[1]);
print(r_time_series);
