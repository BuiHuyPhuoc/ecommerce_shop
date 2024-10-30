using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models;

public partial class ProductVarient
{
    public int Id { get; set; }

    public int? IdProduct { get; set; }

    public int Size { get; set; }

    public int InStock { get; set; }
        
    public bool? IsValid { get; set; }
    [JsonInclude]
    public virtual Product? IdProductNavigation { get; set; }

    [JsonIgnore]
    public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();
}
