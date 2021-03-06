\name{ecospat.CCV.communityEvaluation.prob}
\alias{ecospat.CCV.communityEvaluation.prob}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Evaluates community predictions directly on the probabilities (i.e., threshold independent)
}
\description{
This function generates a number of community evaluation metrics directly based on the probability returned by the individual models. Instead of thresholding the predictions (\code{\link{ecospat.CCV.communityEvaluation.bin}} this function directly uses the probability and compares its outcome to null models or average expectations.)
}
\usage{
ecospat.CCV.communityEvaluation.prob(
      ccv.modeling.data,
      community.metrics=c('SR.deviation','community.AUC','probabilistic.Sorensen'),
      se.th=0.01,
      parallel = TRUE,
      cpus = 4)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ccv.modeling.data}{a \code{'ccv.modeling.data'} object returned by \code{\link{ecospat.CCV.modeling}}}
  \item{community.metrics}{a selection of community metrics to calculate (\code{'SR.deviation', 'community.AUC', 'probabilistic.Sorensen', 'probabilistic.Jaccard', 'probabilistic.Simpson'})}
  \item{se.th}{the desired precission for the community metrics (standard error of the mean)}
  \item{parallel}{should parallel computing be allowed (\code{TRUE/FALSE})}
  \item{cpus}{number of cpus to use in parallel computing}
}
\value{
  \item{DataSplitTable}{a matrix with \code{TRUE/FALSE} for each model run (\code{TRUE}=Calibration point, \code{FALSE}=Evaluation point)}
  \item{CommunityEvaluationMetrics.CalibrationSites}{a 3-dimensional array containing the community evaluation metrics for the calibartion sites of each run (\code{NA} means that the site was used for evaluation)}
  \item{CommunityEvaluationMetrics.EvaluationSites}{a 3-dimensional array containing the community evaluation metrics for the evaluation sites of each run (\code{NA} means that the site was used for calibaration)}
}
\author{
Daniel Scherrer <daniel.j.a.scherrer@gmail.com>
}
\note{
If the community evaluation metric \code{'SR.deviation'} is selected the returned tables will have the following columns: 
  \itemize{
    \item \code{SR.obs} = observed species richness, 
    \item \code{SR.mean} = the predicted species richness (based on the probabilities assuming poission binomial distribution), 
    \item \code{SR.dev} = the deviation of observed and predicted species richness, 
    \item \code{SR.sd} = the standard deviation of the predicted species richness (based on the probabilities assuming poission binomial distribution), 
    \item \code{SR.prob} = the probability that the observed species richness falls within the predicted species richness (based on the probabilities assuming poission binomial distribution), 
    \item \code{SR.imp.05} = improvement of species richness prediction over null-model 0.5, 
    \item \code{SR.imp.average.SR} = improvement of species richness prediction over null-model average.SR and 
    \item \code{SR.imp.prevalence} = improvement of species richness prediction over null-model prevalence.
  }

If the community evalation metric \code{community.AUC} is selected the returned tables will have the following colums: 
  \itemize{
    \item \code{Community.AUC} = The AUC of ROC of a given site (in this case the ROC plot is community sensitiviy [percentage species predicted corretly present] vs 1 - community specificity [percentage of species predicted correctly absent])
  }
  
If any of the other community evaluation metrics (\code{'probabilistic.Sorensen', 'probabilistic.Jaccard', 'probabilistic.Simpson'}) is selected the returned tables will have the follwing colums:
  \itemize{
    \item \code{METRIC.mean} = The average Sorensen/Jaccard/Simpson based on a number of random draws of the probabilities.
    \item \code{METRIC.sd} = The standard deviation of Sorensen/Jaccard/Simpson based on a number of random draws of the probabilities.
    \item \code{METRIC.CI} = The 95\% confidence intervall of the average Sorensen/Jaccard/Simpson based on the standard deviation and number of draws. Should normally be <= \code{se.th}.
    \item \code{nb.it} = number of draws used to estimate all the parameters. The draws stop as soon as the desired precission (\code{se.th}) is reached or the limit of allowed iterations (default=10'000).
    \item{composition.imp.05} = improvement of species compostion prediction over the null-model 0.5.
    \item{composition.imp.average.SR} = improvement of the species composition prediction over the null-model average.SR.
    \item{composition.imp.prevalence} = improvement of the species composition prediction over the null-model prevalence.
  }
  
For detailed descriptions of the null models see Scherrer et al. .....
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{ecospat.CCV.createDataSplitTable}}; \code{\link{ecospat.CCV.communityEvaluation.bin}};
}
\examples{
\dontrun{
#Loading species occurence data and remove empty communities
data(ecospat.testData)
testData <- ecospat.testData[,c(24,34,43,45,48,53,55:58,60:63,65:66,68:71)]
sp.data <- testData[which(rowSums(testData)>0), sort(colnames(testData))]

#Loading environmental data
env.data <- ecospat.testData[which(rowSums(testData)>0),4:8]

#Coordinates for all sites
xy <- ecospat.testData[which(rowSums(testData)>0),2:3]

#Running all the models for all species
myCCV.Models <- ecospat.CCV.modeling(sp.data = sp.data,
                                     env.data = env.data,
                                     xy = xy,
                                     NbRunEval = 5,
                                     minNbPredictors = 10,
                                     VarImport = 3)
                                     
#Calculating the probabilistic community metrics
myCCV.communityEvaluation.prob <- ecospat.CCV.communityEvaluation.prob(
      ccv.modeling.data = myCCV.Models,
      community.metrics = c('SR.deviation','community.AUC','probabilistic.Sorensen'),
      se.th = 0.02, 
      parallel = FALSE,
      cpus = 4)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
