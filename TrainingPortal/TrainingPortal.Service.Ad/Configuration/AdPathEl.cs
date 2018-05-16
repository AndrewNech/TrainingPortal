using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainingPortal.Service.Advt.Configuration
{
   public  class AdPathEl : ConfigurationElement
    {
        [ConfigurationProperty("path", DefaultValue = "", IsKey = true, IsRequired = true)]
        public string Path
        {
            get { return ((string)(base["path"])); }
            set { base["path"] = value; }
        }
    }
}
