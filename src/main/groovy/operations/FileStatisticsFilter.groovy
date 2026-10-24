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
class FileStatisticsFilter extends FileFilter
{
    DynamicPropertySet getFilterParameters(Map<String, Object> presetValues) throws Exception
    {
		def dps = (GDynamicPropertySetSupport)super.getFilterParameters(presetValues)

		dps.remove("cell")
		dps.remove("tf")
		dps.remove("geo")
		
		return dps
    }

}
