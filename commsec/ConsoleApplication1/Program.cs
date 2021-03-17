using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using HtmlAgilityPack;
using ICSharpCode.SharpZipLib.GZip;

namespace ConsoleApplication1
{
    class Program
    {
        static async Task Main(string[] args)
        {
            try
            {
                ServicePointManager.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => { return true; };
                //await Download();
                Parse();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
            Console.WriteLine("Finished");
            Console.ReadLine();
        }
        private static void Parse()
        {
            var files = Directory.GetFiles(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "stocks"));
            //files = files.Where(f => f.Contains("TLS")).ToArray();
            var failed = new List<string>();
            var outputDir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "csv");
            ClearFolder(outputDir);
            foreach (var file in files)
            {
                var inputFile = new FileInfo(file).Name;
                var outputfilename = inputFile.Substring(0, inputFile.IndexOf(".html")) + ".csv";
                
                Console.WriteLine("Parsing " + inputFile);
                var htmlDoc = new HtmlDocument();
                htmlDoc.OptionFixNestedTags = true;
                // filePath is a path to a file containing the html
                htmlDoc.Load(file);
                
                var lines = new List<string>();
                try
                {
                    foreach (var node in htmlDoc.DocumentNode.SelectNodes("//table[@class='SolidHeader']"))
                    {
                        //Console.WriteLine(node.ChildNodes["caption"].InnerHtml);
                        var tableName = node.ChildNodes["caption"].InnerText;
                        if (tableName.Contains("Company Historicals") || tableName.Contains("Historical Financials") || tableName.Contains("Balance Sheet"))
                        {
                            lines.Add(Clean(tableName));
                            var headerFields = new List<string>();
                            foreach(var thNode in node.SelectNodes("thead//tr//th"))
                            {
                                //Console.WriteLine(thNode.InnerHtml);
                                headerFields.Add(Clean(thNode.InnerText));
                            }
                            lines.Add(string.Join(",", headerFields.Select(CsvHelpers.Escape)));

                        
                            foreach (var trNode in node.SelectNodes("tbody//tr"))
                            {
                                var fields = new List<string>();
                                foreach (var tdNode in trNode.SelectNodes("td"))
                                {
                                    //Console.WriteLine(tdNode.InnerText);
                                    fields.Add(Clean(tdNode.InnerText));
                                }

                                var line = string.Join(",", fields.Select(CsvHelpers.Escape));
                                lines.Add(line);                                
                            }
                        
                        }
                    }
                    lines = lines.Take(39).ToList();

                    
                    var outputFile = Path.Combine(outputDir, outputfilename);

                    File.WriteAllLines(outputFile, lines);
                }
                catch (Exception e)
                {
                    Console.WriteLine(file + " failed: " + e.Message);
                    failed.Add(file);
                }

                
            }
            Console.WriteLine("the following {0} failed:", failed.Count);
            foreach(var file in failed)
                Console.WriteLine(file);
        }

        static string Clean(string val)
        {
            return val.Trim();
        }

        static void ClearFolder(string outputDir)
        {
            if (Directory.Exists(outputDir))
            {
                foreach (string file in Directory.GetFiles(outputDir))
                {
                    File.Delete(file);
                }
            }
            else
            {
                Directory.CreateDirectory(outputDir);
            }
        }

        static async Task Download()
        {
            int count = 0;
            var tickers = new List<string>();
            const string companiesListFile = "ASXListedCompanies.csv";
            var outputDir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "stocks");
            if (File.Exists(companiesListFile))
            {
                var age = DateTime.Now - File.GetLastWriteTime(companiesListFile);
                if (age > TimeSpan.FromDays(28))
                {
                    File.Delete(companiesListFile);
                }                
            }

            if (!File.Exists(companiesListFile))
            {
                using (var client = new System.Net.WebClient())
                {
                    client.DownloadFile("https://www.asx.com.au/asx/research/ASXListedCompanies.csv", companiesListFile);
                }
                foreach (FileInfo file in new DirectoryInfo(outputDir).GetFiles())
                {
                    file.Delete();
                }
            }
            

            
            using (var reader = new StringReader(File.ReadAllText(companiesListFile)))
            {
                foreach (var tokens in CsvHelpers.Unescape(reader))
                {
                    if (count != 0)
                    {
                        if (tokens.Length > 1 && !string.IsNullOrWhiteSpace(tokens[0]) && !tokens[1].Contains("code"))
                        {
                            tickers.Add(tokens[1]);
                        }
                    }
                    count++;
                }
            }
                

           

            //tickers = new[] { "TLS", "BHP" ,}.ToList();
            Console.WriteLine(string.Join(",", tickers));
            
            //ClearFolder(outputDir);
            var service = new WestpacDataService();
            service.Init();
            foreach (var ticker in tickers)
            {                
                var outputFile = Path.Combine(outputDir, $"{ticker}.html");
                if (ticker == "PRN")
                    continue;
                if (File.Exists(outputFile))
                {
                    Console.WriteLine("already downloaded " + ticker);
                    continue;
                }

                var html = await service.DownloadCompanyResearch(ticker);
                File.WriteAllText(outputFile, html);
                Console.WriteLine($"wrote {outputFile} {html.Length/1024}kB");
                Thread.Sleep(1000);


            }
        }
        private static byte[] Decompress(byte[] bytes)
        {
            var gz = new GZipInputStream(new MemoryStream(bytes));
            int intSizeRead;
            int intChunkSize = 2048;
            byte[] unzipBytes = new byte[intChunkSize + 1];

            var ms = new MemoryStream();
            while ((intSizeRead = gz.Read(unzipBytes, 0, intChunkSize)) > 0)
            {
                ms.Write(unzipBytes, 0, intSizeRead);
            }
            return ms.ToArray();
        }
    }
}
