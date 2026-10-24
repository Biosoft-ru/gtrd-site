package operations

import com.developmentontheedge.be5.groovy.GDynamicPropertySetSupport
import com.developmentontheedge.be5.server.operations.FilterOperation
import com.developmentontheedge.beans.DynamicPropertySet
import groovy.transform.TypeChecked

import static com.developmentontheedge.be5.operation.validation.ValidationRules.range

/**
 * Some hacks
 *
 * 1) "genome" property is set up in url - /#!table/gtrd_current.cage_peaks_/Transcription%20start%20sites/genome=hg38
 * However, for consistency of filter by species it can be edited.
 *
 * 2) location property by default is gene
 * 
 * TODO 
 * 1) gene flanks, for this purpose it is needed gene list with coordinates
 * 2) source list, currently it is available only for rn6
 * 3) filter  
 */
@TypeChecked
class TssFilter extends FilterOperation
{
    DynamicPropertySet getFilterParameters(Map<String, Object> presetValues) throws Exception
    {
        def dps = new GDynamicPropertySetSupport()

        dps.add("genome", "Species") {
			TAG_LIST_ATTR = [ ["hg38", "Homo sapiens"], ["mm10", "Mus musculus"], ["rn6", "Rattus norvegicus"],
                              ["galGal5", "Gallus gallus"] ] as String[][]
			RELOAD_ON_CHANGE = true
        }
		
		dps.add("type", "Type") {
			TAG_LIST_ATTR = [ ["promoter", "promoter"], ["enhancer", "enhancer"], ["unclassified", "unclassified"] ] as String[][]
		}

		dps.add("location", "Location") {
			TAG_LIST_ATTR = [ ["chromosome", "chromosome"], ["gene", "gene"] ] as String[][]
			RELOAD_ON_CHANGE = true
		}

		if( "chromosome".equals(presetValues.get("location")) )
		{
			dps.add("chromosome", "Chromosome") {
				// TODO
				// TAG_LIST_ATTR = [ ["chr1", "chr1"], ["chr2", "chr2"] ] as String[][]
			}	
			dps.add("start",  "Start") 		{ 
				TYPE = Integer.class 
				VALIDATION_RULES = range(1, Integer.MAX_VALUE) 	}
			dps.add("end", "End") 	{ 
				TYPE = Integer.class 
				VALIDATION_RULES = range(1, Integer.MAX_VALUE)  }
		}
		else
		{
			dps.add("gene",   "Gene") 		{}
			
			// TODO
			// dps.add("flanks", "Flanks") 	{}
		}
		
		if( "rn6".equals(presetValues.get("genome")) )
		{
			// TODO
			dps.add("source",  "Source")	{
				TAG_LIST_ATTR = [ ["FANTOM5", "FANTOM5"], ["SOL+EDL", "SOL+EDL"] ] as String[][]
			}
		}
		
		dps.add("fantom5", "FANTOM5/refTSS id")	{}
		
		return dps
    }

	// Hacks 
	public Object getParameters(Map<String, Object> presetValues) throws Exception
	{
		GDynamicPropertySetSupport dps = (GDynamicPropertySetSupport)super.getParameters(presetValues)

		dps.getProperty("genome").setReadOnly(false)
		dps.getProperty("genome").setCanBeNull(false)

		if( presetValues.containsKey("location") && presetValues.get("location") == null )
			dps.getProperty("location").setValue("gene")
		
		return dps;
	}

	public void invoke(Object parameters) throws Exception
	{
		context.getParams().put("genome", ((DynamicPropertySet)parameters).getValue("genome"))

		super.invoke(parameters)
	}
}
