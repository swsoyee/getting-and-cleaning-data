require(knitr)
require(markdown)

setwd("D:/coursera/cleanData")
knit("run_analysis.Rmd", encoding="UTF-8")
markdownToHTML("run_analysis.md", "run_analysis.html")

knit("codebook.Rmd", encoding="UTF-8")
markdownToHTML("codebook.md", "codebook.html")