using System;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;

namespace Autoesindus
{
    public partial class LisaAuto : System.Web.UI.Page
    {
        int MuudaId
        {
            get
            {
                int id;
                return int.TryParse(Request.QueryString["id"], out id) ? id : 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            LoadLists();
            if (MuudaId > 0) LoadCar();
        }

        void LoadLists()
        {
            using (var db = Abi.Db())
            {
                ddlMark.DataSource = db.Set<mark>().OrderBy(m => m.nimetus).ToList();
                ddlMark.DataTextField = "nimetus";
                ddlMark.DataValueField = "Id";
                ddlMark.DataBind();

                ddlKat.DataSource = db.Set<Kategooria>().OrderBy(k => k.nimetus).ToList();
                ddlKat.DataTextField = "nimetus";
                ddlKat.DataValueField = "Id";
                ddlKat.DataBind();

                cblLisa.DataSource = db.Set<lisavarustus>().OrderBy(l => l.nimetus).ToList();
                cblLisa.DataTextField = "nimetus";
                cblLisa.DataValueField = "Id";
                cblLisa.DataBind();
            }
        }

        void LoadCar()
        {
            using (var db = Abi.Db())
            {
                var a = db.Set<auto>().Find(MuudaId);
                if (a == null)
                {
                    Response.Redirect("~/Autod", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                litPealkiri.Text = "Muuda autot";
                Title = "Muuda autot";
                txtNimi.Text = a.nimetus;
                txtKirj.Text = a.kirjeldus;
                txtHind.Text = a.hind ?? "";
                ddlMark.SelectedValue = a.mark.Id.ToString();
                ddlKat.SelectedValue = a.Kategooria.Id.ToString();

                var valitud = a.autoLisavarustus.Select(x => x.lisavarustus.Id.ToString()).ToList();
                foreach (ListItem li in cblLisa.Items)
                    li.Selected = valitud.Contains(li.Value);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            decimal hind;
            if (string.IsNullOrWhiteSpace(txtNimi.Text))
            {
                Abi.Teade(lblMsg, "Palun sisesta auto mudel.", false);
                return;
            }
            if (!decimal.TryParse(txtHind.Text.Trim().Replace(',', '.'), NumberStyles.Any, CultureInfo.InvariantCulture, out hind) || hind <= 0)
            {
                Abi.Teade(lblMsg, "Palun sisesta korrektne hind (nt 24900).", false);
                return;
            }
            if (ddlMark.Items.Count == 0 || ddlKat.Items.Count == 0)
            {
                Abi.Teade(lblMsg, "Enne auto lisamist peavad andmebaasis olema margid ja kategooriad.", false);
                return;
            }

            try
            {
                using (var db = Abi.Db())
                {
                    auto a;
                    if (MuudaId > 0)
                    {
                        a = db.Set<auto>().Find(MuudaId);
                        if (a == null) { Abi.Teade(lblMsg, "Autot ei leitud.", false); return; }
                        foreach (var item in a.autoLisavarustus.ToList())
                        {
                            db.Set<autoLisavarustus>().Remove(item);
                        }
                    }
                    else
                    {
                        a = new auto();
                        db.Set<auto>().Add(a);
                    }

                    a.nimetus = txtNimi.Text.Trim();
                    a.kirjeldus = txtKirj.Text.Trim();
                    a.hind = hind.ToString(CultureInfo.InvariantCulture);
                    a.mark = db.Set<mark>().Find(int.Parse(ddlMark.SelectedValue));
                    a.Kategooria = db.Set<Kategooria>().Find(int.Parse(ddlKat.SelectedValue));

                    foreach (ListItem li in cblLisa.Items)
                    {
                        if (!li.Selected) continue;
                        db.Set<autoLisavarustus>().Add(new autoLisavarustus
                        {
                            auto = a,
                            lisavarustus = db.Set<lisavarustus>().Find(int.Parse(li.Value))
                        });
                    }

                    db.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                Abi.Teade(lblMsg, "Salvestamine ebaõnnestus: " + Abi.Viga(ex), false);
                return;
            }

            Response.Redirect("~/Autod?teade=salvestatud", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
