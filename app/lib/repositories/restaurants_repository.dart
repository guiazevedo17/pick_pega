import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class RestaurantsRepository extends ChangeNotifier {
  final List<Restaurant> _restaurants = [
    // Restaurant(
    //   name: 'Poco Loco',
    //   address:
    //       'Av. Profa. Ana Maria Silvestre Adade, 255-395 - Parque das Universidades, Campinas - SP',
    //   picture:
    //       'https://www.google.com/url?sa=i&url=https%3A%2F%2Frestaurantguru.com.br%2FPocoloco-bar-Campinas&psig=AOvVaw2atpjPQNt0-vD6xR4HiNU3&ust=1695601936343000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCMD6ssr_wYEDFQAAAAAdAAAAABAE',
    //   latitude: -22.83507567555765,
    //   longitude: -47.0533037397943,
    // ),
    // Restaurant(
    //   name: 'Otro',
    //   address: 'Av. João Mendes Júnior, 104 - Cambuí, Campinas - SP',
    //   picture:
    //       'https://www.google.com/imgres?imgurl=https%3A%2F%2Fotrobar.com.br%2Fwp-content%2Fuploads%2F2023%2F03%2Fotro_bar_campinas-1-1024x684.jpg&tbnid=ddEhxozRDFnVnM&vet=12ahUKEwiH76ee_8GBAxWgr5UCHUEgCXgQMygBegQIARBZ..i&imgrefurl=https%3A%2F%2Fotrobar.com.br%2F&docid=VxVEKjB2WAV6TM&w=1024&h=684&q=otro%20bar%20cambui&ved=2ahUKEwiH76ee_8GBAxWgr5UCHUEgCXgQMygBegQIARBZ',
    //   latitude: -22.8935185909755,
    //   longitude: -47.04822412445141,
    // ),
  ];
}
