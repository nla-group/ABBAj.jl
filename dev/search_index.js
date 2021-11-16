var documenterSearchIndex = {"docs":
[{"location":"#ABBAj.jl","page":"Home","title":"ABBAj.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Build Status) (Image: Build Status) (Image: codecov) (Image: License) (Image: Binder)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Documentation for ABBAj.jl: A Julia version of ABBA with parallel k-means implementation","category":"page"},{"location":"","page":"Home","title":"Home","text":"A Julia version of ABBA with parallel k-means implementation ","category":"page"},{"location":"","page":"Home","title":"Home","text":"Documentation: (Image: Dev)","category":"page"},{"location":"","page":"Home","title":"Home","text":"ABBA (Adaptive Brownian bridge-based aggregation) is a symbolic time series representation method introduced by Elsworth Steven and Stefan Güttel, which archives time-series compression and discretization by transforming time series into a symbolic representation. The package provides lightweight Julia implementation of the ABBA method, also use ParallelKMeans.jl to achieve speedup the digitization. ","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"You can simply install the stable version of this package by simply running in Julia:","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> add ABBAj","category":"page"},{"location":"#Examples","page":"Home","title":"Examples","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"julia> time_series = load_samples(); # load time series samples \njulia> symbols, model = fit_transform(time_series, 4, 0.1); # use 4 symbols with compressed tolerance of 0.1\njulia> r_time_series = inverse_transform(symbols, model, time_series[1]); # inverse transform time series\njulia> symbols, model = fit_transform(time_series, 4, 0.1, 10); # use 4 symbols with compressed tolerance of 0.1 \n                                                                # and run in parallel kmeans with 10 threads\njulia> r_time_series = inverse_transform(symbols, model, time_series[1]); # inverse transform time series\n","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: Digitization)","category":"page"},{"location":"#Referece","page":"Home","title":"Referece","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Elsworth, S., Güttel, S. ABBA: adaptive Brownian bridge-based symbolic aggregation of time series. Data Min Knowl Disc 34, 1175–1200 (2020). https://doi.org/10.1007/s10618-020-00689-6","category":"page"}]
}