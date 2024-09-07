Return-Path: <linux-can+bounces-1432-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC61897030E
	for <lists+linux-can@lfdr.de>; Sat,  7 Sep 2024 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6628B283B6D
	for <lists+linux-can@lfdr.de>; Sat,  7 Sep 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491115ECC8;
	Sat,  7 Sep 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Utr3FVeO"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E240BE5
	for <linux-can@vger.kernel.org>; Sat,  7 Sep 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725724434; cv=none; b=bCojS41DrNU4uLOWpBPsQfUBbtcyGb5KvUSjXeptDf/lJdZtaztSnoaMI4trmSE5qbRfHwH8EEPHcDmEMdUvmtiVDTxUp9bSjuiklK2B3MNVJIWnKtHzQdeDoRbixw65eve/0k4gISFCqUAH7ag1vhvX8BitZIPzRscpWp8O/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725724434; c=relaxed/simple;
	bh=qdzS8xuOtsEJ11X6Vl8r/TaNQivRPcZWHXGEd/OnlZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U1le0CogrNrRLKGyV9wqm8//O2igaqJ8vBu+qnNRiAtvth1niHa0Ug1sOPihaov5uycbKdy7i9F5RCyefCFbX0TTIcjRm3Ug674EReHTUx+qfFI1l8F1z60HTX4POLtmEkqBUDJz00UTm1GPBuS/I3SVBdNZtCHeH+F+5MVflVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Utr3FVeO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725724432; x=1757260432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qdzS8xuOtsEJ11X6Vl8r/TaNQivRPcZWHXGEd/OnlZg=;
  b=Utr3FVeO77a8TEYf79ZbYMr4Geq7AEFbRLLrWcYYWUSuDQ6lznSqWxSb
   SEIVU0BmQ8lEOyt3E7Oad2UdwSbXbRUjH0KgqCSYzFYP/akt2/U/li8Sr
   PGxsexqTLQ2uPiJa1XG71FuK06fbmz6NnOAd9rM1eXFdwI1xlHUEOFMvl
   UYW7qVKgXU+1Xn9AY8HJQhwxAV1gd9CF6y4+AqBKY0O67pg1bN1rnPovT
   8V6n7vqEHwRdzpd9oHg4Bcth7BBqsH7VadsSt8S2X2v78vSKStW10N1AV
   AoY2gxM93XCZocpRQistYXE7Dnm135QGz6/QAzmG435LC0XSySnXvkbE0
   g==;
X-CSE-ConnectionGUID: u2XyEmiORWm6Dd1istdpGw==
X-CSE-MsgGUID: aB04eCFYQFKl+pZnlJV4Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="35819041"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="35819041"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 08:53:52 -0700
X-CSE-ConnectionGUID: RHY0OhZ+TPOzlE5Yo1Ri8Q==
X-CSE-MsgGUID: D6luA1gWQoOnRlUlXo3hMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="70809671"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Sep 2024 08:53:50 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smxky-000Cff-2G;
	Sat, 07 Sep 2024 15:53:48 +0000
Date: Sat, 7 Sep 2024 23:52:49 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: [mkl-can-next:rockchip-canfd-downstream 38/42]
 drivers/net/can/rockchip/rk3562_can.c:733:13: warning: variable 'dlc' set
 but not used
Message-ID: <202409072335.qAZ7qANN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git rockchip-canfd-downstream
head:   88e198c286acbb38dc8b67d4d787a801649a18f9
commit: 904a568387b83f7975ed63ad323f5fb9966580c4 [38/42] can: rk3562_can: update to modern can_{put,get}_echo_skb()
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240907/202409072335.qAZ7qANN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409072335.qAZ7qANN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409072335.qAZ7qANN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/can/rockchip/rk3562_can.c: In function 'rk3562_can_start_xmit':
   drivers/net/can/rockchip/rk3562_can.c:525:23: error: implicit declaration of function 'can_len2dlc'; did you mean 'can_fd_len2dlc'? [-Wimplicit-function-declaration]
     525 |                 dlc = can_len2dlc(cf->len) & DLC_MASK;
         |                       ^~~~~~~~~~~
         |                       can_fd_len2dlc
   drivers/net/can/rockchip/rk3562_can.c: In function 'rk3562_can_rx':
   drivers/net/can/rockchip/rk3562_can.c:589:27: error: implicit declaration of function 'can_dlc2len'; did you mean 'can_fd_dlc2len'? [-Wimplicit-function-declaration]
     589 |                 cf->len = can_dlc2len(dlc & DLC_MASK);
         |                           ^~~~~~~~~~~
         |                           can_fd_dlc2len
   drivers/net/can/rockchip/rk3562_can.c:591:27: error: implicit declaration of function 'get_can_dlc' [-Wimplicit-function-declaration]
     591 |                 cf->len = get_can_dlc(dlc & DLC_MASK);
         |                           ^~~~~~~~~~~
   drivers/net/can/rockchip/rk3562_can.c: In function 'rk3562_can_interrupt':
>> drivers/net/can/rockchip/rk3562_can.c:733:13: warning: variable 'dlc' set but not used [-Wunused-but-set-variable]
     733 |         u32 dlc = 0;
         |             ^~~
   drivers/net/can/rockchip/rk3562_can.c: In function 'rk3562_can_probe':
   drivers/net/can/rockchip/rk3562_can.c:1026:9: error: too many arguments to function 'netif_napi_add'
    1026 |         netif_napi_add(ndev, &rcan->napi, rk3562_can_rx_poll,
         |         ^~~~~~~~~~~~~~
   In file included from drivers/net/can/rockchip/rk3562_can.c:17:
   include/linux/netdevice.h:2644:1: note: declared here
    2644 | netif_napi_add(struct net_device *dev, struct napi_struct *napi,
         | ^~~~~~~~~~~~~~
   drivers/net/can/rockchip/rk3562_can.c: At top level:
   drivers/net/can/rockchip/rk3562_can.c:1066:19: error: initialization of 'void (*)(struct platform_device *)' from incompatible pointer type 'int (*)(struct platform_device *)' [-Wincompatible-pointer-types]
    1066 |         .remove = rk3562_can_remove,
         |                   ^~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rk3562_can.c:1066:19: note: (near initialization for 'rk3562_can_driver.<anonymous>.remove')


vim +/dlc +733 drivers/net/can/rockchip/rk3562_can.c

74b93b4510dc75 Elaine Zhang      2022-10-28  560  
74b93b4510dc75 Elaine Zhang      2022-10-28  561  static int rk3562_can_rx(struct net_device *ndev)
74b93b4510dc75 Elaine Zhang      2022-10-28  562  {
74b93b4510dc75 Elaine Zhang      2022-10-28  563  	struct rk3562_can *rcan = netdev_priv(ndev);
74b93b4510dc75 Elaine Zhang      2022-10-28  564  	struct net_device_stats *stats = &ndev->stats;
74b93b4510dc75 Elaine Zhang      2022-10-28  565  	struct canfd_frame *cf;
74b93b4510dc75 Elaine Zhang      2022-10-28  566  	struct sk_buff *skb;
74b93b4510dc75 Elaine Zhang      2022-10-28  567  	u32 id_rk3562_can, dlc;
74b93b4510dc75 Elaine Zhang      2022-10-28  568  	int i = 0;
74b93b4510dc75 Elaine Zhang      2022-10-28  569  	u32 __maybe_unused ts, ret;
74b93b4510dc75 Elaine Zhang      2022-10-28  570  	u32 data[16] = {0};
74b93b4510dc75 Elaine Zhang      2022-10-28  571  
74b93b4510dc75 Elaine Zhang      2022-10-28  572  	dlc = rk3562_can_read(rcan, CAN_RXFRD);
74b93b4510dc75 Elaine Zhang      2022-10-28  573  	id_rk3562_can = rk3562_can_read(rcan, CAN_RXFRD);
74b93b4510dc75 Elaine Zhang      2022-10-28  574  	for (i = 0; i < (rcan->rx_max_data - 2); i++)
74b93b4510dc75 Elaine Zhang      2022-10-28  575  		data[i] = rk3562_can_read(rcan, CAN_RXFRD);
74b93b4510dc75 Elaine Zhang      2022-10-28  576  
74b93b4510dc75 Elaine Zhang      2022-10-28  577  	/* create zero'ed CAN frame buffer */
74b93b4510dc75 Elaine Zhang      2022-10-28  578  	if (dlc & FDF_MASK)
74b93b4510dc75 Elaine Zhang      2022-10-28  579  		skb = alloc_canfd_skb(ndev, &cf);
74b93b4510dc75 Elaine Zhang      2022-10-28  580  	else
74b93b4510dc75 Elaine Zhang      2022-10-28  581  		skb = alloc_can_skb(ndev, (struct can_frame **)&cf);
74b93b4510dc75 Elaine Zhang      2022-10-28  582  	if (!skb) {
74b93b4510dc75 Elaine Zhang      2022-10-28  583  		stats->rx_dropped++;
74b93b4510dc75 Elaine Zhang      2022-10-28  584  		return 1;
74b93b4510dc75 Elaine Zhang      2022-10-28  585  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  586  
74b93b4510dc75 Elaine Zhang      2022-10-28  587  	/* Change CAN data length format to socketCAN data format */
74b93b4510dc75 Elaine Zhang      2022-10-28  588  	if (dlc & FDF_MASK)
74b93b4510dc75 Elaine Zhang      2022-10-28 @589  		cf->len = can_dlc2len(dlc & DLC_MASK);
74b93b4510dc75 Elaine Zhang      2022-10-28  590  	else
74b93b4510dc75 Elaine Zhang      2022-10-28  591  		cf->len = get_can_dlc(dlc & DLC_MASK);
74b93b4510dc75 Elaine Zhang      2022-10-28  592  
74b93b4510dc75 Elaine Zhang      2022-10-28  593  	/* Change CAN ID format to socketCAN ID format */
74b93b4510dc75 Elaine Zhang      2022-10-28  594  	if (dlc & FORMAT_MASK) {
74b93b4510dc75 Elaine Zhang      2022-10-28  595  		/* The received frame is an Extended format frame */
74b93b4510dc75 Elaine Zhang      2022-10-28  596  		cf->can_id = id_rk3562_can;
74b93b4510dc75 Elaine Zhang      2022-10-28  597  		cf->can_id |= CAN_EFF_FLAG;
74b93b4510dc75 Elaine Zhang      2022-10-28  598  		if (dlc & RTR_MASK)
74b93b4510dc75 Elaine Zhang      2022-10-28  599  			cf->can_id |= CAN_RTR_FLAG;
74b93b4510dc75 Elaine Zhang      2022-10-28  600  	} else {
74b93b4510dc75 Elaine Zhang      2022-10-28  601  		/* The received frame is a standard format frame */
74b93b4510dc75 Elaine Zhang      2022-10-28  602  		cf->can_id = id_rk3562_can;
74b93b4510dc75 Elaine Zhang      2022-10-28  603  		if (dlc & RTR_MASK)
74b93b4510dc75 Elaine Zhang      2022-10-28  604  			cf->can_id |= CAN_RTR_FLAG;
74b93b4510dc75 Elaine Zhang      2022-10-28  605  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  606  
74b93b4510dc75 Elaine Zhang      2022-10-28  607  	if (dlc & BRS_MASK)
74b93b4510dc75 Elaine Zhang      2022-10-28  608  		cf->flags |= CANFD_BRS;
74b93b4510dc75 Elaine Zhang      2022-10-28  609  
74b93b4510dc75 Elaine Zhang      2022-10-28  610  	if (!(cf->can_id & CAN_RTR_FLAG)) {
74b93b4510dc75 Elaine Zhang      2022-10-28  611  		/* Change CAN data format to socketCAN data format */
74b93b4510dc75 Elaine Zhang      2022-10-28  612  		for (i = 0; i < cf->len; i += 4)
74b93b4510dc75 Elaine Zhang      2022-10-28  613  			*(u32 *)(cf->data + i) = data[i / 4];
74b93b4510dc75 Elaine Zhang      2022-10-28  614  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  615  
74b93b4510dc75 Elaine Zhang      2022-10-28  616  	stats->rx_packets++;
74b93b4510dc75 Elaine Zhang      2022-10-28  617  	stats->rx_bytes += cf->len;
74b93b4510dc75 Elaine Zhang      2022-10-28  618  	netif_rx(skb);
74b93b4510dc75 Elaine Zhang      2022-10-28  619  
74b93b4510dc75 Elaine Zhang      2022-10-28  620  	return 1;
74b93b4510dc75 Elaine Zhang      2022-10-28  621  }
74b93b4510dc75 Elaine Zhang      2022-10-28  622  
74b93b4510dc75 Elaine Zhang      2022-10-28  623  /* rk3562_can_rx_poll - Poll routine for rx packets (NAPI)
74b93b4510dc75 Elaine Zhang      2022-10-28  624   * @napi:	napi structure pointer
74b93b4510dc75 Elaine Zhang      2022-10-28  625   * @quota:	Max number of rx packets to be processed.
74b93b4510dc75 Elaine Zhang      2022-10-28  626   *
74b93b4510dc75 Elaine Zhang      2022-10-28  627   * This is the poll routine for rx part.
74b93b4510dc75 Elaine Zhang      2022-10-28  628   * It will process the packets maximux quota value.
74b93b4510dc75 Elaine Zhang      2022-10-28  629   *
74b93b4510dc75 Elaine Zhang      2022-10-28  630   * Return: number of packets received
74b93b4510dc75 Elaine Zhang      2022-10-28  631   */
74b93b4510dc75 Elaine Zhang      2022-10-28  632  static int rk3562_can_rx_poll(struct napi_struct *napi, int quota)
74b93b4510dc75 Elaine Zhang      2022-10-28  633  {
74b93b4510dc75 Elaine Zhang      2022-10-28  634  	struct net_device *ndev = napi->dev;
74b93b4510dc75 Elaine Zhang      2022-10-28  635  	struct rk3562_can *rcan = netdev_priv(ndev);
74b93b4510dc75 Elaine Zhang      2022-10-28  636  	int work_done = 0;
74b93b4510dc75 Elaine Zhang      2022-10-28  637  	u32 cnt;
74b93b4510dc75 Elaine Zhang      2022-10-28  638  
74b93b4510dc75 Elaine Zhang      2022-10-28  639  	quota = (rk3562_can_read(rcan, CAN_RXFC) & rcan->rx_fifo_mask) >>
74b93b4510dc75 Elaine Zhang      2022-10-28  640  		rcan->rx_fifo_shift;
74b93b4510dc75 Elaine Zhang      2022-10-28  641  	cnt = rk3562_can_read(rcan, CAN_FIFO_INFO) & CAN_FIFO_INFO_CNT_MASK;
74b93b4510dc75 Elaine Zhang      2022-10-28  642  	cnt = cnt / rcan->rx_max_data;
74b93b4510dc75 Elaine Zhang      2022-10-28  643  	if (cnt != quota)
74b93b4510dc75 Elaine Zhang      2022-10-28  644  		quota = cnt;
74b93b4510dc75 Elaine Zhang      2022-10-28  645  
74b93b4510dc75 Elaine Zhang      2022-10-28  646  	while (work_done < quota)
74b93b4510dc75 Elaine Zhang      2022-10-28  647  		work_done += rk3562_can_rx(ndev);
74b93b4510dc75 Elaine Zhang      2022-10-28  648  
74b93b4510dc75 Elaine Zhang      2022-10-28  649  	if (work_done < rcan->rx_fifo_depth) {
74b93b4510dc75 Elaine Zhang      2022-10-28  650  		napi_complete_done(napi, work_done);
74b93b4510dc75 Elaine Zhang      2022-10-28  651  		rk3562_can_write(rcan, CAN_INT_MASK, 0);
74b93b4510dc75 Elaine Zhang      2022-10-28  652  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  653  
74b93b4510dc75 Elaine Zhang      2022-10-28  654  	return work_done;
74b93b4510dc75 Elaine Zhang      2022-10-28  655  }
74b93b4510dc75 Elaine Zhang      2022-10-28  656  
74b93b4510dc75 Elaine Zhang      2022-10-28  657  static int rk3562_can_err(struct net_device *ndev, u32 isr)
74b93b4510dc75 Elaine Zhang      2022-10-28  658  {
74b93b4510dc75 Elaine Zhang      2022-10-28  659  	struct rk3562_can *rcan = netdev_priv(ndev);
74b93b4510dc75 Elaine Zhang      2022-10-28  660  	struct net_device_stats *stats = &ndev->stats;
74b93b4510dc75 Elaine Zhang      2022-10-28  661  	struct can_frame *cf;
74b93b4510dc75 Elaine Zhang      2022-10-28  662  	struct sk_buff *skb;
74b93b4510dc75 Elaine Zhang      2022-10-28  663  	unsigned int rxerr, txerr;
74b93b4510dc75 Elaine Zhang      2022-10-28  664  	u32 sta_reg, err_code;
74b93b4510dc75 Elaine Zhang      2022-10-28  665  
74b93b4510dc75 Elaine Zhang      2022-10-28  666  	skb = alloc_can_err_skb(ndev, &cf);
74b93b4510dc75 Elaine Zhang      2022-10-28  667  
74b93b4510dc75 Elaine Zhang      2022-10-28  668  	rxerr = rk3562_can_read(rcan, CAN_RX_ERR_CNT);
74b93b4510dc75 Elaine Zhang      2022-10-28  669  	txerr = rk3562_can_read(rcan, CAN_TX_ERR_CNT);
74b93b4510dc75 Elaine Zhang      2022-10-28  670  	sta_reg = rk3562_can_read(rcan, CAN_STATE);
74b93b4510dc75 Elaine Zhang      2022-10-28  671  	err_code = rk3562_can_read(rcan, CAN_ERR_CODE);
74b93b4510dc75 Elaine Zhang      2022-10-28  672  
74b93b4510dc75 Elaine Zhang      2022-10-28  673  	if ((isr & TX_LOSTARB_INT) ||
74b93b4510dc75 Elaine Zhang      2022-10-28  674  	    ((!(err_code & ERR_DIR_RX)) &&
74b93b4510dc75 Elaine Zhang      2022-10-28  675  	     (err_code & ERR_TX_ERR_MASK))) {
74b93b4510dc75 Elaine Zhang      2022-10-28  676  		err_code = rk3562_can_read(rcan, CAN_ERR_CODE);
74b93b4510dc75 Elaine Zhang      2022-10-28  677  		err_code = rk3562_can_read(rcan, CAN_CMD);
74b93b4510dc75 Elaine Zhang      2022-10-28  678  		rk3562_can_write(rcan, CAN_CMD, CAN_TX0_REQ);
74b93b4510dc75 Elaine Zhang      2022-10-28  679  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  680  
74b93b4510dc75 Elaine Zhang      2022-10-28  681  	if (skb) {
74b93b4510dc75 Elaine Zhang      2022-10-28  682  		cf->data[6] = txerr;
74b93b4510dc75 Elaine Zhang      2022-10-28  683  		cf->data[7] = rxerr;
74b93b4510dc75 Elaine Zhang      2022-10-28  684  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  685  
74b93b4510dc75 Elaine Zhang      2022-10-28  686  	if (isr & BUS_OFF_INT) {
74b93b4510dc75 Elaine Zhang      2022-10-28  687  		rcan->can.state = CAN_STATE_BUS_OFF;
74b93b4510dc75 Elaine Zhang      2022-10-28  688  		rcan->can.can_stats.bus_off++;
74b93b4510dc75 Elaine Zhang      2022-10-28  689  		cf->can_id |= CAN_ERR_BUSOFF;
74b93b4510dc75 Elaine Zhang      2022-10-28  690  	} else if (isr & ERR_WARN_INT) {
74b93b4510dc75 Elaine Zhang      2022-10-28  691  		rcan->can.can_stats.error_warning++;
74b93b4510dc75 Elaine Zhang      2022-10-28  692  		rcan->can.state = CAN_STATE_ERROR_WARNING;
74b93b4510dc75 Elaine Zhang      2022-10-28  693  		/* error warning state */
74b93b4510dc75 Elaine Zhang      2022-10-28  694  		if (likely(skb)) {
74b93b4510dc75 Elaine Zhang      2022-10-28  695  			cf->can_id |= CAN_ERR_CRTL;
74b93b4510dc75 Elaine Zhang      2022-10-28  696  			cf->data[1] = (txerr > rxerr) ?
74b93b4510dc75 Elaine Zhang      2022-10-28  697  				CAN_ERR_CRTL_TX_WARNING :
74b93b4510dc75 Elaine Zhang      2022-10-28  698  				CAN_ERR_CRTL_RX_WARNING;
74b93b4510dc75 Elaine Zhang      2022-10-28  699  			cf->data[6] = txerr;
74b93b4510dc75 Elaine Zhang      2022-10-28  700  			cf->data[7] = rxerr;
74b93b4510dc75 Elaine Zhang      2022-10-28  701  		}
74b93b4510dc75 Elaine Zhang      2022-10-28  702  	} else if (isr & PASSIVE_ERR_INT) {
74b93b4510dc75 Elaine Zhang      2022-10-28  703  		rcan->can.can_stats.error_passive++;
74b93b4510dc75 Elaine Zhang      2022-10-28  704  		rcan->can.state = CAN_STATE_ERROR_PASSIVE;
74b93b4510dc75 Elaine Zhang      2022-10-28  705  		/* error passive state */
74b93b4510dc75 Elaine Zhang      2022-10-28  706  		cf->can_id |= CAN_ERR_CRTL;
74b93b4510dc75 Elaine Zhang      2022-10-28  707  		cf->data[1] = (txerr > rxerr) ?
74b93b4510dc75 Elaine Zhang      2022-10-28  708  					CAN_ERR_CRTL_TX_WARNING :
74b93b4510dc75 Elaine Zhang      2022-10-28  709  					CAN_ERR_CRTL_RX_WARNING;
74b93b4510dc75 Elaine Zhang      2022-10-28  710  		cf->data[6] = txerr;
74b93b4510dc75 Elaine Zhang      2022-10-28  711  		cf->data[7] = rxerr;
74b93b4510dc75 Elaine Zhang      2022-10-28  712  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  713  
74b93b4510dc75 Elaine Zhang      2022-10-28  714  	if (rcan->can.state >= CAN_STATE_BUS_OFF ||
74b93b4510dc75 Elaine Zhang      2022-10-28  715  	    ((sta_reg & CAN_BUSOFF_FLAG) == CAN_BUSOFF_FLAG))
74b93b4510dc75 Elaine Zhang      2022-10-28  716  		can_bus_off(ndev);
74b93b4510dc75 Elaine Zhang      2022-10-28  717  
74b93b4510dc75 Elaine Zhang      2022-10-28  718  	stats->rx_packets++;
74b93b4510dc75 Elaine Zhang      2022-10-28  719  	stats->rx_bytes += cf->can_dlc;
74b93b4510dc75 Elaine Zhang      2022-10-28  720  	netif_rx(skb);
74b93b4510dc75 Elaine Zhang      2022-10-28  721  
74b93b4510dc75 Elaine Zhang      2022-10-28  722  	return 0;
74b93b4510dc75 Elaine Zhang      2022-10-28  723  }
74b93b4510dc75 Elaine Zhang      2022-10-28  724  
74b93b4510dc75 Elaine Zhang      2022-10-28  725  static irqreturn_t rk3562_can_interrupt(int irq, void *dev_id)
74b93b4510dc75 Elaine Zhang      2022-10-28  726  {
74b93b4510dc75 Elaine Zhang      2022-10-28  727  	struct net_device *ndev = (struct net_device *)dev_id;
74b93b4510dc75 Elaine Zhang      2022-10-28  728  	struct rk3562_can *rcan = netdev_priv(ndev);
74b93b4510dc75 Elaine Zhang      2022-10-28  729  	struct net_device_stats *stats = &ndev->stats;
74b93b4510dc75 Elaine Zhang      2022-10-28  730  	u32 err_int = ERR_WARN_INT | RX_BUF_OV_INT | PASSIVE_ERR_INT |
74b93b4510dc75 Elaine Zhang      2022-10-28  731  		      TX_LOSTARB_INT | BUS_ERR_INT | BUS_OFF_INT;
74b93b4510dc75 Elaine Zhang      2022-10-28  732  	u32 isr;
74b93b4510dc75 Elaine Zhang      2022-10-28 @733  	u32 dlc = 0;
74b93b4510dc75 Elaine Zhang      2022-10-28  734  
74b93b4510dc75 Elaine Zhang      2022-10-28  735  	isr = rk3562_can_read(rcan, CAN_INT);
74b93b4510dc75 Elaine Zhang      2022-10-28  736  	if (isr & RX_FINISH_INT) {
74b93b4510dc75 Elaine Zhang      2022-10-28  737  		rk3562_can_write(rcan, CAN_INT_MASK,
74b93b4510dc75 Elaine Zhang      2022-10-28  738  				 RX_FINISH_INT | TIMEOUT_INT);
74b93b4510dc75 Elaine Zhang      2022-10-28  739  		napi_schedule(&rcan->napi);
74b93b4510dc75 Elaine Zhang      2022-10-28  740  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  741  	if (isr & TX_FINISH_INT) {
74b93b4510dc75 Elaine Zhang      2022-10-28  742  		dlc = rk3562_can_read(rcan, CAN_TXFIC);
74b93b4510dc75 Elaine Zhang      2022-10-28  743  		/* transmission complete interrupt */
74b93b4510dc75 Elaine Zhang      2022-10-28  744  		stats->tx_packets++;
74b93b4510dc75 Elaine Zhang      2022-10-28  745  		rk3562_can_write(rcan, CAN_CMD, 0);
904a568387b83f Marc Kleine-Budde 2024-09-05  746  		stats->tx_bytes += can_get_echo_skb(ndev, 0, NULL);
74b93b4510dc75 Elaine Zhang      2022-10-28  747  		netif_wake_queue(ndev);
74b93b4510dc75 Elaine Zhang      2022-10-28  748  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  749  
74b93b4510dc75 Elaine Zhang      2022-10-28  750  	if (isr & err_int) {
74b93b4510dc75 Elaine Zhang      2022-10-28  751  		/* error interrupt */
74b93b4510dc75 Elaine Zhang      2022-10-28  752  		if (rk3562_can_err(ndev, isr))
74b93b4510dc75 Elaine Zhang      2022-10-28  753  			netdev_err(ndev, "can't allocate buffer - clearing pending interrupts\n");
74b93b4510dc75 Elaine Zhang      2022-10-28  754  	}
74b93b4510dc75 Elaine Zhang      2022-10-28  755  
74b93b4510dc75 Elaine Zhang      2022-10-28  756  	rk3562_can_write(rcan, CAN_INT, isr);
74b93b4510dc75 Elaine Zhang      2022-10-28  757  	return IRQ_HANDLED;
74b93b4510dc75 Elaine Zhang      2022-10-28  758  }
74b93b4510dc75 Elaine Zhang      2022-10-28  759  

:::::: The code at line 733 was first introduced by commit
:::::: 74b93b4510dc75aedab1ee607dcd35487188332c can: rk3562_can: add rk3562 can driver

:::::: TO: Elaine Zhang <zhangqing@rock-chips.com>
:::::: CC: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

