using System;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace Autoesindus
{
    public partial class Kliendid : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindList();
        }

        void BindList()
        {
            using (var db = Abi.Db())
            {
                IQueryable<Klient> q = db.Set<Klient>();
                string s = txtOtsi.Text.Trim();
                if (s.Length > 0)
                    q = q.Where(k => k.eesnimi.Contains(s) || k.perenimi.Contains(s) || k.telefon.Contains(s));

                var list = q.OrderBy(k => k.perenimi).ThenBy(k => k.eesnimi)
                    .Select(k => new { k.Id, k.eesnimi, k.perenimi, k.telefon, Tellimusi = k.Tellimus.Count() })
                    .ToList();

                rep.DataSource = list;
                rep.DataBind();
                rep.Visible = list.Count > 0;
                pnlTuhi.Visible = list.Count == 0;
                litCount.Text = "Kliente kokku: " + list.Count;
            }
        }

        protected void btnOtsi_Click(object sender, EventArgs e)
        {
            BindList();
        }

        protected void btnTuhista_Click(object sender, EventArgs e)
        {
            txtOtsi.Text = "";
            BindList();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string tel = txtTel.Text.Trim();
            if (string.IsNullOrWhiteSpace(txtEes.Text) || string.IsNullOrWhiteSpace(txtPere.Text))
            {
                Abi.Teade(lblMsg, "Palun sisesta kliendi ees- ja perenimi.", false);
                return;
            }
            if (tel.Length > 0 && !Regex.IsMatch(tel, @"^[0-9+\s\-]{5,20}$"))
            {
                Abi.Teade(lblMsg, "Telefoninumber ei ole korrektne.", false);
                return;
            }

            try
            {
                using (var db = Abi.Db())
                {
                    db.Set<Klient>().Add(new Klient
                    {
                        eesnimi = txtEes.Text.Trim(),
                        perenimi = txtPere.Text.Trim(),
                        telefon = tel
                    });
                    db.SaveChanges();
                }
                txtEes.Text = txtPere.Text = txtTel.Text = "";
                Abi.Teade(lblMsg, "Klient lisati.", true);
            }
            catch (Exception ex)
            {
                Abi.Teade(lblMsg, "Viga salvestamisel: " + Abi.Viga(ex), false);
            }
            BindList();
        }

        protected void rep_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "kustuta") return;
            int id = int.Parse((string)e.CommandArgument);
            try
            {
                using (var db = Abi.Db())
                {
                    var k = db.Set<Klient>().Find(id);
                    if (k != null)
                    {
                        if (k.Tellimus.Any())
                        {
                            Abi.Teade(lblMsg, "Klienti ei saa kustutada, sest tal on tellimusi.", false);
                            BindList();
                            return;
                        }
                        db.Set<Klient>().Remove(k);
                        db.SaveChanges();
                    }
                }
                Abi.Teade(lblMsg, "Klient kustutati.", true);
            }
            catch (Exception ex)
            {
                Abi.Teade(lblMsg, "Kustutamine ebaõnnestus: " + Abi.Viga(ex), false);
            }
            BindList();
        }
    }
}
