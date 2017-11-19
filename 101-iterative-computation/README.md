# Receive streaming data and concurrently display it in Shiny

Source: https://groups.google.com/forum/#!topic/shiny-discuss/n11-mnBYXQc

Code: https://gist.github.com/trestletech/8608815


Kirill Savin	

4/17/14

I've been trying to find a solution for this problem, but only stumbled into vague mentions.

The goal is to receive live data from a trading platform with IBrokers package, accumulate it, do computations with it periodically and as the user changes reactive inputs.
The package uses subscribe-callback mechanism to process new data. Once the data is requested, the function goes to a while(TRUE) loop and passes incoming messages to a callback function, where it can be written to a data frame, until stopped. Although it is not computationally intensive, it occupies the session.

Is it possible to update the data on a background and periodically do the calculations with it? I suspect it somehow involves multiple R sessions, since R is single threaded. I would appreciate any tips.
 


Jeff Allen	

4/18/14


Not entirely the same question, but here's a related discussion and code modeling one approach to a situation like this.

Not sure how well that will fit in your situation, though. I think you would be using this scheduler that works in chunks rather than a grand, blocking `while (TRUE)` call. There may be a simpler approach of just forcing Shiny to update its reactives periodically within your big loop, but I haven't explored that yet.

As far as I know, there's not an "official" best practice here. Would love to continue the discussion, though.

Jeff