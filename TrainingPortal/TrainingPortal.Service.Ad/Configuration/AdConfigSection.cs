using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainingPortal.Service.Advt.Configuration
{
    public class AdConfigSection : ConfigurationSection
    {
        [ConfigurationProperty("pathways")]
        public PathColl Pathways
        {
            get { return ((PathColl)(base["pathways"])); }
        }
    }
}
