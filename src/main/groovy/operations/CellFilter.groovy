package operations

import com.developmentontheedge.be5.groovy.GDynamicPropertySetSupport
import com.developmentontheedge.be5.server.operations.FilterOperation
import com.developmentontheedge.beans.DynamicPropertySet
import groovy.transform.TypeChecked

@TypeChecked
class CellFilter extends FilterOperation
{
    DynamicPropertySet getFilterParameters(Map<String, Object> presetValues) throws Exception
    {

        def dps = new GDynamicPropertySetSupport()

        dps.add("species", "Species") {
            TAG_LIST_ATTR = queries.getTagsFromCustomSelectionView(
                    "gtrd_current.cells", "Selection view species")
			RELOAD_ON_CHANGE = true
        }

        Map<String, String> map = Collections.emptyMap()
        if (presetValues.get("species") != null) {
            map = Collections.singletonMap("species", (String)presetValues.get("species"))
        }

//		dps.add("search", "Search")

        return dps
    }
}
