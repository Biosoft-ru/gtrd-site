package operations

import com.developmentontheedge.be5.groovy.GDynamicPropertySetSupport
import com.developmentontheedge.be5.server.operations.FilterOperation
import com.developmentontheedge.beans.DynamicPropertySet
import groovy.transform.TypeChecked

@TypeChecked
class Filter extends FilterOperation
{
    DynamicPropertySet getFilterParameters(Map<String, Object> presetValues) throws Exception
    {
        def dps = new GDynamicPropertySetSupport((DynamicPropertySet) super.getFilterParameters(presetValues))

        dps.edit("specie", "specie") {
            TAG_LIST_ATTR = queries.getTagsFromCustomSelectionView(
                    "gtrd_current.chip_experiments", "Selection view specie")
            RELOAD_ON_CHANGE = true
        }

        Map<String, String> map = Collections.emptyMap()
        if (presetValues.get("specie") != null) {
            map = Collections.singletonMap("specie", (String) presetValues.get("specie"))
        }
        dps.add("cell_id", "Cells") {
            TAG_LIST_ATTR = queries.getTagsFromSelectionView("gtrd_current.cells", map)
        }
        dps.moveAfter("cell_id", "specie")

        return dps
    }
}
