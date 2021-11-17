module ABBAj
include("Compress.jl")
include("Digitization.jl")
include("Reconstruction.jl")
using .Compress, .Digitization, .Reconstruction
using Statistics

export fit_transform, inverse_transform, standard_data, load_sample


"""
ABBA: adaptive Brownian bridge-based symbolic aggregation of time series
    A novel time series symbolic compressed technique with mean-based clustering.

Examples:
julia> time_series = load_samples(); # load time series samples 

julia> symbols, model = fit_transform(time_series, 20, 0.1); # use 20 symbols with compressed tolerance of 0.1
julia> r_time_series = inverse_transform(symbols, model, time_series[1]); # inverse transform time series

julia> symbols, model = fit_transform(time_series, 20, 0.1, 10); # use 20 symbols with compressed tolerance of 0.1 
                                                                 # and run in parallel kmeans with 10 threads
julia> r_time_series = inverse_transform(symbols, model, time_series[1]); # inverse transform time series

Reference
Elsworth, S., Güttel, S. ABBA: adaptive Brownian bridge-based symbolic aggregation of time series. 
Data Min Knowl Disc 34, 1175–1200 (2020). https://doi.org/10.1007/s10618-020-00689-6

"""
global ABBA_PARAM_MU, ABBA_PARAM_SCL = Ref{Float64}(0.0), Ref{Float64}(1.0)

function fit_transform(series::AbstractVector, k::Int, tol=0.5::AbstractFloat, 
                       nthreads=Threads.nthreads()::Int, max_len=typemax(Int)::Int
                       )
    @assert(k > 0 && typeof(k) == Int)
    @assert(tol > 0)
    @assert(max_len >=1)
    global ABBA_PARAM_MU, ABBA_PARAM_SCL;
    scl_series, ABBA_PARAM_MU, ABBA_PARAM_SCL= standard_data(series);
    if (ABBA_PARAM_SCL==0)
       ABBA_PARAM_SCL = 1;
    end
    # scl_series = copy(series);
    compressed = compress(scl_series, tol, max_len);
    symbols, model = digitization_k(compressed, k, nthreads);
    
    return symbols, model;
end


function inverse_transform(symbols::Array{Char,1}, 
                           model::Digitization.Model, 
                           start=0.0::AbstractFloat
                           )
    pieces = inverse_digitize(symbols, model);
    pieces = quantize(pieces);
    reconstructed_ts = inverse_compress(pieces, start);
    reconstructed_ts = broadcast(*, reconstructed_ts, ABBA_PARAM_SCL);
    reconstructed_ts = broadcast(+, reconstructed_ts, ABBA_PARAM_MU);
    return reconstructed_ts;
end



function standard_data(series::AbstractVector)
    PARARM_SCL = Statistics.std(series);
    PARARM_MU =  mean(series);
    scl_series = broadcast(-, copy(series), PARARM_MU);
    scl_series = broadcast(/, scl_series, PARARM_SCL);
    return scl_series, PARARM_MU, PARARM_SCL;
end



function load_sample(len=1000::Int, freq=20.0::AbstractFloat)
    sample = zeros(len);
    j = 1;
    for i in range(0, len-1, step=1)*(1/freq)
        sample[j] = sin(i);
        j = j + 1;
    end
    return sample;
end

end
