files = token.get('https://www.googleapis.com/drive/v2/files').parsed['items']
# OAuth2::Response#parsed は JSON.parse(response.body) と同じ

# File リソースの属性を確認
files.first.keys.each_slice(5) {|keys| puts keys.join(', ') }
# =>
# kind, id, etag, selfLink, alternateLink
# embedLink, iconLink, thumbnailLink, title, mimeType
# labels, createdDate, modifiedDate, modifiedByMeDate, lastViewedByMeDate
# markedViewedByMeDate, version, parents, exportLinks, userPermission
# quotaBytesUsed, ownerNames, owners, lastModifyingUserName, lastModifyingUser
# editable, copyable, writersCanShare, shared, explicitlyTrashed
# appDataContents, spaces


# Google Drive に保存されているファイル一覧の作成日付とタイトルを出力
files.sort_by{|f| f['createdDate'] }.
  reverse.map{|f| "#{Time.parse(f['createdDate']).strftime('%Y/%m/%d')} #{f['title']}" }
# =>
# 2015/05/30 JSBi試験 - 答え合わせと知識復習
# 2015/05/24 ファイナンシャルプランナー2級 答え合わせ
# 2015/04/25 Untitled spreadsheet
# 2015/04/03 010000000000-aws-billing-csv-2015-04.csv
# 2015/03/24 AWS S3 vs さくらクラウド オブジェクトストレージ
# 2015/03/06 作成キャッシュフロー表.xls
# 2015/03/01 金融資産バランスグラフ作成
# 2015/02/17 FP提案書（本体）
# 2015/01/06 手数料比較
# 2014/11/25 Untitled spreadsheett
# 2014/11/25 無題スプレッドシート
# 2014/10/08 学会リスト
# 2014/07/21 遺伝子検査項目 DeNA vs 23andMe
# 2014/03/30 電子定款代行会社比較
# 2014/02/03 2014ロード購入検討
# 2014/01/30 Rubyガイド記事ラインアップ（橋本）
# ...


# ファイルを一つ選んで Excel 形式でダウンロード
File.open("dtc.xlsx", "w+") do |out|
 target = files.find{|f| f['title'] =~ /遺伝子検査項目/ }
 content = token.get(target['exportLinks']['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']).body
 out.write content
end

