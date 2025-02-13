if(0) {
    devtools::load_all()
    
    source("../R/computeConnectivityEnrichment.R")
    source("../R/computeMoaEnrichment.R")
    source("../R/plotDrugConnectivity.R")
    source("../R/plotMOA.R")
    source("../R/plotActivationMap.R")
    source("../R/metaLINCS.R")
    source("../R/utils.R")
    
    ##remotes::install_github("bigomics/metaLINCS")
    remove.packages("metaLINCS")
    library(metaLINCS)
    ls("package:metaLINCS")

    ## First we compute the connectivity enrichment    
    res <- computeConnectivityEnrichment(mFC, nprune=0)
    names(res)

    png("../vignettes/images/cmap.png",w=3600,h=2400,res=480)
    rdbu <- RColorBrewer::brewer.pal(n=8, name = "RdBu")
    ii <- 1:100
    heatmap(t(res$X[ii,]), mar=c(20,10), col=rdbu)
    dev.off()
    
    ## Now compute the MOA enrichment
    moa <- computeMoaEnrichment(res) 
    names(moa)
    
    ## Get the mechanism of action results for the first contrast
    head(moa[[1]]$drugClass)
    head(moa[[1]]$targetGene)

    ## select a contrast for the analysis
    colnames(mFC)
    head(selectResult(res,1))
    
    ## Plot the drugs connectivity using plotDrugConnectivity()
    png("../vignettes/images/plotDrugConnectivity-RvsS.png",w=3600,h=2400,res=480)
    plotDrugConnectivity(res, contr="Resistant.vs.Sensitive")
    dev.off()
    
    ## If you want to select some drugs manually for plotting
    dd <- c("strophanthidin","palbociclib")
    plotDrugConnectivity(res, contr="Resistant.vs.Sensitive", drugs=dd, nplots=9)
    
    ## Plot the mechanism of action using plotMOA()
    png("../vignettes/images/plotMOA-drugClass-WvsU.png",w=3600,h=2800,res=400)    
    plotMOA(moa, contr="WithaferinA.vs.Untreated", type="drugClass", ntop=20)
    dev.off()

    png("../vignettes/images/plotMOA-targetGene-WvsU.png",w=3600,h=2800,res=400)        
    plotMOA(moa, contr="WithaferinA.vs.Untreated", type="targetGene", ntop=20)
    dev.off()
    
    ## Plot the drugs activity map using plotActivationMap()
    png("../vignettes/images/plotActivationMap.png",w=3600,h=1200,res=400)            
    plotActivationMap(res, nterms = 60, nfc=20, rot=FALSE)
    dev.off()

}
