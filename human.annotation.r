
#################################
# Dealing with the org.Hs.eg.db #
#################################

library(org.Hs.eg.db) #  loads a package that contains different annotations about (human) genes and its corresponding Entrez gene identifiers

class( org.Hs.eg.db ) # the 'OrgDb' class is an specific object that contains an organism database

ls( 'package:org.Hs.eg.db' ) # it lists the supported objects the compounds the database

class( org.Hs.egREFSEQ ) # the 'AnnDbBimap' class is an annotation bipartite map object as (left_set) --> (right_set), the reverse (left_set) <-- (right_set) is surjective with no repeated elements in (rigth_set)

summary( org.Hs.egREFSEQ ) # it displays some more useful information about the bipartite map object, whith 'Entrez ID' as the left_set and 'RefSEQ accession names' as the right_set

class( as.list(o rg.Hs.egREFSEQ ) ) # shows the bipartite map as a list object, where one list is reported for each key in the bipartite set

as.list(org.Hs.egREFSEQ)[[1]] # a vector of strings characters with all mapped RefSEQ IDs for the first key in 'org.Hs.egREFSEQ'

mytable = toTable( org.Hs.egREFSEQ[1:3] ) # shows the bipartite map as a table for only the three first elements in 'org.Hs.egREFSEQ', that are a genes with Entrez ID equal to '1', '10' and '100', each one mapped to diferent RefSEQ accesions names; for instance, gene with EntrezID equal to '1' has 'NM_130786' and 'NP_570602'

class( mytable ) # 'mytable' is a data.frame object

class( mytable[,1] ) # the first row of 'mytable' is also a data.frame with all the Entrez IDs

class( mytable[1,2] ) # each element of 'mytable' is a string of character

refseq = unique( mytable[,2] ) # a vector with all the RefSEQ IDs in 'mytable'

subset( mytable,select=gene_id,mytable[,2]==refseq[3] )  # get the objects from 'mytable' that meet the criterion, the output object is the same as the input one: a data frame


# there is an easier way to map among gene identifiers with the org.Hs.eg.db


?mget # mget function allows to interact directly with 'AnnDbBimap' objects

mylist = mget( refseq[3], envir=(org.Hs.egREFSEQ2EG) ) # a list object made of lists, the input must be a vector as c( 'NM_000015' )

class( mylist[1] ) # it is a list

class( mylist[[1]] ) # it s a string of characters

reportedlist = mget( mylist[[1]], envir=revmap(org.Hs.egREFSEQ2EG) ) # reverse mapping is also posible

length( reportedlist ) # only one list is reported in 'reportedlist'

length( reportedlist[[1]] ) # and it has two IDs
