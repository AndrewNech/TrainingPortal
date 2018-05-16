using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrainigPortal.App.General.Entities
{
    public class Category
    {
        public int ID { get; set; }

        public string Name { get; set; }

        public ICollection<Subcategory> Subcategories { get; set; }
    }
}
