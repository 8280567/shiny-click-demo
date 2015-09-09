
LoadJSCSS <- function() {#text = ".Lee.",img = "1.jpg"
  tagList(
    includeJS()
  )
}
includeJS <- function(drag.and.drop = FALSE) {
  #   If you’re using an index.html style user interface, you’ll just need to add this line to your <head>
  #     (make sure it comes after the script tag that loads shiny.js):
  tagList(
#       singleton(tags$head("<META HTTP-EQUIV='pragma' CONTENT='no-cache'>"))
#       ,singleton(tags$head("<META HTTP-EQUIV='Cache-Control' CONTENT='no-cache, must-revalidate'>"))
#       ,singleton(tags$head(" <META HTTP-EQUIV='expires' CONTENT='Wed, 26 Feb 1997 08:21:57 GMT'>"))
#       ,singleton(tags$head("<META HTTP-EQUIV='expires' CONTENT='0'>"))

    singleton(tags$head(tags$link(href="style.css",rel="stylesheet",type="text/css"))),
    singleton(tags$head(tags$link(href="alertwindow.css",rel="stylesheet",type="text/css")))
    ,singleton(tags$head(tags$script(src="alertwindow.js")))
    ,singleton(tags$head(tags$script(src="http://code.hs-cn.com/jquery/jquery-1.7.1.min.js")))
    ,singleton(tags$head(tags$script(src="style.js")))
    # ,singleton(tags$head(tags$script("<A class=menuItem href='${href}' onclick='sas(${index})'>${name}</A>"),id="tmpl-data"))

    #	,singleton(tags$head(tags$script(src="select3input.js")))
  )
  #browser()
}

