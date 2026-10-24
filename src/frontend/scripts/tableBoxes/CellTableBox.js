import React, {Component} from 'react';
import {registerTableBox, processHashUrl, Navs} from 'be5-react';


class CellTableBox extends Component
{
  componentDidMount()
  {
  }
  
  render()
  {
    const cell = this.props.value.data.attributes.rows[0];

    this.title = cell.PageTitle.value;
    be5.ui.setTitle(this.title);

    const tableRef = '#!table/';

  	const steps = [
		{title: "Description", 		  url: tableRef + 'cells/Description/ID='                       + cell.ID.value},
		{title: "ChIP-seq", 		  url: tableRef + 'experiments/ForCell/chip=seq/cell_id='       + cell.ID.value},
    	{title: "ChIP-exo", 		  url: tableRef + 'experiments/ForCell/chip=exo/cell_id='       + cell.ID.value},
		{title: "Chromatin", 		  url: tableRef + 'experiments/ForCell/chromatin=true/cell_id=' + cell.ID.value},
		{title: "Histone marks",	  url: tableRef + 'experiments/ForCell/hm=true/cell_id='        + cell.ID.value},
		{title: "RNA-seq",	          url: tableRef + 'experiments/ForCell/rna=true/cell_id='       + cell.ID.value},
		{title: "CAGE-seq",	          url: tableRef + 'experiments/ForCell/cage=true/cell_id='      + cell.ID.value},
  	];

  	return (
      	<div className="cellInfo">

    	<h1>{cell.PageTitle.value}</h1>

      	<Navs steps={steps} tabs startAtStep={0} />
      	</div>
    );
  }
}

registerTableBox('cell', CellTableBox);
