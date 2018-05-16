using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrainigPortal.App.General.Entities;

namespace TrainigPortal.App.Business.Abstract
{
    public interface ICoRepository : IEntityRepository<Cource>
    {
        IReadOnlyCollection<Cource> GetCategoryCources(int categoryID);

        Cource GetCource(int adID);
    }
}
