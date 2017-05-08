
library(mrgsolve)
library(lattice)
options(mrgsolve_mread_quiet=TRUE)

# compile the model
mod <- mread("pk1cmt", modlib())
# configure
mod <- mod %>% update(end=480+144,delta=1) %>% Req(CP)

shinyServer(function(input,output,session) {
  
  # Reactive event object
  e <- reactive({
    ev(amt=100,ii=input[["ii"]],addl=floor(480/input[["ii"]])-1)
  })
  
  # Reactive parameter value
  par <- reactive({
    param(VC = as.numeric(input[["vc"]]))
  })
  
  # Main plot
  output$plot <- renderPlot({
    mod %>% 
      param(par())%>%
      ev(e()) %>% 
      mrgsim %>%
      plot
  },res=110)
  
  output$download <- download_app() ## hidden; see about.R in the app
  
})
