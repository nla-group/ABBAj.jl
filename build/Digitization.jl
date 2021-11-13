module Digitization
using ParallelKMeans
using Statistics

export digitization_k, Model

mutable struct Model
   centers::Array{Float64,}
   hashmap::Dict{Char,Int64}
end

function digitization_k(array, k::Int, nthreads::Int)
    features = collect(Matrix(array[:, 1:2])');
    result = kmeans(features, k; n_threads=nthreads);
    labels = result.assignments;
    symbols = map(x -> Char(x+33), labels);
    hashmap = Dict(zip(symbols, labels));
    centers = zeros((0, 2));
    features = features';
    for i in sort(unique(labels))
        condition = (labels .== i);
        group = features[condition, :];
        center = mean!([1. 1.], group);
        centers = vcat(centers, center);
    end
    model = Model(centers, hashmap);
    return symbols, model;
end



end