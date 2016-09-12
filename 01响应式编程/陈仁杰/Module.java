public class Module {

    public static Observable<List<String>> getDataFromLocal() {
        List<String> list = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            list.add("Local " + i);
        }

        return Observable.just(list).subscribeOn(Schedulers.io());
    }

    public static Observable<List<String>> getDataFromServer() {
        List<String> list = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            list.add("Server " + i);
        }

        return Observable.just(list)
                .doOnNext(data -> {
                    // 保存到本地
                })
                .subscribeOn(Schedulers.io());
    }

    public static Observable<List<String>> getData() {
        return Observable.concat(getDataFromLocal(), getDataFromServer());
    }


    public static void main(String[] args) {
        // 普通加载数据
        getData().filter(list -> list != null).
                observeOn(AndroidSchedulers.mainThread())
                .subscribe(list -> {
                    // 获得数据
                }, e -> {
                    e.printStackTrace();
                    // 提示用户出错
                }, () -> {
                    // 加载完成
                });

        // 过滤
        getData().last()
                .observeOn(Schedulers.computation())
                .flatMap(Observable::from)
                .filter(s -> s.contains("1"))
                .toList()
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(list -> {
                    // 获得数据
                }, e -> {
                    e.printStackTrace();
                    // 提示用户出错
                }, () -> {
                    // 加载完成
                });
    }
}