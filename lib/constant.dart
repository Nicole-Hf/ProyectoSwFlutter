
const baseUrl = /*'https://mainbusesgi.herokuapp.com/api/';*/ 
/*"http://127.0.0.1:8000/api/";*/ "http://10.0.2.2:8000/api/";
const loginUrl = '${baseUrl}login';
const registerUrl = '${baseUrl}register';
const logoutUrl = '${baseUrl}logout';
const userUrl = '${baseUrl}user';

const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Somethin went wrong, try again';
const Map<String, String> headers = {"Accept": "application/json"};