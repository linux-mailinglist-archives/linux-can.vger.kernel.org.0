Return-Path: <linux-can+bounces-3731-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FBAC7894
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 08:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D207A32C9
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 06:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847720E00A;
	Thu, 29 May 2025 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hu5NDYU1"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358581E25FA
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499340; cv=none; b=D0qeGROmnx3aQXiAnL8vhNQVrSj+qU6NOmctrZB4qdfQfx0IvfvtcGq4YqOT01WG7Q2BDR454GN3T695OwBbhuskjaruFfl6F9/8pD265Ed/vpRylZpM0sqqDL0oq2RxeKX8yODRTzOeEvpHgSOwKi8enT6TjLNeuryIhra2sZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499340; c=relaxed/simple;
	bh=ohjCYPOzZJeoiC8Htfdxwlv23aNNYpgAYFa2HZhhkzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=swKXZExv3LAlZ4FCAXB9XSeau9MQ7E98NI9n5XUQfpuGhQfbxyLObboxN9WL/G1GJcv7m5FiGJ7MojFRsXtVLbP7Hd7oCQUpjvlo1QzDEIVpKXUCSgkL7KNu+m4JxbbfzbCLv8S9i7Lr0W4OfaFQdLlpmcfTC4G4iU9u35Gjvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hu5NDYU1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748499338; x=1780035338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ohjCYPOzZJeoiC8Htfdxwlv23aNNYpgAYFa2HZhhkzU=;
  b=hu5NDYU1U1FgLTzznHoy2NltiFFkliIv97Djgr+yWR3jVWLBj12f+ed8
   4F7Fl4aKWiHN1vG3mPk/K9e16hupiQ6qcLgFxQX7vFZRrv4oeu1HSlN9e
   8SS6tDib+AoneR0dhRYwLy/8dXMYj8jKWNg6StIqh/+FzqPN6DQlg++CF
   Q3PrSFraACDVGmoHsFBiFYbkq6yLetuEHk3r8U8nZzgZHV/MQlgu3694Q
   1M4B5BhPF4eFSgbXDkMZCgD1W9BxVPJSv+cW+yhZGyaTmUPI4DpTIIzaB
   7ElDnxk7zjVJxeoErLC0w594F8myomWFxQT8kcJKZnYpkgQl0iJx0QPng
   g==;
X-CSE-ConnectionGUID: IkUywY5AQ4iqRnb7Zb07hA==
X-CSE-MsgGUID: 9aORXkKCR72rbbODpzcmmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68096920"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="68096920"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:15:37 -0700
X-CSE-ConnectionGUID: nI4yorGdQrmbHtzmXC3Y1w==
X-CSE-MsgGUID: jHw2CYS+QZuu5cbqWuXbjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143453048"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2025 23:15:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKWY9-000WNo-2b;
	Thu, 29 May 2025 06:15:33 +0000
Date: Thu, 29 May 2025 14:15:06 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [mkl-can-next:b4/can-xl 6/11] drivers/net/can/xilinx_can.c:518:7:
 error: call to undeclared function 'can_tdc_is_enabled'; ISO C99 and later
 do not support implicit function declarations
Message-ID: <202505291443.O21tBseZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git b4/can-xl
head:   7861c36608b1d1f26b010a9c465c048137d9d156
commit: 48f48b8238cc98e533eaeda03271a101ccdac359 [6/11] can: netlink: add CAN XL support
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250529/202505291443.O21tBseZ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505291443.O21tBseZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505291443.O21tBseZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/can/xilinx_can.c:518:7: error: call to undeclared function 'can_tdc_is_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     518 |                 if (can_tdc_is_enabled(&priv->can)) {
         |                     ^
>> drivers/net/can/xilinx_can.c:520:55: error: no member named 'tdc' in 'struct can_priv'
     520 |                                 btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
         |                                                                         ~~~~~~~~~ ^
   include/linux/bitfield.h:115:33: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                                               ^~~~
   include/linux/bitfield.h:68:41: note: expanded from macro '__BF_FIELD_CHECK'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                                                       ^~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                                          ^~~~
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/can/xilinx_can.c:520:55: error: no member named 'tdc' in 'struct can_priv'
     520 |                                 btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
         |                                                                         ~~~~~~~~~ ^
   include/linux/bitfield.h:115:33: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                                               ^~~~
   include/linux/bitfield.h:70:12: note: expanded from macro '__BF_FIELD_CHECK'
      70 |                                         (0 + (_val)) : 0,               \
         |                                               ^~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                                          ^~~~
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/can/xilinx_can.c:520:55: error: no member named 'tdc' in 'struct can_priv'
     520 |                                 btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
         |                                                                         ~~~~~~~~~ ^
   include/linux/bitfield.h:116:20: note: expanded from macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                  ^~~~
   drivers/net/can/xilinx_can.c:523:57: error: no member named 'tdc' in 'struct can_priv'
     523 |                                 btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
         |                                                                           ~~~~~~~~~ ^
   include/linux/bitfield.h:115:33: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                                               ^~~~
   include/linux/bitfield.h:68:41: note: expanded from macro '__BF_FIELD_CHECK'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                                                       ^~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                                          ^~~~
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/net/can/xilinx_can.c:523:57: error: no member named 'tdc' in 'struct can_priv'
     523 |                                 btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
         |                                                                           ~~~~~~~~~ ^
   include/linux/bitfield.h:115:33: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                                               ^~~~
   include/linux/bitfield.h:70:12: note: expanded from macro '__BF_FIELD_CHECK'
      70 |                                         (0 + (_val)) : 0,               \
         |                                               ^~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                                          ^~~~
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/net/can/xilinx_can.c:523:57: error: no member named 'tdc' in 'struct can_priv'
     523 |                                 btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
         |                                                                           ~~~~~~~~~ ^
   include/linux/bitfield.h:116:20: note: expanded from macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                  ^~~~
>> drivers/net/can/xilinx_can.c:1972:13: error: no member named 'tdc_const' in 'struct can_priv'
    1972 |                 priv->can.tdc_const = &xcan_tdc_const_canfd;
         |                 ~~~~~~~~~ ^
   drivers/net/can/xilinx_can.c:1978:13: error: no member named 'tdc_const' in 'struct can_priv'
    1978 |                 priv->can.tdc_const = &xcan_tdc_const_canfd2;
         |                 ~~~~~~~~~ ^
>> drivers/net/can/xilinx_can.c:1985:13: error: no member named 'do_get_auto_tdcv' in 'struct can_priv'
    1985 |                 priv->can.do_get_auto_tdcv = xcan_get_auto_tdcv;
         |                 ~~~~~~~~~ ^
   10 errors generated.


vim +/can_tdc_is_enabled +518 drivers/net/can/xilinx_can.c

   472	
   473	/**
   474	 * xcan_set_bittiming - CAN set bit timing routine
   475	 * @ndev:	Pointer to net_device structure
   476	 *
   477	 * This is the driver set bittiming  routine.
   478	 * Return: 0 on success and failure value on error
   479	 */
   480	static int xcan_set_bittiming(struct net_device *ndev)
   481	{
   482		struct xcan_priv *priv = netdev_priv(ndev);
   483		struct can_bittiming *bt = &priv->can.bittiming;
   484		struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
   485		u32 btr0, btr1;
   486		u32 is_config_mode;
   487	
   488		/* Check whether Xilinx CAN is in configuration mode.
   489		 * It cannot set bit timing if Xilinx CAN is not in configuration mode.
   490		 */
   491		is_config_mode = priv->read_reg(priv, XCAN_SR_OFFSET) &
   492					XCAN_SR_CONFIG_MASK;
   493		if (!is_config_mode) {
   494			netdev_alert(ndev,
   495				     "BUG! Cannot set bittiming - CAN is not in config mode\n");
   496			return -EPERM;
   497		}
   498	
   499		/* Setting Baud Rate prescaler value in BRPR Register */
   500		btr0 = (bt->brp - 1);
   501	
   502		/* Setting Time Segment 1 in BTR Register */
   503		btr1 = (bt->prop_seg + bt->phase_seg1 - 1);
   504	
   505		/* Setting Time Segment 2 in BTR Register */
   506		btr1 |= (bt->phase_seg2 - 1) << priv->devtype.btr_ts2_shift;
   507	
   508		/* Setting Synchronous jump width in BTR Register */
   509		btr1 |= (bt->sjw - 1) << priv->devtype.btr_sjw_shift;
   510	
   511		priv->write_reg(priv, XCAN_BRPR_OFFSET, btr0);
   512		priv->write_reg(priv, XCAN_BTR_OFFSET, btr1);
   513	
   514		if (priv->devtype.cantype == XAXI_CANFD ||
   515		    priv->devtype.cantype == XAXI_CANFD_2_0) {
   516			/* Setting Baud Rate prescaler value in F_BRPR Register */
   517			btr0 = dbt->brp - 1;
 > 518			if (can_tdc_is_enabled(&priv->can)) {
   519				if (priv->devtype.cantype == XAXI_CANFD)
 > 520					btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
   521						XCAN_BRPR_TDC_ENABLE;
   522				else
   523					btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.tdc.tdco) |
   524						XCAN_BRPR_TDC_ENABLE;
   525			}
   526	
   527			/* Setting Time Segment 1 in BTR Register */
   528			btr1 = dbt->prop_seg + dbt->phase_seg1 - 1;
   529	
   530			/* Setting Time Segment 2 in BTR Register */
   531			btr1 |= (dbt->phase_seg2 - 1) << priv->devtype.btr_ts2_shift;
   532	
   533			/* Setting Synchronous jump width in BTR Register */
   534			btr1 |= (dbt->sjw - 1) << priv->devtype.btr_sjw_shift;
   535	
   536			priv->write_reg(priv, XCAN_F_BRPR_OFFSET, btr0);
   537			priv->write_reg(priv, XCAN_F_BTR_OFFSET, btr1);
   538		}
   539	
   540		netdev_dbg(ndev, "BRPR=0x%08x, BTR=0x%08x\n",
   541			   priv->read_reg(priv, XCAN_BRPR_OFFSET),
   542			   priv->read_reg(priv, XCAN_BTR_OFFSET));
   543	
   544		return 0;
   545	}
   546	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

