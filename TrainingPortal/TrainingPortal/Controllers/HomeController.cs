using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TrainigPortal.App.Business.Abstract;
using TrainigPortal.App.General.Loggers.Abstract;
using TrainingPortal.Models;

namespace TrainingPortal.Controllers
{
    public class HomeController : Controller
    {
        private ICoRepository _repository;
        private ILoggerWrapper _logger;

       
        public HomeController(ICoRepository repository, ILoggerWrapper logger)
        {
            _repository = repository;
            _logger = logger;
        }

        // GET: Home
        public ActionResult Index()
        {
            CoViewModel model = new CoViewModel
            {
                Cources = _repository.Items.ToList()
            };
            return View(model);
        }

        public ActionResult GetCategoryCource(int categoryID)
        {
            CoViewModel model = new CoViewModel
            {
                Cources = _repository.GetCategoryCources(categoryID).ToList()
            };

            _logger.InfoFormat($"Get elements by categoryID: { categoryID }", null);

            return View("Index", model);
        }

        public ActionResult GetCource(int coID, string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            var model = _repository.GetCource(coID);

            _logger.InfoFormat($"Get ad by coID: { coID }", null);

            return View("CourcesInformation", model);
        }
    }
}
