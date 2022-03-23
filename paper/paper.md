---
title: 'ABBAj.jl: An accelerated ABBA in Julia'
tags:
  - time series
  - symbolic representation
  - data mining
authors:
  - name: Xinye Chen
    orcid: 0000-0003-1778-393X
    affiliation: 1
affiliations:
  - name: Department of Mathematics, The University of Manchester
    index: 1
date: 11 March 2022
bibliography: paper.bib
---

# Summary

Adaptive Brownian bridge-based aggregation (ABBA) [@EG19b] is a symbolic time series representation method that is applicable to general time series. It is based on an adaptive polygonal chain approximation, followed by a mean-based clustering algorithm. Compared to raw data, transforming time series into a sequence of symbols with ABBA enjoys numerous benefits including dimensionality reduction, noise reduction, feature discretization, and so on. ABBA follows two steps to symbolize time series, namely compression and digitization. The benefits of symbolic time series representation by ABBA include but are not limited to: (1) ABBA symbolic representation aims to preserve the original shape of the original time series data, as demonstrated in performance profiles of [@EG19b]; (2) the symbolic sequence can reflect the local up and down behavior of the time series and help find repeated motif; (3) With respect to time series forecasting, symbolic representation transformed by ABBA has recently been demonstrated to reduce sensitivity to the LSTM hyper-parameters and the initialization of random weights against original time series [@EG20b].  

![Runtime comparison of Julia ABBA and Python ABBA.\label{fig:comsort_center}](BOXPLOT.png)

There are already ABBA variants available in Python such as fABBA [@CG22a]. As a member of the ABBA family, fABBA achieves digitization based on greedy aggregation by replacing k-means clustering, which obtains appealing speedup and tolerance-oriented digitization (i.e., without the requirement of prior knowledge for specifying the number of distinct symbols). 

The current digitization for ABBA is based on k-means with scikit-learn [@scikit-learn] which does not achieve satisfying speed in this application. Now our application of interest focuses on whether it is possible to accelerate ABBA by preserving k-means clustering?  We introduce a lightweight Julia package for implementing speedup ABBA, called `ABBAj.jl`. The package provides lightweight Julia implementation of the ABBA method, using `ParallelKMeans.jl` to achieve speedup in digitization with parallel k-means implementation. As shown in \autoref{fig:comsort_center}, we generate 100 Gaussian white noise of length 5000 with a mean of 0.0 and a standard deviation of 1.0, and run 'ABBAj.jl' and ABBA, the empirical result demonstrates that the `ABBAj.jl` compares favorably to ABBA in Python regarding runtime. 

# Statement of Need

Symbolizing time series may potentially allow avail of useful data structures and techniques from the text processing and bioinformatics communities [@SAX03]. `ABBAj.jl` is a Julia module for time series transformation with ABBA. With `ABBAj.jl`, we can efficiently employ ABBA to symbolize time series and apply the symbolic representation to the downstream time series task such as time series classification, forecasting, and anomaly detection. Compared to the ABBA python module, `ABBAj.jl` enjoys significantly faster speed while retaining the consistent reconstruction error of representation.  


# References
