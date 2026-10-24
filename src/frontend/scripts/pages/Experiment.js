import React from 'react';
import {
  be5,
  createStaticValue,
  changeDocument,
  Document,
  fetchTableByUrl,
  loadDocumentByUrl,
  loadTableByUrl,
  registerDocument,
  registerRoute,
  Table
} from 'be5-react';


class ExperimentInfoTable extends React.Component
{
  render() {
    let bean = this.props.value;
    return (
      <table className="table">
        <tbody>
          {
            bean.experiment_type.value != "chip_control"
            &&
            <tr>
              <td>Transcription&nbsp;factor</td>
              <td>{bean.tf_protein_names.value}</td>
            </tr>
          }
          {
            bean.experiment_type.value != "chip_control"
            &&
            <tr>
              <td>TFClass</td>
              <td>{bean.tf_class_id.value}</td>
            </tr>
          }
          {
            bean.experiment_type.value != "chip_control"
            &&
            <tr>
              <td>Uniprot</td>
              <td><a target="_blank" href={"http://www.uniprot.org/uniprot/"+bean.tf_uniprot_id.value}>{bean.tf_uniprot_id.value}</a></td>
            </tr>
          }
          <tr>
            <td>Antibody</td>
            <td>{bean.antibody.value}</td>
          </tr>
          <tr>
            <td>Species</td>
            <td>{bean.specie.value}</td>
          </tr>
          <tr>
            <td>Cell/Tissue</td>
            <td>{bean.cell_title.value}</td>
          </tr>
            <tr>
              <td>GEO&nbsp;Series</td>
              <td dangerouslySetInnerHTML={{__html: bean.geo_series.value}} />
            </tr>
            <tr>
              <td>GEO&nbsp;Samples</td>
              <td dangerouslySetInnerHTML={{__html: bean.geo_samples.value}} />
            </tr>
            <tr>
              <td>Citation</td>
              <td dangerouslySetInnerHTML={{__html: bean.article.value}} />
            </tr>
        </tbody>
      </table>
    );
  }
}

class RawDataTable extends React.Component
{
  constructor(props) {
    super(props);
    this.state = {"rows": []};
  }

  componentDidMount() {
    this.loadData(this.props.exp_id);
  }

  componentWillReceiveProps(newProps) {
    if(this.props.exp_id != newProps.exp_id)
      this.loadData(newProps.exp_id);
  }

  loadData(exp_id) {
    this.setState({"rows": []});
    fetchTableByUrl('table/gtrd_current.chip_experiments/Elements/id='+exp_id+"/type=ReadsGTRDType", json => {
       var elements = json.data.attributes.rows;
       for(var i = 0; i < elements.length; i++)
       {
         let element_id = elements[i].element_id.value;
         
         fetchTableByUrl('table/gtrd_current.chip_experiments/ElementProperties/id='+element_id, json => {
           var elementProperties = {id: element_id};
           var properties = json.data.attributes.rows;
           for(var j = 0; j < properties.length; j++)
           {
             var property_name = properties[j].property_name.value;
             var property_value = properties[j].property_value.value;
             elementProperties[property_name] = property_value;
           }
           var oldRows = this.state.rows;
           var newRows = oldRows.slice();
           newRows.push(elementProperties);
           newRows.sort(function(a,b) { return a.id<b.id?-1:1; });
           this.setState({rows:newRows});
         });
       }
    }); 
  }

  render() {
    return (
      <table className="table-sm table-bordered">
        <thead>
          <tr>
            <th>Accession</th>
            <th>Size</th>
            <th>Download</th>
            <th>Format</th>
            <th>Read count</th>
            <th>Layout</th>
            <th>Platform</th>
          </tr>
        </thead>
        <tbody>
            {this.state.rows.map(row => {
              var readCountFormatted = row.readCount ? row.readCount.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') : "unknown";
              var urlParts = row.url.split("/");
              var fileName = urlParts[urlParts.length - 1];
              var fileParts = fileName.split(".");
              var extension = fileParts.length==1 ? "unknown" : fileParts[fileParts.length - 1];
              return (<tr key={row.id}>
                <td>{row.id}</td>
                <td>unknown</td>
                <td><a target="_blank" href={row.url}>{fileName}</a></td>
                <td>{extension}</td>
                <td>{readCountFormatted}</td>
                <td>unknown</td>
                <td>unknown</td>
              </tr>);
            })}
        </tbody>
      </table>
    );
  }
}

class AlignmentsTable extends React.Component
{
  constructor(props) {
    super(props);
    this.state = {"rows": []};
  }

  componentDidMount() {
    this.loadData(this.props.exp_id);
  }

  componentWillReceiveProps(newProps) {
    if(this.props.exp_id != newProps.exp_id)
      this.loadData(newProps.exp_id);
  }

  loadData(exp_id) {
    this.setState({"rows": []});
    fetchTableByUrl('table/gtrd_current.chip_experiments/Elements/id='+exp_id+"/type=AlignmentsGTRDType", json => {
       var elements = json.data.attributes.rows;
       for(var i = 0; i < elements.length; i++)
       {
         let element_id = elements[i].element_id.value;
         
         fetchTableByUrl('table/gtrd_current.chip_experiments/ElementProperties/id='+element_id, json => {
           var elementProperties = {id: element_id};
           var properties = json.data.attributes.rows;
           for(var j = 0; j < properties.length; j++)
           {
             var property_name = properties[j].property_name.value;
             var property_value = properties[j].property_value.value;
             elementProperties[property_name] = property_value;
           }
           var oldRows = this.state.rows;
           var newRows = oldRows.slice();
           newRows.push(elementProperties);
           newRows.sort(function(a,b) { return a.id<b.id?-1:1; });
           this.setState({rows:newRows});
         });
       }
    }); 
  }

  render() {
    return (
      <table className="table-sm table-bordered">
        <thead>
          <tr>
            <th>Accession</th>
            <th>Size</th>
            <th>Download</th>
            <th>Aligned count</th>
            <th>Percent aligned</th>
            <th>Method</th>
          </tr>
        </thead>
        <tbody>
            {this.state.rows.map(row => {
              var alignedCountFormatted = row.readAlignedCount ? row.readAlignedCount.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') : "unknown";
              var alignmentPercent = (row.readAlignedCount && row.readCount) ? (row.readAlignedCount*100/row.readCount).toFixed(2) + "%" : "unknown"
              return (<tr key={row.id}>
                <td>{row.id}</td>
                <td>unknown</td>
                <td><a target="_blank" href={"/downloads/aligns/"+row.id+".bam"}>{row.id+".bam"}</a></td>
                <td>{alignedCountFormatted}</td>
                <td>{alignmentPercent}</td>
                <td>bowtie2</td>
              </tr>);
            })}
        </tbody>
      </table>
    );
  }
}

class PeaksTable extends React.Component
{
  constructor(props) {
    super(props);
    this.state = {"rows": []};
  }

  componentDidMount() {
    this.loadData(this.props.exp_id);
  }

  componentWillReceiveProps(newProps) {
    if(this.props.exp_id != newProps.exp_id)
      this.loadData(newProps.exp_id);
  }

  loadData(exp_id) {
    this.setState({"rows": []});
    fetchTableByUrl('table/gtrd_current.chip_experiments/Elements/id='+exp_id+"/type=PeaksGTRDType", json => {
       var elements = json.data.attributes.rows;
       for(var i = 0; i < elements.length; i++)
       {
         let element_id = elements[i].element_id.value;
         
         fetchTableByUrl('table/gtrd_current.chip_experiments/ElementProperties/id='+element_id, json => {
           var elementProperties = {id: element_id};
           var properties = json.data.attributes.rows;
           for(var j = 0; j < properties.length; j++)
           {
             var property_name = properties[j].property_name.value;
             var property_value = properties[j].property_value.value;
             elementProperties[property_name] = property_value;
           }
           var oldRows = this.state.rows;
           var newRows = oldRows.slice();
           newRows.push(elementProperties);
           newRows.sort(function(a,b) { return a.id<b.id?-1:1; });
           this.setState({rows:newRows});
         });
       }
    }); 
  }

  render() {
    return (
      <table className="table-sm table-bordered">
        <thead>
          <tr>
            <th>Accession</th>
            <th>Size</th>
            <th>Download</th>
            <th>Peak count</th>
            <th>Method</th>
          </tr>
        </thead>
        <tbody>
            {this.state.rows.map(row => {
              return (<tr key={row.id}>
                <td>{row.id}</td>
                <td>unknown</td>
                <td><a target="_blank" href={"/downloads/peaks/macs/"+row.id+".interval.gz"}>{row.id+".interval.gz"}</a></td>
                <td>unknown</td>
                <td>macs</td>
              </tr>);
            })}
        </tbody>
      </table>
    );
  }
}

class Experiment extends React.Component
{
  render() {
    let rows = this.props.value.data.attributes.rows;
    if(rows.length == 0)
      return (<div>Not found</div>);
    let bean = this.props.value.data.attributes.rows[0];
    return (
      <div className="card" style={{maxWidth:800}}>
        <div className="card-header">
          ChIP-seq {bean.experiment_type.value=="chip_control"?"control":""} experiment {bean.id.value}
        </div>
        <div className="card-body">
          <ExperimentInfoTable value={bean} />
          <p>Raw data</p>
          <RawDataTable exp_id={bean.id.value}/>
          <p>Alignments</p>
          <AlignmentsTable exp_id={bean.id.value}/>
          {
            bean.experiment_type.value != "chip_control"
            &&
            <div>
              <p>Peaks</p>
              <PeaksTable exp_id={bean.id.value}/>
            </div>
          }
        </div>
      </div>);
  }
};

registerDocument('Experiment', Experiment);

registerRoute('experiment', (frontendParams, id) => {
  fetchTableByUrl("table/gtrd_current.chip_experiments/OneRecordDetailed/id=" + id,
      json => {
        changeDocument(frontendParams.documentName, {value: json, frontendParams: {type: 'Experiment'}});
      }
  );
});
