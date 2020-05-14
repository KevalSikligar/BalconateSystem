using Newtonsoft.Json;

namespace Balcony.Miracle.Web.Models {

    public class UserNameModel {
        
        [JsonProperty]
        public string UserId;
        
        [JsonProperty]
        public string CustomerId;
    }
}