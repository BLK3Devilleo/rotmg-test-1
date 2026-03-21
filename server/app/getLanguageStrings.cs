using System.Collections.Specialized;
using Anna.Request;

namespace server.app
{
    class getLanguageStrings : RequestHandler
    {
        public override void HandleRequest(RequestContext context, NameValueCollection query)
        {
            var lang = query["languageType"];
            if (lang == null || !Program.Resources.Languages.ContainsKey(lang))
                lang = "en";

            Write(context, Program.Resources.Languages[lang]);
        }
    }
}
