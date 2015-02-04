Miscellaneous
=============

Miscellaneous programs to perform different Bioinformatics tasks.


# `liftover.sh` [:octocat:](https://github.com/mscastillo/Miscellaneous/blob/master/liftover.sh)

Script to convert genome coordinates between assemblies in batch.

It depends on `liftOver` from the UCSC [utilities](http://hgdownload.soe.ucsc.edu/admin/exe/). It  will also require the [chain files](http://hgdownload.cse.ucsc.edu/downloads.html) to map between genome assemblies.


# `homologene.sh` [:octocat:](https://github.com/mscastillo/Miscellaneous/blob/master/homologene.sh)

Instructions to construct a table with pairs of hologous genes using [NCBI'S homologene](http://www.ncbi.nlm.nih.gov/homologene).

The input is an *XML* file with the results of your query. Use the organism filters to query all the genes from any of the species of your interest as in [here](http://www.ncbi.nlm.nih.gov/homologene/?term=(%22Mus+musculus%22%5BOrganism%5D+OR+%22Homo+sapiens%22%5BOrganism%5D)). The output will be a two columns table with the [Entrez Gene](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3013746/) ID of each homologous pair.
