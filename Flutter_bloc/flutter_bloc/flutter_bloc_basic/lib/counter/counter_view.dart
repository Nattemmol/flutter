import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_basic/counter/counter_cubit.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<CounterCubit, int>(builder: (context, state) {
      return Text(
        state.toString(),
        style: const TextStyle(
          fontSize: 50,
        ),
      );
    }),
      floatingActionButton:Column(
            mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
          child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
          child: const Icon(Icons.remove),
          ),
        ],
      ),
      );
  }
}
