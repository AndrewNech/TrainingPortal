using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;
using TrainingPortal.Service.Advt.Entities;

namespace TrainingPortal.Service.Advt.Abstract
{
    [ServiceContract]
   public  interface IAdRepos
    {
        [OperationContract]
        Ad[] GetAd();
    }
}
