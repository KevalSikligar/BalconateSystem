namespace Balcony.Miracle.Web.Models
{
    public class ChangesWrapper<T>
    {
        public T[] Changed { get; set; }
        public T[] Added { get; set; }
        public T[] Removed { get; set; }
    }
}