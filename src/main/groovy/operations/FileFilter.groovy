package operations

import static com.developmentontheedge.be5.FrontendConstants.SEARCH_PARAM
import static com.developmentontheedge.be5.FrontendConstants.SEARCH_PRESETS_PARAM

import javax.management.remote.SubjectDelegationPermission

import com.developmentontheedge.be5.databasemodel.util.DpsUtils
import com.developmentontheedge.be5.groovy.GDynamicPropertySetSupport
import com.developmentontheedge.be5.server.operations.FilterOperation
import com.developmentontheedge.be5.util.FilterUtil
import com.developmentontheedge.beans.BeanInfoConstants
import com.developmentontheedge.beans.DynamicProperty
import com.developmentontheedge.beans.DynamicPropertyBuilder
import com.developmentontheedge.beans.DynamicPropertySet
import groovy.transform.TypeChecked

@TypeChecked
class FileFilter extends FilterOperation
{
    DynamicPropertySet getFilterParameters(Map<String, Object> presetValues) throws Exception
    {
		def dps = new GDynamicPropertySetSupport()
		Map<String, String> map = new HashMap<>()

		String species		  = presetValues.get("species")
		String experimentType = presetValues.get("experiment")
		String dataType		  = presetValues.get("data")
		String[][] dataTags   = null;

        dps.add("species", "Species") {
			TAG_LIST_ATTR = queries.getTagsFromSelectionView("species")
			RELOAD_ON_CHANGE = true
        }

		if ( species != null)
			map.put("species", (String)presetValues.get("species"))

		dps.add("experiment", "Experiment") {
			TAG_LIST_ATTR = queries.getTagsFromCustomSelectionView("experiment_types", "Types for files", map)
			RELOAD_ON_CHANGE = true
		}
			
        if ( experimentType != null ) 
		{
            map.put("experiment", experimentType)
			
			dataTags = queries.getTagsFromCustomSelectionView("data_types", "Selection for experiment type", map)
				
			dps.add("data", "Data type") {
            TAG_LIST_ATTR = dataTags
            RELOAD_ON_CHANGE = true
			}
        }

	
		if( hasCell(experimentType, dataType, dataTags) )
		{
			dps.add("cell", "Cell type") 		{}
			dps.add("has_cell", "has_cell") 	{ HIDDEN = true }
		}

		if( hasTF(experimentType, dataType, dataTags) )
		{
			dps.add("tf", "TF or cofactor") 	{}
			dps.add("has_tf", "has_tf") 		{ HIDDEN = true }
		}

		if( hasExperiment(experimentType, dataType, dataTags) )
		{
			dps.add("geo", "GEO") 				{}
			dps.add("has_exp", "has_exp") 		{ HIDDEN = true }
		}

		return dps
    }

	/** Returns true if result set can have experiment details. */
	protected boolean hasExperiment(String experimentType, String dataType, String[][] dataTags)
	{
		if( experimentType == null )
			return true
				
		return has("Peaks", "zzz", dataType, dataTags)
	}

	/** Returns true if result set can have cell details. */
	protected boolean hasCell(String experimentType, String dataType, String[][] dataTags)
	{
		if( experimentType == null )
			return true
				
		return has("Peaks", "Cell", dataType, dataTags)
	}

	/** Returns true if result set can have TF or cofactor. */
	protected boolean hasTF(String experimentType, String dataType, String[][] dataTags)
	{
		if( experimentType == null )
			return true
				
		if( "ChIP-seq".equals(experimentType) || "ChIP-exo".equals(experimentType) ) 
			return has("Peaks", "TF", dataType, dataTags)
			
		return false
	}
		
	protected boolean has(String peaks, String prefix, String dataType, String[][] dataTags)
	{
		if( dataType != null )
			return dataType.equals(peaks) || dataType.indexOf(prefix) > 0 	
		
		for(int i=0; i<dataTags.length; i++ )
		{
			if( dataTags[i][0].equals(peaks) || dataTags[i][0].indexOf(prefix) > 0 )
				return true;
		}
		
		return false;
	}

	@Override
	public Object getParameters(Map<String, Object> presetValues) throws Exception
	{
		GDynamicPropertySetSupport dps = (GDynamicPropertySetSupport)super.getParameters(presetValues)

		if( dps.hasProperty("has_exp") )	
			dps.setValue("has_exp", "true")

		if( dps.hasProperty("has_cell") )	
			dps.setValue("has_cell", "true")

		if( dps.hasProperty("has_tf") )	
			dps.setValue("has_tf", "true")
			
		return dps;
	}

}
