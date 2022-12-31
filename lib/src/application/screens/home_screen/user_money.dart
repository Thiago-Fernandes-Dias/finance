part of 'home_screen.dart';

class UserMoney extends ConsumerWidget {
  const UserMoney({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = MediaQuery.of(context).size.width * paddingFactor;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 8,
            child: FractionallySizedBox(
              heightFactor: .5,
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cash',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ref.watch(userCashStream).when(
                        data: (cash) => Text(cash.toUTCFormat()),
                        error: (error, _) => Text(error.toString()),
                        loading: CircularProgressIndicator.adaptive,
                      ),
                ],
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 8,
            child: FractionallySizedBox(
              heightFactor: .5,
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'TOTAL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Text(ref.watch(userTotalFundProvider).toUTCFormat()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
