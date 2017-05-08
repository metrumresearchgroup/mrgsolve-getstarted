gr <- "#009933"

## Download
dl <- downloadButton("download", "Download App Code")

link <- function(url,text) {
  text <- tag("font",list(color=gr, text, size=3))
  tag("a",  list(href=url,text))
  
}
title <- h2(tag("font", list(color=gr,"mrgsolve + shiny")))

mrgs <- "mrgsolve is a free, open-source modeling and simulation platform from MetrumRG to support ODE-based PKPD and QSP model development in R."
about <- h4("About")
header <- p(mrgs)
body <- p("This app is a simple demonstration of mrgsolve working with shiny to create an interactive,
model visualization tool.")
map <- p( "Browse tabs to view
           model code, the user interface code (ui.R), and the server code (server.R).  
          sessionInfo lists packages used for this app.")
metrum <- link("http://metrumrg.com", "metrumrg.com")
mrgsolve <- link("http://mrgsolve.github.io", "mrgsolve.github.io")
about <- list(title,br(),about,header,body,map,br(),dl,br(),br(),h4("More information"),metrum,br(),mrgsolve)

title2 <- h4("Use")
use <- p("It's pretty simple: move sliders to control dosing interval and volume of distribution. Then,  
check out the code underlying the model, ui and server in the tabs across the top to see how the app runs.")

use <- list(br(),title2,use)

zip_name <- "mrgsolve_shiny_MetrumRG.zip"

create_zip <- function() {
  utils::zip(zip_name, list.files(getwd(), pattern="\\.R$"))
}

download_app <- function() {
  downloadHandler(contentType = 'application/zip',
                  filename = zip_name, 
                  content = function(file) {
                    create_zip()
                    file.rename(zip_name, file) 
                  })
}

