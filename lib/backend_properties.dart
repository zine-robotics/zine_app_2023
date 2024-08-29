class BackendProperties {
  static Uri baseUrl = Uri(
      scheme: 'http',
      host: 'ec2-18-116-38-241.us-east-2.compute.amazonaws.com');

  static Uri resetUri = baseUrl.replace(path: '/auth/forgot');
  static Uri loginUri = baseUrl.replace(path: '/auth/login');
  static Uri userInfoUri = baseUrl.replace(path: '/auth/me');
  static Uri registerUri = baseUrl.replace(path: '/auth/register');

  static Uri roomDataUri = baseUrl.replace(path: '/rooms/user');
  static Uri allRoomDataUri = baseUrl.replace(path: '/rooms/get-all');

  static Uri allTasksUri = baseUrl.replace(path: '/tasks');
  static Uri taskDetailUri(String taskId) {
    return baseUrl.replace(path: '/tasks/$taskId');
  }
}
