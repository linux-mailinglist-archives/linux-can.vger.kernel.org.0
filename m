Return-Path: <linux-can+bounces-1016-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCDC93DE2D
	for <lists+linux-can@lfdr.de>; Sat, 27 Jul 2024 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0712C1C20D1D
	for <lists+linux-can@lfdr.de>; Sat, 27 Jul 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535F4653A;
	Sat, 27 Jul 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOcg2so2"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5249405C9;
	Sat, 27 Jul 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722072810; cv=none; b=uDNw5FG/0rEyo+iOQoOfX1RfGk/SHvkl0CgHQbrJikzsB67Sj5ACL0uTKX0uXu/e85SisiHrQNLfLA3w8l94KvSC0VYF9qU8rZc9bTO4n/cweyu9rtfuKJ+8itsFXdP/hAf0A8REf/2FVefp1nRGOQ/hjeWCbUdODgMv4dwosLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722072810; c=relaxed/simple;
	bh=96QOIG/h1nLnig5TjvXXPOrhIEeMRrOBAX7BbjccgxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm6AMH4fLrwWrCq0fKHfsfF63wO9COpEEOg/+o6W4uZxMIGLno2WtEi7u6dv1YJ/e66/YlRcKS3iUG57UwY0vr9UPPa7zj4OjzFtPGSPwu8vku1Q9q+/hoVfXslp8jKEYZ6XPswwwZUrdYY/xELD2l5j+d2CuocmU3YbvkcFSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOcg2so2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722072808; x=1753608808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=96QOIG/h1nLnig5TjvXXPOrhIEeMRrOBAX7BbjccgxY=;
  b=LOcg2so2GtBM2bmRGc2elBkIErkIdedlyCVu8ikxygK3WL6t9ahFXzm7
   iX7++6im8ga1hna5wh0VNWpwFJlnHpaioJLCWVRVVVdWfNVoVIsPFToT6
   d7P12H/tn5cw1LnVbV304YXm14YnzxuX4Nghg9bIjB/zIsTv0dvdmoYFi
   cCal4ZL7naKFul9grlk6k6dUct4jWb8MXfoySM0v2K0f0Gy+cBxfH25QU
   qBs8PDBOaWHYk7m8wk+vb+AoLNsnXW6ufEJmRN2Bz1FBnMgqdPXWgyi9K
   1MfdPAIxq8G38Zppci+PZUCmACFzeLt6lU/G2YkRUYD8coGDBbAAEksJN
   A==;
X-CSE-ConnectionGUID: H7ZtnrnMReix0w8b7bjTEg==
X-CSE-MsgGUID: OG5IZX79TZyFr41IOdzkQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="23623102"
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="23623102"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 02:33:27 -0700
X-CSE-ConnectionGUID: 5BsX9X7rT/uE1OY406do8A==
X-CSE-MsgGUID: H/UUFVt3SzWj6VvkW03j2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="54279932"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Jul 2024 02:33:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXdnk-000pou-0b;
	Sat, 27 Jul 2024 09:33:20 +0000
Date: Sat, 27 Jul 2024 17:32:25 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] can: m_can: Do not cancel timer from within timer
Message-ID: <202407271748.gsVE0Hih-lkp@intel.com>
References: <20240726195944.2414812-5-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726195944.2414812-5-msp@baylibre.com>

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkl-can-next/testing]
[also build test WARNING on linus/master v6.10 next-20240726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/can-m_can-Reset-coalescing-during-suspend-resume/20240727-042714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20240726195944.2414812-5-msp%40baylibre.com
patch subject: [PATCH 4/7] can: m_can: Do not cancel timer from within timer
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240727/202407271748.gsVE0Hih-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240727/202407271748.gsVE0Hih-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407271748.gsVE0Hih-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/m_can/m_can.c:1205: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This interrupt handler is called either from the interrupt thread or a


vim +1205 drivers/net/can/m_can/m_can.c

  1203	
  1204	/**
> 1205	 * This interrupt handler is called either from the interrupt thread or a
  1206	 * hrtimer. This has implications like cancelling a timer won't be possible
  1207	 * blocking.
  1208	 */
  1209	static int m_can_interrupt_handler(struct m_can_classdev *cdev)
  1210	{
  1211		struct net_device *dev = cdev->net;
  1212		u32 ir;
  1213		int ret;
  1214	
  1215		if (pm_runtime_suspended(cdev->dev))
  1216			return IRQ_NONE;
  1217	
  1218		ir = m_can_read(cdev, M_CAN_IR);
  1219		m_can_coalescing_update(cdev, ir);
  1220		if (!ir)
  1221			return IRQ_NONE;
  1222	
  1223		/* ACK all irqs */
  1224		m_can_write(cdev, M_CAN_IR, ir);
  1225	
  1226		if (cdev->ops->clear_interrupts)
  1227			cdev->ops->clear_interrupts(cdev);
  1228	
  1229		/* schedule NAPI in case of
  1230		 * - rx IRQ
  1231		 * - state change IRQ
  1232		 * - bus error IRQ and bus error reporting
  1233		 */
  1234		if (ir & (IR_RF0N | IR_RF0W | IR_ERR_ALL_30X)) {
  1235			cdev->irqstatus = ir;
  1236			if (!cdev->is_peripheral) {
  1237				m_can_disable_all_interrupts(cdev);
  1238				napi_schedule(&cdev->napi);
  1239			} else {
  1240				ret = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
  1241				if (ret < 0)
  1242					return ret;
  1243			}
  1244		}
  1245	
  1246		if (cdev->version == 30) {
  1247			if (ir & IR_TC) {
  1248				/* Transmission Complete Interrupt*/
  1249				u32 timestamp = 0;
  1250				unsigned int frame_len;
  1251	
  1252				if (cdev->is_peripheral)
  1253					timestamp = m_can_get_timestamp(cdev);
  1254				frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
  1255				m_can_finish_tx(cdev, 1, frame_len);
  1256			}
  1257		} else  {
  1258			if (ir & (IR_TEFN | IR_TEFW)) {
  1259				/* New TX FIFO Element arrived */
  1260				ret = m_can_echo_tx_event(dev);
  1261				if (ret != 0)
  1262					return ret;
  1263			}
  1264		}
  1265	
  1266		if (cdev->is_peripheral)
  1267			can_rx_offload_threaded_irq_finish(&cdev->offload);
  1268	
  1269		return IRQ_HANDLED;
  1270	}
  1271	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

