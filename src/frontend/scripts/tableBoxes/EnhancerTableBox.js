import React, {Component} from 'react';
import {registerTableBox, processHashUrl, Navs} from 'be5-react';

function Field(props)
{
	if( !props.value )
	return null
	 
	return (
		<div className="row">
			<div className="col-md-2 fieldTitle" >{props.title}:</div>
			
			{ props.innerHtml  
				? <div className="col fieldValue" dangerouslySetInnerHTML={{__html: props.value}} />
				: <div className="col fieldValue">{props.value}</div> 
			}
			
		</div>	
	);
}

class EnhancerTableBox extends Component
{
	
  render()
  {
	const enhancer = this.props.value.data.attributes.rows[0];

    this.title = enhancer.PageTitle.value;
    be5.ui.setTitle(this.title);

	const location =  enhancer.Chromosome.value + ": " + enhancer.Start.value.toLocaleString() + " - " 
	                                                   + enhancer.End.value.toLocaleString(); 

    const tableRef    = '#!table/cage_enhancers_/';
    const params      = '/genome=' + enhancer.Genome.value + '/species=' + enhancer.Species.value + '/id=' + enhancer.ID.value;
	const locationRef = '/chromosome=' + enhancer.Chromosome.value + '/start=' + enhancer.Start.value + '/end=' + enhancer.End.value

  	const steps = [];
  	if ( enhancer.Genome.value == "rn6" && enhancer.Source.value != "SOL+EDL" )
	  	steps.push( 	{title: "Potentially regulated genes", url: tableRef + 'Regulated genes' + params} );

  	return ( 
   	<div className="enhancerDetails">

    	<h1>{enhancer.PageTitle.value}</h1>

		{ /* Common */ }
		<Field 	title='Species' 			value={enhancer.Species.value}	/>
		<Field 	title='Location' 			value={location}			/>
    	<Field 	title='Name' 		        value={enhancer.Name.value}		/>
		<Field 	title='Source' 		        value={enhancer.Source.value}	/>

		{ steps.length > 0 &&
		<div> 
		<br/>
      	<Navs steps={steps} tabs startAtStep={0} />
      	</div>
      	}

    </div>);
  }

}

registerTableBox('enhancerDetails', EnhancerTableBox);
