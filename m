Return-Path: <linux-can+bounces-1425-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE04796DEE7
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 17:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912AD1F21A4E
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9D484D3E;
	Thu,  5 Sep 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5RCVTOr"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF08F507
	for <linux-can@vger.kernel.org>; Thu,  5 Sep 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551537; cv=none; b=Cc5c3ouJELDSddiRG+I4dKXcNu8cYaz/lMqrD+MOAUipi7Dftp3QyI4DtQifd5TQ9w7RwarXtoEVFLYvpfwrA6ERj2XDkq/4fzyLdZrNt1XqGVH2ip83bQa4MythAtK5WQzMk4gbmPFOwKp5xxi7rJFgPzpI1fShmd6czm0tNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551537; c=relaxed/simple;
	bh=VBmJcArQLrwXyXAB6Q4wUKhIXA/Z9GEZDlN0soQpAxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mfoxW2CQKOvHTm9xPO5oLPUqMDF/q1mQTsry7rs0EpST5mcVOKORqoHxafwAPuL0CzG1Fo/UFJ/5BE3oOHDZDLSx2bFpnU7Lc3Pr2xl8dIrqC5H7MiPXOUXOc0p8VP4/fcIWpthWZ3X1Q1TtiAmj7rnq6chhxadG804K4PO2tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5RCVTOr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725551536; x=1757087536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VBmJcArQLrwXyXAB6Q4wUKhIXA/Z9GEZDlN0soQpAxA=;
  b=X5RCVTOrRxFbW4TFt6jsJCtYhMWP5vY3qspt6v/NdUL+RnKzrkazMUtV
   iocIeTwN6Y63V1/hfUbhxczhKxGWiLxSCFULT+hrwtn/gOAPxHOwhWlK4
   OHcJHeUFq3Fx9nZ6KiByqrYG5TmEnTNYh/+hElSjAQXzJ8JB3qhsptSX6
   FOrQW12p/fP7S+dUhyoSchXwzfhWaIfh3shdEukyNxStGJ/7FP5yoichr
   laWL4+bmVxqy2PmjFoFX9ernHd1PXBRF6h8L/0QHK0c2KUATZElIgS0z3
   hDWMf/4Gd3DDNZIzsS5fzUNovKYnhviqYFpGJ68fNgPwan/YvEVB6J6Vv
   A==;
X-CSE-ConnectionGUID: iY3ugwhrQkWothFOViGoWw==
X-CSE-MsgGUID: 2zW2DI6sScGUhD43gvcKGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24394081"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24394081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:52:15 -0700
X-CSE-ConnectionGUID: 2jk9ag5eT4mLg8bJklNH+g==
X-CSE-MsgGUID: i+pJ4MeISfW1vYm64meMLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65698386"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Sep 2024 08:52:13 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smEmJ-000A4V-0O;
	Thu, 05 Sep 2024 15:52:11 +0000
Date: Thu, 5 Sep 2024 23:51:15 +0800
From: kernel test robot <lkp@intel.com>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [mkl-can-next:rockchip-canfd-downstream 31/32]
 drivers/net/can/rockchip/rk3562_can.c:27:10: fatal error: linux/can/led.h:
 No such file or directory
Message-ID: <202409052331.YSMkLfF3-lkp@intel.com>
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
commit: 7e7b481ee3f0ca0a564bb3da3fe4f391da459ac2 [31/32] can: rk3562_can: add rk3562 can driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240905/202409052331.YSMkLfF3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409052331.YSMkLfF3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409052331.YSMkLfF3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/can/rockchip/rk3562_can.c:27:10: fatal error: linux/can/led.h: No such file or directory
      27 | #include <linux/can/led.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.


vim +27 drivers/net/can/rockchip/rk3562_can.c

  > 27	#include <linux/can/led.h>
    28	#include <linux/reset.h>
    29	#include <linux/pm_runtime.h>
    30	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

