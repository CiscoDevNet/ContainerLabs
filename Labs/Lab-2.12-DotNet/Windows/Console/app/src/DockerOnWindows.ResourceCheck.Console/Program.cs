using System.Threading;
using System;
using System.Net;
using System.Net.Http;
using DockerOnWindows.ResourceCheck.Console.Models;
using DockerOnWindows.ResourceCheck.Console.ResourceHogs;

namespace DockerOnWindows.ResourceCheck.Console
{
    class Program
    {
        static void Main(string[] args)
        {
            var commandLine = Args.Configuration.Configure<CommandLine>().CreateAndBind(args);

            IResourceHog hog = null;
            switch (commandLine.Resource)
            {
                case Resource.Memory:
                    hog = new MemoryResourceHog(commandLine.Parameter);
                    Thread.Sleep(20000);
                    System.Console.WriteLine("In memory");
                    WriteToFile();
                    RequestSubmitter("http://front-end");
                    Checker("http://www.example.com");
                    Checker("http://windows-client-api:8080/supplier");
                    Thread.Sleep(10000);
                    break;

                case Resource.Cpu:
                    hog = new CpuResourceHog(commandLine.Parameter);
                    System.Console.WriteLine("In memory");
                    Thread.Sleep(5000);
                    WriteToFile();
                    RequestSubmitter("http://front-end");
                    Checker("http://www.example.com");
                    Checker("http://windows-client-api:8080");
                    break;
            }
            hog.Go();

        }
        public static void WriteToFile()
        {
            System.Console.WriteLine("In write to file");
            Thread.Sleep(2000);
        }

        public static void RequestSubmitter(string myurl)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(myurl);
            request.Method = "GET";
            var webResponse = request.GetResponse();
            System.Console.WriteLine("Response: " + webResponse);
        }
        public static void Checker(string myurl)
        {
            Thread.Sleep(2000);
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(myurl);
            request.Method = "GET";
            var webResponse = request.GetResponse();
            System.Console.WriteLine("Response: " + webResponse);
        }
    }
}
