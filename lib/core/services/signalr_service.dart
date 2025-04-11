// import 'package:civix_app/core/constants/api_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:signalr_netcore/signalr_client.dart';

// class SignalRService {
//   HubConnection? _hubConnection;

//   // Connect to the SignalR Hub

//   Future<void> connectToHub() async {
//     const serverUrl = "${ApiConstants.baseUrl}/notificationHub";
//     const token =
//         "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjhmZTg1NDdiLTA5NWQtNGRmOS1hNzIzLWZkODQyN2M4MDhlMiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2dpdmVubmFtZSI6ImlzbGFtIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiYm9zc2lzbGFtNTVAZ21haWwuY29tIiwicm9sZXMiOlsiVXNlciJdLCJwZXJtaXNzaW9ucyI6W10sImV4cCI6MTc0NDQxMjkzOCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MjUyIiwiYXVkIjoiTXlTZWN1cmVLZXkifQ.t68y_ED60wL7BgKQ1UyfzLs09T0kEkYs3A7kR8v6xaA";
//     // Replace the URL with your SignalR Hub URL
//     final hubConnection = HubConnectionBuilder()
//         .withUrl(
//           serverUrl,
//           options: HttpConnectionOptions(
//             accessTokenFactory: () async => token,
//           ),
//         )
//         .build();

//     _hubConnection = hubConnection;

//     // Set up receiving the message
//     hubConnection.on('ReceiveNotification', (data) {
//       String message = data![0] as String;
//       print("Received Notification: $message");
//     });
//     // Start the connection
//     try {
//       await hubConnection.start();
//       print("Connected to SignalR");
//     } catch (e) {
//       print("Error connecting to SignalR: $e");
//     }
//   }

//   // Handler for receiving notifications
//   void _onReceiveNotification(List<Object> args) {
//     // args[0] will be the message sent from the server
//     String message = args[0] as String;
//     print("Received Notification: $message");
//   }

//   // Disconnect from the hub
//   Future<void> disconnectFromHub() async {
//     await _hubConnection?.stop();
//     print("Disconnected from SignalR");
//   }
// }
