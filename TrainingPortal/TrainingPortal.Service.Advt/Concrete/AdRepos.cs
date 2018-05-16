using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrainingPortal.Service.Advt.Abstract;
using TrainingPortal.Service.Advt.Configuration;
using TrainingPortal.Service.Advt.Entities;

namespace TrainingPortal.Service.Advt.Concrete
{
   public  class AdRepos:IAdRepos
    {
        private IDictionary<string, string> _pathways;
        private const int adCount = 3;
        public AdRepos()
        {
            _pathways = new Dictionary<string, string>();
            var pathwaysSection = ((AdConfigSection)ConfigurationManager.GetSection("adSettings")).Pathways;
            foreach (AdPathEl item in pathwaysSection)
            {
                DirectoryInfo directory = new DirectoryInfo(item.Path);
                FileInfo[] files = directory.GetFiles();
                foreach (var fileInfo in files)
                {
                    _pathways.Add(fileInfo.FullName, fileInfo.Extension);
                }
            }
        }

        public Ad[] GetAd()
        {
            var resultCollection = new List<Ad>();
            Random random = new Random();
            for (int i = 0; i < adCount; i++)
            {
                int index = random.Next(0, _pathways.Count);
                byte[] image = File.ReadAllBytes(_pathways.Keys.ElementAt(index));
                Ad ad = new Ad
                {
                    ImageData = image,
                    ImageExtension = _pathways.Values.ElementAt(index).TrimStart('.')
                };
                resultCollection.Add(ad);
            }

            return resultCollection.ToArray();
        }
    }
}
