using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrainigPortal.App.Business.Abstract;
using TrainigPortal.App.General.Entities;

namespace TrainigPortal.App.Business.Concrete
{
    class CoRepository: ICoRepository
    {
        private readonly SqlConnection connect = new SqlConnection(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=TrainingPortalDB;Integrated Security=True");

        private ICollection<Cource> _source = new List<Cource>();
        public CoRepository()
        {
            connect.Open();
            for (int i = 0; i < 5; i++)
            {
                string strSQL = $"Select Name From Courses WHERE Course_ID = {i+1}";
                SqlCommand myCommand = new SqlCommand(strSQL, connect);
                

                Cource co = new Cource();
                co.ID = i;
                co.Name =$"Name {i}"; //myCommand.ExecuteNonQuery().ToString();//
                co.Description = $"Description {i}";
               
                co.Categories = new List<Category>
                {
                    new Category { ID = i, Name = $"Category {i}"}
                };
                _source.Add(co);
            }
        }

        public IReadOnlyCollection<Cource> Items
        {
            get { return _source.ToList(); }
            set { throw new NotImplementedException(); }
        }

        public Cource GetCource(int coID)
        {
            return _source.First(x => x.ID == coID);
        }

        public IReadOnlyCollection<Cource> GetCategoryCources(int categoryID)
        {
            return _source.Where(x => x.Categories?.Where(y => y.ID == categoryID).Count() != 0).ToList(); // replace on stored procedure
        }
    }
}

