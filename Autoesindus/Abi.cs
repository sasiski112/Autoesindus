using System;
using System.Globalization;
using System.Reflection;
using System.Web.UI.WebControls;

namespace Autoesindus
{
    // Abiklass: koik, mis soltub mudeli nimedest, on siin uhes kohas.
    public static class Abi
    {
        // Kui sinu konteksti klassi nimi on teine (vaata Model1.Context.cs), muuda ainult siin.
        public static Model1Container Db()
        {
            return new Model1Container();
        }

        static readonly CultureInfo Et = new CultureInfo("et-EE");

        public static decimal HindArv(string tekst)
        {
            decimal arv;
            if (decimal.TryParse((tekst ?? "").Trim().Replace(',', '.'), NumberStyles.Any, CultureInfo.InvariantCulture, out arv))
                return arv;
            return 0m;
        }

        public static string Hind(string tekst)
        {
            return Hind(HindArv(tekst));
        }

        public static string Hind(decimal h)
        {
            return h.ToString("N0", Et) + " €";
        }

        public static void Teade(Label lbl, string tekst, bool korras)
        {
            lbl.Text = tekst;
            lbl.CssClass = korras ? "alert ok" : "alert err";
            lbl.Visible = true;
        }

        public static string Viga(Exception ex)
        {
            while (ex.InnerException != null) ex = ex.InnerException;
            return ex.Message;
        }

        public static string StaatuseKlass(string staatus)
        {
            switch (staatus)
            {
                case "Valmis": return "ok";
                case "Kinnitatud": return "info";
                case "Tühistatud": return "err";
                default: return "neutral";
            }
        }

        // ---- Tellimuse kuupaev/kellaaeg: tootab olenemata sellest, kas mudelis on DateTime, TimeSpan voi string ----

        static PropertyInfo Omadus(object o, string nimi)
        {
            return o.GetType().GetProperty(nimi,
                BindingFlags.Public | BindingFlags.Instance | BindingFlags.IgnoreCase);
        }

        public static void SetKuupaev(object o, DateTime d)
        {
            var p = Omadus(o, "kuupaev");
            if (p == null) return;
            var t = Nullable.GetUnderlyingType(p.PropertyType) ?? p.PropertyType;
            if (t == typeof(DateTime)) p.SetValue(o, d.Date, null);
            else if (t == typeof(string)) p.SetValue(o, d.ToString("dd.MM.yyyy"), null);
        }

        public static void SetKellaaeg(object o, TimeSpan k)
        {
            var p = Omadus(o, "kellaaeg");
            if (p == null) return;
            var t = Nullable.GetUnderlyingType(p.PropertyType) ?? p.PropertyType;
            if (t == typeof(TimeSpan)) p.SetValue(o, k, null);
            else if (t == typeof(DateTime)) p.SetValue(o, DateTime.Today.Add(k), null);
            else if (t == typeof(string)) p.SetValue(o, k.ToString(@"hh\:mm"), null);
        }

        public static string Naita(object o, string nimi)
        {
            var p = Omadus(o, nimi);
            if (p == null) return "";
            object v = p.GetValue(o, null);
            if (v == null) return "";
            if (v is DateTime)
            {
                var dt = (DateTime)v;
                return nimi.ToLower().StartsWith("kuup") ? dt.ToString("dd.MM.yyyy") : dt.ToString("HH:mm");
            }
            if (v is TimeSpan) return ((TimeSpan)v).ToString(@"hh\:mm");
            return v.ToString();
        }
    }
}
