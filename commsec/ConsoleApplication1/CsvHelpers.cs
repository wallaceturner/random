using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace ConsoleApplication1
{
    public class CsvHelpers
    {
        public static string Escape(OrderedDictionary dictionary)
        {
            return string.Join(",", dictionary.Values.Cast<string>().Select(v => Escape((v))));
        }

        public static string Escape(string s)
        {
            if (s == null)
                return null;
            if (s.Contains(QUOTE))
                s = s.Replace(QUOTE, ESCAPED_QUOTE);

            if (s.IndexOfAny(CHARACTERS_THAT_MUST_BE_QUOTED) > -1)
                s = QUOTE + s + QUOTE;

            return s;
        }

        public static string UnescapeLine(string s)
        {
            if (s == null)
                return null;
            if (s.StartsWith(QUOTE) && s.EndsWith(QUOTE))
            {
                s = s.Substring(1, s.Length - 2);

                if (s.Contains(ESCAPED_QUOTE))
                    s = s.Replace(ESCAPED_QUOTE, QUOTE);
            }

            return s;
        }

        public static IEnumerable<string[]> Unescape(string text)
        {
            using (var reader = new StringReader(text))
            {
                return Unescape(reader);
            }
        }

        public static IEnumerable<string[]> Unescape(TextReader reader)
        {
            if (null == reader)
                throw new System.ApplicationException("I can't start reading without CSV input.");


            string sLine;
            string sNextLine;

            while (null != (sLine = reader.ReadLine()))
            {
                while (rexRunOnLine.IsMatch(sLine) && null != (sNextLine = reader.ReadLine()))
                    sLine += "\n" + sNextLine;

                string[] values = rexCsvSplitter.Split(sLine);

                for (int i = 0; i < values.Length; i++)
                    values[i] = CsvHelpers.UnescapeLine(values[i]);

                yield return values;
            }

        }

        private static Regex rexCsvSplitter = new Regex(@",(?=(?:[^""]*""[^""]*"")*(?![^""]*""))");
        private static Regex rexRunOnLine = new Regex(@"^[^""]*(?:""[^""]*""[^""]*)*""[^""]*$");


        private const string QUOTE = "\"";
        private const string ESCAPED_QUOTE = "\"\"";
        private static char[] CHARACTERS_THAT_MUST_BE_QUOTED = { ',', '"', '\n' };

    }
}