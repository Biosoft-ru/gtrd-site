package operations

import com.developmentontheedge.beans.DynamicPropertySet
import com.developmentontheedge.be5.databasemodel.util.DpsUtils
import com.developmentontheedge.be5.groovy.GDynamicPropertySetSupport
import com.developmentontheedge.be5.server.operations.FilterOperation

import groovy.transform.TypeChecked

@TypeChecked
class ExperimentFilter extends FilterOperation
{
    DynamicPropertySet getFilterParameters(Map<String, Object> presetValues) throws Exception
    {
        def dps = new GDynamicPropertySetSupport()
		String species = presetValues.get("species");
		String type    = presetValues.get("type");

		Map<String, String>map = new HashMap()
		if (species != null)
			map.put("species", species)

		if (type != null)
			map.put("type", type)

        dps.add("species", "Species") {
            TAG_LIST_ATTR = queries.getTagsFromSelectionView("gtrd_current.species")
            RELOAD_ON_CHANGE = true
        }

		dps.add("type", "Type") {
			TAG_LIST_ATTR = queries.getTagsFromSelectionView("gtrd_current.experiment_types", map)
			RELOAD_ON_CHANGE = true
		}

		if (species != null)
		{
			dps.add("cell_id", "Cells") 
			{TAG_LIST_ATTR = queries.getTagsFromCustomSelectionView("gtrd_current.experiments", "Select cells for species and type",  map) }
		}
		
		if ( type != null && type.startsWith("ChIP") )
		{
			dps.add("tf", "TF or cofactor") { RELOAD_ON_CHANGE = true }
		}
		
		dps.add("geo", "GEO") 				{}
		
        return dps
    }
	
}