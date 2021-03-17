using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using HtmlAgilityPack;

namespace ConsoleApplication1
{
    public class WestpacDataService 
    {
        private const string _cookieFile = "cookie.bin";
        private static Uri _baseAddress = new Uri("https://onlineinvesting.westpac.com.au");

        public WestpacDataService()
        {
        }


        private async Task DoWithLogin(Func<HttpClient, Task> action)
        {
            var cookies = new CookieContainer();
            if (File.Exists(_cookieFile))
            {
                using (Stream stream = File.Open(_cookieFile, FileMode.Open))
                {
                    BinaryFormatter formatter = new BinaryFormatter();
                    cookies = (CookieContainer)formatter.Deserialize(stream);
                    IEnumerable<Cookie> responseCookies = cookies.GetCookies(_baseAddress).Cast<Cookie>();
                    // foreach (Cookie cookie in responseCookies)
                    //     Console.WriteLine(cookie.Name + ": " + cookie.Value);
                }
            }

            using (var handler = new HttpClientHandler { UseCookies = true })
            {
                using (var client = new HttpClient(handler) { BaseAddress = _baseAddress })
                {
                    handler.CookieContainer = cookies;

                    if (cookies.Count == 0)
                    {
                        await GetCookies(client, cookies);
                    }
                    await action(client);
                }
            }
        }

        private async Task GetCookies(HttpClient client, CookieContainer cookies)
        {
            string formData = "username=therubygroup80&password=ycdiux&startIn=Start+in%3A+My+Home";
            await ExecutePostToFile(client, formData, "output1.html", "/user/client/logon");

            using (Stream stream = File.Create(_cookieFile))
            {
                BinaryFormatter formatter = new BinaryFormatter();
                formatter.Serialize(stream, cookies);
            }
        }

        private async Task ExecutePostToFile(HttpClient client, string formData, string outputFile, string requestUri)
        {
            var message = new HttpRequestMessage(HttpMethod.Post, requestUri);
            SetHeaderCommon(message);
            message.Content = new StringContent(formData, Encoding.UTF8, "application/x-www-form-urlencoded");

            var result = await client.SendAsync(message);
            var responseString = await result.Content.ReadAsStringAsync();
            File.WriteAllText(outputFile, responseString);
        }

        private void SetHeaderCommon(HttpRequestMessage message)
        {
            message.Headers.Add("Host", "onlineinvesting.westpac.com.au");
            message.Headers.Add("Cache-Control", "max-age=0");
            message.Headers.Add("Origin", "https://onlineinvesting.westpac.com.au");
            message.Headers.Add("Upgrade-Insecure-Requests", "1");
            message.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36");

            message.Headers.Add("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            message.Headers.Add("Referer", "https://onlineinvesting.westpac.com.au/");
        }


        public async Task<string> DownloadCompanyResearch(string ticker)
        {
            //var url = $"https://onlineinvesting.westpac.com.au/Private/MarketPrices/CompanyProfile/Financials.aspx?stockCode={ticker}";
            var url = $"https://onlineinvesting.westpac.com.au/Private/MarketPrices/CompanyProfile/Financials.aspx?pID=14Cv2jyfh8PPsGdvTXo0JraCO561e8AloU%2fl6Lzd2GU%3d&stockCode={ticker}";
            var responseString = "";
            bool success = await DoWithRetry(async (client) =>
            {
                string formData = "";
                {

                    var message = new HttpRequestMessage(HttpMethod.Get, url);
                    SetHeaderCommon(message);
                    var result = await client.SendAsync(message);
                    responseString = await result.Content.ReadAsStringAsync();

                }
            });

            return responseString;

        }
        

        private async Task<bool> DoWithRetry(Func<HttpClient, Task> action)
        {
            int count = 0;
            while (true)
            {
                try
                {
                    await DoWithLogin(async (client) =>
                    {
                        await action(client);
                    });
                    break;
                }
                catch (Exception e)
                {
                    Console.WriteLine("Fetch error: " + e.Message);
                    File.Delete(_cookieFile);
                    count++;
                }
                count++;
                if (count > 5)
                {
                    return false;
                }
                await Task.Delay(TimeSpan.FromSeconds(5));
            }
            return true;
        }




        public void Init()
        {
            File.Delete(_cookieFile);
        }
    }
}