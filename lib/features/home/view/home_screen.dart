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
        backgroundColor: Colors.purple,
        title: Row(
          children: [
            Text(
              'Home Screen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.light_mode, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeCubit>().toggleViewMode();
        },
        child: Icon(Icons.list, color: Colors.white, size: 50),
        backgroundColor: Colors.purple,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          bool isGridView = true;
          if (state is HomeLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomeErrorState) {
            return Text(state.error);
          }

          if (state is HomeSuccessState) {
            isGridView = state.isGridView;
            return isGridView? Column(
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
                            state.homeModel[index].title,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.network(
                            state.homeModel[index].image,
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            state.homeModel[index].description,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'price:' +
                                state.homeModel[index].price.toString() +
                                ' \$',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ):ListView.separated(itemBuilder: (context, index) {return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.homeModel[index].title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.network(
                  state.homeModel[index].image,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                Text(
                  state.homeModel[index].description,
                  maxLines: 2,
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  'price:' +
                      state.homeModel[index].price.toString() +
                      ' \$',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            );},itemCount: state.homeModel.length, separatorBuilder: (BuildContext context, int index) { return Divider(); },);
          }

          return Center(child: FlutterLogo());
        },
      ),
    );
  }
}
