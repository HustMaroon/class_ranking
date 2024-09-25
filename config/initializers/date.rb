class Date
  def wday_mapping
    {
      '0' => 'Chủ Nhật',
      '1' => 'Thứ Hai',
      '2' => 'Thứ Ba',
      '3' => 'Thứ Tư',
      '4' => 'Thứ Năm',
      '5' => 'Thứ Sáu',
      '6' => 'Thứ Bảy'
    }
  end

  def to_wday
    wday_mapping[wday.to_s]
  end
end
