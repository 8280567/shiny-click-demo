library(shiny)
source('LoadJSCSS.R', encoding = "utf-8")

shinyUI(fluidPage(
    tabsetPanel(
        tabPanel(title = "BarDemo",
            column(12,
                   wellPanel(plotOutput("mainBar", click = "plot_click1"),
                        verbatimTextOutput("pplot1"),   ## call the click envent on the picture
                        LoadJSCSS(),
                        div(class = 'menu', id = 'myMenu1',
                            a(class = 'menuItem', id = "tc1", onclick = "TC('404.png','Popup1','imgId1')",  ## The name of the picture can't include Chinese.
                            "404Error"),
                            a(class = 'menuItem', id = "tc2", onclick = "TC('prettyGirl.png','Popup1','imgId1')",
                            "prettyGirl")
                        ),
                        div(class = "border-radius box-shadow", id = "Popup1",
                            div( class = "top border-radius-top",
                               span("X", class = "close", title = "Close Window")
                            ),
                            div( class = "main",
                               img(src = '404.png', width = "800", height = "400", id = "imgId1")
                            )
                        )
                    )
            )
        ),

        tabPanel(title = "LineDemo",
             column(12,
                    wellPanel(plotOutput("mainLine", click = "plot_click2"),
                       verbatimTextOutput("pplot2"),   ## call the click envent on the picture
                       div(class = 'menu', id = 'myMenu2',
                           a(class = 'menuItem', id = "tc3", onclick = "TC('weChat.png','Popup2','imgId2')",   ## The name of the picture can't include Chinese.
                             "myWeChat"),
                           a(class = 'menuItem', id = "tc4", onclick = "TC('sentence.png', 'Popup2','imgId2')",
                             "mySentence")
                       ),
                       div(class = "border-radius box-shadow", id = "Popup2",
                           div( class = "top border-radius-top",
                                span("X", class = "close", title = "Close Window")
                           ),
                           div( class = "main",
                                img(src = '404.png', width = "800", height = "400", id = "imgId2")
                           )
                       )
                    )
             )
        ),

        tabPanel(title = "PieDemo",
             column(12,
                    wellPanel(plotOutput("mainPie", click = "plot_click3"),
                       verbatimTextOutput("pplot3"),   ## call the click envent on the picture
                       div(class = 'menu', id = 'myMenu3',
                           a(class = 'menuItem', id = "tc5", onclick = "TC('weChat.png','Popup3','imgId3')",   ## The name of the picture can't include Chinese.
                             "myWeChat"),
                           a(class = 'menuItem', id = "tc6", onclick = "TC('sentence.png', 'Popup3','imgId3')",
                             "mySentence")
                       ),
                       div(class = "border-radius box-shadow", id = "Popup3",
                           div( class = "top border-radius-top",
                                span("X",class = "close", title = "Close Window")
                           ),
                           div( class = "main",
                                img(src = '404.png', width = "800", height = "400", id = "imgId3")
                           )
                       )
                    )
             )
        ),

        tabPanel(title = "RoseDemo",
             column(12,
                    wellPanel(plotOutput("mainRose", click = "plot_click4"),
                       verbatimTextOutput("pplot4"),   ## call the click envent on the picture
                       div(class = 'menu', id = 'myMenu4',
                           a(class = 'menuItem', id = "tc7", onclick = "TC('weChat.png','Popup4','imgId4')",   ## The name of the picture can't include Chinese.
                             "myWeChat"),
                           a(class = 'menuItem', id = "tc8", onclick = "TC('sentence.png', 'Popup4','imgId4')",
                             "mySentence")
                       ),
                       div(class = "border-radius box-shadow", id = "Popup4",
                           div( class = "top border-radius-top",
                                span("X", class = "close", title = "Close Window")
                           ),
                           div( class = "main",
                                img(src = '404.png', width = "800", height = "400", id = "imgId4")
                           )
                       )
                    )
             )
        )
)))
