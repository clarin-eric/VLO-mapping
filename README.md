# VLO mappings and vocabularies
Mapping [definitions](mapping) and [normalisation vocabularies](uniform-maps) for the [Virtual Language Observatory](https://github.com/clarin-eric/VLO).

## Context/workflow
The following diagram illustrates the intended workflow: the production and beta instance of the VLO source their mapping definitions from a clone of the main repository. The curation team works on a fork and makes pull requests once new mappings have been established. Mapping adaptions can be the result of processing secondary source files (e.g. tabular representations) or services (such as CLAVAS), potentially authored by external curators and domain experts.

![](https://github.com/clarin-eric/VLO-mapping/wiki/vlo_mapping_workflow.png)
(source: see Wiki)

## Usage
To use the mapping with the VLO, clone the repository or download its contents to make the definitions available locally. Then adapt your [VloConfig file](https://github.com/clarin-eric/VLO/blob/master/vlo-commons/src/main/resources/VloConfig.xml) to use these locations. More information is available in the [VLO deployment instructions](https://github.com/clarin-eric/VLO/blob/master/DEPLOY-README.txt).

Note that the VLO has built-in copies (retrieved at build time through the Maven artifact generated from this project) that can be used as a fallback solution.

### Branches/versions
The `beta` branch is intended for usage in pre-production testing environment. The CLARIN production environment should stay synchronised with the `master` branch. Forks can be made for other applications (such as curation) and proposing modifications to the mapping (via pull requests).

### Editing the mapping files

The CSV files in `value-maps`-folder are meant as the interaction point between the human and the machine, as they should be farely easy to edit by a human and are structured enough for the machine processing.

Following is a (syntactically) valid sample file, normalizing values in `resourceClass` AND optionally also populating the `genre` facet
```
"resourceclass","resourceclass","genre"
"AnnotatedTextCorpus","annotatedText;text","some"
"SongsAnthologiesLinguistic corporaCorpus","audioRecording","other"
"~Speech*","audioRecording","foo"
"Spoken Corpus","audioRecording","bar"
"OralCorpus","corpus",
OralCorpus,"audioRecording",
"AnthologiesDevotional,Addresses","plainText","""literature""",
```

Following restrictions on the structure of the CSV apply:

````
Row 1: column headers referring to facets
Column A: source
Column B and higher: targets, each facet should appear only once
Source values (row 2 and higher, column A): if starting with a tilde (‘~’) the value is assumed to be a regular expression (see line 4 )
Target values (row 2 and higher, column B and higher): multiple values for one target facet are to be separated by semicolon (‘;’) (see line 2)

Make sure all rows have an equal number of columns!
Double quote (‘“‘) in the value can be escaped by doubling ("foo""bar") (see line 8)
Double quotes (‘“‘) are only mandatory if the value contains a comma (‘,’) (cf. line 7 vs. 8)

Source values are grouped into the mapping XML (see line 6 and 7)
````


