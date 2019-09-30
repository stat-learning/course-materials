library(tidyverse)
library(stringr)

train <- read.csv("http://andrewpbray.github.io/data/crime-train.csv")
test <- read.csv("/Users/andrewbray/Dropbox/Teaching/2017-fall/math-243/assets/week-04/crime-test.csv")

# NOTES FOR ME

# add third function: data_process
# call all arguments data

# NOTES FOR THEM

## Be sure to not reference anything that's not passed into a function
## Process data in data frame to allow flexible reuse of model
## I had to strip out states if necessary
## Use built in functions where possible
## Break lines at 80 characters
## I removed state as a predictor because of lack of match w test/train
## Always submit your Rmd
## Check your output to be sure they make sense. predict(m1) vs predict(m1, data)

n <- 12
group <- rep(LETTERS[1:n], 4)
setting <- rep(rep(c("train", "test"), each = n), 2)
model_type <- rep(c("bespoke", "automated"), each = n * 2)
p <- rep(1, n * 4)
MSE <- rep(NA, n * 4)
results <- data.frame(group, 
                      setting,
                      model_type,
                      p,
                      MSE)

process_models <- function(f_process, f_fit, f_MSE, group, m_type, train, test, results) {
  train_processed <- f_process(train)
  test_processed <- f_process(test)
  m <- f_fit(train_processed)
  results[results$group == group & 
            results$model_type == m_type, "p"] <- length(coef(m)) - 1
  results[results$group == group & 
            results$model_type == m_type & 
            results$setting == "train", "MSE"] <- f_MSE(m, train_processed)
  results[results$group == group & 
            results$model_type == m_type & 
            results$setting == "test", "MSE"] <- f_MSE(m, test_processed)
  results
}


# GROUP A

group_A_process <- function(training_data) {
  mutate(training_data, sqrtcrime = sqrt(ViolentCrimesPerPop))
}

group_A_fit <- function(training_data_processed) {
  m1 <- lm(sqrtcrime ~ PctIlleg + racePctWhite + TotalPctDiv + PctVacantBoarded:racePctWhite + LemasPctOfficDrugUn + MedRentPctHousInc + PctNotHSGrad, data = training_data_processed)
  m1
}

group_A_MSE <- function(model, data) {
  errors <- function(x1, x2, x3, x4, x5, x6, x7){
    predicted <- model$coefficients[1] + (model$coefficients[2] * x1) + (model$coefficients[3] * x2) + (model$coefficients[4] * x3) + (model$coefficients[5] * x4) + (model$coefficients[6] * x5) + (model$coefficients[7] * x6) + (model$coefficients[8] * x7)
    err <- data$sqrtcrime - predicted
    err
  }
  
  MSE <- mean(errors(data$PctIlleg, data$racePctWhite, data$TotalPctDiv, data$LemasPctOfficDrugUn, data$MedRentPctHousInc, data$PctNotHSGrad, (data$racePctWhite * data$PctVacantBoarded))^2)
  MSE
}

results <- process_models(f_process = group_A_process, 
                          f_fit = group_A_fit, 
                          f_MSE = group_A_MSE,
                          group = "A", m_type = "bespoke", 
                          train, test, results)


# GROUP B

group_B_process <- function(training_data) {
  # Select out variables to be fitted in the model
  training_data = training_data[c(8,49,54,127)]
  # Filter out the observations with missing data 
  filtered_data = training_data[rowSums(!is.na(training_data)) == 4,]
  filtered_data = mutate(filtered_data,NumIllegsr = sqrt(NumIlleg))
}

group_B_fit <- function(training_data) {
  # run lm() to fit your model.
  m1 = lm(ViolentCrimesPerPop ~ racePctWhite + PctKids2Par +NumIllegsr, data = training_data)
  # on the last line, simply put m1, your final model.
  # this will return it as output.
  m1
}

group_B_MSE <- function(model, data) {
  # when you run group_A_fit, save the output and put 
  # it here as the "model" argument.
  
  # use your model to find the predicted values for 
  # all of the observations in the data set.
  p = predict(model, data)
  true_values = data$ViolentCrimesPerPop
  # use those fitted values and the true values to
  # compute the MSE, which this function should return
  # as output.
  MSE = mean((p - true_values)^2)
  
  MSE
}

results <- process_models(f_process = group_B_process, 
                          f_fit = group_B_fit, 
                          f_MSE = group_B_MSE,
                          group = "B", m_type = "bespoke", 
                          train, test, results)

# GROUP C

group_C_process <- function(data) {
  data
}

group_C_fit <- function(training_data) {
  m1 <- lm(training_data$ViolentCrimesPerPop ~ training_data$pctUrban +  as.numeric(training_data$PolicPerPop)+training_data$PctNotHSGrad+training_data$PctLess9thGrade+training_data$PctPopUnderPov+ training_data$NumStreet+training_data$NumInShelters+training_data$MedRent+training_data$pctWInvInc+training_data$whitePerCap)
  m1
}

group_C_MSE <- function(model, data) {
  fitted = model$coefficients[1]+model$coefficients[2]*data$pctUrban+model$coefficients[3]*as.numeric(data$PolicPerPop)+model$coefficients[4]*data$PctNotHSGrad+model$coefficients[5]*data$PctLess9thGrade+model$coefficients[6]*data$PctPopUnderPov+model$coefficients[7]*data$NumStreet+model$coefficients[8]*data$NumInShelters+model$coefficients[9]*data$MedRent+model$coefficients[10]*data$pctWInvInc+model$coefficients[11]*data$whitePerCap
  
  MSE = sum((fitted-data$ViolentCrimesPerPop)^2)/length(data$ViolentCrimesPerPop)
  MSE
}

results <- process_models(f_process = group_C_process, 
                          f_fit = group_C_fit, 
                          f_MSE = group_C_MSE,
                          group = "C", m_type = "bespoke", 
                          train, test, results)


# GROUP D

group_D_process <- function(data) {
  data
}

group_D_fit <- function(training_data) {
  model <- lm(data = training_data, ViolentCrimesPerPop ~  racePctWhite + pctUrban  + PctEmploy + MalePctDivorce + MalePctDivorce^2 + PctKids2Par + PctKids2Par^2  + PctWorkMom + PctPersDenseHous  + NumStreet + PctVacantBoarded + PctImmigRec8 + PctImmigRec8^2 + PctIlleg +  PctHousOccup + PctWorkMom*MalePctDivorce + pctUrban*racePctWhite + PctEmploy*racePctWhite + pctUrban*PctHousOccup + PctEmploy*pctUrban + PctIlleg*PctEmploy + PctImmigRec8*PctVacantBoarded + PctNotHSGrad + PctLess9thGrade + NumInShelters+PctEmploy*pctUrban + PctIlleg*PctEmploy + PctImmigRec8*PctVacantBoarded+PctNotHSGrad + PctLess9thGrade + NumInShelters)
}

group_D_MSE <- function(model, data){
  n <- nrow(data)
  ys <- data$ViolentCrimesPerPop 
  y_hats <- predict(model, data)
  residuals <- y_hats - ys
  MSE <- sum(residuals^2)/n
  MSE
}

results <- process_models(f_process = group_D_process, 
                          f_fit = group_D_fit, 
                          f_MSE = group_D_MSE,
                          group = "D", m_type = "bespoke", 
                          train, test, results)

## GROUP E

group_E_process <- function(data) {
  data
}

group_E_fit <- function(training_data) {
  m1 <- lm(ViolentCrimesPerPop ~ PctKids2Par * PctHousOwnOcc* racePctWhite, data = training_data)
  m1
}

group_E_MSE <- function(model, data) {
  mean((data$ViolentCrimesPerPop - predict(model, data))^2)
}

results <- process_models(f_process = group_E_process, 
                          f_fit = group_E_fit, 
                          f_MSE = group_E_MSE,
                          group = "E", m_type = "bespoke", 
                          train, test, results)

## GROUP F

group_F_process <- function(data) {
  data
}

group_F_fit <- function(training_data) {
  m1 <- lm(ViolentCrimesPerPop~ I(MalePctDivorce^(1/3)) + I(PctKids2Par^(1/3)) +
             PctIlleg + (PctPersDenseHous^2) + RentLowQ+MedRent, training_data)
  m1
}

group_F_MSE <- function(model, data) {
  MSE<-mean((data$ViolentCrimesPerPop - predict.lm(model, data)) ^ 2)
  return(MSE)
}

results <- process_models(f_process = group_F_process, 
                          f_fit = group_F_fit, 
                          f_MSE = group_F_MSE,
                          group = "F", m_type = "bespoke", 
                          train, test, results)


## GROUP H

group_H_process <- function(functdata) {
  suppressWarnings(functdata$RacialMatchCommPol <- 1 - as.numeric(as.character(functdata$RacialMatchCommPol)))
  colnames(functdata)[colnames(functdata)=="RacialMatchCommPol"] <- "RacialMismatchCommPol"
  functdata <- na.omit(functdata)
}

group_H_fit <- function(functdata) {
  lm(ViolentCrimesPerPop ~ 
       PctTeen2Par + 
       PctVacantBoarded +
       RacialMismatchCommPol + 
       PctNotHSGrad + 
       FemalePctDiv, 
     data = functdata
  )
  
}

group_H_MSE <- function(model, functdata) {
  yhat <- predict(model, functdata)
  
  y <- functdata$ViolentCrimesPerPop
  
  return(mean((y - yhat)^2))
  
}

results <- process_models(f_process = group_H_process, 
                          f_fit = group_H_fit, 
                          f_MSE = group_H_MSE,
                          group = "H", m_type = "bespoke", 
                          train, test, results)


## GROUP I

group_I_process <- function(training_data) {
  training_data1<- mutate(training_data,
                          FactorState2=case_when(state==2~"1", state!=2~"0"),
                          FactorState4=case_when(state==4~"1", state!=4~"0"),
                          FactorState5=case_when(state==5~"1", state!=5~"0"),
                          FactorState6=case_when(state==6~"1", state!=6~"0"),
                          FactorState8=case_when(state==8~"1", state!=8~"0"),
                          FactorState9=case_when(state==9~"1", state!=9~"0"),
                          FactorState12=case_when(state==12~"1", state!=12~"0"),
                          FactorState13=case_when(state==13~"1", state!=13~"0"),
                          FactorState16=case_when(state==16~"1", state!=16~"0"),
                          FactorState18=case_when(state==18~"1", state!=18~"0"),
                          FactorState19=case_when(state==19~"1", state!=19~"0"),
                          FactorState21=case_when(state==21~"1", state!=21~"0"),
                          FactorState22=case_when(state==22~"1", state!=22~"0"),
                          FactorState23=case_when(state==23~"1", state!=23~"0"),
                          FactorState24=case_when(state==24~"1", state!=24~"0"),
                          FactorState25=case_when(state==25~"1", state!=25~"0"),
                          FactorState27=case_when(state==27~"1", state!=27~"0"),
                          FactorState28=case_when(state==28~"1", state!=28~"0"),
                          FactorState29=case_when(state==29~"1", state!=29~"0"),
                          FactorState32=case_when(state==32~"1", state!=32~"0"),
                          FactorState33=case_when(state==33~"1", state!=33~"0"),
                          FactorState34=case_when(state==34~"1", state!=34~"0"),
                          FactorState36=case_when(state==36~"1", state!=36~"0"),
                          FactorState37=case_when(state==37~"1", state!=37~"0"),
                          FactorState38=case_when(state==38~"1", state!=38~"0"),
                          FactorState39=case_when(state==39~"1", state!=39~"0"),
                          FactorState40=case_when(state==40~"1", state!=40~"0"),
                          FactorState41=case_when(state==41~"1", state!=41~"0"),
                          FactorState42=case_when(state==42~"1", state!=42~"0"),
                          FactorState44=case_when(state==44~"1", state!=44~"0"),
                          FactorState45=case_when(state==45~"1", state!=45~"0"),
                          FactorState46=case_when(state==46~"1", state!=46~"0"),
                          FactorState47=case_when(state==47~"1", state!=47~"0"),
                          FactorState48=case_when(state==48~"1", state!=48~"0"),
                          FactorState49=case_when(state==49~"1", state!=49~"0"),
                          FactorState50=case_when(state==50~"1", state!=50~"0"),
                          FactorState51=case_when(state==51~"1", state!=51~"0"),
                          FactorState53=case_when(state==53~"1", state!=53~"0"),
                          FactorState54=case_when(state==54~"1", state!=54~"0"),
                          FactorState55=case_when(state==55~"1", state!=55~"0"),
                          FactorState56=case_when(state==56~"1", state!=56~"0"))
}

group_I_fit <- function(training_data) {
  library(tidyverse)
  library(broom)
  library(infer)
  library(modelr)

  m1<- lm(ViolentCrimesPerPop~
            population+
            racePctWhite+
            pctUrban+
            PctIlleg+
            PctVacantBoarded+
            PctNotHSGrad+
            FactorState2+
            FactorState4+
            FactorState5+
            FactorState6+
            FactorState8+
            FactorState9+
            FactorState12+
            FactorState13+
            FactorState16+
            FactorState18+
            FactorState19+
            FactorState21+
            FactorState22+
            FactorState23+
            FactorState24+
            FactorState25+
            FactorState27+
            FactorState28+
            FactorState29+
            FactorState32+
            FactorState33+
            FactorState34+
            FactorState36+
            FactorState37+
            FactorState38+
            FactorState39+
            FactorState40+
            FactorState41+
            FactorState42+
            FactorState44+
            FactorState45+
            FactorState46+
            FactorState47+
            FactorState48+
            FactorState49+
            FactorState50+
            FactorState51+
            FactorState53+
            FactorState54+
            FactorState55+
            FactorState56,
          data=training_data)
  m1
}

group_I_MSE <- function(model, data) {
  library(tidyverse)
  library(broom)
  library(infer)
  library(modelr)
  
  p1 <- predict(model, data)
  VCP<-data$ViolentCrimesPerPop
  MSE<-mean((VCP-p1)^2)
  MSE
}


results <- process_models(f_process = group_I_process, 
                          f_fit = group_I_fit, 
                          f_MSE = group_I_MSE,
                          group = "I", m_type = "bespoke", 
                          train, test, results)


## GROUP J

group_J_process <- function(training_data) {
  training_data <- training_data %>%
    mutate(sqrInvInc = (100*pctWInvInc)^2,
           sqrPop = population^2)
}

group_J_fit <- function(training_data) {
  m1 <- lm(ViolentCrimesPerPop ~ population + sqrPop + log(medIncome) + PctHousOccup +
             NumInShelters + PctKids2Par + pctWInvInc + sqrInvInc + PctPersDenseHous +
             racePctWhite + PctWorkMomYoungKids, data = training_data)
  m1
}

group_J_MSE <- function(model, data) {
  MSE <- mean((data$ViolentCrimesPerPop - predict.lm(model, data)) ^ 2)
  return(MSE)
}

results <- process_models(f_process = group_J_process, 
                          f_fit = group_J_fit, 
                          f_MSE = group_J_MSE,
                          group = "J", m_type = "bespoke", 
                          train, test, results)

## GROUP K

group_K_process <- function(training_data) {
  training_data
}

group_K_fit <- function(training_data) { 
  m1<-lm(ViolentCrimesPerPop ~ PctFam2Par + racePctWhite + PctPersOwnOccup, 
         data = training_data)
}

group_K_MSE <- function(model, data) {
  yhat <- predict(model, newdata = data)
  mean((data$ViolentCrimesPerPop - yhat)^2)
}

results <- process_models(f_process = group_K_process, 
                          f_fit = group_K_fit, 
                          f_MSE = group_K_MSE,
                          group = "K", m_type = "bespoke", 
                          train, test, results)

## GROUP L

group_L_process <- function(data) {
  data
}

group_L_fit <- function(training_data) {
  m <- lm(ViolentCrimesPerPop ~ PctHousOccup + medIncome + PctKids2Par + 
            PctPersDenseHous + pctWInvInc + PctPopUnderPov + PctIlleg + 
            NumInShelters/population + MedRentPctHousInc + PctVacantBoarded + 
            MalePctNevMarr + racePctWhite, training_data)
  m
}

group_L_MSE <- function(model, data) {
  mean((data$ViolentCrimesPerPop - predict.lm(model, data)) ^ 2)
}

results <- process_models(f_process = group_L_process, 
                          f_fit = group_L_fit, 
                          f_MSE = group_L_MSE,
                          group = "L", m_type = "bespoke", 
                          train, test, results)

results <- results %>%
  filter(group != "G")
