import 'package:flutter/widgets.dart';

import '../widgets/design/button.dart';
import '../widgets/design/pageLayout.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => PageLayout(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Button(
                  onPressed: () => Navigator.of(context).pushNamed('/game/'),
                  child: Text('New game'),
                ),
                Button(
                  // onPressed: () => Navigator.of(context).pushNamed('/game_setup/'),
                  child: Text('Join game'),
                ),
              ],
            ),
          ),
        ),
      );
}
