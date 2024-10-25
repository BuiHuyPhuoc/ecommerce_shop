using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models;

public partial class Order
{
    public int Id { get; set; }

    public DateTime Date { get; set; }

    public int IdCustomer { get; set; }

    public string Status { get; set; } = null!;

    public double Amount { get; set; }
    [JsonIgnore]
    public virtual Customer IdCustomerNavigation { get; set; } = null!;
    [JsonIgnore]
    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
