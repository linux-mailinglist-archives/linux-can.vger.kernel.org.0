Return-Path: <linux-can+bounces-2094-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E15CB9D15F5
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 17:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60792829A9
	for <lists+linux-can@lfdr.de>; Mon, 18 Nov 2024 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1671AA1EE;
	Mon, 18 Nov 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bK9z7SDX"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3919DFA4
	for <linux-can@vger.kernel.org>; Mon, 18 Nov 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948786; cv=none; b=ZHkPp/qsJZkHQnYUlsbrVOHfcMJkwpljodztGe9rhLzCslG8nJrmY991+BfLMVkObcaF5A+DVbL9nv+Nl/ebxc5f39vb02/JBTKIbuybm+0N/2Wzhpo5ZtejpXqm+G8PpXm6UtsWXvxTNMvChStdekjUx2KAUB/n+QxD42Mf6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948786; c=relaxed/simple;
	bh=IlE5jQMC28qvEIO1TsmfMkUNehxSyMRk/N6i1dXZ0VA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tQOjXvbs9E9c/O84MdfNkCLeyNcBxcGHaYZyoovfpcsMX+x1VuefpXC2mRW420ookxv87vV2rgYmx5cTsAQLjOfAQP6Erq0LqCX01lLk1bfacUJlFif29F018ONNp7rKsAX68yamB5nNyV8dsXQGPlIcU526YBzGZ5x5GueihV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bK9z7SDX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731948784; x=1763484784;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IlE5jQMC28qvEIO1TsmfMkUNehxSyMRk/N6i1dXZ0VA=;
  b=bK9z7SDXQeSZOoX7kuT5fg9HUXXVE/NeKbngLNWlLdmOSiYve/NXQdeX
   BE2c9arqWrqxSrL9XdgLQKp4BNxxZYzoCBHCqVN4pnwNSbwwR5PddYjyY
   JyoQlV+Ei4B6Cqi3gDD6Zxu6Vzgg15tQstOlrnKUrVnzxFB0PFrfKPJ8N
   iTnZjjSGXY7e9PoLzYFsSoyVUzvlk1NM5dNaL1WJB6Nv+NmJygIzkMGXN
   XwcFrxfb/DqmnuuH8dlArSuolwg9R1v1TXN4Cr5sx5X6ExMjBMUDvDrcc
   TVCfihDzPmA7sikwilG0mVWyrjxG1T5GKKKJiwcSkgRcuV9GpIPxVrFfO
   w==;
X-CSE-ConnectionGUID: WZ5kUc1iQ/q2EMiSUlG+Fg==
X-CSE-MsgGUID: scfl4wwfRJKgrbdfHIQQ0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31321465"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31321465"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 08:53:03 -0800
X-CSE-ConnectionGUID: AIFHBgNZRyy9PyE3dm02qQ==
X-CSE-MsgGUID: /LEg28OKQ3uZ9zslWRsbpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89427910"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2024 08:53:01 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tD4zi-0002Y2-0C;
	Mon, 18 Nov 2024 16:52:58 +0000
Date: Tue, 19 Nov 2024 00:51:59 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [mkl-can-next:testing 4/5]
 drivers/net/can/m_can/tcan4x5x-core.c:333:22: warning: unused variable 'np'
Message-ID: <202411190037.WDcg9NkS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
head:   e0b741bc53c94f9ae25d4140202557a0aa51b5a0
commit: 490105aa8f79a2f96de9c6c23fb22437faf0d6a4 [4/5] can: tcan4x5x: add option for selecting nWKRQ voltage
config: x86_64-buildonly-randconfig-004-20241118 (https://download.01.org/0day-ci/archive/20241119/202411190037.WDcg9NkS-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241119/202411190037.WDcg9NkS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411190037.WDcg9NkS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/can/m_can/tcan4x5x-core.c:5:
   In file included from drivers/net/can/m_can/tcan4x5x.h:14:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/can/m_can/tcan4x5x-core.c:333:22: warning: unused variable 'np' [-Wunused-variable]
     333 |         struct device_node *np = cdev->dev->of_node;
         |                             ^~
   5 warnings generated.


vim +/np +333 drivers/net/can/m_can/tcan4x5x-core.c

   329	
   330	static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
   331	{
   332		struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 > 333		struct device_node *np = cdev->dev->of_node;
   334	
   335		tcan4x5x->nwkrq_voltage_vio =
   336			of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
   337	}
   338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

