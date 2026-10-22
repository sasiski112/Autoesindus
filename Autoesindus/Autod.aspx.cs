using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace Autoesindus
{
    public partial class Autod : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            LoadLists();
            if (Request.QueryString["teade"] == "salvestatud")
                Abi.Teade(lblMsg, "Auto salvestati edukalt.", true);
            BindList();
        }

        void LoadLists()
        {
            using (var db = Abi.Db())
            {
                ddlMark.DataSource = db.Set<mark>().OrderBy(m => m.nimetus).ToList();
                ddlMark.DataTextField = "nimetus";
                ddlMark.DataValueField = "Id";
                ddlMark.DataBind();
                ddlMark.Items.Insert(0, new ListItem("Kõik margid", "0"));

                ddlKat.DataSource = db.Set<Kategooria>().OrderBy(k => k.nimetus).ToList();
                ddlKat.DataTextField = "nimetus";
                ddlKat.DataValueField = "Id";
                ddlKat.DataBind();
                ddlKat.Items.Insert(0, new ListItem("Kõik kategooriad", "0"));
            }
        }

        void BindList()
        {
            using (var db = Abi.Db())
            {
                IEnumerable<auto> q = db.Set<auto>().ToList();

                string s = txtOtsi.Text.Trim();
                if (s.Length > 0)
                    q = q.Where(a => a.nimetus.Contains(s) || a.mark.nimetus.Contains(s));

                int markId = int.Parse(ddlMark.SelectedValue);
                if (markId > 0) q = q.Where(a => a.mark.Id == markId);

                int katId = int.Parse(ddlKat.SelectedValue);
                if (katId > 0) q = q.Where(a => a.Kategooria.Id == katId);

                switch (ddlSort.SelectedValue)
                {
                    case "hind_asc": q = q.OrderBy(a => Abi.HindArv(a.hind)); break;
                    case "hind_desc": q = q.OrderByDescending(a => Abi.HindArv(a.hind)); break;
                    case "mudel": q = q.OrderBy(a => a.nimetus); break;
                    default: q = q.OrderBy(a => a.mark.nimetus).ThenBy(a => a.nimetus); break;
                }

                var raw = q.Select(a => new
                {
                    a.Id,
                    Mark = a.mark.nimetus,
                    Mudel = a.nimetus,
                    Kat = a.Kategooria.nimetus,
                    a.kirjeldus,
                    a.hind,
                    Extras = a.autoLisavarustus.Select(x => x.lisavarustus.nimetus)
                }).ToList();

                var list = raw.Select(a => new
                {
                    a.Id,
                    a.Mark,
                    a.Mudel,
                    a.Kat,
                    a.kirjeldus,
                    Hind = Abi.Hind(a.hind),
                    Extras = a.Extras.Any() ? string.Join(", ", a.Extras) : "–"
                }).ToList();

                rep.DataSource = list;
                rep.DataBind();
                rep.Visible = list.Count > 0;
                pnlTuhi.Visible = list.Count == 0;
                litCount.Text = "Leiti " + list.Count + " autot";
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindList();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtOtsi.Text = "";
            ddlMark.SelectedIndex = 0;
            ddlKat.SelectedIndex = 0;
            ddlSort.SelectedIndex = 0;
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
                    var a = db.Set<auto>().Find(id);
                    if (a != null)
                    {
                        foreach (var item in a.autoLisavarustus.ToList())
                        {
                            db.Set<autoLisavarustus>().Remove(item);
                        }
                        foreach (var item in a.TellimusAuto.ToList())
                        {
                            db.Set<TellimusAuto>().Remove(item);
                        }
                        db.Set<auto>().Remove(a);
                        db.SaveChanges();
                    }
                }
                Abi.Teade(lblMsg, "Auto kustutati.", true);
            }
            catch (Exception ex)
            {
                Abi.Teade(lblMsg, "Kustutamine ebaõnnestus: " + Abi.Viga(ex), false);
            }
            BindList();
        }
    }
}
