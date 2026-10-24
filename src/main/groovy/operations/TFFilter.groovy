package operations

import com.developmentontheedge.be5.groovy.GDynamicPropertySetSupport
import com.developmentontheedge.be5.server.operations.FilterOperation
import com.developmentontheedge.beans.DynamicPropertySet
import groovy.transform.TypeChecked

@TypeChecked
class TFFilter extends FilterOperation
{
    DynamicPropertySet getFilterParameters(Map<String, Object> presetValues) throws Exception
    {
        def dps = new GDynamicPropertySetSupport()

        dps.add("species", "Species") {
            TAG_LIST_ATTR = queries.getTagsFromCustomSelectionView(
                    "gtrd_current.cells", "Selection view species")
        }

		dps.add("type", "Type") {
			TAG_LIST_ATTR = [ ["TF", "TF"], ["Cofactor", "Cofactor"], ["Unclassified", "Unclassified"] ] as String[][]
		}

		dps.add("gene", "Gene") 		{}

		dps.add("ref", "External id") 	{}
		
		dps.add("classification", "Classification") {
			TAG_LIST_ATTR = [ 
				["AnimalTFDB", "AnimalTFDB"], ["Cis-BP", "Cis-BP"], ["TFClass", "TFClass"], ["GTRD", "GTRD"],
				["GTRD+AnimalTFDB", "GTRD with AnimalTFDB"], ["GTRD+Cis-BP", "GTRD with Cis-BP"], ["GTRD+TFClass", "GTRD with TFClass"], 
				["GTRDmAnimalTFDB", "GTRD missing in AnimalTFDB"], ["GTRDmCis-BP", "GTRD missing in Cis-BP"], ["GTRDmTFClass", "GTRD missing in TFClass"], 
				["GTRDuAnimalTFDB", "GTRD unclassified in AnimalTFDB"], ["GTRDuCis-BP", "GTRD unclassified in Cis-BP"], ["GTRDuTFClass", "GTRD unclassified in TFClass"] 
			] as String[][]
		}

		return dps
    }
}
