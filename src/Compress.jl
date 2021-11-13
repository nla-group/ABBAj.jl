module Compress
using LinearAlgebra, Statistics

export compress

function compress(series::AbstractVector, tol=0.5::AbstractFloat, max_len=typemax(Int)::Int)
    """
    Approximate a time series using a continuous piecewise linear function.

    Parameters
    ----------
    series - 
        Time series as input of numpy array
    
    tol - default 0.5
        the tolerance will restrict the compression, the higher it is,
        the more accurate the reconstruction will be

    max_len - default typemax(Int)
        The max length of the pieces for the compression

    Returns
    -------
    pieces - 
        Array with three columns, each row contains length, increment, error for the segment.
    """
    # print("tol:", tol, "\n");
    pieces = zeros((0, 3));
    # pieces = Any[]
    num_ts = length(series);

    x = range(0, num_ts-1, step=1);
    start = 1;    
    _end = 2;    
    epsilon = eps(1.0);  # 2.220446049250313e-16
    (lastinc, lasterr) = (0, 0);
    while _end <= num_ts
        inc = series[_end] - series[start];
        term = broadcast(+, series[start] , (inc / (_end-start)) * x[1:_end-start+1]);  
        term = broadcast(-, term, series[start:_end]);
        err = opnorm(term', 2)^2;
        if (err <= tol*(_end-start-1) + epsilon) && (_end-start-1 < max_len)
            (lastinc, lasterr) = (inc, err);
            _end = _end + 1;
            # continue
        else
            pieces = vcat(pieces, [_end-start-1, lastinc, lasterr]');
            # push!(pieces, [_end-start-1, lastinc, lasterr]);
            start = _end - 1;
        end
    end
    
    # push!(pieces, [_end-start-1, lastinc, lasterr]);
    pieces = vcat(pieces, [_end-start-1, lastinc, lasterr]');
    # pieces = to_matrix(pieces, 3);
    return pieces;
end

# function to_matrix(pieces::Array{Any, 1}, dim::Int)
#     T_MATRIX = zeros((length(pieces), dim));
#     row = 1;
#     for piece in pieces
#         T_MATRIX[row, :] = piece;
#         row = row + 1;
#     end
#     return T_MATRIX;
# end

end
