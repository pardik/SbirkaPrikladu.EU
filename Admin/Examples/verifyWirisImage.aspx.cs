using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace SbirkaPrikladuEU.Admin.Examples
{
    public partial class verifyWirisImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string imgPath = Server.MapPath("/Files/Wiris/cache/" + Request.QueryString["img"].ToString());
                        
            Bitmap myBitmap = new Bitmap(imgPath);
            int cropFromTop = -1;
            for (int i = 0; i < myBitmap.Height; i++)           //remove block from top
            {
                for (int j = 0; j < myBitmap.Width; j++)
                {
                    if (myBitmap.GetPixel(j, i).A != 0) { cropFromTop = i; break; }
                }
                if (cropFromTop != -1) break;
            }

            int cropFromBottom = -1;
            /*for (int i = myBitmap.Height - 1; i > 0; i--)     //remove block from bottom
            {
                for (int j = 0; j < myBitmap.Width; j++)
                {
                    if (myBitmap.GetPixel(j, i).A != 0) { cropFromBottom = i; break; }
                }
                if (cropFromBottom != -1) break;
            }*/

            cropFromTop -= 2;   //let little empty block on top
            if (cropFromTop < -1) cropFromTop = -1;

            if (cropFromTop == -1 && cropFromBottom == -1) return;
            if (cropFromTop == -1) cropFromTop = 0;
            if (cropFromBottom == -1) cropFromBottom = myBitmap.Height;
            else cropFromBottom++;

            System.Drawing.Image img = System.Drawing.Image.FromFile(imgPath);
            System.Drawing.Image img2 = cropImage(img, new Rectangle(0, cropFromTop, img.Width, cropFromBottom - cropFromTop));
            myBitmap.Dispose();
            img.Dispose();
            img2.Save(imgPath);
        }

        private static System.Drawing.Image cropImage(System.Drawing.Image img, Rectangle cropArea)
        {
            Bitmap bmpImage = new Bitmap(img);
            Bitmap bmpCrop = bmpImage.Clone(cropArea, bmpImage.PixelFormat);
            return (System.Drawing.Image)(bmpCrop);
        }
    }
}