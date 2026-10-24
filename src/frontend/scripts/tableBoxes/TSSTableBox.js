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

class TSSTableBox extends Component
{
	
  render()
  {
	const tss = this.props.value.data.attributes.rows[0];

    this.title = tss.PageTitle.value;
    be5.ui.setTitle(this.title);

	const location =  tss.Chromosome.value + ": " + tss.Start.value.toLocaleString() + " - " 
	                                              + tss.End.value.toLocaleString()   + " (" + tss.Strand.value + ")"; 

    const tableRef    = '#!table/gtrd_current.cage_peaks_/';
    const params      = '/genome=' + tss.Genome.value + '/species=' + tss.Species.value + '/id=' + tss.ID.value;
	const locationRef = '/chromosome=' + tss.Chromosome.value + '/start=' + tss.Start.value + '/end=' + tss.End.value

  	const steps = [];
  	
  	if( tss.Type.value == 'promoter' )
  	{
  		steps.push( {title: "Annotation", 		  url: tableRef + 'Annotation'  + params},
  					{title: "Transcripts", 		  url: tableRef + 'Transcripts' + params + locationRef}
  		 		  );
  	}
  	else if( tss.Type.value == 'enhancer' )
  	{
  		steps.push( {title: "Regulated genes", 	  url: tableRef + 'Regulated_genes' + params} );
  	}
  	
  	steps.push( 	{title: "Expression", 		  url: tableRef + 'Expression' + params} );

  	return ( 
   	<div className="tssDetails">

    	<h1>{tss.PageTitle.value}</h1>

		{ /* Common */ }
		<Field 	title='Species' 			value={tss.Species.value}	/>
		<Field 	title='Location' 			value={location}			/>
		<Field 	title='Summit' 			    value={tss.Summit.value.toLocaleString()}	/>

		{ tss.Type.value == 'promoter' && (
		<div>
		<br/>
		<Field 	title='Gene symbol'		    value={tss.Gene.value} 	/>
		</div> 
		)}

		<br/>
		<Field 	title='Source' 		        value={tss.Source.value}	/>
		<Field 	title='Name' 		        value={tss.Name.value}		/>
		<Field 	title='FANTOM5' 		    value={tss.FANTOM5.value}	/>
		<Field 	title='Version' 		    value={tss.Version.value}	/>

		<br/>
      	<Navs steps={steps} tabs startAtStep={0} />

    </div>);
  }

}

registerTableBox('tssDetails', TSSTableBox);
