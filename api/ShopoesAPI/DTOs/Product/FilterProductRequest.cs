namespace ShopoesAPI.DTOs.Product
{
    public class FilterProductRequest
    {
        public int? idBrand { get; set; }
        public int? idCategory { get; set; }
        public string? searchString { get; set; }
    }
}
