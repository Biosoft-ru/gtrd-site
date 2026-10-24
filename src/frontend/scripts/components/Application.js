import React from 'react';
import {MAIN_DOCUMENT, NavbarMenuContainer, Document, Be5Components, SideBar, LanguageSelector} from 'be5-react';


class Application extends React.Component
{
  render() {
    return (
      <div>
        <Be5Components/>
        <NavbarMenuContainer brand='Main' />
        <div className="container">
          <div className="row">
              {/*<LanguageSelector className="ml-auto"/>*/}
              <Document frontendParams={{documentName: MAIN_DOCUMENT}} />
          </div>
        </div>
      </div>
    );
  }
}

export default Application;
