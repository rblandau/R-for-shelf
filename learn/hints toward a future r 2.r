# Example taken from 
# https://stackoverflow.com/questions/10349206/add-legend-to-ggplot2-line-plot
# 
# I need to figure out how to do this with horizontal data divisions.
# 
# Example is heavily reindented from the original, to explicate its structure.
# 

datos <-
    structure
    (
        list
        (
            fecha = structure
            (
                c(1317452400, 1317538800, 1317625200, 
                1317711600, 1317798000, 1317884400, 1317970800, 1318057200, 1318143600, 
                1318230000, 1318316400, 1318402800, 1318489200, 1318575600, 1318662000, 
                1318748400, 1318834800, 1318921200, 1319007600, 1319094000), 
                class = c("POSIXct", "POSIXt"), 
                tzone = ""
            ), 
        TempMax = c(26.58, 27.78, 27.9, 27.44, 
            30.9, 30.44, 27.57, 25.71, 25.98, 26.84, 33.58, 30.7, 31.3, 27.18, 
            26.58, 26.18, 25.19, 24.19, 27.65, 23.92), 
        TempMedia = c(22.88, 
            22.87, 22.41, 21.63, 22.43, 22.29, 21.89, 20.52, 19.71, 20.73, 
            23.51, 23.13, 22.95, 21.95, 21.91, 20.72, 20.45, 19.42, 19.97, 
            19.61), 
        TempMin = c(19.34, 19.14, 18.34, 17.49, 16.75, 16.75, 
            16.88, 16.82, 14.82, 16.01, 16.88, 17.55, 16.75, 17.22, 19.01, 
            16.95, 17.55, 15.21, 14.22, 16.42)
        ), 
        .Names = c("fecha", "TempMax", "TempMedia", "TempMin"), 
        row.names = c(NA, 20L), 
        class = "data.frame"
    )

ggplot(data = datos, aes(x = fecha)) 
    + geom_line(aes(y = TempMax, colour = "TempMax")) 
    + geom_line(aes(y = TempMedia, colour = "TempMedia")) 
    + geom_line(aes(y = TempMin, colour = "TempMin")) 
    + scale_colour_manual("", 
                      breaks = c("TempMax", "TempMedia", "TempMin"),
                      values = c("red", "green", "blue")
                      ) 
    + xlab(" ") 
    + scale_y_continuous("Temperatura (C)", limits = c(-10,40)) 
    + labs(title="TITULO") 

