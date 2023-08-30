import 'package:flutter/material.dart';
import 'package:tugas3/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const CircleAvatar(
              foregroundImage: AssetImage("images/profile.jpg"),
              radius: 60,
            ),
            const SizedBox(height: 20,),
            Text(userSession.name, style: const TextStyle(color: Colors.white, fontSize: 20),),
            const SizedBox(height: 10,),
            Text(userSession.email, style: const TextStyle(color: Colors.white, fontSize: 20),),
            const SizedBox(height: 10,),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 1),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                },
                child: const Text('Log Out'),
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
