package renren;

class BitServerAdapter {
	private final String endpoints_;
	private Ice.Communicator ic_;
	private renren.BitServerPrx prx_;

	public BitServerAdapter(String endpoints) {
		this.endpoints_ = endpoints;
	}

	public void initialize() {
		ic_ = Ice.Util.initialize();
		prx_ = renren.BitServerPrxHelper.uncheckedCast(ic_.stringToProxy(endpoints_));
	}

	public boolean get(int id) {
		return prx_.get(id);
	}

	public static void main(String[] args) {
		BitServerAdapter adapter = new BitServerAdapter(args[0]);
		adapter.initialize();
		boolean ret = adapter.get(Integer.valueOf(args[1]));
		System.out.println(ret);
		System.exit(0);
	}
}
