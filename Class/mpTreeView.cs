using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace SbirkaPrikladuEU
{
    public class mpTreeView
    {
        public void fillTreeView(string dboTableName, TreeView treeViewToFillId)
        {
            List<oneNodeObject> list = new List<oneNodeObject>();
            using (dboManager dboManager = new dboManager())
            {
                SqlDataReader reader = dboManager.ExecuteQuery("SELECT * FROM [" + dboTableName + "] ORDER BY [position],[name]");
                while (reader.Read())
                {
                    bool pomHasCheckBox = false;
                    bool pomChecked = false;
                    try { if (reader["checked"] != null) { pomHasCheckBox = true; pomChecked = Convert.ToBoolean(reader["checked"].ToString()); } }
                    catch { }
                    oneNodeObject pomNode = new oneNodeObject() { Id = Convert.ToInt64(reader["id"].ToString()), Name = reader["name"].ToString(), ParentId = Convert.ToInt64(reader["parentId"].ToString()), hasCheckBox = pomHasCheckBox };                    
                    list.Add(pomNode);
                }
            }
            treeViewToFillId.Nodes.Clear();
            tvRecursive(list, null, treeViewToFillId);
        }

        private class oneNodeObject
        {
            public Int64 Id;
            public Int64 ParentId;
            public string Name;            
            public bool hasCheckBox = false;            
        }

        // tohle je pouze funkce pro rekurzivni naplneni TreeView. Pouzij fillTreeView.
        private void tvRecursive(IEnumerable<oneNodeObject> listOfAllNodes, TreeNode parentNode, TreeView treeViewId)
        {
            var nodes = listOfAllNodes.Where(x => parentNode == null ? x.ParentId == -1 : x.ParentId == int.Parse(parentNode.Value));
            foreach (var node in nodes)
            {                
                TreeNode newNode = new TreeNode(node.Name, node.Id.ToString());                
                if (parentNode == null) treeViewId.Nodes.Add(newNode);
                else parentNode.ChildNodes.Add(newNode);

                tvRecursive(listOfAllNodes, newNode, treeViewId);
            }
        }

        public TreeNode findNodeByValue(TreeNodeCollection treeNodesCollection, string valueToFind)
        {
            TreeNode pomTN = null;
            for (int i = 0; i < treeNodesCollection.Count; i++)
            {
                if (treeNodesCollection[i].Value == valueToFind) return treeNodesCollection[i];
                pomTN = findNodeByValue(treeNodesCollection[i].ChildNodes, valueToFind);
                if (pomTN != null) return pomTN;
            }
            return null;
        }

        public string getNodeText(TreeNode node)
        {
            string pomStr = node.Text.Replace("<span class=\"noChecked\">", null);
            return pomStr.Replace("</span>", null);
        }        

        public TreeNode checkNode(TreeNode treeNode)
        {
            treeNode.Text = treeNode.Text.Replace("<span class=\"noChecked\">", null);
            treeNode.Text = treeNode.Text.Replace("</span>", null);
            treeNode.Checked = true;
            return treeNode;
        }

        public TreeNode unCheckNode(TreeNode treeNode)
        {
            treeNode.Text = "<span class=\"noChecked\">" + treeNode.Text + "</span>";
            treeNode.Checked = false;
            return treeNode;
        }
    }
}