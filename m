Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6639D68E1A7
	for <lists+linux-can@lfdr.de>; Tue,  7 Feb 2023 21:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBGUBg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Feb 2023 15:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBGUBf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2023 15:01:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E93EFC3
        for <linux-can@vger.kernel.org>; Tue,  7 Feb 2023 12:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675800092; x=1707336092;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4xIeivNeheGV10GaSYDAa//tf69jn6+aAcKRYxVOcsw=;
  b=WHw+5tDIm5Qb5Qnxqxf+THQE5j+Brl900u6ExgnPfNHQA4raBl6FvgdC
   RMcVEO6ebMmYYdvjyMMoMLi4BBCrUqwJpiIyTx5ClQnZISaX1XG55IxwT
   VdeBvYG9y1LtO+ajRrSMU23qLh9zUVBpx629cSwyAKyAcI+p9Yq1oJ9Xj
   n/1TPtEe1IR2Od6vOSBJRdidxVsaDMsteXtn8xMQvdmbdionhSjvQD8Cw
   Q0+v7RRadn6czK1h22vibOLhcqh7gN8aj/K03uswVhoUfPRmSCDISqO7v
   gGhBt3aysVgSKqnKPvToF2cjt5V6tp19lC6gSHZ4XqjXwE1reVMBiQi0P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327304275"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="327304275"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 12:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="790922519"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="790922519"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2023 12:01:30 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPU9i-0003qY-0Q;
        Tue, 07 Feb 2023 20:01:30 +0000
Date:   Wed, 8 Feb 2023 04:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: [mkl-can-next:testing 42/51] drivers/net/can/dev/bittiming.c:79:24:
 error: too many arguments to function 'can_calc_bittiming'
Message-ID: <202302080358.PGPjdXwE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
head:   3dafbe5cc1409dd2e3fc2955b0026c1ba7dfa323
commit: 286c0e09e8e07de0f116a01aa234b05d9956dcf5 [42/51] can: bittiming: can_changelink() pass extack down callstack
config: parisc-randconfig-r026-20230205 (https://download.01.org/0day-ci/archive/20230208/202302080358.PGPjdXwE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=286c0e09e8e07de0f116a01aa234b05d9956dcf5
        git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
        git fetch --no-tags mkl-can-next testing
        git checkout 286c0e09e8e07de0f116a01aa234b05d9956dcf5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/can/dev/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/can/dev/bittiming.c: In function 'can_get_bittiming':
>> drivers/net/can/dev/bittiming.c:79:24: error: too many arguments to function 'can_calc_bittiming'
      79 |                 return can_calc_bittiming(dev, bt, btc, extack);
         |                        ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/can/dev.h:18,
                    from drivers/net/can/dev/bittiming.c:7:
   include/linux/can/bittiming.h:126:1: note: declared here
     126 | can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
         | ^~~~~~~~~~~~~~~~~~


vim +/can_calc_bittiming +79 drivers/net/can/dev/bittiming.c

    66	
    67	int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
    68			      const struct can_bittiming_const *btc,
    69			      const u32 *bitrate_const,
    70			      const unsigned int bitrate_const_cnt,
    71			      struct netlink_ext_ack *extack)
    72	{
    73		/* Depending on the given can_bittiming parameter structure the CAN
    74		 * timing parameters are calculated based on the provided bitrate OR
    75		 * alternatively the CAN timing parameters (tq, prop_seg, etc.) are
    76		 * provided directly which are then checked and fixed up.
    77		 */
    78		if (!bt->tq && bt->bitrate && btc)
  > 79			return can_calc_bittiming(dev, bt, btc, extack);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
