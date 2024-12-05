using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models;

public partial class Product
{
    public int Id { get; set; }

    public string NameProduct { get; set; } = null!;

    public string Description { get; set; } = null!;

    public decimal PriceProduct { get; set; }

    public decimal? NewPrice { get; set; }

    public int IdCategory { get; set; }

    public int IdBrand { get; set; }

    public string? ImageProduct { get; set; }

    public bool IsValid { get; set; }
  
    [JsonRequired]
    public virtual Brand IdBrandNavigation { get; set; } = null!;
  
    [JsonRequired]
    public virtual Category IdCategoryNavigation { get; set; } = null!;
  
    public virtual ICollection<ProductImage> ProductImages { get; set; } = new List<ProductImage>();
  
    public virtual ICollection<ProductVarient> ProductVarients { get; set; } = new List<ProductVarient>();

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();

}
