#!/bin/bash

## VARIABLES AND PARAMETERS # # # # # # # # # # # # # # # # # # # # # # 
   TODAY=$(date +%Y%m%d)
   SUFFIX=$RANDOM
   OUTPUTFILE='table.tsv'
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# (1) Download a big XML table from NCBI - homologene using you preferred filters.
#     I used next:
#     ("Mus musculus"[Organism] OR "Homo sapiens"[Organism])
#     that reported 20979 entries.

INPUTFILE='homologene_result.xml'

# (2) The downloaded file is not in the propper XML format.
#     It requires to remove all lines having the tag '<?xml version="1.0"?>'.

grep -v '<?xml version="1.0"?>' $INPUTFILE > filtered.xml.$SUFFIX

# (3) For the next steps you need to have installed xml2.
#     The next comand parses the XML file to xml2 and grab the information of any of the next tags: <HG-Entry_hg-id>, <HG-Gene_geneid> and <HG-Gene_taxid>
#     The structure returned is the one showed below:
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_hg-id=1331
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_geneid=861
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_taxid=9606
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_geneid=101058316
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_taxid=9598
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_geneid=696749
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_taxid=9544
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_hg-id=2346
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_geneid=6688
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_taxid=9606
#    	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_geneid=611255
#     	/Entrez-Homologene-Set/HG-Entry/HG-Entry_genes/HG-Gene/HG-Gene_taxid=9615

xml2 < filtered.xml.$SUFFIX | egrep "HG-Entry_hg-id|Gene_geneid|Gene_taxid" > text.$SUFFIX 

# (4) Using awk, I want to find  pairs of <Gene_taxid> and <Gene_geneid> tags after each <HG-Entry_hg-id> entry.
#     For each entry, I will print the pair of human and mouse gene IDs.
#     The next command is used to generate this list, with human genes at the first column and its mouse equivalent at second column.
#		BEGIN{ FS="=" ; human_gene="void" ; mouse_gene="void" } 
#		{if ( $0~/HG-Entry_hg-id/ ){
#			if ( human_gene != "void" && mouse_gene!="void" ){
#				print human_gene,mouse_gene ;
#			}else{
#				human_gene="void" ; mouse_gene="void" ;
#			}
#			next ;
#		}else{
#			if ( $0~/HG-Gene_geneid/ ){
#				gene = $2 ;	next ;
#			}
#			if ( $0~/HG-Gene_taxid=9606/ ){
#				human_gene=gene ; next ;
#			}
#			if ( $0~/HG-Gene_taxid=10090/ ){
#				mouse_gene=gene ; next ;
#			} 
#		} }

cat text.$SUFFIX | awk 'BEGIN{ FS="=";OFS="\t";human_gene="void";mouse_gene="void"}{if($0~/HG-Entry_hg-id/){if(human_gene!="void"&&mouse_gene!="void"){print human_gene,mouse_gene}else{human_gene="void";mouse_gene="void"};next}else{if($0~/HG-Gene_geneid/){gene=$2;next;}if($0~/HG-Gene_taxid=9606/){human_gene=gene;next}if($0~/HG-Gene_taxid=10090/){mouse_gene=gene;next}}}'
