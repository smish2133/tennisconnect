part of tennisconnect;

class TipsPage extends StatelessWidget {
  final List<String> videoUrls = [
    // Add your tennis video URLs here
    'https://www.youtube.com/watch?v=CRLKCqcXDOY',
    'https://www.youtube.com/watch?v=YqgcykDGB2A',
    'https://www.youtube.com/watch?v=foD2mMKl7xs',
    'https://www.youtube.com/watch?v=05Ueg1vsMeM',
    'https://www.youtube.com/watch?v=gWB_7BR458E',
    'https://www.youtube.com/watch?v=c5SqRb9i020',
    'https://www.youtube.com/watch?v=AX9nYKiUK4A',
    'https://www.youtube.com/watch?v=hLNezzhMK7E',
    'https://www.youtube.com/watch?v=6998O764rKU',
    'https://www.youtube.com/watch?v=gT6g4QjDLBg',
    'https://www.youtube.com/watch?v=Aib4RgynvcE',
    'https://www.youtube.com/watch?v=qfMVnQ07pcI',
    'https://www.youtube.com/watch?v=e--YUi86EZw',
    'https://www.youtube.com/watch?v=Ggwb3C46CsA',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tennis Tips'),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                icon: Icon(Icons.home),
              ),
            ),
            SizedBox(
              width: 200,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/addactivity');
                },
                icon: Icon(Icons.add_circle),
              ),
            ),
            SizedBox(
              width: 200,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                icon: Icon(Icons.person),
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: videoUrls.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.play_arrow),
                title: Text('Tennis Tip ${index + 1}'),
                onTap: () {
                  // Navigate to a video player screen passing the video URL
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VideoPlayerPage(videoUrl: videoUrls[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Video Player'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Image.network(
            'http://localhost:3001/youtube-thumbnail?videoId=${_controller.initialVideoId}',
            height: 200, // Adjust the height as needed
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: const Color.fromARGB(255, 65, 72, 84),
            progressColors: const ProgressBarColors(
              playedColor: Colors.blueAccent,
              handleColor: Colors.blueAccent,
            ),
            onReady: () {
              _controller.play();
            },
          )
        ]));
  }
}
