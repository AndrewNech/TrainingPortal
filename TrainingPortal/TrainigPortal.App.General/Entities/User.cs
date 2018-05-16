using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainigPortal.App.General.Entities
{
    public class User
    {
        public int ID { get; set; }

        public string Name { get; set; }

        public byte[] PhotoData { get; set; }

        public string PhotoMimeType { get; set; }

        public ICollection<Email> Emails { get; set; }

        public ICollection<Phone> Phones { get; set; }
    }
}
