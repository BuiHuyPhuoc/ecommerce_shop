namespace ShopoesAPI.DTOs.Review
{
    public class PostReviewRequest
    {
        public int IdProduct { get; set; }

        public int Rating { get; set; }

        public string Content { get; set; } = null!;
    }
}
