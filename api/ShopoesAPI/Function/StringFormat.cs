using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

namespace ShopoesAPI.Function
{
    public class StringFormat
    {
        public static bool IsValidEmail(string email)
        {
            var trimmedEmail = email.Trim();

            if (trimmedEmail.EndsWith("."))
            {
                return false;
            }
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == trimmedEmail;
            }
            catch
            {
                return false;
            }
        }
        public static bool IsDigitsOnly(string str)
        {
            foreach (char c in str)
            {
                if (c < '0' || c > '9')
                    return false;
            }

            return true;
        }
        public static string RemoveDiacritics(string text)
        {
            var normalizedString = text.Normalize(NormalizationForm.FormD);
            var stringBuilder = new StringBuilder();

            foreach (var c in normalizedString)
            {
                var unicodeCategory = CharUnicodeInfo.GetUnicodeCategory(c);
                if (unicodeCategory != UnicodeCategory.NonSpacingMark)
                {
                    stringBuilder.Append(c);
                }
            }

            return stringBuilder.ToString().Normalize(NormalizationForm.FormC);
        }
        public static string GeneratePasswordString(int length)
        {
            // Định nghĩa các tập hợp ký tự
            const string lowercase = "abcdefghijklmnopqrstuvwxyz";
            const string uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            const string specialChars = "!@#$%^&*()_-+=<>?.";

            // Kết hợp tất cả các ký tự
            string allChars = lowercase + uppercase + specialChars;

            // Sử dụng StringBuilder để xây dựng chuỗi
            StringBuilder result = new StringBuilder(length);
            Random random = new Random();

            // Đảm bảo có ít nhất một ký tự từ mỗi tập hợp
            result.Append(lowercase[random.Next(lowercase.Length)]);
            result.Append(uppercase[random.Next(uppercase.Length)]);
            result.Append(specialChars[random.Next(specialChars.Length)]);

            // Tạo các ký tự ngẫu nhiên còn lại
            for (int i = 3; i < length; i++)
            {
                result.Append(allChars[random.Next(allChars.Length)]);
            }

            // Trộn chuỗi để đảm bảo ngẫu nhiên
            return ShuffleString(result.ToString());
        }

        private static string ShuffleString(string str)
        {
            Random random = new Random();
            char[] array = str.ToCharArray();
            for (int i = array.Length - 1; i > 0; i--)
            {
                int j = random.Next(i + 1);
                // Hoán đổi
                char temp = array[i];
                array[i] = array[j];
                array[j] = temp;
            }
            return new string(array);
        }

    }

    public interface IPasswordValidator
    {
        string Validate(string password);
    }

    public class PasswordValidation
    {
        private readonly List<IPasswordValidator> _validators = new List<IPasswordValidator>();

        public void AddValidator(IPasswordValidator validator)
        {
            _validators.Add(validator);
        }

        public string ValidatePassword(string password)
        {
            StringBuilder stringBuilder = new StringBuilder();
            foreach (var validator in _validators)
            {
                string result = validator.Validate(password);
                if (!string.IsNullOrEmpty(result))
                {
                    stringBuilder.Append(result);
                }
            }
            return stringBuilder.ToString();
        }
    }

    public class Length8Validator : IPasswordValidator
    {
        public string Validate(string password)
        {
            return (password.Length >= 8) ? "" : "Mật khẩu phải trên 8 kí tự.\n";
        }
    }

    public class UppercaseValidator : IPasswordValidator
    {
        public string Validate(string password)
        {
            return password.Any(char.IsUpper) ? "" : "Mật khẩu phải có chữ in hoa \n";
        }
    }

    public class LowercaseValidator : IPasswordValidator
    {
        public string Validate(string password)
        {
            return password.Any(char.IsLower) ? "" : "Mật khẩu phải có chữ thường \n";
        }
    }

    public class NumberValidator : IPasswordValidator
    {
        public string Validate(string password)
        {
            return password.Any(char.IsDigit) ? "" : "Mật khẩu phải có kí tự số \n";
        }
    }

    public class SpecialCharacterValidator : IPasswordValidator
    {
        public string Validate(string password)
        {
            Regex regex = new Regex("[~`!@#$%^&*()\\-_=+\\\\|\\[{\\]};:'\",<.>/?]");
            return regex.IsMatch(password) ? "" : "Mật khẩu phải có kí tự đặc biệt\n";
        }
    }




}
