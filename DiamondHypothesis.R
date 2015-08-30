
standardError <- function( x ) {
  sd( x )/sqrt( length( x ) )
}

diamonds <- read.csv( "Data.csv")



HRD_Diamonds <- subset( diamonds , Certification.Body == "HRD")
Non_HRD_Diamonds <- subset( diamonds , Certification.Body != "HRD" )

ndiff <- 40
set.seed(425)
HRD_Sample <- sample( HRD_Diamonds$Price.in.Singapore.. , ndiff , replace = TRUE )
Non_HRD_Sample <- sample( Non_HRD_Diamonds$Price.in.Singapore.. , ndiff , replace = TRUE )


xVar <- c(HRD_Sample , Non_HRD_Sample )
colorVar <- as.factor(c(rep(1, ndiff), rep(2, ndiff ) ) )
sampleDensityDf <- data.frame( xVar ,  colorVar )

ggplot( sampleDensityDf , aes(x = xVar, fill = colorVar) ) + 
  geom_density( alpha = .2 ) +
  scale_x_continuous( "Price of Diamond in SGD" ) +
  scale_fill_discrete( 
    name = "Sample" , labels=c( "HRD Certified Sample", "Non HRD Certified Sample" ) ) +
  scale_y_continuous( "Density" )

ggplot( sampleDensityDf , aes( colorVar , xVar ) ) + 
  geom_boxplot( aes( fill = colorVar ) ) + 
  scale_y_continuous( "Price of Diamond in SGD" ) +
  scale_fill_discrete( 
    name = "Sample" , labels=c( "HRD Certified Sample", "Non HRD Certified Sample" ) ) +
  scale_x_discrete( "Sample" , labels=c( "HRD Certified Sample", "Non HRD Certified Sample" )  ) 




Diff = HRD_Sample - Non_HRD_Sample
xBar <- mean(Diff)
zScore <- xBar / standardError(Diff)
zScore
## Calculating p-value
## 1-pnorm() because we are doing a one-sided test - greater than
pValue <- 1-pnorm( zScore ) 
pValue
