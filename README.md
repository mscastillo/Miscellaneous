Miscellaneous
=============

Miscellaneous programs to perform different Bioinformatics tasks.


# `liftover.sh` [:octocat:](https://github.com/mscastillo/Miscellaneous/blob/master/liftover.sh)

Script to convert genome coordinates between assemblies in batch.

It depends on `liftOver` from the [UCSC utilities](http://hgdownload.soe.ucsc.edu/admin/exe/). It  will also require the [chain files](http://hgdownload.cse.ucsc.edu/downloads.html) to map between genome assemblies. Inputs files should be in tab-separated three-columns *bed* format. 


# `homologene.sh` [:octocat:](https://github.com/mscastillo/Miscellaneous/blob/master/homologene.sh)

Instructions to construct a table with pairs of hologous genes using [NCBI'S homologene](http://www.ncbi.nlm.nih.gov/homologene).

The input file of this script is an *XML* file with the results of your query. Use the organism filters to query all the genes from any of the species of your interest. For example, follow next link querying [human and mouse](http://www.ncbi.nlm.nih.gov/homologene/?term=(%22Mus+musculus%22%5BOrganism%5D+OR+%22Homo+sapiens%22%5BOrganism%5D)) genes (the resulting *XML* is more than 3GB).

The output of the script will be a two columns table with the [Entrez Gene](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3013746/) ID of each pair of homologous genes.


# `refseq2entrez.r` [:octocat:](https://github.com/mscastillo/Miscellaneous/blob/master/refseq2entrez.r)

Script to map between different (human) gene annotations using [org.Hs.eg.db](http://www.bioconductor.org/packages/release/data/annotation/html/org.Hs.eg.db.html).


# `annotation.r` [:octocat:](https://github.com/mscastillo/Miscellaneous/blob/master/annotation.r)

Examples and general instructions to manage between gene annotations using:
 * [org.Hs.eg.db](http://www.bioconductor.org/packages/release/data/annotation/html/org.Hs.eg.db.html), additional information about others non-human genomes can be fund [here](http://davetang.org/muse/2013/12/16/bioconductor-annotation-packages/).
 * [biomaRt](http://bioconductor.org/packages/release/bioc/html/biomaRt.html).

> Have a look to the whole list of Bioconductors annotation packages [here](http://www.bioconductor.org/packages/release/data/annotation/).

