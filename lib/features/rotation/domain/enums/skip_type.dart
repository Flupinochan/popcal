enum SkipType {
  skipToNext, // 次の人に回す場合、ローテーション日のまま
  skipToPrevious, // 前の人に回す場合、ローテーション日のまま
  holiday, // 休日などでローテーション日にしたくない場合、ローテーション日から除外
}

// skipToNext と skipToPrevious は複数回skip可能にする
// holiday はskipCount1で固定
