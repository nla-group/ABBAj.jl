# Julia-ABBA


A Julia version of ABBA with parallel k-means implementation

ABBA is a symbolic representation method, which achives time series compression and discretization 
by transforming time series into symbolic representation. The package provides Julia implementation of ABBA 
method, also use ParallelKMeans.jl to achieve speedup the digitization. 


## Examples

```
julia> time_series = load_samples(); # load time series samples 
julia> symbols, model = fit_transform(time_series, 4, 0.1); # use 4 symbols with compressed tolerance of 0.1
julia> r_time_series = inverse_transform(symbols, model, time_series[1]); # inverse transform time series
julia> symbols, model = fit_transform(time_series, 4, 0.1, 10); # use 4 symbols with compressed tolerance of 0.1 
                                                                # and run in parallel kmeans with 10 threads
julia> r_time_series = inverse_transform(symbols, model, time_series[1]); # inverse transform time series

```

### Referece

Elsworth, S., Güttel, S. ABBA: adaptive Brownian bridge-based symbolic aggregation of time series. Data Min Knowl Disc 34, 1175–1200 (2020). https://doi.org/10.1007/s10618-020-00689-6