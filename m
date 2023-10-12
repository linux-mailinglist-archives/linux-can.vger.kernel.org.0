Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2237C6BB8
	for <lists+linux-can@lfdr.de>; Thu, 12 Oct 2023 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbjJLK7u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Oct 2023 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbjJLK7t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Oct 2023 06:59:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72CE90
        for <linux-can@vger.kernel.org>; Thu, 12 Oct 2023 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697108387; x=1728644387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8Tm2oV0QKZp0uBCMHL6D58b6lKmab3ZhUZGw4xyTzUQ=;
  b=c+qsV0oS/tHjJQB+DBqPZ9TJ5/T+KCVI53ovkjP42V1NPLbvgMK5l7N5
   oNJnc36R0r9JlccwOYZiAYh6WepmITFcAlsCjglnAgVO9bzCiK6hAl78I
   6WaZkgs9Egqc5ubCL4QeOdRId/ZXvy1gJI9reK9gnQmPjVl19/CX0aVtY
   yoHvlruaqL50dDa1oVeF30/VlnL6IUwed0DIOJD6F46iiQPGaqICGgNxP
   Am++btmNd6LRywiERvKZtubP8gH46zmbSRgWsnPrcEwwteu8xws0AEzMr
   6ePYZkIpUytItbF8115eEuXwFDlzdbtsvJTjh40FwYKcHvNGinYL9nRym
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415941077"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415941077"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="820093079"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="820093079"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Oct 2023 03:59:46 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqtPs-0003OD-0C;
        Thu, 12 Oct 2023 10:59:44 +0000
Date:   Thu, 12 Oct 2023 18:59:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: [mkl-can-next:rockchip-canfd 21/23]
 drivers/net/can/rockchip/rockchip_canfd.c:516:13: warning: variable 'cmd'
 set but not used
Message-ID: <202310121831.ixQ9djg4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git rockchip-canfd
head:   88a789562472734e7e100ab2338d4ec5122aba3f
commit: 1271eb8dd6f6d99d3a922c44f27753b5ee3eff4e [21/23] can: rockchip_canfd: remove obsolete CAN LED support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231012/202310121831.ixQ9djg4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310121831.ixQ9djg4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310121831.ixQ9djg4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/can/rockchip/rockchip_canfd.c: In function 'rockchip_canfd_start_xmit':
   drivers/net/can/rockchip/rockchip_canfd.c:532:23: error: implicit declaration of function 'can_len2dlc'; did you mean 'can_fd_len2dlc'? [-Werror=implicit-function-declaration]
     532 |                 dlc = can_len2dlc(cf->len) & DLC_MASK;
         |                       ^~~~~~~~~~~
         |                       can_fd_len2dlc
   drivers/net/can/rockchip/rockchip_canfd.c:573:17: error: too few arguments to function 'can_put_echo_skb'
     573 |                 can_put_echo_skb(skb, ndev, 0);
         |                 ^~~~~~~~~~~~~~~~
   In file included from include/linux/can/dev.h:22,
                    from drivers/net/can/rockchip/rockchip_canfd.c:25:
   include/linux/can/skb.h:20:5: note: declared here
      20 | int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
         |     ^~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_canfd.c:590:9: error: too few arguments to function 'can_put_echo_skb'
     590 |         can_put_echo_skb(skb, ndev, 0);
         |         ^~~~~~~~~~~~~~~~
   include/linux/can/skb.h:20:5: note: declared here
      20 | int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
         |     ^~~~~~~~~~~~~~~~
>> drivers/net/can/rockchip/rockchip_canfd.c:516:13: warning: variable 'cmd' set but not used [-Wunused-but-set-variable]
     516 |         u32 cmd = CAN_TX0_REQ;
         |             ^~~
   drivers/net/can/rockchip/rockchip_canfd.c: In function 'rockchip_canfd_rx':
   drivers/net/can/rockchip/rockchip_canfd.c:641:27: error: implicit declaration of function 'can_dlc2len'; did you mean 'can_fd_dlc2len'? [-Werror=implicit-function-declaration]
     641 |                 cf->len = can_dlc2len(dlc & DLC_MASK);
         |                           ^~~~~~~~~~~
         |                           can_fd_dlc2len
   drivers/net/can/rockchip/rockchip_canfd.c:643:27: error: implicit declaration of function 'get_can_dlc' [-Werror=implicit-function-declaration]
     643 |                 cf->len = get_can_dlc(dlc & DLC_MASK);
         |                           ^~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_canfd.c: In function 'rockchip_canfd_interrupt':
   drivers/net/can/rockchip/rockchip_canfd.c:769:17: error: too few arguments to function 'can_get_echo_skb'
     769 |                 can_get_echo_skb(ndev, 0);
         |                 ^~~~~~~~~~~~~~~~
   include/linux/can/skb.h:25:27: note: declared here
      25 | unsigned int __must_check can_get_echo_skb(struct net_device *dev,
         |                           ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/cmd +516 drivers/net/can/rockchip/rockchip_canfd.c

bdf3296059e25fb Elaine Zhang 2022-10-18  504  
9162e6d9cffe734 Elaine Zhang 2020-07-13  505  /* transmit a CAN message
9162e6d9cffe734 Elaine Zhang 2020-07-13  506   * message layout in the sk_buff should be like this:
9162e6d9cffe734 Elaine Zhang 2020-07-13  507   * xx xx xx xx         ff         ll 00 11 22 33 44 55 66 77
9162e6d9cffe734 Elaine Zhang 2020-07-13  508   * [ can_id ] [flags] [len] [can data (up to 8 bytes]
9162e6d9cffe734 Elaine Zhang 2020-07-13  509   */
9162e6d9cffe734 Elaine Zhang 2020-07-13  510  static int rockchip_canfd_start_xmit(struct sk_buff *skb,
9162e6d9cffe734 Elaine Zhang 2020-07-13  511  				     struct net_device *ndev)
9162e6d9cffe734 Elaine Zhang 2020-07-13  512  {
9162e6d9cffe734 Elaine Zhang 2020-07-13  513  	struct rockchip_canfd *rcan = netdev_priv(ndev);
9162e6d9cffe734 Elaine Zhang 2020-07-13  514  	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
9162e6d9cffe734 Elaine Zhang 2020-07-13  515  	u32 id, dlc;
9162e6d9cffe734 Elaine Zhang 2020-07-13 @516  	u32 cmd = CAN_TX0_REQ;
9162e6d9cffe734 Elaine Zhang 2020-07-13  517  	int i;
ff796d95bac887b Elaine Zhang 2022-09-23  518  	unsigned long flags;
9162e6d9cffe734 Elaine Zhang 2020-07-13  519  
9162e6d9cffe734 Elaine Zhang 2020-07-13  520  	if (can_dropped_invalid_skb(ndev, skb))
9162e6d9cffe734 Elaine Zhang 2020-07-13  521  		return NETDEV_TX_OK;
9162e6d9cffe734 Elaine Zhang 2020-07-13  522  
9162e6d9cffe734 Elaine Zhang 2020-07-13  523  	netif_stop_queue(ndev);
9162e6d9cffe734 Elaine Zhang 2020-07-13  524  
9162e6d9cffe734 Elaine Zhang 2020-07-13  525  	if (rockchip_canfd_read(rcan, CAN_CMD) & CAN_TX0_REQ)
9162e6d9cffe734 Elaine Zhang 2020-07-13  526  		cmd = CAN_TX1_REQ;
9162e6d9cffe734 Elaine Zhang 2020-07-13  527  
9162e6d9cffe734 Elaine Zhang 2020-07-13  528  	/* Watch carefully on the bit sequence */
9162e6d9cffe734 Elaine Zhang 2020-07-13  529  	if (cf->can_id & CAN_EFF_FLAG) {
9162e6d9cffe734 Elaine Zhang 2020-07-13  530  		/* Extended CAN ID format */
9162e6d9cffe734 Elaine Zhang 2020-07-13  531  		id = cf->can_id & CAN_EFF_MASK;
9162e6d9cffe734 Elaine Zhang 2020-07-13  532  		dlc = can_len2dlc(cf->len) & DLC_MASK;
8ac193e3e340ca9 Elaine Zhang 2021-01-05  533  		dlc |= FORMAT_MASK;
9162e6d9cffe734 Elaine Zhang 2020-07-13  534  
9162e6d9cffe734 Elaine Zhang 2020-07-13  535  		/* Extended frames remote TX request */
9162e6d9cffe734 Elaine Zhang 2020-07-13  536  		if (cf->can_id & CAN_RTR_FLAG)
9162e6d9cffe734 Elaine Zhang 2020-07-13  537  			dlc |= RTR_MASK;
9162e6d9cffe734 Elaine Zhang 2020-07-13  538  	} else {
9162e6d9cffe734 Elaine Zhang 2020-07-13  539  		/* Standard CAN ID format */
9162e6d9cffe734 Elaine Zhang 2020-07-13  540  		id = cf->can_id & CAN_SFF_MASK;
9162e6d9cffe734 Elaine Zhang 2020-07-13  541  		dlc = can_len2dlc(cf->len) & DLC_MASK;
9162e6d9cffe734 Elaine Zhang 2020-07-13  542  
9162e6d9cffe734 Elaine Zhang 2020-07-13  543  		/* Standard frames remote TX request */
9162e6d9cffe734 Elaine Zhang 2020-07-13  544  		if (cf->can_id & CAN_RTR_FLAG)
9162e6d9cffe734 Elaine Zhang 2020-07-13  545  			dlc |= RTR_MASK;
9162e6d9cffe734 Elaine Zhang 2020-07-13  546  	}
9162e6d9cffe734 Elaine Zhang 2020-07-13  547  
9162e6d9cffe734 Elaine Zhang 2020-07-13  548  	if ((rcan->can.ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
9162e6d9cffe734 Elaine Zhang 2020-07-13  549  		dlc |= TX_FD_ENABLE;
9162e6d9cffe734 Elaine Zhang 2020-07-13  550  		if (cf->flags & CANFD_BRS)
9162e6d9cffe734 Elaine Zhang 2020-07-13  551  			dlc |= TX_FD_BRS_ENABLE;
9162e6d9cffe734 Elaine Zhang 2020-07-13  552  	}
9162e6d9cffe734 Elaine Zhang 2020-07-13  553  
ff796d95bac887b Elaine Zhang 2022-09-23  554  	if (!rcan->txtorx && rcan->mode >= ROCKCHIP_CAN_MODE && cf->can_id & CAN_EFF_FLAG) {
ff796d95bac887b Elaine Zhang 2022-09-23  555  		/* Two frames are sent consecutively.
ff796d95bac887b Elaine Zhang 2022-09-23  556  		 * Before the first frame is tx finished,
ff796d95bac887b Elaine Zhang 2022-09-23  557  		 * the register of the second frame is configured.
ff796d95bac887b Elaine Zhang 2022-09-23  558  		 * Don't be interrupted in the middle.
ff796d95bac887b Elaine Zhang 2022-09-23  559  		 */
ff796d95bac887b Elaine Zhang 2022-09-23  560  		local_irq_save(flags);
ff796d95bac887b Elaine Zhang 2022-09-23  561  		rockchip_canfd_write(rcan, CAN_TXID, rcan->tx_invalid[1]);
ff796d95bac887b Elaine Zhang 2022-09-23  562  		rockchip_canfd_write(rcan, CAN_TXFIC, rcan->tx_invalid[0]);
ff796d95bac887b Elaine Zhang 2022-09-23  563  		rockchip_canfd_write(rcan, CAN_TXDAT0, rcan->tx_invalid[2]);
ff796d95bac887b Elaine Zhang 2022-09-23  564  		rockchip_canfd_write(rcan, CAN_TXDAT1, rcan->tx_invalid[3]);
ff796d95bac887b Elaine Zhang 2022-09-23  565  		rockchip_canfd_write(rcan, CAN_CMD, CAN_TX0_REQ);
ff796d95bac887b Elaine Zhang 2022-09-23  566  		rockchip_canfd_write(rcan, CAN_TXID, id);
ff796d95bac887b Elaine Zhang 2022-09-23  567  		rockchip_canfd_write(rcan, CAN_TXFIC, dlc);
ff796d95bac887b Elaine Zhang 2022-09-23  568  		for (i = 0; i < cf->len; i += 4)
ff796d95bac887b Elaine Zhang 2022-09-23  569  			rockchip_canfd_write(rcan, CAN_TXDAT0 + i,
ff796d95bac887b Elaine Zhang 2022-09-23  570  					     *(u32 *)(cf->data + i));
ff796d95bac887b Elaine Zhang 2022-09-23  571  		rockchip_canfd_write(rcan, CAN_CMD, CAN_TX1_REQ);
ff796d95bac887b Elaine Zhang 2022-09-23  572  		local_irq_restore(flags);
ff796d95bac887b Elaine Zhang 2022-09-23  573  		can_put_echo_skb(skb, ndev, 0);
ff796d95bac887b Elaine Zhang 2022-09-23  574  
ff796d95bac887b Elaine Zhang 2022-09-23  575  		return NETDEV_TX_OK;
ff796d95bac887b Elaine Zhang 2022-09-23  576  	}
ff796d95bac887b Elaine Zhang 2022-09-23  577  
9162e6d9cffe734 Elaine Zhang 2020-07-13  578  	rockchip_canfd_write(rcan, CAN_TXID, id);
9162e6d9cffe734 Elaine Zhang 2020-07-13  579  	rockchip_canfd_write(rcan, CAN_TXFIC, dlc);
9162e6d9cffe734 Elaine Zhang 2020-07-13  580  
9162e6d9cffe734 Elaine Zhang 2020-07-13  581  	for (i = 0; i < cf->len; i += 4)
9162e6d9cffe734 Elaine Zhang 2020-07-13  582  		rockchip_canfd_write(rcan, CAN_TXDAT0 + i,
9162e6d9cffe734 Elaine Zhang 2020-07-13  583  				     *(u32 *)(cf->data + i));
9162e6d9cffe734 Elaine Zhang 2020-07-13  584  
ff796d95bac887b Elaine Zhang 2022-09-23  585  	rockchip_canfd_write(rcan, CAN_CMD, CAN_TX1_REQ);
9162e6d9cffe734 Elaine Zhang 2020-07-13  586  
bdf3296059e25fb Elaine Zhang 2022-10-18  587  	if (rcan->txtorx && rcan->mode >= ROCKCHIP_CAN_MODE && cf->can_id & CAN_EFF_FLAG)
bdf3296059e25fb Elaine Zhang 2022-10-18  588  		schedule_delayed_work(&rcan->tx_err_work, 1);
bdf3296059e25fb Elaine Zhang 2022-10-18  589  
ff796d95bac887b Elaine Zhang 2022-09-23 @590  	can_put_echo_skb(skb, ndev, 0);
9162e6d9cffe734 Elaine Zhang 2020-07-13  591  
9162e6d9cffe734 Elaine Zhang 2020-07-13  592  	return NETDEV_TX_OK;
9162e6d9cffe734 Elaine Zhang 2020-07-13  593  }
9162e6d9cffe734 Elaine Zhang 2020-07-13  594  

:::::: The code at line 516 was first introduced by commit
:::::: 9162e6d9cffe73420d072187d9f1a0f39540da59 can: rockchip_canfd: add rockchip CANFD driver

:::::: TO: Elaine Zhang <zhangqing@rock-chips.com>
:::::: CC: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
