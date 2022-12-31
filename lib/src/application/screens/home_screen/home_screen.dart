import 'package:finance/gen/assets.gen.dart';
import 'package:finance/src/core/extensions/num_extension.dart';
import 'package:finance/src/repositories/iex_repository.dart';
import 'package:finance/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'menu.dart';
part 'app_title.dart';
part 'user_money.dart';
part 'header.dart';
part 'stock_expansion_panel.dart';

final userStocksStream = StreamProvider<List<MapEntry<String, int>>>((ref) async* {
  final userRepository = ref.watch(userRepositoryProvider);
  yield* userRepository
      .userInfoStream()
      .map((userInfo) => userInfo.stocks)
      .map((stocksMap) => stocksMap.entries.toList());
});

final authenticatedProvider = Provider<bool>((ref) {
  return ref.read(userRepositoryProvider).signedIn;
});

final stocksQtyStream = StreamProvider.family<int, String>((ref, symbol) async* {
  final userRepository = ref.watch(userRepositoryProvider);
  yield* userRepository.userInfoStream().map((userInfo) => userInfo.stocks).map((stocks) => stocks[symbol] ?? 0);
});

final userCashStream = StreamProvider<double>((ref) async* {
  final userRepository = ref.watch(userRepositoryProvider);
  yield* userRepository.userInfoStream().map((userInfo) => userInfo.cash);
});

final stockPriceStream = StreamProvider.family<double, String>((ref, symbol) async* {
  final iexRepository = ref.watch(iexRepositoryProvider);
  while (true) {
    final stockPrice = await iexRepository.getStockPrice(symbol);
    yield stockPrice;
  }
});

final totalPerStockStream = Provider.family<double, String>((ref, symbol) {
  final stockPrice = ref.watch(stockPriceStream(symbol)).valueOrNull ?? 0.0;
  final stocksQty = ref.watch(stocksQtyStream(symbol)).valueOrNull ?? 0;
  return stockPrice * stocksQty;
});

final companyNameProvider = FutureProvider.autoDispose.family<String, String>((ref, symbol) async {
  final iexRepository = ref.watch(iexRepositoryProvider);
  final name = await iexRepository.getStockCompanyName(symbol);
  ref.keepAlive();
  return name;
});

final userTotalFundProvider = Provider<double>((ref) {
  final userCash = ref.watch(userCashStream).valueOrNull ?? 0;
  final userStocks = ref.watch(userStocksStream).valueOrNull ?? [];
  var stocksTotal = 0.0;
  if (userStocks.isNotEmpty) {
    for (final stock in userStocks) {
      final stockPrice = ref.watch(stockPriceStream(stock.key)).valueOrNull ?? 0.0;
      stocksTotal += stockPrice * stock.value;
    }
  }
  return userCash + stocksTotal;
});

const paddingFactor = .05;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _signedIn = false;

  @override
  void initState() {
    super.initState();
    _signedIn = ref.read(authenticatedProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_signedIn) {
        context.go('sign-in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.width * paddingFactor;
    final userStocks = ref.watch(userStocksStream);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.grey.shade800),
        elevation: .5,
        centerTitle: true,
        title: const AppTitle(),
      ),
      drawer: const Drawer(child: Menu()),
      body: Center(
        child: _signedIn
            ? Column(
                children: [
                  const Header(),
                  Expanded(
                    child: userStocks.when(
                      data: (stocks) => ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: stocks.length,
                        itemBuilder: (context, index) => StockExpansionPanel(stockSymbol: stocks[index].key),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(endIndent: padding, indent: padding);
                        },
                      ),
                      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                      error: (error, _) => Text(error.toString()),
                    ),
                  ),
                  const UserMoney(),
                ],
              )
            : const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
