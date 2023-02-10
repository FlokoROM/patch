# FlokoROM/patch

## Usage

- 普通に [crDroidAndroid/android](https://github.com/crdroidandroid/android/tree/13.0) を引っ張ってきます
- `remove.xml` を `.repo/local_manifests` 以下にコピーしてください
- 後は `floko.sh` を適切に実行するとパッチが当たります

ロゴ画像などのバイナリを含むリポジトリについてのみ `patch` ではなく `git diff/apply` でやっていますが、後者に統一しても良い気はします。

## License

### それぞれの `patch` / `diff`

パッチ先のファイルに準じます。

特に指定がない場合、AOSPに倣って Apache License v2.0 を採用します。

### `floko.sh`

スクリプトのうちパッチ適用処理について [lineageos4microg:docker-lineage-cicd/build.sh](https://github.com/lineageos4microg/docker-lineage-cicd/blob/master/src/build.sh) をベースにしていることから、 [GNU General Public License v3](https://www.gnu.org/licenses/gpl-3.0.html) が適用されます。
