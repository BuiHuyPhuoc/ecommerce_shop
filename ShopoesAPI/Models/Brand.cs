using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class Brand
{
    public int Id { get; set; }

    public string NameBrand { get; set; } = null!;

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
