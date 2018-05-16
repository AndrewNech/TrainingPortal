using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TrainingPortal.AdService;
using TrainingPortal.Models;


namespace TrainingPortal.Controllers
{
    public class AdController : Controller
    {
        public PartialViewResult GetAd()
        {
            IAdRepos adRepository = new AdReposClient();

            var ads = adRepository.GetAd();
            var model = new AdViewModel
            {
                Ads = ads
            };

            return PartialView("AdPartialView", model);
        }
    }
}