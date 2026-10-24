import React, { Component } from 'react';
import { registerTableBox } from 'be5-react';

/** Safe accessor: returns obj.value or null if obj/obj.value missing */
const v = (obj) => (obj && obj.value !== undefined && obj.value !== null ? obj.value : null);

/** Safe JSON.parse that never throws */
function safeJsonParse(str, fallback) {
  try {
    if (str === undefined || str === null || str === "") return fallback;
    return JSON.parse(str);
  } catch (e) {
    return fallback;
  }
}

function Field(props) {
  if (!props.value) return null;

  return (
    <div className="row">
      <div className="col-md-2 fieldTitle">{props.title}:</div>

      {props.innerHtml
        ? <div className="col fieldValue" dangerouslySetInnerHTML={{ __html: props.value }} />
        : <div className="col fieldValue">{props.value}</div>
      }
    </div>
  );
}

/** plotly html embedding via iframe (safe for full HTML documents) */
function PlotlyEmbedIFrame({ src, height = 800 }) {
  if (!src) return null;

  return (
    <div style={{ width: "100%" }}>
      <iframe
        title="plotly"
        src={src}
        style={{ width: "100%", height: `${height}px`, border: "0" }}
        loading="lazy"
      />
    </div>
  );
}

/**
 * scATAC buttons panel.
 * Works even if files_info is missing/empty.
 */
function ScATACFilesPanel({ files }) {
  files = Array.isArray(files) ? files : [];

  const pickFirst = (pred) => files.find(pred);

  const fragments = pickFirst(f =>
    (f.data_type && /fragment/i.test(f.data_type)) ||
    (f.name && /fragment/i.test(f.name))
  );

  const bed = pickFirst(f =>
    (f.format && /bed/i.test(f.format)) ||
    (f.name && /\.bed(\.gz)?$/i.test(f.name))
  );

  const bigwig = pickFirst(f =>
    (f.format && /bigwig|bw/i.test(f.format)) ||
    (f.name && /\.(bw|bigwig)$/i.test(f.name))
  );

  const browserFile = bigwig || bed || fragments;
  const ucsc =
    browserFile && browserFile.assembly && browserFile.path
      ? ("http://genome.ucsc.edu/cgi-bin/hgTracks?db=" +
         browserFile.assembly + "&hgct_customText=" + browserFile.path)
      : null;

  // helper: если url нет — рисуем disabled кнопку
  const BtnLink = ({ title, url }) => (
    url
      ? <a className="btn btn-light" href={url} target="_blank" rel="noreferrer">{title}</a>
      : <button className="btn btn-light" type="button" disabled>{title}</button>
  );

  return (
    <div style={{ marginTop: "10px", marginBottom: "15px" }}>
      <div className="btn-group" role="group" aria-label="scATAC files">
        <BtnLink title="Fragments" url={fragments && fragments.path} />
        <BtnLink title="BED"       url={bed && bed.path} />
        <BtnLink title="BigWig"    url={bigwig && bigwig.path} />
        <BtnLink title="Open genome browser" url={ucsc} />
        <button className="btn btn-light" onClick={() => window.history.back()}>Back</button>
      </div>
    </div>
  );
}
class ScATACExperimentDetails extends Component {
  constructor(props) {
    super(props);
    this.state = { view: "2D" }; // "2D" | "3D"
  }

  render() {
    const exp = this.props.exp;

    const pageTitle = v(exp.PageTitle) || "Experiment";
    be5.ui.setTitle(pageTitle);

    // Cell type link
    const cellTypeText = v(exp.CellType) || "";
    const cellId = v(exp.CellID);
    const cellLink = (cellId && cellTypeText)
      ? `<a href="#!table/gtrd_current.cells/Details/ID=${cellId}" target="_blanck">${cellTypeText}</a>`
      : (cellTypeText || null);

    // Files (может отсутствовать)
    const files = safeJsonParse(v(exp.files_info), []);

    const accession = exp.ID.value;

    const plotlyFileName =
      this.state.view === "3D"
        ? `${accession}_3D_UMAP_by_Clusters.html`
        : `${accession}_2D_UMAP_by_Clusters.html`;

    const plotlySrc = `/plotly/${plotlyFileName}`;

    return (
      <div className="experimentDetails scATACDetails">
        <h1>{pageTitle}</h1>

        {/* ==== ОПИСАНИЕ ЭКСПЕРИМЕНТА (сохраняем сверху) ==== */}
        <Field title="Species" value={v(exp.Species)} />

        {cellLink && cellLink.startsWith && cellLink.startsWith("<a ")
          ? <Field title="Cell type" value={cellLink} innerHtml="true" />
          : <Field title="Cell type" value={cellLink} />
        }

        <Field title="Tissue" value={v(exp.Tissue)} />
        <Field title="Treatment" value={v(exp.Treatment)} />
        <Field title="Platform" value={v(exp.Platform)} />
        <Field title="Number of cells" value={v(exp.NumberOfCells)} />
        <Field title="Number of clusters" value={v(exp.NumberOfClusters)} />

        <br /><b>References</b>
        <Field title="GEO series" value={v(exp.geo_series)} innerHtml="true" />
        <Field title="GEO samples" value={v(exp.geo_samples)} innerHtml="true" />
        <Field title="Article" value={v(exp.article)} innerHtml="true" />

        <br /><b>Files</b>
        <ScATACFilesPanel files={files} />

        {/* ==== UMAP БЛОК (кнопки + iframe) ==== */}
        <br /><b style={{ marginRight: "20px" }}>UMAP</b>

        <div className="btn-group" role="group" aria-label="UMAP tabs" style={{ margin: "10px 0" }}>
          <button
            type="button"
            className={"btn " + (this.state.view === "2D" ? "btn-primary" : "btn-light")}
            onClick={() => this.setState({ view: "2D" })}
          >
            2D
          </button>

          <button
            type="button"
            className={"btn " + (this.state.view === "3D" ? "btn-primary" : "btn-light")}
            onClick={() => this.setState({ view: "3D" })}
          >
            3D
          </button>
        </div>

        <PlotlyEmbedIFrame src={plotlySrc} height={800} />
      </div>
    );
  }
}

// ======= старый FilesTable/QCTable (слегка “анти-падающий”) =======

function formatSize(size) {
  if (size === undefined || size === null || isNaN(size)) return "";
  var suffixes = ["B", "KB", "MB", "GB", "TB"];
  let s = size;
  for (var i = 0; s > 1000 && i < suffixes.length; i++) s /= 1000;
  return (s.toPrecision(3) + suffixes[i]);
}

class FilesTable extends React.Component {
  render() {
    let files = this.props.files;
    if (!files || files.length === 0) return null;

    return (
      <table className="table-sm table-bordered">
        <thead>
          <tr>
            <th>Accession</th>
            <th>Data type</th>
            <th>Peak caller</th>
            <th>Assembly</th>
            <th># elements</th>
            <th>File size</th>
            <th>Format</th>
            <th>Download</th>
            <th>Genome browser</th>
          </tr>
        </thead>
        <tbody>
          {files.map((row, idx) => {
            const assembly = row.assembly || "";
            const path = row.path || "";
            const ucsc = assembly && path
              ? ("http://genome.ucsc.edu/cgi-bin/hgTracks?db=" + assembly + "&hgct_customText=" + path)
              : null;

            return (
              <tr key={row.id || idx}>
                <td>{row.peaks_id}</td>
                <td>{row.data_type}</td>
                <td>{row.peakcaller}</td>
                <td>{row.assembly}</td>
                <td>{row.item_count}</td>
                <td>{formatSize(row.size)}</td>
                <td>{row.format}</td>
                <td>{row.path ? <a href={row.path}>{row.name || "download"}</a> : null}</td>
                <td>{ucsc ? <a href={ucsc} target="_blank" rel="noreferrer">UCSC</a> : null}</td>
              </tr>
            );
          })}
        </tbody>
      </table>
    );
  }
};

function getColor(value, threshold) {
  if (value > threshold) return "rgb(0, 204, 68)";
  else if (value <= threshold) return "rgb(255, 80, 80)";
  else return "gray";
}

function circle(name, value, threshold, inverse = false) {
  if (value === undefined || value === null || isNaN(value)) return null;
  var title = name + " = " + value;
  var color = inverse ? getColor(threshold, value) : getColor(value, threshold);
  return (
    <div>
      <div title={title} style={{ "margin-right": "5px", "background-color": color, "border-radius": "50%", width: "16px", height: "16px", display: "inline-block" }} />
      <p style={{ margin: 0, "vertical-align": "top", display: "inline-block" }}>{title}</p>
    </div>
  );
}

function triangle(name, value, threshold) {
  if (value === undefined || value === null || isNaN(value)) return null;
  var title = name + " = " + value;
  var color = getColor(value, threshold);
  return (
    <div>
      <div title={title} style={{
        "margin-right": "5px",
        width: 0, height: 0,
        "border-bottom": "16px solid " + color,
        "border-left": "8px solid transparent",
        "border-right": "8px solid transparent",
        display: "inline-block"
      }} />
      <p style={{ margin: 0, "vertical-align": "top", "display": "inline-block" }}>{title}</p>
    </div>
  );
}

class QCTable extends React.Component {
  render() {
    // Оставляем ваше правило: QC только для ChIP-seq
    if (this.props.type !== "ChIP-seq" || !this.props.values) return null;

    const qc = {};
    this.props.values.forEach(e => qc[e.name] = parseFloat(e.value));

    return (
      <div>
        <b>Quality metrics</b>:<br /><br />
        {circle("FNCM(GEM)", qc["QC.FNCM_gem"], 0.5)}
        {circle("FNCM(MACS)", qc["QC.FNCM_macs"], 0.5)}
        {circle("FNCM(PICS)", qc["QC.FNCM_pics"], 0.5)}
        {circle("FNCM(SISSRS)", qc["QC.FNCM_sissrs"], 0.5)}
        {circle("FPCM", qc["QC.FPCM"], 2, true)}
        {triangle("NRF", qc["QC.NRF"], 0.8)}
        {triangle("PBC1", qc["QC.PBC1"], 0.8)}
        {triangle("PBC2", qc["QC.PBC2"], 3)}
        {triangle("NSC", qc["QC.NSC"], 1.1)}
        {triangle("RSC", qc["QC.RSC"], 1)}
        {triangle("FRiP_GEM", qc["QC.FRiP_GEM"], 0.01)}
        {triangle("FRiP_MACS", qc["QC.FRiP_MACS"], 0.01)}
        {triangle("FRiP_PICS", qc["QC.FRiP_PICS"], 0.01)}
        {triangle("FRiP_SISSRS", qc["QC.FRiP_SISSRS"], 0.01)}
      </div>
    );
  }
}

class ExperimentDetailsTableBox extends Component {
  render() {
    const exp = this.props.value.data.attributes.rows[0];

    const pageTitle = v(exp.PageTitle) || "Experiment";
    be5.ui.setTitle(pageTitle);

    // Ветвление: scATAC — отдельная страница
    const type = v(exp.Type);
    if (type === "scATAC-seq") {
      return <ScATACExperimentDetails exp={exp} />;
    }

    // Старое поведение для остальных типов
    const cellTypeText = v(exp.CellType) || "";
    const cellId = v(exp.CellID);
    const cellLink = (cellId && cellTypeText)
      ? `<a href="#!table/gtrd_current.cells/Details/ID=${cellId}" target="_blanck">${cellTypeText}</a>`
      : (cellTypeText || null);

    let control = null;
    const controlId = v(exp.Control);
    if (controlId) {
      control = `<a href="#!table/gtrd_current.experiments/Details/ID=${controlId}">${controlId}</a>`;
    }

    const files = safeJsonParse(v(exp.files_info), []);
    const qcValues = safeJsonParse(v(exp.qc), null);

    return (
      <div className="experimentDetails">
        <h1>{pageTitle}</h1>

        <Field title="Species" value={v(exp.Species)} />

        {cellLink && cellLink.startsWith && cellLink.startsWith("<a ")
          ? <Field title="Cell type" value={cellLink} innerHtml="true" />
          : <Field title="Cell type" value={cellLink} />
        }

        <Field title="Treatment" value={v(exp.Treatment)} />
        <Field title="Control" value={control} innerHtml="true" />
        <Field title="Design" value={v(exp.Design)} />

        {v(exp.Antibody) && <div><br /><b>Antibody</b></div>}
        <Field title="Antibody" value={v(exp.Antibody)} innerHtml="true" />
        <Field title="TF Class" value={v(exp.TFClass)} />
        <Field title="Gene" value={v(exp.Gene)} />
        <Field title="Uniprot" value={v(exp.Uniprot)} innerHtml="true" />
        <Field title="Protein synonyms" value={v(exp.Protein)} />

        <Field title="Target" value={v(exp.Target)} />

        <br /><b>References</b>
        <Field title="GEO series" value={v(exp.geo_series)} innerHtml="true" />
        <Field title="GEO samples" value={v(exp.geo_samples)} innerHtml="true" />
        <Field title="Article" value={v(exp.article)} innerHtml="true" />

        <br /><b>Files</b>
        <FilesTable files={files} />
        <br />
        <QCTable type={type} values={qcValues} />
      </div>
    );
  }
}

registerTableBox('experimentDetails', ExperimentDetailsTableBox);
