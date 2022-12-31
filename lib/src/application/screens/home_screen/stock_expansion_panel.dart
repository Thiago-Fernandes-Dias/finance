part of 'home_screen.dart';

class StockExpansionPanel extends HookWidget {
  const StockExpansionPanel({super.key, required this.stockSymbol});

  final String stockSymbol;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);
    const collapsedHeight = 65.0;
    const expandedHeight = 200.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final hPadding = screenWidth * .05;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInExpo,
      height: expanded.value ? expandedHeight : collapsedHeight,
      child: Row(
        children: [
          SizedBox(width: hPadding),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: collapsedHeight,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            alignment: Alignment.centerLeft,
                                            child: Text(stockSymbol),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: IconButton(
                                      icon: Icon(
                                        expanded.value
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons.keyboard_arrow_down_rounded,
                                      ),
                                      onPressed: () => expanded.value = !expanded.value,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (expanded.value)
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Company',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Consumer(
                                builder: (context, ref, _) {
                                  final companyNameFuture = ref.watch(companyNameProvider(stockSymbol));
                                  return companyNameFuture.when(
                                    data: Text.new,
                                    error: (error, _) => Text(error.toString()),
                                    loading: ShareInfoLoadingIndicator.new,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const VerticalDivider(width: 0),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Shares',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Consumer(
                                builder: (context, ref, _) {
                                  final shares = ref.watch(stocksQtyStream(stockSymbol));
                                  return shares.when(
                                    data: (shares) => Text(shares.toString()),
                                    error: (error, stackTrace) => Text(error.toString()),
                                    loading: ShareInfoLoadingIndicator.new,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Price',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Consumer(
                                builder: (context, ref, _) {
                                  final stockPrice = ref.watch(stockPriceStream(stockSymbol));
                                  return stockPrice.when(
                                    data: (price) => Text(price.toUTCFormat()),
                                    error: (error, _) => Text(error.toString()),
                                    loading: ShareInfoLoadingIndicator.new,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'TOTAL',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Consumer(builder: (context, ref, _) {
                                final totalPerStock = ref.watch(totalPerStockStream(stockSymbol));
                                return Text(totalPerStock.toUTCFormat());
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: hPadding),
        ],
      ),
    );
  }
}

@visibleForTesting
class ShareInfoLoadingIndicator extends StatelessWidget {
  const ShareInfoLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final padding = constraints.maxHeight * .3;
          return Padding(
            padding: EdgeInsets.all(padding),
            child: const CircularProgressIndicator(strokeWidth: 1),
          );
        },
      ),
    );
  }
}
