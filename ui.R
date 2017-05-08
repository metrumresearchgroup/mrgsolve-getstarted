
library(shiny)
library(rsconnect)
library(shinyAce)
library(mrgsolve)

# Code listings
.ui <- paste(readLines("ui.R"),collapse='\n')
.server <- paste(readLines("server.R"),collapse='\n')
.packages <- paste(capture.output(sessionInfo()), collapse='\n')
.model <- paste(mrgsolve:::code(mrgsolve:::house()), collapse='\n')

# Inputs
vc_slider <- sliderInput("vc", "Volume of distribution", 5,75,20,5)
ii_slider <- sliderInput("ii", "Dosing interval", 6,72,24,6)

# Control panel
source("about.R")
use <- fluidRow(use)
ii_row <- fluidRow(vc_slider)
vc_row <- fluidRow(ii_slider)
control <- fluidPage(use,vc_row, ii_row)


# Output tab
plot_tab <- plotOutput("plot",height="550px")

# Code tabs
ui_tab <- aceEditor("ui_code", .ui, 
                    mode="r", height="580px")

sv_tab <- aceEditor("sv_code", .server,
                    mode="r",  height="580px")

pk_tab <- aceEditor("pk_code", .packages, 
                    mode="r", height="580px")

mod_tab <- aceEditor("mod_code", .model,
                     mode="r", height="580px")

# Tab panels
p1 <- tabPanel("App output", plot_tab)
p2 <- tabPanel("Model code", mod_tab)
p3 <- tabPanel("server.R",sv_tab)
p4 <- tabPanel("ui.R", ui_tab)
p5 <- tabPanel("sessionInfo", pk_tab)

# Page
left <- column(3,about)
panels <- column(6,tabsetPanel(p1,p2,p3,p4,p5))
right <- column(2,br(),br(),br(),control)
page <- fluidPage(fluidRow(left,panels,right,column(1,"")))


# Go!
shinyUI(page)

