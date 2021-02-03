# Facet configurations

The file `facetsConfiguration.xml` provides definitions for the fields in the VLO's
index that are used to determine field specific behaviour of the VLO importer and
web app. A schema for this configuration file can be 
[found in the VLO project](https://github.com/clarin-eric/VLO/blob/master/vlo-commons/src/main/resources/facetsConfiguration.xsd).

## Structure of the configuration file

A root element `<facetsConfiguration>` can have any number of `<facet>` child elements
with a mandatory `@name` attribute that determines to which facet the contained
properties and conditions apply. These must be the names as they appear in the index,
not the field keys that can be found in `VloConfig.xml`.

### Properties

TODO

Example:
```xml
<facet name="name">
	<allowMultipleValues>false</allowMultipleValues>
	<multilingual>true</multilingual>
	<description>The name of the resource or tool</description>
	<definition>The full public name of the resource or tool.</definition>
</facet>
```

### Conditions

TODO

Example:

```xml
<facet name="multilingual">
	<multilingual>false</multilingual>
	<description>Whether the resources covers more than one language</description>
	<conditions>
		<condition>
			<facetSelectionCondition>
				<facetName>languageCode</facetName>
				<selection type="anyValue"/>
			</facetSelectionCondition>
		</condition>
	</conditions>
</facet>
```
