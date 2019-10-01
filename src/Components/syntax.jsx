import React from 'react';
import SyntaxHighlighter from 'react-syntax-highlighter';
import { vs, github, dark } from 'react-syntax-highlighter/dist/esm/styles/hljs';

export default class UDSyntaxHighlighter extends React.Component {
  render() {
    var style;
    switch(this.props.style)
    {
      case 'vs':
        style = vs; 
        break; 
      case 'github':
        style = github;
        break; 
      case 'dark':
        style = dark;
        break;
    }

    return (
      <SyntaxHighlighter {...this.props} style={style}>
        {this.props.code}
      </SyntaxHighlighter>
    );
  }
}