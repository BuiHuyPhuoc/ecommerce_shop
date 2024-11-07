using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace ShopoesAPI.Models;

public partial class Order
{
    public int Id { get; set; }

    public DateTime Date { get; set; }

    public int IdCustomer { get; set; }

    public int IdAddress { get; set; }

    public string Status { get; set; } = null!;

    public decimal Amount { get; set; }

    public virtual Address IdAddressNavigation { get; set; } = null!;

    [JsonIgnore]
    public virtual Customer IdCustomerNavigation { get; set; } = null!;

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
