########################################################################
#  source( 'refseq2entrez.r' )
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# ms2188(at)cam.ac.uk
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# last update: 20130904
########################################################################

 rm( list=ls() ) ;
 system( 'clear' ) ;
 
# libraries and dependencies # # # # # # # # # # # # # # # # # # # # # #

 library(org.Hs.eg.db) ; #  loads a package that contains different annotations about (human) genes and its corresponding Entrez gene identifiers

# input variables # # # # # # # # # # # # # # # # # # # # # # # # # # # 

 inputfile = "table.tsv" ; # table with the gene information
 outputfile = "genes.tsv" ; # table with the gene information
 colindex = 2 ; # column including the RefSeq IDs to be mapped to Entrez unique ID
 
# variables initialization # # # # # # # # # # # # # # # # # # # # # # #
 
# main # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

 filename = strsplit( inputfile,'\\.' )[[1]] ; 
 filetype = switch( filename[ length(filename) ],tsv='\t',csv=',',ssv=';',txt='' ) ;
 inputdata = read.table( inputfile,quote='',header=TRUE,stringsAsFactors=FALSE,sep=filetype ) ; # this is a data.frame 
 nrow = dim( inputdata )[1] ;
 ncol = dim( inputdata )[2] ;
 myrefseqid = as.vector( inputdata[,colindex] ) ;
  
 for( k in 1:nrow ){
 
 entrezid = mget( myrefseqid[k], envir=(org.Hs.egREFSEQ2EG),ifnotfound=NA ) ; 
 mytable = data.frame(
   ID='',
   GENEID = entrezid,
   SYMBOL=inputdata[k,13],
   COOR = substr(inputdata[k,3],4,nchar(inputdata[k,3])),
   START=inputdata[k,5],
   END=inputdata[k,6],
   COOR = paste( inputdata[k,3],":",inputdata[k,5],"-",inputdata[k,6],collapse='',sep='' )
  )
 write.table( mytable,file=outputfile,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE,sep="\t" ) ;
 
 }#endfor
