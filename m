Return-Path: <linux-can+bounces-1420-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16796D730
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 13:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69731F24032
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB6D199389;
	Thu,  5 Sep 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3mQh7lr"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4E199252
	for <linux-can@vger.kernel.org>; Thu,  5 Sep 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535950; cv=none; b=ZOcYY5PKKZaYtfkoaR/G0yGtoTq5siMFl73Nzbqgr8PtMxHMehn9BNRhPBBRNmYmDj8qDeNUWgtjKceFS/B1rh7/exEMVxEX5cY1mgd9PA6HiqlTRmZG4z0iXa0vx+MmaaqLxSzebKZeVrYpMmQ/zJRJAuxnLlvp5Bz7egtanME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535950; c=relaxed/simple;
	bh=y0QZAKcv0PUgKOPWKMSXhFJFqVDtV+O+Fw+DmX2KoFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iUDAuTcryBX9rUEDeQ5pru2mw9g3d2/HmIY6TS4doodCy5YyZdGUZXd7+neNb6Ov5T+zTHf+e8yhy/LZpcCph2qK8pjEPhzG31CXdyHMrUdPHwAX7S54THVC6N6GSFUzSYRFbWw3JEAPV6MRwq9+Ua/vpZbeuu4DJ1E7EDTemq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3mQh7lr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725535948; x=1757071948;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y0QZAKcv0PUgKOPWKMSXhFJFqVDtV+O+Fw+DmX2KoFE=;
  b=d3mQh7lrezrmM9lfQet7v0SOBaGoowWuxzg3xPYXXT74btVEv/mJWf+l
   X27f8O6/yxQg9VBb+G05OE02ixZsdngJi76zB1AThL4mGLqfq0PPWhNMy
   noqK50JWV1g9TTuAdMETsSbqWQnQsSM9yF5hwyXIrN+Mo9LIsK4ajaaPT
   mMjxMoe7cVZ58rpyvooYV+cgwTkNq5OT7mWERAyr26BZl9/9hLhw/UVWs
   tRQW9JKG4auP7usKMiCoQp/vd/oI/KYW8sa79D7STte5lZldFGLEVOmZf
   8bj7ftp2hbKAEGxvQTtUkrX8g3Adh/ebqFXwBfPbcVPBukFW+4HzqqXT0
   w==;
X-CSE-ConnectionGUID: GB6dlTrJTzKywu6W08Ht3g==
X-CSE-MsgGUID: QgaE8OgWT8q15cyduUPOYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34816841"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34816841"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:32:28 -0700
X-CSE-ConnectionGUID: exCrQbOlQwuoMJRB1SHFog==
X-CSE-MsgGUID: WljtksRTSwWNRMY+Y93UoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70389532"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Sep 2024 04:32:26 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smAit-0009m3-2k;
	Thu, 05 Sep 2024 11:32:23 +0000
Date: Thu, 5 Sep 2024 19:31:35 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: [mkl-can-next:rockchip-canfd-downstream 8/32]
 drivers/net/can/rockchip/rockchip_can.c:683:34: error: array type has
 incomplete element type 'struct of_device_id'
Message-ID: <202409051940.fGUe59lb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git rockchip-canfd-downstream
head:   57a1d7b3fcdc3ccf99336327347d54ad630a4485
commit: ffed8877bb0efe42f7a0c9022c414d32f97843b3 [8/32] can: rockchip_can: remove obsolete CAN LED support
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240905/202409051940.fGUe59lb-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409051940.fGUe59lb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409051940.fGUe59lb-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/can/rockchip/rockchip_can.c: In function 'rockchip_can_start_xmit':
   drivers/net/can/rockchip/rockchip_can.c:312:9: error: too few arguments to function 'can_put_echo_skb'
     312 |         can_put_echo_skb(skb, ndev, 0);
         |         ^~~~~~~~~~~~~~~~
   In file included from include/linux/can/dev.h:22,
                    from drivers/net/can/rockchip/rockchip_can.c:10:
   include/linux/can/skb.h:20:5: note: declared here
      20 | int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
         |     ^~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c: In function 'rockchip_can_rx':
   drivers/net/can/rockchip/rockchip_can.c:337:23: error: implicit declaration of function 'get_can_dlc' [-Wimplicit-function-declaration]
     337 |         cf->can_dlc = get_can_dlc(fi & CAN_DLC_MASK);
         |                       ^~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c: In function 'rockchip_can_interrupt':
   drivers/net/can/rockchip/rockchip_can.c:513:17: error: too few arguments to function 'can_get_echo_skb'
     513 |                 can_get_echo_skb(ndev, 0);
         |                 ^~~~~~~~~~~~~~~~
   include/linux/can/skb.h:25:27: note: declared here
      25 | unsigned int __must_check can_get_echo_skb(struct net_device *dev,
         |                           ^~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c: At top level:
>> drivers/net/can/rockchip/rockchip_can.c:683:34: error: array type has incomplete element type 'struct of_device_id'
     683 | static const struct of_device_id rockchip_can_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/can/rockchip/rockchip_can.c:689:38: warning: 'struct platform_device' declared inside parameter list will not be visible outside of this definition or declaration
     689 | static int rockchip_can_probe(struct platform_device *pdev)
         |                                      ^~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c: In function 'rockchip_can_probe':
>> drivers/net/can/rockchip/rockchip_can.c:697:15: error: implicit declaration of function 'platform_get_irq' [-Wimplicit-function-declaration]
     697 |         irq = platform_get_irq(pdev, 0);
         |               ^~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:8,
                    from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from include/linux/can/bittiming.h:9,
                    from include/linux/can/dev.h:18:
>> drivers/net/can/rockchip/rockchip_can.c:699:30: error: invalid use of undefined type 'struct platform_device'
     699 |                 dev_err(&pdev->dev, "could not get a valid irq\n");
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:699:17: note: in expansion of macro 'dev_err'
     699 |                 dev_err(&pdev->dev, "could not get a valid irq\n");
         |                 ^~~~~~~
>> drivers/net/can/rockchip/rockchip_can.c:703:15: error: implicit declaration of function 'platform_get_resource' [-Wimplicit-function-declaration]
     703 |         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         |               ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/can/rockchip/rockchip_can.c:703:13: error: assignment to 'struct resource *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     703 |         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         |             ^
   drivers/net/can/rockchip/rockchip_can.c:704:43: error: invalid use of undefined type 'struct platform_device'
     704 |         addr = devm_ioremap_resource(&pdev->dev, res);
         |                                           ^~
   drivers/net/can/rockchip/rockchip_can.c:710:30: error: invalid use of undefined type 'struct platform_device'
     710 |                 dev_err(&pdev->dev, "could not allocate memory for CAN device\n");
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:710:17: note: in expansion of macro 'dev_err'
     710 |                 dev_err(&pdev->dev, "could not allocate memory for CAN device\n");
         |                 ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:721:37: error: invalid use of undefined type 'struct platform_device'
     721 |         err = devm_request_irq(&pdev->dev, ndev->irq, rockchip_can_interrupt,
         |                                     ^~
   drivers/net/can/rockchip/rockchip_can.c:724:30: error: invalid use of undefined type 'struct platform_device'
     724 |                 dev_err(&pdev->dev, "request_irq err: %d\n", err);
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:724:17: note: in expansion of macro 'dev_err'
     724 |                 dev_err(&pdev->dev, "request_irq err: %d\n", err);
         |                 ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:728:57: error: invalid use of undefined type 'struct platform_device'
     728 |         rcan->reset = devm_reset_control_array_get(&pdev->dev, false, false);
         |                                                         ^~
   drivers/net/can/rockchip/rockchip_can.c:731:38: error: invalid use of undefined type 'struct platform_device'
     731 |                         dev_err(&pdev->dev, "failed to get rcan reset lines\n");
         |                                      ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:731:25: note: in expansion of macro 'dev_err'
     731 |                         dev_err(&pdev->dev, "failed to get rcan reset lines\n");
         |                         ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:735:53: error: invalid use of undefined type 'struct platform_device'
     735 |         rcan->num_clks = devm_clk_bulk_get_all(&pdev->dev, &rcan->clks);
         |                                                     ^~
   drivers/net/can/rockchip/rockchip_can.c:737:30: error: invalid use of undefined type 'struct platform_device'
     737 |                 dev_err(&pdev->dev, "bus clock not found\n");
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:737:17: note: in expansion of macro 'dev_err'
     737 |                 dev_err(&pdev->dev, "bus clock not found\n");
         |                 ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:741:26: error: invalid use of undefined type 'struct platform_device'
     741 |         rcan->dev = &pdev->dev;
         |                          ^~
>> drivers/net/can/rockchip/rockchip_can.c:751:9: error: implicit declaration of function 'platform_set_drvdata' [-Wimplicit-function-declaration]
     751 |         platform_set_drvdata(pdev, ndev);
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:752:35: error: invalid use of undefined type 'struct platform_device'
     752 |         SET_NETDEV_DEV(ndev, &pdev->dev);
         |                                   ^~
   include/linux/netdevice.h:2609:63: note: in definition of macro 'SET_NETDEV_DEV'
    2609 | #define SET_NETDEV_DEV(net, pdev)       ((net)->dev.parent = (pdev))
         |                                                               ^~~~
   drivers/net/can/rockchip/rockchip_can.c:754:32: error: invalid use of undefined type 'struct platform_device'
     754 |         pm_runtime_enable(&pdev->dev);
         |                                ^~
   drivers/net/can/rockchip/rockchip_can.c:755:40: error: invalid use of undefined type 'struct platform_device'
     755 |         err = pm_runtime_get_sync(&pdev->dev);
         |                                        ^~
   drivers/net/can/rockchip/rockchip_can.c:757:30: error: invalid use of undefined type 'struct platform_device'
     757 |                 dev_err(&pdev->dev, "%s: pm_runtime_get failed(%d)\n",
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:757:17: note: in expansion of macro 'dev_err'
     757 |                 dev_err(&pdev->dev, "%s: pm_runtime_get failed(%d)\n",
         |                 ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:764:30: error: invalid use of undefined type 'struct platform_device'
     764 |                 dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:764:17: note: in expansion of macro 'dev_err'
     764 |                 dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
         |                 ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:769:29: error: invalid use of undefined type 'struct platform_device'
     769 |         pm_runtime_put(&pdev->dev);
         |                             ^~
   drivers/net/can/rockchip/rockchip_can.c:774:29: error: invalid use of undefined type 'struct platform_device'
     774 |         pm_runtime_put(&pdev->dev);
         |                             ^~
   drivers/net/can/rockchip/rockchip_can.c:776:33: error: invalid use of undefined type 'struct platform_device'
     776 |         pm_runtime_disable(&pdev->dev);
         |                                 ^~
   drivers/net/can/rockchip/rockchip_can.c: At top level:
   drivers/net/can/rockchip/rockchip_can.c:782:39: warning: 'struct platform_device' declared inside parameter list will not be visible outside of this definition or declaration
     782 | static int rockchip_can_remove(struct platform_device *pdev)
         |                                       ^~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c: In function 'rockchip_can_remove':
>> drivers/net/can/rockchip/rockchip_can.c:784:35: error: implicit declaration of function 'platform_get_drvdata' [-Wimplicit-function-declaration]
     784 |         struct net_device *ndev = platform_get_drvdata(pdev);
         |                                   ^~~~~~~~~~~~~~~~~~~~
>> drivers/net/can/rockchip/rockchip_can.c:784:35: error: initialization of 'struct net_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/net/can/rockchip/rockchip_can.c:787:33: error: invalid use of undefined type 'struct platform_device'
     787 |         pm_runtime_disable(&pdev->dev);
         |                                 ^~
   drivers/net/can/rockchip/rockchip_can.c: At top level:
>> drivers/net/can/rockchip/rockchip_can.c:793:15: error: variable 'rockchip_can_driver' has initializer but incomplete type
     793 | static struct platform_driver rockchip_can_driver = {
         |               ^~~~~~~~~~~~~~~
>> drivers/net/can/rockchip/rockchip_can.c:794:10: error: 'struct platform_driver' has no member named 'driver'
     794 |         .driver = {
         |          ^~~~~~
>> drivers/net/can/rockchip/rockchip_can.c:794:19: error: extra brace group at end of initializer
     794 |         .driver = {
         |                   ^
   drivers/net/can/rockchip/rockchip_can.c:794:19: note: (near initialization for 'rockchip_can_driver')
>> drivers/net/can/rockchip/rockchip_can.c:794:19: warning: excess elements in struct initializer
   drivers/net/can/rockchip/rockchip_can.c:794:19: note: (near initialization for 'rockchip_can_driver')
>> drivers/net/can/rockchip/rockchip_can.c:799:10: error: 'struct platform_driver' has no member named 'probe'
     799 |         .probe = rockchip_can_probe,
         |          ^~~~~
   drivers/net/can/rockchip/rockchip_can.c:799:18: warning: excess elements in struct initializer
     799 |         .probe = rockchip_can_probe,
         |                  ^~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:799:18: note: (near initialization for 'rockchip_can_driver')
>> drivers/net/can/rockchip/rockchip_can.c:800:10: error: 'struct platform_driver' has no member named 'remove'
     800 |         .remove = rockchip_can_remove,
         |          ^~~~~~
   drivers/net/can/rockchip/rockchip_can.c:800:19: warning: excess elements in struct initializer
     800 |         .remove = rockchip_can_remove,
         |                   ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:800:19: note: (near initialization for 'rockchip_can_driver')
>> drivers/net/can/rockchip/rockchip_can.c:802:1: warning: data definition has no type or storage class
     802 | module_platform_driver(rockchip_can_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/can/rockchip/rockchip_can.c:802:1: error: type defaults to 'int' in declaration of 'module_platform_driver' [-Wimplicit-int]
>> drivers/net/can/rockchip/rockchip_can.c:802:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>> drivers/net/can/rockchip/rockchip_can.c:793:31: error: storage size of 'rockchip_can_driver' isn't known
     793 | static struct platform_driver rockchip_can_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~
>> drivers/net/can/rockchip/rockchip_can.c:793:31: warning: 'rockchip_can_driver' defined but not used [-Wunused-variable]


vim +683 drivers/net/can/rockchip/rockchip_can.c

31119b56075179 Andy Yan 2019-03-25  682  
31119b56075179 Andy Yan 2019-03-25 @683  static const struct of_device_id rockchip_can_of_match[] = {
31119b56075179 Andy Yan 2019-03-25  684  	{.compatible = "rockchip,can-1.0"},
31119b56075179 Andy Yan 2019-03-25  685  	{},
31119b56075179 Andy Yan 2019-03-25  686  };
31119b56075179 Andy Yan 2019-03-25  687  MODULE_DEVICE_TABLE(of, rockchip_can_of_match);
31119b56075179 Andy Yan 2019-03-25  688  
31119b56075179 Andy Yan 2019-03-25 @689  static int rockchip_can_probe(struct platform_device *pdev)
31119b56075179 Andy Yan 2019-03-25  690  {
31119b56075179 Andy Yan 2019-03-25  691  	struct net_device *ndev;
31119b56075179 Andy Yan 2019-03-25  692  	struct rockchip_can *rcan;
31119b56075179 Andy Yan 2019-03-25  693  	struct resource *res;
31119b56075179 Andy Yan 2019-03-25  694  	void __iomem *addr;
31119b56075179 Andy Yan 2019-03-25  695  	int err, irq;
31119b56075179 Andy Yan 2019-03-25  696  
31119b56075179 Andy Yan 2019-03-25 @697  	irq = platform_get_irq(pdev, 0);
31119b56075179 Andy Yan 2019-03-25  698  	if (irq < 0) {
31119b56075179 Andy Yan 2019-03-25 @699  		dev_err(&pdev->dev, "could not get a valid irq\n");
31119b56075179 Andy Yan 2019-03-25  700  		return -ENODEV;
31119b56075179 Andy Yan 2019-03-25  701  	}
31119b56075179 Andy Yan 2019-03-25  702  
31119b56075179 Andy Yan 2019-03-25 @703  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
31119b56075179 Andy Yan 2019-03-25  704  	addr = devm_ioremap_resource(&pdev->dev, res);
31119b56075179 Andy Yan 2019-03-25  705  	if (IS_ERR(addr))
31119b56075179 Andy Yan 2019-03-25  706  		return -EBUSY;
31119b56075179 Andy Yan 2019-03-25  707  
31119b56075179 Andy Yan 2019-03-25  708  	ndev = alloc_candev(sizeof(struct rockchip_can), 1);
31119b56075179 Andy Yan 2019-03-25  709  	if (!ndev) {
31119b56075179 Andy Yan 2019-03-25  710  		dev_err(&pdev->dev, "could not allocate memory for CAN device\n");
31119b56075179 Andy Yan 2019-03-25  711  		return -ENOMEM;
31119b56075179 Andy Yan 2019-03-25  712  	}
31119b56075179 Andy Yan 2019-03-25  713  
31119b56075179 Andy Yan 2019-03-25  714  	ndev->netdev_ops = &rockchip_can_netdev_ops;
31119b56075179 Andy Yan 2019-03-25  715  	ndev->irq = irq;
31119b56075179 Andy Yan 2019-03-25  716  	ndev->flags |= IFF_ECHO;
31119b56075179 Andy Yan 2019-03-25  717  
31119b56075179 Andy Yan 2019-03-25  718  	rcan = netdev_priv(ndev);
31119b56075179 Andy Yan 2019-03-25  719  
31119b56075179 Andy Yan 2019-03-25  720  	/* register interrupt handler */
31119b56075179 Andy Yan 2019-03-25  721  	err = devm_request_irq(&pdev->dev, ndev->irq, rockchip_can_interrupt,
31119b56075179 Andy Yan 2019-03-25  722  			       0, ndev->name, ndev);
31119b56075179 Andy Yan 2019-03-25  723  	if (err) {
31119b56075179 Andy Yan 2019-03-25  724  		dev_err(&pdev->dev, "request_irq err: %d\n", err);
31119b56075179 Andy Yan 2019-03-25  725  		return err;
31119b56075179 Andy Yan 2019-03-25  726  	}
31119b56075179 Andy Yan 2019-03-25  727  
31119b56075179 Andy Yan 2019-03-25  728  	rcan->reset = devm_reset_control_array_get(&pdev->dev, false, false);
31119b56075179 Andy Yan 2019-03-25  729  	if (IS_ERR(rcan->reset)) {
31119b56075179 Andy Yan 2019-03-25  730  		if (PTR_ERR(rcan->reset) != -EPROBE_DEFER)
31119b56075179 Andy Yan 2019-03-25  731  			dev_err(&pdev->dev, "failed to get rcan reset lines\n");
31119b56075179 Andy Yan 2019-03-25  732  		return PTR_ERR(rcan->reset);
31119b56075179 Andy Yan 2019-03-25  733  	}
31119b56075179 Andy Yan 2019-03-25  734  
31119b56075179 Andy Yan 2019-03-25  735  	rcan->num_clks = devm_clk_bulk_get_all(&pdev->dev, &rcan->clks);
31119b56075179 Andy Yan 2019-03-25  736  	if (rcan->num_clks < 1) {
31119b56075179 Andy Yan 2019-03-25  737  		dev_err(&pdev->dev, "bus clock not found\n");
31119b56075179 Andy Yan 2019-03-25  738  		return -ENODEV;
31119b56075179 Andy Yan 2019-03-25  739  	}
31119b56075179 Andy Yan 2019-03-25  740  
31119b56075179 Andy Yan 2019-03-25  741  	rcan->dev = &pdev->dev;
31119b56075179 Andy Yan 2019-03-25  742  	rcan->can.clock.freq = clk_get_rate(rcan->clks[0].clk);
31119b56075179 Andy Yan 2019-03-25  743  	rcan->can.bittiming_const = &rockchip_can_bittiming_const;
31119b56075179 Andy Yan 2019-03-25  744  	rcan->can.do_set_mode = rockchip_can_set_mode;
31119b56075179 Andy Yan 2019-03-25  745  	rcan->can.do_get_berr_counter = rockchip_can_get_berr_counter;
31119b56075179 Andy Yan 2019-03-25  746  	rcan->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING |
31119b56075179 Andy Yan 2019-03-25  747  				       CAN_CTRLMODE_LISTENONLY |
31119b56075179 Andy Yan 2019-03-25  748  				       CAN_CTRLMODE_LOOPBACK |
31119b56075179 Andy Yan 2019-03-25  749  				       CAN_CTRLMODE_3_SAMPLES;
31119b56075179 Andy Yan 2019-03-25  750  	rcan->base = addr;
31119b56075179 Andy Yan 2019-03-25 @751  	platform_set_drvdata(pdev, ndev);
31119b56075179 Andy Yan 2019-03-25  752  	SET_NETDEV_DEV(ndev, &pdev->dev);
31119b56075179 Andy Yan 2019-03-25  753  
31119b56075179 Andy Yan 2019-03-25  754  	pm_runtime_enable(&pdev->dev);
31119b56075179 Andy Yan 2019-03-25  755  	err = pm_runtime_get_sync(&pdev->dev);
31119b56075179 Andy Yan 2019-03-25  756  	if (err < 0) {
31119b56075179 Andy Yan 2019-03-25  757  		dev_err(&pdev->dev, "%s: pm_runtime_get failed(%d)\n",
31119b56075179 Andy Yan 2019-03-25  758  			__func__, err);
31119b56075179 Andy Yan 2019-03-25  759  		goto err_pmdisable;
31119b56075179 Andy Yan 2019-03-25  760  	}
31119b56075179 Andy Yan 2019-03-25  761  
31119b56075179 Andy Yan 2019-03-25  762  	err = register_candev(ndev);
31119b56075179 Andy Yan 2019-03-25  763  	if (err) {
31119b56075179 Andy Yan 2019-03-25  764  		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
31119b56075179 Andy Yan 2019-03-25  765  			DRV_NAME, err);
31119b56075179 Andy Yan 2019-03-25  766  		goto err_disableclks;
31119b56075179 Andy Yan 2019-03-25  767  	}
31119b56075179 Andy Yan 2019-03-25  768  
31119b56075179 Andy Yan 2019-03-25  769  	pm_runtime_put(&pdev->dev);
31119b56075179 Andy Yan 2019-03-25  770  
31119b56075179 Andy Yan 2019-03-25  771  	return 0;
31119b56075179 Andy Yan 2019-03-25  772  
31119b56075179 Andy Yan 2019-03-25  773  err_disableclks:
31119b56075179 Andy Yan 2019-03-25  774  	pm_runtime_put(&pdev->dev);
31119b56075179 Andy Yan 2019-03-25  775  err_pmdisable:
31119b56075179 Andy Yan 2019-03-25  776  	pm_runtime_disable(&pdev->dev);
31119b56075179 Andy Yan 2019-03-25  777  	free_candev(ndev);
31119b56075179 Andy Yan 2019-03-25  778  
31119b56075179 Andy Yan 2019-03-25  779  	return err;
31119b56075179 Andy Yan 2019-03-25  780  }
31119b56075179 Andy Yan 2019-03-25  781  
31119b56075179 Andy Yan 2019-03-25  782  static int rockchip_can_remove(struct platform_device *pdev)
31119b56075179 Andy Yan 2019-03-25  783  {
31119b56075179 Andy Yan 2019-03-25 @784  	struct net_device *ndev = platform_get_drvdata(pdev);
31119b56075179 Andy Yan 2019-03-25  785  
31119b56075179 Andy Yan 2019-03-25  786  	unregister_netdev(ndev);
31119b56075179 Andy Yan 2019-03-25  787  	pm_runtime_disable(&pdev->dev);
31119b56075179 Andy Yan 2019-03-25  788  	free_candev(ndev);
31119b56075179 Andy Yan 2019-03-25  789  
31119b56075179 Andy Yan 2019-03-25  790  	return 0;
31119b56075179 Andy Yan 2019-03-25  791  }
31119b56075179 Andy Yan 2019-03-25  792  
31119b56075179 Andy Yan 2019-03-25 @793  static struct platform_driver rockchip_can_driver = {
31119b56075179 Andy Yan 2019-03-25 @794  	.driver = {
31119b56075179 Andy Yan 2019-03-25  795  		.name = DRV_NAME,
31119b56075179 Andy Yan 2019-03-25  796  		.pm = &rockchip_can_dev_pm_ops,
31119b56075179 Andy Yan 2019-03-25  797  		.of_match_table = rockchip_can_of_match,
31119b56075179 Andy Yan 2019-03-25  798  	},
31119b56075179 Andy Yan 2019-03-25 @799  	.probe = rockchip_can_probe,
31119b56075179 Andy Yan 2019-03-25 @800  	.remove = rockchip_can_remove,
31119b56075179 Andy Yan 2019-03-25  801  };
31119b56075179 Andy Yan 2019-03-25 @802  module_platform_driver(rockchip_can_driver);
31119b56075179 Andy Yan 2019-03-25  803  

:::::: The code at line 683 was first introduced by commit
:::::: 31119b560751797c63452b1badad825d6830ac28 can: rockchip_can: add rockchip CAN driver

:::::: TO: Andy Yan <andy.yan@rock-chips.com>
:::::: CC: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

