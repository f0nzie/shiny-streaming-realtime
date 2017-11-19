---
output: html_notebook
---
# Using PostgreSQL and shiny with a dynamic leaflet map: monitoring trash cans

A dynamic map that shows when trash cans are full helps us to optimize our resources and pick them up at the right time. When there is increased social activity, the trash cans can get full quicker. On the contrary, during very cold weather, the trash cans can take one or a couple of more days to get full. Therefore, knowing when the trash cans are full lets us pick them up right away rather than waiting for a specific day of the week to come. In this video blog post, we will create a dynamic map that shows when trash cans are full, when one or more of the sensors fail or when the gateway is not transferring data. Video tutorial available here


https://github.com/fissehab/monitoring_trash_cans_with_shiny_and_leaflet


## QUESTIONs

* Who stops the database data generation?
  
> The three cycles of different sensor events. 15 sensors working; 2 sensors broken; and 5 sensors broken.

* How is the time zone set up?

* How is the interval set?

> It is set through the `Sys.sleep(2)` command.

* How are the sensors data coordinated? Are they random?

> Yes. They are uniform random. They have been defined as three different situations or events: (1) all 15 sensors working; (2) two sensors not working; (3) 5 sensors not working. 

> Two sensors not working though this:
`temp = matrix(c(runif(13, min=0, max=0.03), rep(NA, 2)), ncol=15)`

> Five sensors not working with this:
`temp = matrix(c(runif(10, min=0, max=0.03), rep(NA, 5)), ncol=15)`





