import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outclass/blocs/home/calendar/calendar_cubit.dart';
import 'package:outclass/blocs/home/overview/overview_cubit.dart';
import 'package:outclass/injectable.dart';

@RoutePage()
class OverviewPage extends StatelessWidget implements AutoRouteWrapper {
  const OverviewPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OverviewCubit>(),
      child: BlocListener<CalendarCubit, CalendarState>(
        listener: (context, state) {
          if (state.getEventsStatus == GetEventsStatus.success) {
            context.read<OverviewCubit>().updateEvents(state.events);
          }
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Beranda'),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Deadline tugas',
                      style: textTheme.titleMedium,
                    ),
                  ),
                  const Divider(indent: 8, endIndent: 8, height: 0),
                  const ListTile(
                    title: Text('Presentasi OutClass'),
                    subtitle: Text('11:00 pm, 27 Desember 2022'),
                    leading: CircleAvatar(
                      child: Icon(Icons.article_rounded),
                    ),
                    // onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 64),
          )
        ],
      ),
    );
  }
}
