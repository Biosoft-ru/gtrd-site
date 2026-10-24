package operations

import com.developmentontheedge.be5.groovy.GDynamicPropertySetSupport
import com.developmentontheedge.be5.server.operations.FilterOperation
import com.developmentontheedge.beans.DynamicPropertySet
import groovy.transform.TypeChecked

import static com.developmentontheedge.be5.operation.validation.ValidationRules.range

/**
 * TODO 
 * 1) search by regulated genes
 */
@TypeChecked
class EnhancerFilter extends TssFilter
{
	DynamicPropertySet getFilterParameters(Map<String, Object> presetValues) throws Exception
    {
		def dps = new GDynamicPropertySetSupport()
	
		dps.add("genome", "Species") {
				TAG_LIST_ATTR = [ ["hg38", "Homo sapiens"], ["mm10", "Mus musculus"], ["rn6", "Rattus norvegicus"],
                                  ["galGal5", "Gallus gallus"] ] as String[][]
				RELOAD_ON_CHANGE = true
		}
			
		dps.add("chromosome", "Chromosome") {}
		dps.add("start",  "Start") 		{
					TYPE = Integer.class
					VALIDATION_RULES = range(1, Integer.MAX_VALUE) 	}
		dps.add("end", "End") 	{
					TYPE = Integer.class
					VALIDATION_RULES = range(1, Integer.MAX_VALUE)  }

		dps.add("species", "Species") { HIDDEN = true }

		return dps
	}

	public Object getParameters(Map<String, Object> presetValues) throws Exception
	{
		GDynamicPropertySetSupport dps = (GDynamicPropertySetSupport)super.getParameters(presetValues)
		
		def species = [ "hg38" : "Homo sapiens", 
			            "mm10" : "Mus musculus",
						"rn6"  : "Rattus norvegicus" ]
		
		dps.setValue("species", species[dps.getValue("genome")] )
		
		return dps
	}
	
}
