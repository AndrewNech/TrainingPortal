using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TrainigPortal.App.General.Entities;

namespace TrainingPortal.Models
{
    public class CoViewModel
    {
        public IReadOnlyCollection<Cource> Cources { get; set; }
    }
}