import 'package:flutter/material.dart';
import 'package:navigation_demo/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      //clipbehavior = karena stack menghiraukan shape parentnya. card bisa force cut excess child dengan properti clipbehavior
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              //fit = wrapping imagenya, cover agar di zoom menyesuaikan ukuran
              //fadeinimage = buat efek fadein pas render build
              //MemImage = image dari memori (pub transparent image)
              // Networkimage = image dari url
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      //maxlines = maksimal baris, otherwise akan di cut textnya oleh overflow
                      //overflow = determine bagaimana text yg diluar max akan di cut
                      //softwrap = biar bagus dan rata
                    ),
                    const SizedBox(height: 4),
                    Text('[data]'),
                  ],
                ),
              ),
              //positioned dipake untuk memposisikan children nya stack
            ),
          ],
        ),
      ),
    );
  }
}
