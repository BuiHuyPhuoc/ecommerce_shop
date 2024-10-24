using System;
using System.Collections.Generic;

namespace ShopoesAPI.Models;

public partial class Order
{
    public int Id { get; set; }

    public DateTime Date { get; set; }

    public int IdCustomer { get; set; }

    public string Status { get; set; } = null!;

    public double Amount { get; set; }

    public virtual Customer IdCustomerNavigation { get; set; } = null!;

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
