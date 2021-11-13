module Reconstruction

export inverse_compress, inverse_digitize, quantize

function inverse_compress(pieces::Array{Float64,}, start=0.0::AbstractFloat)
    """
    Reconstruct time series from its first value `start` and its `pieces`.
    `pieces` must have (at least) two columns, incremenent and window width, resp.
    A window width w means that the piece ranges from s to s+w.
    In particular, a window width of 1 is allowed.

    Parameters
    ----------
    start - 
        First element of original time series. Applies vertical shift in
        reconstruction.

    pieces - 
        Array with three columns, each row contains increment, length,
        error for the segment. Only the first two columns are required.

    Returns
    -------
    time_series : Reconstructed time series
    """
    
    r_time_series = [start];
    num_pieces = size(pieces)[1];
    for j in range(1, stop=num_pieces)
        x = range(0, stop=pieces[j,1]) / (pieces[j,1]) * pieces[j,2];
        y = broadcast(+, r_time_series[length(r_time_series)], x);
        r_time_series = vcat(r_time_series, y[2:length(y)]);
    end
    return r_time_series
end


function inverse_digitize(symbols::Array{Char,1}, model)
    """
    Convert symbolic representation back to compressed representation for reconstruction.

    Parameters
    ----------
    symbols - 
        Time series in symbolic representation using unicode characters starting
        with character 'a'.

    centers - 
        Centers of clusters from clustering algorithm. Each centre corresponds
        to character in string.

    Returns
    -------
    pieces - 
        Time series in compressed format. 
    """
    
    pieces = zeros((0, 2));
    for symbol in symbols
        pc = model.centers[model.hashmap[symbol],:];
        pieces = vcat(pieces, pc');
    end
    return pieces;
end


function quantize(pieces::Array{Float64,})
    """
    Realign window lengths with integer grid.

    Parameters
    ----------
    pieces: Time series in compressed representation.


    Returns
    -------
    pieces: Time series in compressed representation with window length adjusted to integer grid.
    """
    num_pieces = size(pieces)[1];
    if num_pieces == 1
        pieces[1,1] = round(pieces[1,1], digits=0);
    else
        for p in range(1, stop=num_pieces-1)
            corr = round(pieces[p,1]) - pieces[p,1];
            pieces[p,1] = round(pieces[p,1] + corr);
            pieces[p+1,1] = pieces[p+1,1] - corr;
            if pieces[p,1] == 0
                pieces[p,1] = 1;
                pieces[p+1,1] = pieces[p+1,1] - 1;
            end
        end
        
        pieces[num_pieces,1] = round(pieces[num_pieces,1],digits=0);
    end
    return pieces;
end


end