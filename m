Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807B752B2FC
	for <lists+linux-can@lfdr.de>; Wed, 18 May 2022 09:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiERHG0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 May 2022 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiERHGD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 May 2022 03:06:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E18019C0D
        for <linux-can@vger.kernel.org>; Wed, 18 May 2022 00:06:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nrDkt-0000Oz-Hu
        for linux-can@vger.kernel.org; Wed, 18 May 2022 09:05:59 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0ABFB80F45
        for <linux-can@vger.kernel.org>; Wed, 18 May 2022 07:05:58 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id kNvxGkWWhGLiAAcAs6a69A
        (envelope-from <lkp@intel.com>)
        for <mkl-all@blackshift.org>; Wed, 18 May 2022 06:46:29 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5FCA980EFA
        for <mkl-all@blackshift.org>; Wed, 18 May 2022 06:46:29 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5910180EF9
        for <ptx@kleine-budde.de>; Wed, 18 May 2022 06:46:29 +0000 (UTC)
Received: from mga01.intel.com ([192.55.52.88])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nrDRz-00069y-5N
        for mkl@pengutronix.de; Wed, 18 May 2022 08:46:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652856387; x=1684392387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eFg/OiSzC+FbPf82f+mKznpjNGbY+1W6OsvZJl8tgKA=;
  b=A0EjyEpaMxUVeAqhCBpch7wkaSwRZ9uTyqkBjacqLx2V6D1xkg9BjywQ
   aFxdY4gk6WrO6jl+zhUFicvsOEAaIPJzStunN2yJHBoJ9tk2cOXOBAF4s
   iF0X6fMcHFbvTr3bQQRVQzb8ne5MPllgfOCRdb0fXkFPjPtSkYDptUzr6
   JC4LVj6nN1ncopDF9YnIHGEmPAjRLzFAyXDBNRugNovHRwr5KTAR4Fj2m
   96cEJ++W6vZa5a434YP/sN6tMRss0161GYVy41SddeNWeX3ZTZJ9uNycO
   3JuWA6k/DYLtvhcqyTr+AIu2FrEnQYKiHDe/kMaBhv/xDg2CRDYxFSs7z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="296799846"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="296799846"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 23:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="660994892"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 23:46:21 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrDRs-0001t1-D4;
        Wed, 18 May 2022 06:46:20 +0000
Date:   Wed, 18 May 2022 14:45:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Message-ID: <202205181414.n8QRDe8k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field
 hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than
 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to ...
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   210e04ff768142b96452030c4c2627512b30ad95
commit: eb79a267c9b3e608e7762a1b221428f37ace3aa3 can: mcp251xfd: rename all remaining occurrence to mcp251xfd
date:   1 year, 8 months ago
config: arm-randconfig-c002-20220518 (https://download.01.org/0day-ci/archive/20220518/202205181414.n8QRDe8k-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb79a267c9b3e608e7762a1b221428f37ace3aa3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout eb79a267c9b3e608e7762a1b221428f37ace3aa3
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
                                                  ^
   drivers/net/can/spi/mcp251xfd/mcp251xfd.h:485:34: warning: field hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' is less aligned than 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
                                                  ^
   drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:511:1: warning: unused function 'mcp251xfd_chip_set_mode_nowait' [-Wunused-function]
   mcp251xfd_chip_set_mode_nowait(const struct mcp251xfd_priv *priv,
   ^
   3 warnings generated.
--
>> drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
                                                  ^
   drivers/net/can/spi/mcp251xfd/mcp251xfd.h:485:34: warning: field hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' is less aligned than 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
                                                  ^
   2 warnings generated.


vim +481 drivers/net/can/spi/mcp251xfd/mcp251xfd.h

   477	
   478	union mcp251xfd_tx_obj_load_buf {
   479		struct __packed {
   480			struct mcp251xfd_buf_cmd cmd;
 > 481			struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
   482		} nocrc;
   483		struct __packed {
   484			struct mcp251xfd_buf_cmd_crc cmd;
   485			struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
   486			__be16 crc;
   487		} crc;
   488	} ____cacheline_aligned;
   489	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

