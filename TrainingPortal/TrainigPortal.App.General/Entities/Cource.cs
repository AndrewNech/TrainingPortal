using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainigPortal.App.General.Entities
{
    public class Cource
    {
        public int ID { get; set; }

        public int UserID { get; set; }

        public int CertificateID { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public ICollection<Category> Categories { get; set; }

        public ICollection<Lesson> Lessons { get; set; }
    }
}
