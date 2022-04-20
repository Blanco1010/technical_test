import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/color_controller.dart';
import 'package:google_maps/models/response_branch_offices_by_id_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Widgets/widgets.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({
    Key? key,
    required this.branchOffices,
  }) : super(key: key);

  final ResponseBranchOfficesById branchOffices;

  @override
  Widget build(BuildContext context) {
    if (branchOffices.code == 200) {
      return ChangeNotifierProvider(
        create: ((context) => ColorAppBar()),
        child: SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBarWidget(
                  cover: branchOffices.data!.cover,
                  title: branchOffices.data!.name,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _PosterAndTitle(
                        title: branchOffices.data!.name,
                        logo: branchOffices.data!.brand.logo,
                        address: branchOffices.data!.address,
                        isAvailable: branchOffices.data!.brand.isAvailable,
                      ),
                      _OverView(branchOffices: branchOffices.data!)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.red,
                ),
                const Text(
                  'Hubo un error',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    Key? key,
    required this.cover,
    required this.title,
  }) : super(key: key);

  final String cover;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<ColorAppBar>(context, listen: true);
    moviesProvider.getColorFromImg(cover);

    return SliverAppBar(
      backgroundColor: moviesProvider.colorAppbar,
      floating: false,
      pinned: true,
      expandedHeight: size.height * 0.25,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
            bottom: size.height * 0.025,
            right: size.width * 0.05,
            left: size.width * 0.05,
          ),
          color: Colors.black45,
          child: Text(
            title,
            style: TextStyle(fontSize: size.width * 0.06),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(cover),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String title;
  final String logo;
  final String address;
  final bool isAvailable;

  const _PosterAndTitle({
    Key? key,
    required this.title,
    required this.logo,
    required this.address,
    required this.isAvailable,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-imagen.png'),
              image: NetworkImage(logo),
              height: size.height * 0.25,
              width: size.width * 0.35,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: (isAvailable ? Colors.green : Colors.red),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Text(
                    isAvailable ? 'Está disponible' : 'No está disponible',
                    style: TextStyle(
                      color: isAvailable ? Colors.green : Colors.red,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: theme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Text(
                  address,
                  style: theme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final Data branchOffices;

  const _OverView({required this.branchOffices});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rowInformation(
            iconData: FontAwesomeIcons.circleInfo,
            color: Colors.blue,
            title: 'Descripción ',
            description: branchOffices.brand.description,
          ),
          _rowInformation(
            iconData: FontAwesomeIcons.personWalking,
            color: Colors.amber,
            title: 'Tiempo de entrega estimado: ',
            description: branchOffices.deliveryRate!,
          ),
          if (branchOffices.minSellAmount != 0 &&
              branchOffices.maxSellAmount != 0)
            _rowInformation(
              iconData: FontAwesomeIcons.scaleBalanced,
              color: Colors.green,
              title: 'Cantidad mínima y máxima de venta: ',
              description:
                  '\$${branchOffices.minSellAmount.toString()} - \$${branchOffices.maxSellAmount.toString()}',
            ),
          _rowInformation(
            iconData: FontAwesomeIcons.mobileRetro,
            color: Colors.grey,
            title: branchOffices.acceptDatafono ? '' : 'No',
            description:
                '${branchOffices.acceptDatafono ? 'Se' : ' se'} acepta con un datáfono',
          ),
          _rowInformation(
              iconData: FontAwesomeIcons.creditCard,
              color: Colors.black,
              title: branchOffices.acceptCreditcard ? '' : 'No',
              description:
                  '${branchOffices.acceptCreditcard ? 'Se' : ' se'} acepta con tarjeta de crédito'),
          _rowInformation(
              iconData: FontAwesomeIcons.moneyBills,
              color: Colors.green,
              title: branchOffices.acceptCash ? '' : 'No',
              description:
                  '${branchOffices.acceptCash ? 'Se' : ' se'} acepta en efectivo'),
          _rowInformation(
            iconData: FontAwesomeIcons.at,
            color: Colors.indigoAccent,
            title: 'Correo electrónico: ',
            description: branchOffices.email,
            textAlign: TextAlign.start,
          ),
          if (branchOffices.phone1!.isNotEmpty)
            _rowInformation(
              iconData: FontAwesomeIcons.phone,
              color: Colors.greenAccent,
              title: 'Teléfono: ',
              description: '${branchOffices.phone1} ${branchOffices.phone2}',
              textAlign: TextAlign.start,
            ),
          if (branchOffices.whatsapp1!.isNotEmpty)
            _rowInformation(
              iconData: FontAwesomeIcons.whatsapp,
              color: Colors.green,
              title: 'WhatsApp: ',
              description:
                  '${branchOffices.whatsapp1}  ${branchOffices.whatsapp1}',
              textAlign: TextAlign.start,
            ),
        ],
      ),
    );
  }
}

Row _rowInformation({
  required IconData iconData,
  required Color color,
  required String title,
  required String description,
  TextAlign textAlign = TextAlign.justify,
}) {
  return Row(
    children: [
      IconView(
        icons: iconData,
        color: color,
      ),
      Flexible(
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: description),
            ],
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
          textAlign: textAlign,
        ),
      ),
    ],
  );
}
