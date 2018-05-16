using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace TrainingPortal.Service.Advt.Entities
{
    [DataContract]
    public class Image
    {
        [DataMember]
        public byte[] Data { get; set; }

        [DataMember]
        public string Extension { get; set; }
    }
}
