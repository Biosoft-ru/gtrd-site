import React, {Component} from 'react';
import {registerTableBox, processHashUrl, Navs} from 'be5-react';

function Field(props)
{
	return (
		<div className="row">
			<div className="col-md-2 fieldTitle">{props.title}:</div>
			<div className="col fieldValue">{props.value}</div>
		</div>	
	);
}

function FieldWithInnerHTML(props)
{
	return (
		<div className="row">
			<div className="col-md-2 fieldTitle">{props.title}:</div>
			<div className="col fieldValue" dangerouslySetInnerHTML={{__html: props.value}} />
		</div>	
	);
}


class CellDescriptionTableBox extends Component
{
	
  render()
  {
	const cell = this.props.value.data.attributes.rows[0];

  	return ( 
	<div className="container">
		<Field title='Species' value={cell.Species.value}/>
		<FieldWithInnerHTML title='External references' value={cell.References	.value}/>
		<Field title='Source' value={cell.Source.value}/>
		<Field title='Source references' value={cell.SourceReferences.value}/>
		
		<FieldWithInnerHTML title='Experiemnts' value={cell.Experiments.value}/>
		
    </div>);
  }
}


registerTableBox('cellDescription', CellDescriptionTableBox);
