using System.Collections.Specialized;
using System.IO;
using System.Text;
using System.Xml.Linq;
using Anna.Request;
using common;
using common.resources;

namespace server.app
{
    class init : RequestHandler
    {
        private static byte[] _data;

        public override void InitHandler(Resources resources)
        {
            var init = XElement.Parse(
                File.ReadAllText($"{resources.ResourcePath}/data/init.xml"));

            foreach (var tag in new string[] {"SkinsList", "FilterList"})
            {
                var t = init.Element(tag);
                if (t != null)
                {
                    var value = "";
                    if (File.Exists(t.Value))
                        value = File.ReadAllText(t.Value);

                    t.ReplaceWith(new XElement(tag, value));
                }
            }
            
            _data = Encoding.UTF8.GetBytes(init.ToString());
        }

        public override void HandleRequest(RequestContext context, NameValueCollection query)
        {
            WriteXml(context, _data, false);
        }
    }
}
