import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int seconds = 0, minutes = 0, hours = 0;
  String stringSeconds = '00', stringMinutes = '00', stringHours = '00';
  Timer? timer;
  bool isRunning = false;
  List laps = [];

  void stop() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void reset() {
    stop();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      stringSeconds = '00';
      stringMinutes = '00';
      stringHours = '00';
      laps = [];
    });
  }

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
        if (seconds == 60) {
          seconds = 0;
          minutes++;
          if (minutes == 60) {
            minutes = 0;
            hours++;
          }
        }
        stringSeconds = seconds.toString().padLeft(2, '0');
        stringMinutes = minutes.toString().padLeft(2, '0');
        stringHours = hours.toString().padLeft(2, '0');
      });
    });
    setState(() {
      isRunning = true;
    });
  }

  void addLap() {
    setState(() {
      laps.add('$stringHours:$stringMinutes:$stringSeconds');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stopwatch',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.onBackground,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$stringHours:$stringMinutes:$stringSeconds',
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: laps.isEmpty
                      ? Center(
                          child: Image.asset(
                            'assets/images/empty_list.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : ListView.builder(
                          itemCount: laps.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: ListTile(
                                leading: Text(
                                  '${index + 1}.',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                title: Text(
                                  laps[index],
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        addLap();
                      },
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: const Icon(
                        Icons.flag,
                        color: Colors.black,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (isRunning) {
                          stop();
                        } else {
                          start();
                        }
                      },
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: isRunning
                          ? const Icon(
                              Icons.pause,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        reset();
                      },
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: const Icon(
                        Icons.restart_alt,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
