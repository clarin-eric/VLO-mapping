# VLO mappings and vocabularies
Mapping [definitions](mapping) and [normalisation vocabularies](uniform-maps) for the [Virtual Language Observatory](https://github.com/clarin-eric/VLO).

## Context/workflow
The following diagram illustrates the intended workflow: the production and beta instance of the VLO source their mapping definitions from a clone of the main repository. The curation team works on a fork and makes pull requests once new mappings have been established. Mapping adaptions can be the result of processing secondary source files (e.g. tabular representations) or services (such as CLAVAS), potentially authored by external curators and domain experts.

![](https://github.com/clarin-eric/VLO-mapping/wiki/vlo_mapping_workflow.png)

## Usage
To use the mapping with the VLO, clone the repository or download its contents to make the definitions available locally. Then adapt your [VloConfig file](https://github.com/clarin-eric/VLO/blob/master/vlo-commons/src/main/resources/VloConfig.xml) to use these locations. More information is available in the [VLO deployment instructions](https://github.com/clarin-eric/VLO/blob/master/DEPLOY-README.txt).

Note that the VLO has built-in copies (retrieved at build time through the Maven artifact generated from this project) that can be used as a fallback solution.

### Branches/versions
The `beta` branch is intended for usage in pre-production testing environment. The CLARIN production environment should stay synchronised with the `master` branch. Forks can be made for other applications (such as curation) and proposing modifications to the mapping (via pull requests).
