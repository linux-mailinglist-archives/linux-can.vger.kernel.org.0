Return-Path: <linux-can+bounces-1424-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF2496DA79
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 15:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7DD1C22F5A
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4169C19CCE2;
	Thu,  5 Sep 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqNtYyoo"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F38519CC23
	for <linux-can@vger.kernel.org>; Thu,  5 Sep 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543364; cv=none; b=eDdj/yMUthgxCRhQRVqiYH7mzgyY04GGTszKGRuPx/GoaNdALmojfYsclnbapd3zgHMmkE7cQ1DTOIrJCUtqgzanZHnK22W9Ex8dzpdAwzn4M4SfP6Qi9dWhhhTSMpgaQlYhTKAubzyTROU36rCFpizssFdwavGvtAi7Y/fQRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543364; c=relaxed/simple;
	bh=Y+P2j2qrwSnMDqeWUSlId8+yFQS3DtwH7Wxq2ewUubE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pAEqoB76MBCc5U+vDGNYkOju6A0VVR51eAxFyXI6lQpuHWvR1dUEvkU0A7igr5xsn2X6PU/Z0Q3f5iofliiFo/j8k/ScUnNuEIuwPWg112ocbeFzUgZ/KE98V7JeBnL2GdzbxVL47nsPDaowklD6J4HxnGTzAWi7M2XJf+HHDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqNtYyoo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725543363; x=1757079363;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y+P2j2qrwSnMDqeWUSlId8+yFQS3DtwH7Wxq2ewUubE=;
  b=lqNtYyooj1EHdeTeCkUWVfK5XNLPJA6r3ZHNBbUgwlm2GvnkhwE648NF
   7UgoEyShLNDTYeaCLQ6KWQ9jICLNE+lsonrPVOGnhzT7MvFPuFKS/svsj
   zDhHRhGsLZ+xrFOnQIdoMPFtfvbrlPZBx7OyGac2bAW+RHGVaYp581Z3r
   EZ4+gfPjls6lnewXW/QU5IJHinYzVslK+yRIeC02eZLtbK7jacCCEPuYX
   sOLR4CuzZ/KzyHVbHOGGBcn0l7d6xK0aEXVJofPEiGXTpDi2gP0ngd6bi
   8MjreZPZY8mI3B86QuIEJdiD3Pf8TxCgBu2M+X0wIJMh/KwPniuIVvu5p
   w==;
X-CSE-ConnectionGUID: Z+GOsm/rSKWfQJ+eHDAoyA==
X-CSE-MsgGUID: LwwZDUIQRJC65g49SmSlPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="28049269"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="28049269"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 06:36:02 -0700
X-CSE-ConnectionGUID: jZDU/06vS5eHmtiyiZBExQ==
X-CSE-MsgGUID: DRKUsx1rSJG5TEkPiQ+n1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65324357"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Sep 2024 06:36:00 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smCeU-0009wK-1z;
	Thu, 05 Sep 2024 13:35:58 +0000
Date: Thu, 5 Sep 2024 21:35:56 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: [mkl-can-next:rockchip-canfd-downstream 28/32]
 drivers/net/can/rockchip/rockchip_canfd.c:29:10: fatal error:
 linux/rockchip/cpu.h: No such file or directory
Message-ID: <202409052113.UCbJ9FFA-lkp@intel.com>
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
commit: 4e81d160c560ca2fea7805dee1c5262965268d93 [28/32] can: rockchip_canfd: remove obsolete CAN LED support
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240905/202409052113.UCbJ9FFA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409052113.UCbJ9FFA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409052113.UCbJ9FFA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/can/rockchip/rockchip_canfd.c:29:10: fatal error: linux/rockchip/cpu.h: No such file or directory
      29 | #include <linux/rockchip/cpu.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +29 drivers/net/can/rockchip/rockchip_canfd.c

b532c83f2c336c Elaine Zhang 2023-07-28 @29  #include <linux/rockchip/cpu.h>
4a0161b0041f1c Elaine Zhang 2020-07-13  30  

:::::: The code at line 29 was first introduced by commit
:::::: b532c83f2c336c54747f77f90831bd498505dbf4 can: rockchip_canfd: support rk3568 can v2

:::::: TO: Elaine Zhang <zhangqing@rock-chips.com>
:::::: CC: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

