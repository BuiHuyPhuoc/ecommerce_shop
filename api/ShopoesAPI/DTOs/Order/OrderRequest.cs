﻿using ShopoesAPI.Models;

namespace ShopoesAPI.DTOs.Order
{
    public class OrderRequest
    {
        public List<int> IdCarts { get; set; }
        public string Status { get; set; }
        public int IdAddress { get; set; }

    }
}