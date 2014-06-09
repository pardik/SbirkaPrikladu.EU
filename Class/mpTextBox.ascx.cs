using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class mpTextBox : System.Web.UI.UserControl
    {
        public event EventHandler TextChanged;
        public bool autoCompleteAfterLostFocus { get; set; }
        public bool autoCompletionEnable { get; set; }
        public string autoComplDtbTable { get; set; }
        public string autoComplDtbTableColumn { get; set; }        
        public int autoComplMinPrefixLenght { get; set; }
        public int autoComplCompletionInterval { get; set; }
        public int autoComplNrOfListLenght { get; set; }
        public string autoComplServiceMethod { get; set; }        
        public string waterMarkText { set { TextBox1.Attributes.Add("placeholder", value); } }
        public string validationGroup { get { return TextBox1.ValidationGroup; } set { TextBox1.ValidationGroup = value; RequiredValidator1.ValidationGroup = value; } }
        public string requiredValidatorErrorMessage { get { return RequiredValidator1.ErrorMessage; } set { RequiredValidator1.ErrorMessage = value; RequiredValidator1.Visible = true; RequiredValidator1Extender.Enabled = true; } }
        public bool filterNumbersOnly { get { return _filterDoubleNumberOnly; } set { FilteredTextBoxExtender1.Enabled = true; FilteredTextBoxExtender1.FilterType = AjaxControlToolkit.FilterTypes.Custom; FilteredTextBoxExtender1.FilterMode = AjaxControlToolkit.FilterModes.ValidChars; FilteredTextBoxExtender1.ValidChars = "0123456789"; _filterNumbersOnly = value; } }
        public bool _filterNumbersOnly;
        public bool filterDoubleNumberOnly { get { return _filterDoubleNumberOnly; } set { FilteredTextBoxExtender1.Enabled = true; FilteredTextBoxExtender1.FilterType = AjaxControlToolkit.FilterTypes.Custom; FilteredTextBoxExtender1.FilterMode = AjaxControlToolkit.FilterModes.ValidChars; FilteredTextBoxExtender1.ValidChars = "0123456789,."; _filterDoubleNumberOnly = value; } }
        protected bool _filterDoubleNumberOnly;
        public string filterValidChars { set { FilteredTextBoxExtender1.Enabled = true; FilteredTextBoxExtender1.FilterType = AjaxControlToolkit.FilterTypes.Custom; FilteredTextBoxExtender1.FilterMode = AjaxControlToolkit.FilterModes.ValidChars; FilteredTextBoxExtender1.ValidChars = value; } }
        public string filterInvalidChars { set { FilteredTextBoxExtender1.Enabled = true; FilteredTextBoxExtender1.FilterType = AjaxControlToolkit.FilterTypes.Custom; FilteredTextBoxExtender1.FilterMode = AjaxControlToolkit.FilterModes.InvalidChars; FilteredTextBoxExtender1.InvalidChars = value; } }        
        public string ToolTip { get { return TextBox1.ToolTip; } set { TextBox1.ToolTip = value; } }
        public string CssClass { get { return TextBox1.CssClass; } set { TextBox1.CssClass = value; } }
        public string CssClassParentPanel { get { return parentPanel.CssClass; } set { parentPanel.CssClass = value; } }
        public bool autoPostBack { get { return TextBox1.AutoPostBack; } set { TextBox1.AutoPostBack = value; } }
        public Unit Width { get { return TextBox1.Width; } set { TextBox1.Width = value; } }
        public Unit Height { get { return TextBox1.Height; } set { TextBox1.Height = value; } }
        public string dataKey { get { return dataKeyHF.Value; } set { dataKeyHF.Value = value; } }
        public short TabIndex { get { return TextBox1.TabIndex; } set { TextBox1.TabIndex = value; } }
        public TextBox textBoxPointer { get { return TextBox1; } set { TextBox1 = value; } }
        public bool negativeNumbers { set { FilteredTextBoxExtender1.ValidChars += "-"; } }
        
        public string Text 
        { 
            get 
            {
                if (filterDoubleNumberOnly || filterNumbersOnly)
                {
                    string pomStr = TextBox1.Text;
                    if (pomStr.Contains("-")) pomStr = "-" + pomStr.Replace("-", "");                                        
                    pomStr = pomStr.Replace(',', '.');
                    while (pomStr.IndexOf('.') != pomStr.LastIndexOf('.')) pomStr = pomStr.Remove(pomStr.LastIndexOf('.'));
                    try { Convert.ToDouble(pomStr); }
                    catch { pomStr = pomStr.Replace('.', ','); }
                    TextBox1.Text = pomStr;
                    try { return Convert.ToDouble(TextBox1.Text).ToString(); }
                    catch { return "0"; }
                }
                return TextBox1.Text;                
            } 
            set 
            {
                TextBox1.Text = value;
            } 
        }

        protected void Page_Load(object sender, EventArgs e)
        {            
            if (autoCompletionEnable)
            {
                AutoCompleteExtender1.Enabled = true;
                Panel1.Visible = true;
                if (autoComplDtbTable != null)
                {
                    AutoCompleteExtender1.ContextKey = string.Format("SELECT DISTINCT [{1}] FROM [{0}] WHERE [{1}]", autoComplDtbTable, autoComplDtbTableColumn);                    
                    AutoCompleteExtender1.UseContextKey = true;
                    AutoCompleteExtender1.ServiceMethod = "completeFromDTB";                    
                }
                if (autoComplMinPrefixLenght > 0) AutoCompleteExtender1.MinimumPrefixLength = autoComplMinPrefixLenght;
                else AutoCompleteExtender1.MinimumPrefixLength = 3;
                if (autoComplNrOfListLenght > 0) AutoCompleteExtender1.CompletionSetCount = autoComplNrOfListLenght;
                else AutoCompleteExtender1.CompletionSetCount = 8;
                AutoCompleteExtender1.CompletionInterval = autoComplCompletionInterval;
                if (autoComplServiceMethod != null) AutoCompleteExtender1.ServiceMethod = autoComplServiceMethod;
            }            
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            if (autoCompleteAfterLostFocus && autoCompletionEnable)
            {
                if (autoComplDtbTable != null)
                {
                    if (string.IsNullOrEmpty(TextBox1.Text)) { TextBox1.Text = ""; Text = ""; return; }

                    using (dboManager dboManager = new dboManager())
                    {
                        string pomStr = dboManager.getScalar(autoComplDtbTable, autoComplDtbTableColumn, string.Format("{0} LIKE '%{1}%' ORDER BY {0}", autoComplDtbTableColumn, TextBox1.Text));
                        if (pomStr == null) pomStr = "";
                        TextBox1.Text = pomStr;
                        Text = pomStr;
                    }
                }
            }
            if (TextChanged != null) TextChanged(this, EventArgs.Empty);            
        }
    }
}