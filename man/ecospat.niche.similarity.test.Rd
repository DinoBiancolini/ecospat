\name{ecospat.niche.similarity.test}

\alias{ecospat.niche.similarity.test}

\title{Niche Similarity Test}

\description{Run a niche similarity test (see Warren et al 2008) based on two species occurrence density grids.}

\usage{ecospat.niche.similarity.test (z1, z2, rep, alternative = "greater", 
rand.type = 1, ncores= 1)}

\arguments{
  \item{z1}{Species 1 occurrence density grid created by \code{ecospat.grid.clim}.}
  \item{z2}{Species 2 occurrence density grid created by \code{ecospat.grid.clim}.}
  \item{rep}{The number of replications to perform.}
  \item{alternative}{To indicate the type of test to be performed. It could be greater or lower.}
  \item{rand.type}{Type of randomization on the density grids (1 or 2).}
  \item{ncores}{The number of cores used for parallelisation.}

}

\details{Compares the observed niche overlap between z1 and z2 to overlaps between z1 and random niches (z2.sim) as available in the range of z2 (z2$Z). z2.sim has the same pattern as z2 but the center is randomly translatated in the availabe z2$Z space and weighted by z2$Z densities.
If rand.type = 1, both z1 and z2 are randomly shifted, if rand.type =2, only z2 is randomly shifted.

\code{alternative} specifies if you want to test for niche conservatism (alternative = "greater", i.e. the niche overlap is more equivalent/similar than random) or for niche divergence (alternative = "lower", i.e. the niche overlap is less equivalent/similar than random). 

If you encounter a problem during your analyses, please first read the FAQ section of "Niche overlap" in http://www.unil.ch/ecospat/home/menuguid/ecospat-resources/tools.html

The arguments \code{ncores} allows choosing the number of cores used to parallelize the computation. The default value is 1. On multicore computers, the optimal would be \code{ncores = detectCores() - 1}. 

}

\value{a list with $obs = observed overlaps, $sim = simulated overlaps, $p.D = p-value of the test on D, $p.I = p-value of the test on I.}

\references{Broennimann, O., M.C. Fitzpatrick, P.B. Pearman, B. Petitpierre, L. Pellissier, N.G. Yoccoz, W. Thuiller, M.J. Fortin, C. Randin, N.E. Zimmermann, C.H. Graham and A. Guisan. 2012. Measuring ecological niche overlap from occurrence and spatial environmental data. \emph{Global Ecology and Biogeography}, \bold{21}, 481-497.

Warren, D.L., R.E. Glor and M. Turelli. 2008. Environmental niche equivalency versus conservatism: quantitative approaches to niche evolution. \emph{Evolution}, \bold{62}, 2868-2883.
}

\author{Olivier Broennimann \email{olivier.broennimann@unil.ch} with contributions of Blaise Petitpierre \email{bpetitpierre@gmail.com}}

\seealso{\code{\link{ecospat.grid.clim.dyn}}, \code{\link{ecospat.niche.equivalency.test}}}
