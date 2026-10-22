using System;
using System.Linq;

namespace Autoesindus
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (var db = Abi.Db())
                {
                    litAutod.Text = db.Set<auto>().Count().ToString();
                    litMargid.Text = db.Set<mark>().Count().ToString();
                    litKliendid.Text = db.Set<Klient>().Count().ToString();
                    litTellimused.Text = db.Set<Tellimus>().Count().ToString();
                }
            }
            catch (Exception)
            {
                // kui andmebaas pole kattesaadav, jaavad kriipsud
            }
        }
    }
}
