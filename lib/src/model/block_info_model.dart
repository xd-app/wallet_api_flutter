class BlockInfo {
  // final List<AverageBlockTime> averageBlockTimePerHour;
  final List<Block> block;

  BlockInfo({
    // required this.averageBlockTimePerHour,
    required this.block,
  });

  factory BlockInfo.fromJson(Map<String, dynamic> json) {
    return BlockInfo(
      // averageBlockTimePerHour: json['average_block_time_per_hour'] == null
      //     ? []
      //     : (json['average_block_time_per_hour'] as List)
      //         .map((e) => AverageBlockTime.fromJson(e))
      //         .toList(),
      block: json['block'] == null
          ? []
          : (json['block'] as List).map((e) => Block.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'average_block_time_per_hour':
      //     averageBlockTimePerHour.map((e) => e.toJson()).toList(),
      'block': block.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    // return 'BlockInfo(averageBlockTimePerHour: $averageBlockTimePerHour, block: $block)';
    return 'BlockInfo(block: $block)';
  }
}

class AverageBlockTime {
  final double averageTime;

  AverageBlockTime({required this.averageTime});

  factory AverageBlockTime.fromJson(Map<String, dynamic> json) {
    return AverageBlockTime(
      averageTime: (json['average_time'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average_time': averageTime,
    };
  }

  @override
  String toString() => 'AverageBlockTime(averageTime: $averageTime)';
}

class Block {
  final BigInt latestBlock;

  Block({required this.latestBlock});

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      latestBlock: BigInt.parse(json['latest_block'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latest_block': latestBlock.toString(), // BigInt 转字符串
    };
  }

  @override
  String toString() => 'Block(latestBlock: $latestBlock)';
}
