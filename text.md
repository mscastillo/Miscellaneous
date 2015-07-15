Designing of a patway-based Protein-Protein interaction network
========================================================================


This document describes how to use design a Protein-Protein interacion (PPi) network based on known biological pathways.


------------------------------------------------------------------------


# Abstract

We describe in this document how to design a PPi from biological pathways at molecular levels. Such type of networks will describe PPi as a cascade signaling process in a relevant biological context, opposite to other type of networks derived from known undirected-physical interactions. Specifically, we use REACTOME as the main source of information. REACTOME's pathways are conveniently provided in extended-SIF format at [Pathway Commons](http://www.pathwaycommons.org/pc2/formats), which allows to identify the direction of the biochemical interaction.


------------------------------------------------------------------------


# Data

We download the data from . REACTOME's pathways describe interactions, reactions and pathways as downloadable flat files in [multiple formats](http://wiki.reactome.org/index.php/Usersguide#Exporting_Data_From_Reactome). However, we consider [Pathway Commons 2](http://www.pathwaycommons.org/pc2) as the main data source, that conveniently provides the pathways in [extended-SIF format](http://www.pathwaycommons.org/pc2/formats).

Specifically, we considered the most recent release (V7) of REACTOME in extended-SIF format with the HGNC annotation, that simultaneously provide the network as triplets (interactor-type-interactor) and the pathways from where the interaction was derived:

 * (Pathway Commons.7.Reactome.EXTENDED_BINARY_SIF.hgnc.sif.gz)[http://www.pathwaycommons.org/pc2/downloads/Pathway%20Commons.7.Reactome.EXTENDED_BINARY_SIF.hgnc.sif.gz]


------------------------------------------------------------------------


# Dependencies

We process the data using basic `bash` commands.


------------------------------------------------------------------------


# Methods

First, we set the working directory as a bash-variable:

```bash
WD="~/Projects/REACTOME"
cd $WD
```
and we continue by downloading the data and building the network. 

## Gathering the data

We download the data from the *Downloads* section of the official (Pathway Commons 2 website)[http://www.pathwaycommons.org/pc2].

```bash
URL="http://www.pathwaycommons.org/pc2/downloads/Pathway%20Commons.7.Reactome.EXTENDED_BINARY_SIF.hgnc.sif.gz;jsessionid=E5322225AC686B7A932BD975E9106201"
wget -O pc2.reactome.sif.gz -c $URL
gunzip pc2.reactome.sif.gz
```

## Building the network

We identify first which kind of interactions are we interested in from the different types considered within the extended-SIF format.

```bash
cat pc2.reactome.sif | cut -f2 | sort -u
```

We use the Pathway Common [extended-SIF format](http://www.pathwaycommons.org/pc2/formats) description to identify the interaction types and theirs directionality. Specifically, we are interested in interaction between proteins, so we filter out interactions involving small molecules that are not expected to be in the proteome. We also consider that these molecular relationships can be directed or undirected. According to the [extended-SIF format](http://www.pathwaycommons.org/pc2/formats) description, we can distinguish between two **directed** interactions. *Forward* interactions between two molecules have the same direction as the one defined in the file, from left to rigth. Opposite, *reverse* intereactions are from rigth to left. On the other hand, **undirected** interactions have no causal relationship stablished, so both *forward* and *reverse* are considered.

```bash
OUTPUT="$WD/PPi.network.directed.tsv"
rm $WD/$OUTPUT
# directed, forward
FORWARD=("catalysis-precedes")
for k in $( seq 0 $((${#FORWARD[@]} - 1)) ) ; do
 cat pc2.reactome.sif | grep -w ${FORWARD[$k]} | awk 'BEGIN{FS="\t";OFS="\t"}{print $1,$3}' >> $OUTPUT
done
# directed, reverse
REVERSE=("controls-expression-of" "controls-phosphorylation-of" "controls-state-change-of" "controls-transport-of") >> $OUTPUT
for k in $( seq 0 $((${#REVERSE[@]} - 1)) ) ; do >> $OUTPUT
 cat pc2.reactome.sif | grep -w ${REVERSE[$k]} | awk 'BEGIN{FS="\t";OFS="\t"}{print $3,$1}' >> $OUTPUT
done
#undirected
UNDIRECTED=("neighbor-of")
for k in $( seq 0 $((${#UNDIRECTED[@]} - 1)) ) ; do
 cat pc2.reactome.sif | grep -w ${UNDIRECTED[$k]} | awk 'BEGIN{FS="\t";OFS="\t"}{print $1,$3"\n"$3,$1}' >> $OUTPUT
done
cat $OUTPUT | sort -u > temp
mv temp $OUTPUT
```
