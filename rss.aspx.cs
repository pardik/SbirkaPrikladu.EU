using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU
{
    public partial class rss : System.Web.UI.Page
    {
        protected string FormatForXML(object input)
        {
            string data = input.ToString();      // cast the input to a string

            // replace those characters disallowed in XML documents
            data = data.Replace("&", "&amp;");
            data = data.Replace("\"", "&quot;");
            data = data.Replace("'", "&apos;");
            data = data.Replace("<", "&lt;");
            data = data.Replace(">", "&gt;");

            return data;
        }
    }
}