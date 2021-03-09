# Use the vlo_mapping command (see build.sh) to generate XML mapping files from CSV files:
#
#	vlo_mapping [OPTIONS] <base-name>
#
#		OPTIONS: 
#			-s=<SKOS>
#			-t=<TMPL>
#			-d
#
#		base-name:
#			file name of map without extension, for example if 'mymap.csv' has to be
#			built, provide 'mymap'
#

vlo_mapping -t=dist/resourceClass_template.xml resourceClass_tf-extended
vlo_mapping profileName2resourceClass_tf-extended_noResourceClassProfiles
vlo_mapping -t=dist/collection_template.xml collection
vlo_mapping -t=dist/creator_template.xml creator
vlo_mapping -t=dist/subject_template.xml subject
