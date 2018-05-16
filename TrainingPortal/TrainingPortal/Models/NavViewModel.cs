using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TrainigPortal.App.General.Entities;

namespace TrainingPortal.Models
{
    public class NavViewModel
    {
        public IReadOnlyCollection<Category> Categories { get; set; }
    }
}