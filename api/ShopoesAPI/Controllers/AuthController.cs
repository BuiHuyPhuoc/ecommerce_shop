using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using ShopoesAPI.DTOs;
using ShopoesAPI.Function;
using ShopoesAPI.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
namespace ShopoesAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly ShopoesDbContext _context;
        private readonly IConfiguration _configuration;
        private readonly IEmailSender _emailSender;

        public AuthController(ShopoesDbContext context, IConfiguration configuration, IEmailSender emailSender)
        {
            _context = context;
            _configuration = configuration;
            _emailSender = emailSender;
        }

        [HttpPost("TestSendEmail")]
        public async Task<ActionResult> TestSendEmail()
        {
            try
            {
                await _emailSender.SendEmailAsync("dfzdfh@gmail.com", "Test send email", "Test send email lorem input");
                return Ok("Email sent");
            }
            catch (Exception e)
            {
                return BadRequest($"Email sent failed \n {e.Message}");
            }
        }

        // API đăng ký tài khoản
        [HttpPost("Register")]
        public async Task<ActionResult<string>> Register(CustomerRegisterDTO customerDTO)
        {
            if (customerDTO == null)
            {
                return BadRequest("Customer is invalid");
            }
            else
            {
                if (string.IsNullOrEmpty(customerDTO.Name)
                    || string.IsNullOrEmpty(customerDTO.Email)
                    || string.IsNullOrEmpty(customerDTO.Password)
                    || string.IsNullOrEmpty(customerDTO.ConfirmPassword)
                    || string.IsNullOrEmpty(customerDTO.Phone))
                {
                    return BadRequest("Missing information.");
                }
                var dbAccount = await _context.Accounts.Where(x => x.Email == customerDTO.Email).FirstOrDefaultAsync();
                // Kiểm tra email đã tồn tại chưa
                if (dbAccount is not null)
                {
                    return BadRequest("Email is used");
                }
                else
                {
                    string password = customerDTO.Password;
                    //Regex regex = new Regex("[~`!@#$%^&*()\\-_=+\\\\|\\[{\\]};:'\",<.>/?]");
                    
                    // Kiểm tra format số điện thoại
                    if (!StringFormat.IsDigitsOnly(customerDTO.Phone))
                    {
                        return BadRequest("Phone number has only number please.");
                    }

                    if (customerDTO.Phone.Length < 10)
                    {
                        return BadRequest("Phone number is too short");
                    }
                    // Kiểm tra format email
                    if (!StringFormat.IsValidEmail(customerDTO.Email))
                    {
                        return BadRequest("Email is incorrect format.");
                    }
                    // Kiểm tra format mật khẩu
                    if (!ValidatePassword(password))
                    {
                        return BadRequest("Password is not in correct format.");
                    }
                    
                    if (customerDTO.Password != customerDTO.ConfirmPassword)
                    {
                        return BadRequest("Incorrect confirm password");
                    }

                    // Gửi email xác nhận
                    string registerToken = CreateRandomToken();
                    await SendVerifiedAccountEmail(registerToken, customerDTO.Email);

                    Customer newCustomer = new Customer
                    {
                        Name = customerDTO.Name,
                        Phone = customerDTO.Phone,
                        IdRole = 1,
                        // Default avatar image
                        AvatarImageUrl = "https://firebasestorage.googleapis.com/v0/b/shopoes-2e0b8.appspot.com/o/avatar%2Favatar_test.png?alt=media&token=4ccfc92e-db73-49de-98bd-526bde1677fb"
                    };
                    await _context.Customers.AddAsync(newCustomer);
                    await _context.SaveChangesAsync();
                    // Create password Hash
                    CreatePasswordHash(password, out byte[] passwordHash, out byte[] passwordSalt);
                    Account newAccount = new Account
                    {
                        Email = customerDTO.Email,
                        PasswordHash = passwordHash,
                        PasswordSalt = passwordSalt,
                        VerificationToken = registerToken,
                        IdCustomer = newCustomer.Id
                    };
                    // Lưu dữ liệu
                    await _context.Accounts.AddAsync(newAccount);
                    await _context.SaveChangesAsync();
                    return Ok("Create account success");
                }
            }
        }

        [HttpPost("SendNewVerifyEmail")]
        public async Task<IActionResult> SendNewVerifyEmail(string email)
        {
            var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.Email == email);
            if (dbAccount == null || dbAccount.VerificationToken == null)
            {
                return BadRequest("Invalid account");
            }
            if (dbAccount.VerifiedAt != null)
            {
                return BadRequest("Acocunt was verified");
            }
            string newRegisterToken = CreateRandomToken();
            dbAccount.VerificationToken = newRegisterToken;
            await _context.SaveChangesAsync();
            await SendVerifiedAccountEmail(newRegisterToken, dbAccount.Email);
            return Ok();
        }


        // Hàm gửi gmail xác nhận tài khoản
        private async Task SendVerifiedAccountEmail(string registerToken, string email)
        {
            string subject = "Verify account";
            var verifyEmailAction = $"https://localhost:7277/api/Auth/VerifyEmail?token={registerToken}";
            await _emailSender.SendEmailAsync(email, subject, verifyEmailAction);
        }

        private async Task SendForgotPasswordToken(string resetToken, string email)
        {
            string subject = "Forgot password";
            var resetLink = Url.Action("ResetPassword", "Auth", new { token = resetToken }, Request.Scheme);

            await _emailSender.SendEmailAsync(email, subject, resetLink!);
        }
        // API đăng nhập
        [HttpPost("Login")]
        public async Task<ActionResult> Login(UserLoginRequest loginRequest)
        {
            if (loginRequest == null)
            {
                return BadRequest();
            }

            if (string.IsNullOrEmpty(loginRequest.Email) || string.IsNullOrEmpty(loginRequest.Password)) {
                return BadRequest("Please input field");
            }
            var dbAccount = await _context.Accounts.Include(x => x.IdNavigation).Where(x => x.Email == loginRequest.Email).FirstOrDefaultAsync();
            if (dbAccount is null)
            {
                return BadRequest("User not found.");
            }
            else
            {
                if (dbAccount.VerifiedAt == null)
                {
                    return BadRequest("Not verified yet.");
                }
                if (!VerifyPasswordHash(loginRequest.Password, dbAccount.PasswordHash, dbAccount.PasswordSalt))
                {
                    return BadRequest("Password is incorrect");
                }

                //var dbCustomer = await _context.Customers.FindAsync(dbAccount.IdCustomer);
                var dbRefreshToken = await _context.RefreshTokens.FirstOrDefaultAsync(x => x.AccountId == dbAccount.Id);
                string jwtToken = CreateToken(dbAccount.IdNavigation, dbAccount.Email);
                var refreshToken = GenerateRefreshToken();
                if (dbRefreshToken == null)
                {
                    refreshToken.AccountId = dbAccount.Id;
                    _context.RefreshTokens.Add(refreshToken);
                }
                else
                {
                    dbRefreshToken.Token = refreshToken.Token;
                    dbRefreshToken.Expires = refreshToken.Expires;
                    dbRefreshToken.Created = refreshToken.Created;
                    dbRefreshToken.Revoked = refreshToken.Revoked;
                }
                await _context.SaveChangesAsync();
                // Trả về token khi đăng nhập thành công
                return Ok(new
                {
                    Token = jwtToken,
                    RefreshToken = refreshToken.Token
                });
            }
        }

        // API xác nhận email khi đăng kí lần đầu
        [HttpGet]
        [Route("VerifyEmail")]
        public async Task<IActionResult> VerifyEmail(string token)
        {
            var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.VerificationToken == token);
            if (dbAccount == null)
            {
                return BadRequest("Invalid token.");
            }
            else
            {
                dbAccount.VerifiedAt = DateTime.Now;
                await _context.SaveChangesAsync();
                return Ok("User Verified!");
            }
        }

        // Api đổi mật khẩu có sử dụng jwt token
        [HttpPost("ChangePassword")]
        [Authorize]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
        {
            var emailClaim = User.FindFirst(ClaimTypes.Email)?.Value;

            var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.Email == emailClaim);
            if (dbAccount == null)
            {
                return BadRequest("User not found");
            }

            // Kiểm tra mật khẩu hiện tại
            var passwordCheck = VerifyPasswordHash(request.CurrentPassword, dbAccount.PasswordHash, dbAccount.PasswordSalt);
            if (!passwordCheck)
            {
                return BadRequest("Current password is incorrect");
            }

            if (!ValidatePassword(request.NewPassword))
            {
                return BadRequest("Wrong format password");
            }
            else
            {
                CreatePasswordHash(request.NewPassword, out byte[] passwordHash, out byte[] passwordSalt);
                dbAccount.PasswordHash = passwordHash;
                dbAccount.PasswordSalt = passwordSalt;
                await _context.SaveChangesAsync();
                return Ok("Update password success");
            }
        }

        // API gửi mật khẩu mới vô gmail
        [HttpPost("ForgotPassword")]
        public async Task<IActionResult> ForgotPassword(string email)
        {
            var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.Email == email);

            if (dbAccount == null)
            {
                return BadRequest("User not found");
            }
            string newPassword = StringFormat.GeneratePasswordString(8);
            CreatePasswordHash(newPassword, out byte[] passwordHash, out byte[] passwordSalt);
            dbAccount.PasswordHash = passwordHash;
            dbAccount.PasswordSalt = passwordSalt;
            await _context.SaveChangesAsync();
            await _emailSender.SendEmailAsync(email, "New password", newPassword);
            return Ok("Your new password was sent to your email");
        }

        [HttpPost("ResetPassword")]
        public async Task<IActionResult> ResetPassword(ResetPasswordRequest request)
        {
            var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.PasswordResetToken == request.Token);

            if (dbAccount == null || dbAccount.ResetTokenExpires < DateTime.Now)
            {
                return BadRequest("token invalid");
            }

            CreatePasswordHash(request.Password, out byte[] passwordHash, out byte[] passwordSalt);
            dbAccount.PasswordHash = passwordHash;
            dbAccount.PasswordSalt = passwordSalt;
            dbAccount.PasswordResetToken = null;
            dbAccount.ResetTokenExpires = null;
            await _context.SaveChangesAsync();

            return Ok("Change password success");
        }

        // API nhận yêu cầu một token mới
        [HttpPost("RefreshToken")]
        public async Task<IActionResult> RefreshToken([FromBody] string refreshToken)
        {
            var dbRefreshToken = await _context.RefreshTokens.Include(x => x.Account.IdNavigation).FirstOrDefaultAsync(x => x.Token == refreshToken);
            if (dbRefreshToken == null)
            {
                return BadRequest("Invalid Refresh Token.");
            } else
            {
                if (dbRefreshToken.Expires < DateTime.Now || !(dbRefreshToken.Revoked == null))
                {
                    //dbRefreshToken.Revoked = DateTime.Now;
                    //await _context.SaveChangesAsync();
                    return BadRequest("Refresh token is expired");
                }
                var newJwtToken = CreateToken(dbRefreshToken.Account.IdNavigation, dbRefreshToken.Account.Email);
                //var newRefreshToken = GenerateRefreshToken();
                return Ok(new { Token = newJwtToken});
            }
        }

        [HttpPost("DeleteCustomer")]
        public async Task<IActionResult> DeleteCustomer(string email)
        {
            var dbAccount = await _context.Accounts.FirstOrDefaultAsync(x => x.Email == email);
            
            if (dbAccount == null) return BadRequest("Invalid customer email");
            var dbCustomer = _context.Customers.Find(dbAccount.IdCustomer);
            if (dbCustomer == null) return BadRequest("Invalid customer email");
            _context.Remove(dbAccount);
            _context.Remove(dbCustomer);
            await _context.SaveChangesAsync();
            return Ok();
        }

        // Các hàm khởi tạo token và gửi gmail
        private string CreateRandomToken()
        {
            return Convert.ToHexString(RandomNumberGenerator.GetBytes(64));
        }

        private bool VerifyPasswordHash(string password, byte[] passwordHash, byte[] passwordSalt)
        {
            using (var hmac = new HMACSHA512(passwordSalt))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return computedHash.SequenceEqual(passwordHash);
            }
        }

        private string CreateToken(Customer customer, string email)
        {
            List<Claim> claims = new List<Claim>
            {
                new Claim(ClaimTypes.Role, customer.IdRole.ToString()),
                new Claim(ClaimTypes.Name, customer.Name),
                new Claim(ClaimTypes.Email, email)
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]!));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                _configuration["Jwt:Issuer"],
                _configuration["Jwt:Audience"],
                claims,
                expires: DateTime.Now.AddMinutes(Convert.ToDouble(_configuration["Jwt:Expires"])),
                signingCredentials: creds);
            var jwt = new JwtSecurityTokenHandler().WriteToken(token);
            return jwt;
        }

        private RefreshToken GenerateRefreshToken()
        {
            var refreshToken = new RefreshToken
            {
                Token = Convert.ToBase64String(RandomNumberGenerator.GetBytes(64)), // Random một chuỗi
                Expires = DateTime.UtcNow.AddDays(1), // Refresh token hết hạn sau 1 ngày
                Created = DateTime.UtcNow
            };

            return refreshToken;
        }

        private async Task SaveRefreshToken(Account account, RefreshToken refreshToken)
        {
            account.RefreshToken = refreshToken;
            _context.Update(account);
            await _context.SaveChangesAsync();
        }

        private void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            using (var hmac = new HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            }
        }

        private bool ValidatePassword(string password)
        {
            Regex regex = new Regex("[~`!@#$%^&*()\\-_=+\\\\|\\[{\\]};:'\",<.>/?]");
            if (!(password.Length >= 8 && password.Any(char.IsUpper) && password.Any(char.IsLower) && password.Any(char.IsDigit) && regex.IsMatch(password)))
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }
}
