
# R shiny app with inputs depending on updated data

Source: https://stackoverflow.com/questions/20681472/r-shiny-app-with-inputs-depending-on-updated-data?rq=1

I am building a web app using shiny, and I'm unsure how to best structure the app since inputs depend on data and the outputs (charts) depend on aggregated data based on inputs.

I tried to come up with a simple application to reproduce the problem. My setup is more advanced and unrelated to the example. Suppose you have a product line and want to analyse sales. Suppose that a data set is created for each day (I'm not saying the data structure is optimal, but it is useful for illustrating my question). Now in the application, one selects a date from a list of available dates, and then one selects a product. The dates are restricted to the period for which data is available, and the product list is restricted to products that were actually sold on the selected day. Then, we wish to plot the total sales value for each hour during the day.

I will list some code for such an example below, where some sample data is also created. Sorry for the "long" code. It is sort of working, but I have some concerns.

My questions are:

1) I am wondering in which order things are executed, in particular when the app is first loaded, and then every time an input changes. Again, data depends on first input, the second input depends on the data. Third, a chart-friendly data set is computed which is used for the graph. You may notice that errors are printed to the console (and flashes briefly in the browser) but as the values are available, updates are made and the plot shows. It seems suboptimal.

2) What is the current best practice when the inputs depend on data/server.R? I saw this https://groups.google.com/forum/?fromgroups=#!topic/shiny-discuss/JGJx5A3Ge-A but it seems like this is not implemented, even thought the post is rather old.