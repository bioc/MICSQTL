% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/csQTL.R
\name{csQTL}
\alias{csQTL}
\title{Cell-type-specific differential expression (csQTL)}
\usage{
csQTL(se, BPPARAM = bpparam())
}
\arguments{
\item{se}{A `SummarizedExperiment` object with bulk protein expression data
frame contained in `counts` slot.
The information from genetic variants should be stored in a P
(the number of SNP) by N (the number of samples,
should match the sample in `counts` slot) matrix contained as an element
(`SNP_data`) in `metadata` slot.
Each matrix entry corresponds to the genotype group indicator (0, 1 or 2)
for a sample at a genetic location.
The annotations of these SNP should be stored as an element (`anno_SNP`)
in `metadata` slot.
It should include at least the following columns: "CHROM" (which chromosome
the SNP is on),
"POS" (position of that SNP) and "ID" (a unique identifier for each SNP,
usually a combination of chromosome and
its position).
The information on cellular composition is required and stored as `prop` in
`metadata` slot.
It is an N (the number of samples, should match the sample in `counts` slot)
by K (the number of cell types) matrix.
This can be obtained by running `deconv()` before any filtering steps, or
use any source data directly.}

\item{BPPARAM}{For applying `bplapply`.}
}
\value{
A `SummarizedExperiment`. The csQTL results will be stored as an
element (`TOAST_output`) in `metadata` slot.
}
\description{
This function returns a `SummarizedExperiment` object including csQTL
proteins based on samples' genotype.
}
\details{
This is a function developed to implement cell-type-specific differential
expression using `TOAST`.
}
\examples{
data(se)
se <- deconv(se, source = "protein", method = "nnls", use_refactor = NULL)
target_protein <- c("ABCA1")
se <- feature_filter(se,
    target_protein = target_protein,
    filter_method = c("allele", "distance"), filter_allele = 0.15,
    filter_geno = 0.05, ref_position = "TSS"
)
se <- csQTL(se)

}
