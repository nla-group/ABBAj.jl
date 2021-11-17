using ABBAj, Test, DelimitedFiles
time_series = load_sample();


#======================== test 1
symbols, model = fit_transform(time_series,20, 0.1);
r_time_series = inverse_transform(symbols, model, time_series[1]);

write("symbols1", String(symbols));
symbols_backup = read("symbols1", String);
@test symbols_backup == String(symbols)

writedlm("r_time_series1", r_time_series)
r_time_series_backup = readdlm("r_time_series1", '\t', Float64, '\n');
@test r_time_series_backup == hcat(r_time_series)

#======================== test 2
symbols, model = fit_transform(time_series,30, 0.1);
r_time_series = inverse_transform(symbols, model, time_series[1]);

write("symbols2", String(symbols));
symbols_backup = read("symbols2", String);
@test symbols_backup == String(symbols)

writedlm("r_time_series2", r_time_series)
r_time_series_backup = readdlm("r_time_series2", '\t', Float64, '\n');
@test r_time_series_backup == hcat(r_time_series)


#======================== test 3
symbols, model = fit_transform(time_series,30, 0.5);
r_time_series = inverse_transform(symbols, model, time_series[1]);

write("symbols3", String(symbols));
symbols_backup = read("symbols3", String);
@test symbols_backup == String(symbols)

writedlm("r_time_series3", r_time_series)
r_time_series_backup = readdlm("r_time_series3", '\t', Float64, '\n');
@test r_time_series_backup == hcat(r_time_series)


#======================== test 4
symbols, model = fit_transform(time_series,30, 0.1, 5);
r_time_series = inverse_transform(symbols, model, time_series[1]);

write("symbols4", String(symbols));
symbols_backup = read("symbols4", String);
@test symbols_backup == String(symbols)

writedlm("r_time_series4", r_time_series)
r_time_series_backup = readdlm("r_time_series4", '\t', Float64, '\n');
@test r_time_series_backup == hcat(r_time_series)

