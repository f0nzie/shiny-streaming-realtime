Shiny and Databases
Everybody loves Shiny, and rightly so. It lets you publish reproducible research, brings R applications to non-R users, and can even serve as a general purpose GUI for R code.

However, sometimes I’m surprised how difficult some basic tasks are. For example, creating a CRUD screen for a database table (CRUD stands for Create, Read, Update and Delete), is often one of the first examples in web frameworks.

To be fair, working with databases is not what most R-people do, and writing business applications is not what Shiny has been built for either. However, multiple of my customers do exactly that: They have a database (mysql, MongoDB, or other), store data in it, and write lots of financial models in R. They use Shiny to build interactive dashboards and to verify the P&L during the trading day. Some of them have only R know-how, so it’s natural for them to ask to leverage that know-how by writing Shiny apps that let them maintain their data directly from their browser.

This post shows you step by step how to build a Shiny app that lets you create, update and delete data in a table.

You can see the app in action here: https://gluc.shinyapps.io/crud

The full source-code is in this [gist](https://redirect.viglink.com/?format=go&jsonp=vglnk_151106038261122&key=949efb41171ac6ec1bf7f206d57e90b8&libId=ja65x3yr01021u9s000DArmh7asd1lg2f&loc=https%3A%2F%2Fwww.r-bloggers.com%2Fshiny-crud-app%2F&v=1&out=https%3A%2F%2Fgist.github.com%2Fgluc%2Fd39cea3d11f03542970b&title=Shiny%20CRUD%20App%20%7C%20R-bloggers&txt=gist).


## Database Binding
In order to hook the app with a “true” database, you will need to replace “responses” with your database. The good news: You can take whatever database, driver, and binding framework you want. The bad news: You will have to implement CreateData, ReadData, UpdateData, and DeleteData functions yourself.

Read this RStudio article for more about database binding.

## Caveats
The app works in a multi-user environment, yet with limitations. For one thing, no transactions are implemented. As a result, the last person to click submit will simply win, and possibly overwrite another users changes without noticing. In many situations this is ok, but it certainly is not in a public web-application which is used by thousands of simultaneous users.

Furthermore, reactivity does not work cross-user. If another user changes a record, your DataTable will not automatically update. You will need to hit F5 for that.

## Further Developments
Many of the hard-coded mentioning of the fields and labels could be generalised. Ideally, we would like to re-use the code for different tables. This is less difficult than what you might think. You need to generalise the GetTableMetadata function and return information on the field types (Text, Number, Boolean, Choice, etc.), derive the Input type (textInput, sliderInput, etc.), and create this code generically. If there is enough interest, I will build such an app in a future post.

## Credits
The featured image is the record label of the Detroit industrial rock n’roll band CRUD, whose members probably know neither R nor Shiny. The converse may not be true, however, even though I have not heard a single song from them. In any case, I hope for them that this free publicity brings them many new fans.

The post Shiny CRUD App appeared first on ipub.