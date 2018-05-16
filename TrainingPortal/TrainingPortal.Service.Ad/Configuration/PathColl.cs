using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainingPortal.Service.Advt.Configuration
{
    [ConfigurationCollection(typeof(AdPathEl), AddItemName = "adPath")]
    public class PathColl : ConfigurationElementCollection
    {


        protected override ConfigurationElement CreateNewElement()
        {
            return new AdPathEl();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((AdPathEl)(element)).Path;
        }

        public AdPathEl this[int index]
        {
            get { return (AdPathEl)BaseGet(index); }
        }
    }

}
