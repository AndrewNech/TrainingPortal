using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TrainigPortal.App.Business.Abstract;
using TrainingPortal.Models;

namespace TrainingPortal.Controllers
{
    public class NavController : Controller
    {

        private ICategoryRepository _repository;
        public NavController(ICategoryRepository repository)
        {
            _repository = repository;
        }
        // GET: Nav
        public PartialViewResult Menu()
        {
            NavViewModel model = new NavViewModel
            {
                Categories = _repository.Items
            };
            return PartialView(model);
        }
    }
}