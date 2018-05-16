
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrainigPortal.App.Business.Abstract;
using TrainigPortal.App.General.Entities;

namespace TrainigPortal.App.Business.Concrete
{
    class CategoryRepository: ICategoryRepository
    {
        private ICollection<Category> _source = new List<Category>();
        public CategoryRepository()
        {
            for (int i = 0; i < 5; i++)
            {
                Category category = new Category();
                category.ID = i;
                category.Name = $"Category {i}";
                _source.Add(category);
            }
        }

        public IReadOnlyCollection<Category> Items
        {
            get => _source.ToList();
            set => throw new NotImplementedException();
        }
    }
}

