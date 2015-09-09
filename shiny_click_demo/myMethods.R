### FUN：input a R coordinates,and it will return its Pixel coordinates
### PAR：x and y are the R coordinates,and the others are used to describe the picture information.
getPixel1 <- function(x, y, myBuild, myWidth = 800, myHeight = 400, UP = 80.5, RIGHT = 13, BUTTOM = 50, LEFT = 53){
    xMin = myBuild$panel$ranges[[1]]$x.range[1]   ## get the range of X/Y-axis
    xMax = myBuild$panel$ranges[[1]]$x.range[2]
    yMin = myBuild$panel$ranges[[1]]$y.range[1]
    yMax = myBuild$panel$ranges[[1]]$y.range[2]

    xPixel = (x - xMin) / (xMax - xMin) * (myWidth - LEFT - RIGHT) + LEFT   ## turn the abscissa into Pixel.
    yPixel = (y - yMin) / (yMax - yMin) * (myHeight - UP - BUTTOM) + BUTTOM   ## turn the ordinate into Pixel.

    return(c(round(xPixel,2), round((myHeight - yPixel),2)))
}


## FUN：input the Pixel coordinates of a point,and it will tell you which columns you have pointed
## PAR：myPixel is a dataframe with the Pixel coordinates of all columns,and (xPixel,yPixel) is the point you clicked on the picture
pointAtBar <- function(myPixel, xPixel, yPixel){
    d = 1
    for (i in 1:nrow(myPixel))
        if ((myPixel[i,1] - d) <= xPixel && xPixel <= (myPixel[i,5] + d))
        {
            if ((myPixel[i,4] - d) <= yPixel && (yPixel <= myPixel[i,2] + d))
                return(myPixel$names[i])
            break
        }
    return(NULL)
}


## FUN：input the Pixel coordinates of a point,and it will tell you which line you have pointed
## PAR：myPixel is a dataframe with the Pixel coordinates of all line-points,and (xPixel,yPixel) is the point you clicked on the picture
pointAtLine <- function(myPixel, xPixel, yPixel){
    d = 4
    for (i in 2:nrow(myPixel))
        if ((myPixel[i-1,1] - d) <= xPixel && xPixel <= (myPixel[i,1] + d))
        {
            if (abs((((myPixel[i,1] - myPixel[i-1,1]) * (yPixel - myPixel[i-1,2])) - (myPixel[i,2] - myPixel[i-1,2]) * (xPixel - myPixel[i-1,1])) /
                   sqrt((myPixel[i,1] - myPixel[i-1,1]) ^ 2 + (myPixel[i,2] - myPixel[i-1,2]) ^ 2)) <= d)
                return(myPixel$names[i])
            break
        }
    return(NULL)
}


## FUN：input the Pixel coordinates of a point,and it will tell you which pie you have pointed
## PAR：myPixel is a dataframe with the angle of Sector blocks(first three rows with radii,center-coordinates),and (xPixel,yPixel) is the point you clicked on the picture
pointAtPie <- function(myAngle, xPixel, yPixel){
    r = myAngle[1,1]
    mid.xPixel = myAngle[2,1]   ## the center-coordinates on the pie
    mid.yPixel = myAngle[3,1]
    fir.xPixel = mid.xPixel   ## the point just above the center and on the circle
    fir.yPixel = mid.yPixel - r
    if (((xPixel - mid.xPixel) ^ 2 + (yPixel - mid.yPixel) ^ 2) <= r ^ 2)
    {
        cosA = (((xPixel - mid.xPixel) ^ 2 + (yPixel - mid.yPixel) ^ 2 + r ^ 2) - ((xPixel - mid.xPixel) ^ 2 + (yPixel - mid.yPixel + r) ^ 2)) /
            (2 * sqrt(((xPixel - mid.xPixel) ^ 2 + (yPixel - mid.yPixel) ^ 2)) * r)
        angle = 180 * acos(cosA) / pi
        if (xPixel < mid.xPixel)
            angle = 360 - angle
        for (i in 4:nrow(myAngle))
            if (angle <= myAngle[i,1])
                return(myAngle[i,2])
    }
    return(NULL)
}

## FUN：get the Pixel coordinates of the columns(4 points),and return as a dataframe
## PAR：p is a ggplot2 object that is going to plot the Bar
Getbar <- function(p)
{
    myBuild = ggplot_build(p)   ## we can use ggplot_build() to view the message of ggplot2 object
    myPixel = data.frame(x1Pixel = c(0), y1Pixel = c(0), x2Pixel = c(0), y2Pixel = c(0),
                         x3Pixel = c(0), y3Pixel = c(0), x4Pixel = c(0), y4Pixel = c(0))
    myData = myBuild$data[[1]]  ## view the message of all points
    for (i in 1:nrow(myData))
    {
        pixel1 = getPixel1(myData[i,8], myData[i,6], myBuild)   ## Warning：if the columns are in different color,you should change the numbers here
        pixel2 = getPixel1(myData[i,8], myData[i,7], myBuild)
        pixel3 = getPixel1(myData[i,9], myData[i,6], myBuild)
        pixel4 = getPixel1(myData[i,9], myData[i,7], myBuild)
        myPixel = rbind(myPixel, c(pixel1, pixel2, pixel3, pixel4))   ## save the Pixel coordinates of four points(one column)
    }
    myPixel = myPixel[-1,]
    myPixel$names = myBuild$panel$ranges[[1]]$x.labels
    return(myPixel)
}


## FUN：get the Pixel coordinates of all points,and return as a dataframe
## PAR：p is a ggplot object that is going to plot the Line
GetLine <- function(p)
{
    myBuild = ggplot_build(p)
    myPixel = data.frame(xPixel = c(0), yPixel = c(0))
    myData = myBuild$data[[1]]
    for (i in 1:nrow(myData))
        myPixel = rbind(myPixel, c(getPixel1(myData[i,2], myData[i,3], myBuild, myWidth = 800, myHeight = 400, UP = 17, RIGHT = 86, BUTTOM = 46, LEFT = 50)))
    myPixel = myPixel[-1,]
    myPixel$names = myData[,2]
    return(myPixel)
}


## FUN：get the angle of all pie blocks,and return as a dataframe
## PAR：p is a ggplot object that is going to plot the Pie,names is the name of all pie blocks
GetPie <- function(p, names)
{
    r = 139   ## Radius of pie
    mid.xPixel = 376   ## center-coordinates of the Pie
    mid.yPixel = 190
    myBuild = ggplot_build(p)
    myData = myBuild$data[[1]]
    ymax = myBuild$panel$ranges[[1]]$theta.range[2]   ## max of Y-axis
    myAngle = data.frame(yPixel = c(r, mid.xPixel, mid.yPixel))
    for (i in 1:nrow(myData))
        myAngle = rbind(myAngle, myData[i,3] / ymax * 360)
    myAngle$names = c('r', 'mid.xPixel', 'mid.yPixel', names)
    return(myAngle)
}


## FUN：get the angle of all pie blocks,and return as a dataframe
## PAR：p is a ggplot object that is going to plot the Rose
GetRose <- function(p)
{
    r = 141.7   ## Radius of Rose
    mid.xPixel = 387   ## center-coordinates of the Rose
    mid.yPixel = 190
    myBuild = ggplot_build(p)
    myData = myBuild$data[[1]]
    parAngle = seq(0, 360, by = 360 / nrow(myData))[-1]   ## the angle of each block
    myAngle = data.frame(yPixel = c(r, mid.xPixel, mid.yPixel))
    for (i in parAngle)
        myAngle = rbind(myAngle, i)
    myAngle$names = c('r', 'mid.xPixel', 'mid.yPixel', myBuild$panel$ranges[[1]]$theta.labels)
    return(myAngle)
}
