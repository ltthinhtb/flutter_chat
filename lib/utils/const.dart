class Const {
  static const String HOST_URL = "http://118.71.224.167:8602/";
  static const String URL_WEBSITE_DEV = "https://www.ninasoft.com.vn/";

//  static const String HOST_URL = "https://fasgroup.com.vn/";

  static const String HOST_GOOGLE_MAP_URL =
      "https://maps.googleapis.com/maps/api/";
  static const String ANDROID_KEY = "AIzaSyAVRrZKBfIphjlPiua9y5Pk4CJ3oaddGp0";
  static const String IOS_KEY = "AIzaSyB6P1Tq9lnnZPjkUJmAlTjUE1uqMVfTLFA";
  static const String PLACE_KEY = "AIzaSyC7tPpmwviNXdX0_krWw5QdxOVGOJgdFmo";
  static const String GIF_KEY = "ekRNTXrW1XngwAJyHhBim8d2gcBepCE7";
  static const String FCM_KEY =
      "AAAAzbpksz8:APA91bEbx3H_xMk41BoZz-bjnpsHJbW7b7aznqlNjIbnTwIv7GY35PE05AR3pnpYosAf3c3Swee_Td3bwmMGgJUbYkCrqqDKadi5rSPs71qsuJvjRnHHCILa_rZmV_gBPo5rVJi4WhkZ";

  static const String ID = "id";
  static const String CODE = "Code";
  static const String NAME = "name";
  static const String FULL_NAME = "Full Name";
  static const String LAST_NAME = "Last Name";
  static const String ADDRESS = "Address";
  static const String CITY = "City";
  static const String DISTRICT = "District";
  static const String STATE = "State";
  static const String EMAIL = "Email";
  static const String AVATAR = "Avatar";
  static const String JOB_TITLE = "JOB title";
  static const String INTRODUCE = "INTRODUCE";
  static const String URL = "Url";
  static const String REFRESH = "Refresh";
  static const String EDIT = "edit";
  static const String REFRESH_TOKEN = "Refresh Token Authorization";
  static const String TOKEN = "Token Authorization";
  static const String PHONE = "Phone";
  static const String CITY_ID = "City ID";
  static const String USER_ID = "deviceToken";
  static const String USERS = "users";
  static const String MESSAGES = "messages";
  static const String DEVICE_TOKEN = "Device Token";
  static const String LOCALE = "LOCALE";
  static const String DATE_TIME_FORMAT = "dd/MM/yyyy HH:mm";
  static const String SEND_TIME = "dd/MM/yyyy HH:mm:s";
  static const String DATE_TIME_DAY = "dd/MM/yyyy HH:mm";
  static const String DATE_TIME_SV_FORMAT = "d MMM, yyyy";
  static const String DATE_TIME_CREATE_SV_FORMAT = "yyyy-MM-dd HH:mm:ss";
  static const String DATE_REQUEST_FORMAT = "MM-dd-yyyy";
  static const String DATE_FORMAT = "dd/MM/yyyy";
  static const String DATE_FORMAT_TASK = "yyyy-MM-dd";
  static const String DATE_FORMAT_FULL = "E, dd/MM/yyyy";
  static const String DATE_DAY = "E, dd";
  static const String DATE_MONTH = "EEEE, dd LLLL";
  static const String DATE = "EEE";
  static const String DAY = "dd";
  static const String YEAR = "yyyy";
  static const String HOUR_MIN = "hh:mm";
  static const String TIME = "hh:mm aa";
  static const String TIME_ONLY = "hh aa";

  static const int TYPE_WEB = 0;
  static const int TYPE_EMAIL = 1;
  static const int TYPE_PHONE = 2;
  static const int TYPE_SMS = 3;

  static const int SPLASH_SCREEN = 0;
  static const int AUTHENTICATION_SCREEN = 1;
  static const int LOGIN_SCREEN = 2;
  static const int SIGN_UP_SCREEN = 3;
  static const int MAIN_SCREEN = 3;

  static const String EN = "en";
  static const String VI = "vi";

  static const String STUDENT_ID = 'Student ID';

  static const String MALE = 'male';
  static const String FEMALE = 'female';
  static const List<String> GENDER = [MALE, FEMALE];

  static const String VIETNAM = 'Việt Nam';
  static const String HANOI = 'Hà Nội';

  static const String PARENT = 'parent';
  static const String GUARDIAN = 'guardian';

  static const String USER = "user";
  static const String PAYMENT = "payment";
  static const String USER_KEY_PREFIX = "USER:";
  static const String PASSWORD_SECRET = "parentportal";
  static const double DESIGN_WIDTH = 481;
  static const double DESIGN_HEIGHT = 986;
  static const int limit = 20;
  static const int limitIncrement = 20;
  static const String CASH = "cash";

  static const String CANCEL = "cancel";
  static const String PAID = "paid";
  static const String UNPAID = "unpaid";
  static const String REVIEW = "review";
  static const String OVERDUE = "overdue";
  static const String DRAFT = "draft";

  static const int MAX_COUNT_ITEM = 15;

  static const String CATEGORY_1 = "Dịch vụ Sửa Chữa";
  static const String CATEGORY_2 = "Dịch vụ Lau Dọn";

  static const String SUB_CATEGORY_1 = "Sửa bếp gas";
  static const String SUB_CATEGORY_2 = "Sửa ống nước";
  static const String SUB_CATEGORY_3 = "Sửa điều hoà";
  static const String SUB_CATEGORY_4 = "Lau dọn 2 phòng";
  static const String SUB_CATEGORY_5 = "Lau dọn 3 phòng";
  static const String SUB_CATEGORY_6 = "Lau dọn phòng vệ sinh";
  static const String SUB_CATEGORY_7 = "Khác";

  static const String STATUS_PENDING = "pending";
  static const String STATUS_NOT_ORDER = "not_order";
  static const String STATUS_ORDERED = "ordered";
  static const String STATUS_SUBMITTED = "submitted";
  static const String STATUS_WAITING = "wait_confirm";
  static const String STATUS_CONFIRMED = "confirmed";
  static const String STATUS_STARTING = "starting";
  static const String STATUS_PROCESSING = "processing";
  static const String STATUS_COMPLETED = "completed";
  static const String STATUS_CANCELLED = "canceled";
  static const String STATUS_APPROVE = "approve";

  static const int HOME = 0;
  static const int MY_ORDER = 1;
  static const int CHAT = 3;

//  static const int NOTIFICATION = 3;
  static const int SETTING = 4;
  static const int APPOINTMENT = 2;

  static const String MESSAGE_TYPE = "message";
  static const String IMAGE_TYPE = "image";
  static const String STICKER_TYPE = "sticker";
  static const String TYPE = "type";
  static const String GIF_TYPE = "gif";
  static const String EMOJI_TYPE = "emoji";
  static const String LIST_IMAGE_TYPE = "list_image_type";

  static const int CASE_STATUS_WAIT = 0;
  static const int CASE_STATUS_PROCESS = 1;
  static const int CASE_STATUS_DONE = 2;
  static const String FONT = "Comfortaa";

  static const String PAYMENT_PAID = "paid";
  static const String PAYMENT_NOT_PAID = "not_paid";

  static const int CROSS_COUNT_TWO = 2;

  static const double RATIO = 1.4;

  static const String PRODUCT = "Product";
  static const String DISCOUNT = "Discount";

  static const String DENTAL = "Dental mobile";
  static const String COMPANY_PHONE_NUMBER = "(0247) 303 5959";
  static const String COMPANY_EMAIL = "dichvufas@gmail.com";

  static const String CONTENT = "content";
  static const String USER_OWNER = "user_owner";
  static const String DateTIME = "date";
  static const String IMAGE_OWNER = "image_owner";
  static const String LIST_IMAGE = "list_image";

  static const String serverToken = '<Server-Token>';
}
