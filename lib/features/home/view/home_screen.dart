import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/features/home/viewmodel/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().fetchClothes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        backgroundColor: Colors.red,
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomeErrorState) {
            return Text(state.error);
          }

          if (state is HomeSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // عدد العناصر في كل صف
                          crossAxisSpacing: 10, // المسافة بين الأعمدة
                          mainAxisSpacing: 10, // المسافة بين الصفوف
                          childAspectRatio: 1, // نسبة العرض للطول
                        ),
                    itemCount: 10, // عدد العناصر
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'title',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.network(
                            "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'description',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('price'),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return Center(child: FlutterLogo());
        },
      ),
    );
  }
}
