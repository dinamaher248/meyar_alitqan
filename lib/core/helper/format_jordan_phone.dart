String formatJordanPhone(String phone) {
  phone = phone.trim().replaceAll(' ', '');

  if (phone.startsWith('+')) return phone;
  if (phone.startsWith('0')) {
    return '+962${phone.substring(1)}';
  }

  return '+962$phone';
}
