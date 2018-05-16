using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace TrainingPortal.Service.Advt.Entities
{

    [DataContract]
    public class Ad
    {
        [DataMember]
        public byte[] ImageData { get; set; }

        [DataMember]
        public string ImageExtension { get; set; }
    }
}

