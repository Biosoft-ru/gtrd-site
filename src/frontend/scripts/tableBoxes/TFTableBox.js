import React, {Component} from 'react';
import {registerTableBox, processHashUrl, Navs} from 'be5-react';


function Field(props)
{
	if( !props.value || props.value == '' || props.value == '-' || props.value == 'unmatched' )
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

class TFTableBox extends Component
{
  componentDidMount()
  {
  }
  
  render()
  {
    const tf = this.props.value.data.attributes.rows[0];

    this.title = tf.PageTitle.value;
    be5.ui.setTitle(this.title);

    const tableRef = '#!table/';

  	const steps = [
		{title: "Experiments", 	  url: tableRef + 'experiments/ForCell/chip=seq/cell_id='       + tf.uniprot.value},
    	{title: "Files", 		  url: tableRef + 'experiments/ForCell/chip=exo/cell_id='       + tf.uniprot.value}
  	];

//      	<Navs steps={steps} tabs startAtStep={0} />

  	return (
      	<div className="tfInfo">

    	<h1>{tf.PageTitle.value}</h1>

    	<Field 	title='Species' 			value={tf.species.value}	/>
		<Field 	title='Gene'    			value={tf.gene.value} />
		<Field 	title='Uniprot'    			value={tf.linkUniprot.value} innerHtml='true'/>

		<Field 	title='AnimalTFDB 3.0.' 	value={tf.linkAnimalTFDB.value} innerHtml='true'/>
		<Field 	title='Cis-BP' 				value={tf.linkCisBP.value}   	innerHtml='true'/>
		<Field 	title='TF Class' 			value={tf.linkTFClass.value}   	innerHtml='true'/>

		<Field 	title='Gene names'			value={tf.geneNames.value} />
		<Field 	title='Protein names'		value={tf.proteinNames.value} />

      	</div>
    );
  }
}

registerTableBox('TFTableBox', TFTableBox);
