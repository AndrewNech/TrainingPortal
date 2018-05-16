using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TrainingPortal.HtmlHelpers;

namespace TrainingPortal.Models
{
    public class AdViewModel
    {
        public IReadOnlyCollection<AdService.Ad> Ads { get; set; }
    }
}