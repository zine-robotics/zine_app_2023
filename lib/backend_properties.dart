class BackendProperties {
  static Uri baseUrl = Uri(
      scheme: 'http',
      host: 'ec2-18-116-38-241.us-east-2.compute.amazonaws.com');
  // host: '172.20.10.4',
  // port: 8080,
  // );

  static Uri resetUri = baseUrl.replace(path: '/auth/forgot');
  static Uri loginUri = baseUrl.replace(path: '/auth/login');
  static Uri userInfoUri = baseUrl.replace(path: '/auth/me');
  static Uri registerUri = baseUrl.replace(path: '/auth/register');

  static Uri roomDataUri(String email) =>
      baseUrl.replace(path: '/rooms/user', queryParameters: {'email': email});

  static Uri allRoomDataUri = baseUrl.replace(path: '/rooms/get-all');
  static Uri roomMessageUri(String tempRoomId) => baseUrl.replace(
      path: 'messages/roomMsg', queryParameters: {'roomId': tempRoomId});

  static Uri allTasksUri = baseUrl.replace(path: '/tasks');
  static Uri taskByIdUri = baseUrl.replace(path: '/tasks/user');
  static Uri taskDetailUri(String taskId) =>
      baseUrl.replace(path: '/tasks/$taskId');

  static Uri eventsUri = baseUrl.replace(path: '/event');
  static Uri websocketUri = baseUrl.replace(path: '/ws');
  static Uri lastSeenUri(String emailId, String roomId) =>
      baseUrl.replace(path: '/user/$emailId/$roomId/last-seen');

  static Uri activeMemberUri = baseUrl.replace(path: '/members/get');

  static Uri updateLastSeenUri(String emailId, String roomId) {
    return baseUrl.replace(path: '/user/$emailId/$roomId/seen');
  }

  static Uri announcementUri(String emailId) => baseUrl
      .replace(path: 'rooms/announcement', queryParameters: {'email': emailId});
}
