using StructureMap;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TrainigPortal.App.Business.Abstract;
using TrainigPortal.App.Business.Concrete;
using System.Threading.Tasks;
using TrainigPortal.App.General.Entities;


namespace TrainigPortal.App.Business.DependencyResolution
{
    public class BusinessRegistry:Registry
    {
        public BusinessRegistry()
        {
            Scan(scan =>
            {
                scan.TheCallingAssembly();
                scan.WithDefaultConventions();
            });
            For<ICoRepository>().Use<CoRepository>();
            For<ICategoryRepository>().Use<CategoryRepository>();
        }
    }
}