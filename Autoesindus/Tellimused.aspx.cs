using System;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;

namespace Autoesindus
{
    public partial class Tellimused : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            LoadLists();
            txtKuup.Text = DateTime.Today.ToString("yyyy-MM-dd");
            txtKell.Text = DateTime.Now.ToString("HH:mm");
            BindList();
        }

        void LoadLists()
        {
            using (var db = Abi.Db())
            {
                var kliendid = db.Set<Klient>().OrderBy(k => k.perenimi).ThenBy(k => k.eesnimi).ToList()
                    .Select(k => new { k.Id, Nimi = k.eesnimi + " " + k.perenimi }).ToList();
                ddlKlient.DataSource = kliendid;
                ddlKlient.DataTextField = "Nimi";
                ddlKlient.DataValueField = "Id";
                ddlKlient.DataBind();

                var salongid = db.Set<salong>().OrderBy(s => s.number).ToList()
                    .Select(s => new { s.Id, Nimi = "Salong " + s.number + " (" + s.kohtadeArv + " kohta)" }).ToList();
                ddlSalong.DataSource = salongid;
                ddlSalong.DataTextField = "Nimi";
                ddlSalong.DataValueField = "Id";
                ddlSalong.DataBind();

                var autod = db.Set<auto>().Include("mark").OrderBy(a => a.mark.nimetus).ThenBy(a => a.nimetus).ToList()
                    .Select(a => new { a.Id, Nimi = a.mark.nimetus + " " + a.nimetus + " (" + Abi.Hind(a.hind) + ")" }).ToList();
                cblAutod.DataSource = autod;
                cblAutod.DataTextField = "Nimi";
                cblAutod.DataValueField = "Id";
                cblAutod.DataBind();
            }
        }

        void BindList()
        {
            using (var db = Abi.Db())
            {
                var tellimused = db.Set<Tellimus>()
                    .Include("Klient").Include("salong").Include("TellimusAuto.auto.mark")
                    .OrderByDescending(t => t.Id).ToList();

                var rows = tellimused.Select(t => new
                {
                    t.Id,
                    Aeg = Abi.Naita(t, "kuupaev") + " " + Abi.Naita(t, "kellaaeg"),
                    KlientNimi = t.Klient != null ? t.Klient.eesnimi + " " + t.Klient.perenimi : "–",
                    Salong = t.salong != null ? "Salong " + t.salong.number : "–",
                    Autod = string.Join(", ", t.TellimusAuto.Select(x => x.auto.mark.nimetus + " " + x.auto.nimetus)),
                    Summa = Abi.Hind(t.TellimusAuto.Sum(x => Abi.HindArv(x.auto.hind))),
                    Staatus = t.staatus,
                    Klass = Abi.StaatuseKlass(t.staatus)
                }).ToList();

                rep.DataSource = rows;
                rep.DataBind();
                rep.Visible = rows.Count > 0;
                pnlTuhi.Visible = rows.Count == 0;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlKlient.Items.Count == 0 || ddlSalong.Items.Count == 0)
            {
                Abi.Teade(lblMsg, "Tellimuse jaoks on vaja vähemalt ühte klienti ja ühte salongi.", false);
                return;
            }

            var valitud = cblAutod.Items.Cast<ListItem>().Where(li => li.Selected).ToList();
            if (valitud.Count == 0)
            {
                Abi.Teade(lblMsg, "Vali tellimusele vähemalt üks auto.", false);
                return;
            }

            DateTime kuup;
            TimeSpan kell;
            if (!DateTime.TryParse(txtKuup.Text, CultureInfo.InvariantCulture, DateTimeStyles.None, out kuup) ||
                !TimeSpan.TryParse(txtKell.Text, CultureInfo.InvariantCulture, out kell))
            {
                Abi.Teade(lblMsg, "Palun sisesta korrektne kuupäev ja kellaaeg.", false);
                return;
            }

            try
            {
                using (var db = Abi.Db())
                {
                    var t = new Tellimus { staatus = ddlStaatus.SelectedValue };
                    Abi.SetKuupaev(t, kuup);
                    Abi.SetKellaaeg(t, kell);
                    t.Klient = db.Set<Klient>().Find(int.Parse(ddlKlient.SelectedValue));
                    t.salong = db.Set<salong>().Find(int.Parse(ddlSalong.SelectedValue));
                    db.Set<Tellimus>().Add(t);

                    foreach (var li in valitud)
                    {
                        db.Set<TellimusAuto>().Add(new TellimusAuto
                        {
                            Tellimus = t,
                            auto = db.Set<auto>().Find(int.Parse(li.Value))
                        });
                    }
                    db.SaveChanges();
                }

                foreach (ListItem li in cblAutod.Items) li.Selected = false;
                Abi.Teade(lblMsg, "Tellimus salvestati.", true);
            }
            catch (Exception ex)
            {
                Abi.Teade(lblMsg, "Salvestamine ebaõnnestus: " + Abi.Viga(ex), false);
            }
            BindList();
        }

        protected void rep_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                using (var db = Abi.Db())
                {
                    if (e.CommandName == "staatus")
                    {
                        var osad = ((string)e.CommandArgument).Split('|');
                        int id = int.Parse(osad[0]);
                        var t = db.Set<Tellimus>().Find(id);
                        if (t != null)
                        {
                            t.staatus = osad[1];
                            db.SaveChanges();
                        }
                        Abi.Teade(lblMsg, "Tellimuse staatus muudeti.", true);
                    }
                    else if (e.CommandName == "kustuta")
                    {
                        int id = int.Parse((string)e.CommandArgument);
                        var t = db.Set<Tellimus>().Find(id);
                        if (t != null)
                        {
                            foreach (var item in t.TellimusAuto.ToList())
                        {
                            db.Set<TellimusAuto>().Remove(item);
                        }
                            db.Set<Tellimus>().Remove(t);
                            db.SaveChanges();
                        }
                        Abi.Teade(lblMsg, "Tellimus kustutati.", true);
                    }
                }
            }
            catch (Exception ex)
            {
                Abi.Teade(lblMsg, "Tegevus ebaõnnestus: " + Abi.Viga(ex), false);
            }
            BindList();
        }
    }
}
