library(shiny)
library(ggplot2)
library(ggthemes)
source("myMethods.R", encoding = "utf-8")

shinyServer(function(input, output, session) {
output$pplot1 <- renderText({  ## click event
    xy_str <- function(e) {
        if (is.null(e)) return("NULL\n")
        print(paste("X:",sep = "", e$x))
        print(paste("Y:",sep = "", e$y))

        bar <- pointAtBar(myPixel1, e$x, e$y)
        if (is.null(bar)) return("NULL\n")  ## if the column is not clicked,then return.
        print(bar)
        session$sendCustomMessage("openMenu", message = list(divid = 'myMenu1', b = 'text', event = e))
    }
    xy_range_str <- function(e) {
        if (is.null(e)) return("NULL\n")
        paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1),
               " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
    }
    xy_str(input$plot_click1)
    paste("You can see more information here：http://blog.csdn.net/Bone_ACE/article/details/48005855")
})


output$pplot2 <- renderText({  ## click event
    xy_str <- function(e) {
        if (is.null(e)) return("NULL\n")
        print(paste("X:", sep = "", e$x))
        print(paste("Y:", sep = "", e$y))

        line <- pointAtLine(myPixel2,e$x,e$y)
        if (is.null(line)) return("NULL\n")   ## if the line is not clicked,then return.
        print(line)
        session$sendCustomMessage("openMenu", message = list(divid = 'myMenu2', b = 'text', event = e))
    }
    xy_range_str <- function(e) {
        if (is.null(e)) return("NULL\n")
        paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1),
               " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
    }
    xy_str(input$plot_click2)
    paste("You can see more information here：http://blog.csdn.net/Bone_ACE/article/details/48005855")
})


output$pplot3 <- renderText({  ## click event
    xy_str <- function(e) {
        if (is.null(e)) return("NULL\n")
        print(paste("X:", sep = "", e$x))
        print(paste("Y:", sep = "", e$y))

        pie <- pointAtPie(myAngle1,e$x,e$y)
        if (is.null(pie)) return("NULL\n")   ## if the fan is not clicked,then return.
        print(pie)
        session$sendCustomMessage("openMenu", message = list(divid = 'myMenu3', b = 'text', event = e))
    }
    xy_range_str <- function(e) {
        if (is.null(e)) return("NULL\n")
        paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1),
               " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
    }
    xy_str(input$plot_click3)
    paste("You can see more information here：http://blog.csdn.net/Bone_ACE/article/details/48005855")
})


output$pplot4 <- renderText({  ## click event
    xy_str <- function(e) {
        if (is.null(e)) return("NULL\n")
        print(paste("X:", sep = "", e$x))
        print(paste("Y:", sep = "", e$y))

        rose <- pointAtPie(myAngle2,e$x,e$y)
        if (is.null(rose)) return("NULL\n")   ## if the fan is not clicked,then return.
        print(rose)
        session$sendCustomMessage("openMenu", message = list(divid = 'myMenu4', b = 'text', event = e))
    }
    xy_range_str <- function(e) {
        if (is.null(e)) return("NULL\n")
        paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1),
               " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
    }
    xy_str(input$plot_click4)
    paste("You can see more information here：http://blog.csdn.net/Bone_ACE/article/details/48005855")
})








output$mainBar <- renderImage({
  dt = data.frame(obj = c('A','D','B','E','C'), val = c(2,15,6,9,7))
  p = ggplot(dt, aes(x = obj, y = val, fill = obj, group = factor(1))) +   ## Here is your plot
      geom_bar(stat = "identity", width = 0.5) +
      theme_economist()
  myPixel1 <<- Getbar(p)   ## Transforming the centimeter coordinates into pixel coordinates.HASHP is a global variable.
  ggsave("img/mainPlot1.png", width = 9, height = 4.6, dpi = 300)   ## Save your ggplot2 plot as a picture.

  filename <- normalizePath(file.path('./img', paste('mainPlot1', '.png', sep = '')))
  list(src = filename
       ,width = 800
       ,height = 400
  )
}, deleteFile = FALSE)


output$mainLine <- renderImage({
    dt = data.frame(A = 1:10, B = c(2,15,6,18,9,7,13,15,10,3), C = c('A','C','A','B','C','D','A','C','D','B'))
    p = ggplot(dt, aes(x = A, y = B, color = C, group = factor(1))) +
        geom_point(size = 0.8) +
        geom_line(size = 0.8) +
        geom_text(aes(label = B, vjust = 1.1, hjust = -0.5, angle = 45), show_guide = FALSE)   ## add the text about the point
    myPixel2 <<- GetLine(p)
    ggsave("img/mainPlot2.png", width = 9, height = 4.6, dpi = 300)   ## Save your ggplot2 plot as a picture.

    filename <- normalizePath(file.path('./img', paste('mainPlot2', '.png', sep = '')))
    list(src = filename
         ,width = 800
         ,height = 400
    )
}, deleteFile = FALSE)


output$mainPie <- renderImage({
    dt = data.frame(A = c(2, 7, 4, 10, 1), B = c('B','A','C','D','E'))
    p = ggplot(dt, aes(x = "", y = A, fill = B)) +
        geom_bar(stat = "identity", width = 1) +
        coord_polar(theta = "y")
    myAngle1 <<- GetPie(p, names = as.vector(dt$B))
    ggsave("img/mainPlot3.png", width = 9, height = 4.6, dpi = 300)   ## Save your ggplot2 plot as a picture.

    filename <- normalizePath(file.path('./img', paste('mainPlot3', '.png', sep = '')))
    list(src = filename
         ,width = 800
         ,height = 400
    )
}, deleteFile = FALSE)


output$mainRose <- renderImage({
    dt = data.frame(A = c(2, 7, 4, 10, 1), B = c('B','A','C','D','E'))
    p = ggplot(dt, aes(x = B, y = A, fill = B)) +
        geom_bar(stat = "identity", alpha = 0.7) +
        coord_polar()
    myAngle2 <<- GetRose(p)
    ggsave("img/mainPlot4.png", width = 9, height = 4.6, dpi = 300)   ## Save your ggplot2 plot as a picture.
    filename <- normalizePath(file.path('./img', paste('mainPlot4', '.png', sep = '')))
    list(src = filename
         ,width = 800
         ,height = 400
    )
}, deleteFile = FALSE)

})

