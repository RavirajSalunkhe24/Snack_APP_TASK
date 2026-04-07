import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/snack_bloc/snack_bloc.dart';
import '../../logic/snack_bloc/snack_event.dart';
import '../../logic/snack_bloc/snack_state.dart';
import '../widgets/snack_card.dart';
import '../widgets/shimmer_widget.dart';

class SnackScreen extends StatelessWidget {
  const SnackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: const Text(
          "Snacks Menu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF7E5F), Color(0xFFFFC371)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SnackBloc>().add(RefreshSnacks());
        },
        child: BlocBuilder<SnackBloc, SnackState>(
          builder: (context, state) {
            // 🔹 Loading
            if (state is SnackLoading) {
              return const SnackShimmer();
            }

            // 🔹 Error
            if (state is SnackError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 50, color: Colors.red),
                    const SizedBox(height: 10),
                    const Text("Something went wrong"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SnackBloc>().add(FetchSnacks());
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            // 🔹 Empty
            if (state is SnackEmpty) {
              return const Center(
                child: Text(
                  "No snacks available",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            // 🔹 Loaded
            if (state is SnackLoaded) {
              final snacks = state.snacks;

              // 👉 Group by category
              final warme = snacks.where((e) => e.category == "warme").toList();

              final koude = snacks.where((e) => e.category == "koude").toList();

              final zoete = snacks.where((e) => e.category == "zoete").toList();

              return ListView(
                padding: const EdgeInsets.all(12),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  buildSection("Warme Snacks", warme),
                  buildSection("Koude Snacks", koude),
                  buildSection("Zoete Snacks", zoete),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  // 🔹 Reusable Section Widget
  Widget buildSection(String title, List snacks) {
    if (snacks.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snacks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return SnackCard(snack: snacks[index]);
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
