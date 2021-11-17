# ABBAj.jl

[![Build Status](https://app.travis-ci.com/nla-group/ABBAj.jl.svg?branch=master)](https://app.travis-ci.com/github/nla-group/ABBAj.jl)
[![Build Status](https://github.com/nla-group/ABBAj.jl/actions/workflows/ci.yml/badge.svg)](https://github.com/nla-group/ABBAj.jl/actions)
[![codecov](https://codecov.io/gh/nla-group/ABBAj.jl/branch/master/graph/badge.svg?token=19A3126WBX)](https://codecov.io/gh/nla-group/ABBAj.jl)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nla-group/jlABBA/HEAD)

Documentation for ABBAj.jl: A Julia version of ABBA with parallel k-means implementation

A Julia version of ABBA with parallel k-means implementation 
> + Documentation: [![Dev](https://img.shields.io/badge/docs-latest-blue.svg)](https://nla-group.github.io/ABBAj.jl/dev/)

ABBA (Adaptive Brownian bridge-based aggregation) is a symbolic time series representation method introduced by Elsworth Steven and Stefan Güttel, which archives time-series compression and discretization by transforming time series into a symbolic representation. The package provides lightweight Julia implementation of the ABBA method, also use ParallelKMeans.jl to achieve speedup in the digitization. 

## Installation
You can simply install the stable version of this package by running in Julia:

```julia
pkg> add ABBAj
```

## Transform
The following functions aims to transform time series into symbols

- [`fit_transform(series::AbstractVector, k::Int, tol=0.5::AbstractFloat, nthreads=Threads.nthreads()::Int, max_len=typemax(Int)::Int)`](@ref)

`compress` aims to compress time series into stacked array, i.e., pieces. Each row refers to the segment information (length, increment, errors)

- [`compress(series::AbstractVector, tol=0.5::AbstractFloat, max_len=typemax(Int)::Int)`](@ref)

`digitization_k` aims to digitize time series pieces into symbols

- [`digitization_k(array, k::Int, nthreads::Int)`](@ref)


The following functions aims to transform symbols back to time series.

`inverse_digitize` aims to reconstruct pieces from symbols.

- [`inverse_digitize(symbols::Array{Char,1}, model)`](@ref)

`quantize` aims to try to reduce the length difference between reconstructed time series and original time series.

- [`quantize(pieces::Array{Float64,})`](@ref)

`inverse_compress` aims to reconstruct time series from reconstructed pieces.

- [`inverse_compress(pieces::Array{Float64,}, start=0.0::AbstractFloat)`](@ref)




## Examples

Run ABBA in all threads:
```julia
julia> time_series = load_sample(); # load time series samples 
julia> symbols, model = fit_transform(time_series, 4, 0.1); # use 4 symbols with compressed tolerance of 0.1
julia> r_time_series = inverse_transform(symbols, model, time_series[1]); # inverse transform time series
```

Run ABBA by specifying the threads:
```julia
julia> time_series = load_sample(); # load time series samples 
julia> symbols, model = fit_transform(time_series, 4, 0.1, 10); # use 4 symbols with compressed tolerance of 0.1 
                                                                # and run in parallel kmeans with 10 threads
julia> r_time_series = inverse_transform(symbols, model, time_series[1]); # inverse transform time series

```

![Reconstruction](demo.png)
### Referece

Elsworth, S., Güttel, S. ABBA: adaptive Brownian bridge-based symbolic aggregation of time series. Data Min Knowl Disc 34, 1175–1200 (2020). https://doi.org/10.1007/s10618-020-00689-6
