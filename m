Return-Path: <linux-can+bounces-4768-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C9B8CB24
	for <lists+linux-can@lfdr.de>; Sat, 20 Sep 2025 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4993A91AD
	for <lists+linux-can@lfdr.de>; Sat, 20 Sep 2025 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75DD2FB63B;
	Sat, 20 Sep 2025 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFrFFbYI"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1618BBAE;
	Sat, 20 Sep 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380715; cv=none; b=Rz/2q3Lt2Tkthg9Umq/Zjs67HZm6pSeb9ZjNdg4dcPyaOfHW2r5CRKEH8e8l1XLnQkKv4kQ9XcqfIcScV2DeHkDPEU2I0cOKKFsxNGZyOZydrQ4AGFt9esv3K3uZGCH1YCFKxlxHT1UFjXqkjeMQNp2p1LExTYvU1uJ4pS/tuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380715; c=relaxed/simple;
	bh=S/kIsn8Xdn5ahWxA0vX3rwBX17DpSAj9iWA6E0xz1pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2uAr6ru2/1YhHLxb9VNH1wQAw9KDti48BhBh2UI0zq9yPQFMstHowVbVGStgdHL8la3NueifQV8Auh+YeMf/ivG29NuMaZFukIJciTpXieJWiYFShHwb6XEKm5V2NvkW6IzD1ebL3fOBE5d9vaOVyZ3w1Tll7/2Z9vpPHroHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFrFFbYI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758380714; x=1789916714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/kIsn8Xdn5ahWxA0vX3rwBX17DpSAj9iWA6E0xz1pM=;
  b=EFrFFbYI7TuoEfZC6afRN6prOH+Sg9d6E49SWHkMlycT/GnijFIgbTux
   W7UOChw+8G7jshepRgpJ98ulUjPUMyb5UW4lF0wgT5b0N6oQmWzl+XKdp
   5afSHCsPY2WYppuwk3+nzdZgHbPSUQyZuEiOwRmSFNpUq8v7Txc9Zi12a
   nY3rct1+Edty8C3BldANLF67iQxyz4ofM015MXg8Hcz5cKiAdZSy6KK5w
   qLrMlRp0oZZf3m6ByLzgOTHede4NACOqrMIO67KY5DmeLRcfcg9G+qWnK
   E3ijdMsbF8cTlYaFCgqMvkZu3gvSw0mJ6Faf8Abpe7LIZysB7fL+G2Ufr
   Q==;
X-CSE-ConnectionGUID: tohuCIweR5mD4LC1W2W1sQ==
X-CSE-MsgGUID: GrHQufwhTwmTC20xbnybDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64507614"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64507614"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 08:05:13 -0700
X-CSE-ConnectionGUID: QVLWmORtT9Kz1OzN9qG+2w==
X-CSE-MsgGUID: 7bZrQKh9SpaIKU9RTiACeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="181344706"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:05:09 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzz98-0005P9-1B;
	Sat, 20 Sep 2025 15:05:06 +0000
Date: Sat, 20 Sep 2025 23:04:51 +0800
From: kernel test robot <lkp@intel.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mkl@pengutronix.de,
	mani@kernel.org, thomas.kopp@microchip.com,
	mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mukesh.savaliya@oss.qualcomm.com,
	anup.kulkarni@oss.qualcomm.com,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v4 4/6] can: mcp251xfd: only configure PIN1 when rx_int
 is set
Message-ID: <202509210053.BtsqeDKp-lkp@intel.com>
References: <20250918064903.241372-5-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918064903.241372-5-viken.dadhaniya@oss.qualcomm.com>

Hi Viken,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkl-can-next/testing]
[also build test WARNING on linus/master v6.17-rc6 next-20250919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Viken-Dadhaniya/can-mcp251xfd-move-chip-sleep-mode-into-runtime-pm/20250918-145404
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20250918064903.241372-5-viken.dadhaniya%40oss.qualcomm.com
patch subject: [PATCH v4 4/6] can: mcp251xfd: only configure PIN1 when rx_int is set
config: x86_64-randconfig-123-20250920 (https://download.01.org/0day-ci/archive/20250921/202509210053.BtsqeDKp-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250921/202509210053.BtsqeDKp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509210053.BtsqeDKp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c:49:19: sparse: sparse: cast to restricted __be16
>> drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c:71:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] reg @@     got restricted __be16 [usertype] @@
   drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c:71:21: sparse:     expected unsigned short [assigned] [usertype] reg
   drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c:71:21: sparse:     got restricted __be16 [usertype]

vim +49 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c

875347fe575636 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c Marc Kleine-Budde 2020-09-18  41  
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  42  static int
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  43  mcp251xfd_regmap_nocrc_gather_write(void *context,
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  44  				    const void *reg_p, size_t reg_len,
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  45  				    const void *val, size_t val_len)
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  46  {
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  47  	const u16 byte_exclude = MCP251XFD_REG_IOCON +
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  48  				 mcp251xfd_first_byte_set(MCP251XFD_REG_IOCON_GPIO_MASK);
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18 @49  	u16 reg = be16_to_cpu(*(u16 *)reg_p) & MCP251XFD_SPI_ADDRESS_MASK;
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  50  	int ret;
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  51  
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  52  	/* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  53  	 *
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  54  	 * According to MCP2518FD Errata DS80000789E 5 writing IOCON register using one
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  55  	 * SPI write command clears LAT0/LAT1.
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  56  	 *
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  57  	 * Errata Fix/Work Around suggests to write registers with single byte
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  58  	 * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  59  	 * is for read-only access and writing to it causes the clearing of LAT0/LAT1.
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  60  	 */
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  61  	if (reg <= byte_exclude && reg + val_len > byte_exclude) {
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  62  		size_t len = byte_exclude - reg;
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  63  
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  64  		/* Write up to 0xe05 */
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  65  		ret = _mcp251xfd_regmap_nocrc_gather_write(context, reg_p, reg_len, val, len);
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  66  		if (ret)
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  67  			return ret;
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  68  
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  69  		/* Write from 0xe07 on */
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  70  		reg += len + 1;
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18 @71  		reg = cpu_to_be16(MCP251XFD_SPI_INSTRUCTION_WRITE | reg);
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  72  		return _mcp251xfd_regmap_nocrc_gather_write(context, &reg, reg_len,
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  73  							    val + len + 1,
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  74  							    val_len - len - 1);
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  75  	}
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  76  
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  77  	return _mcp251xfd_regmap_nocrc_gather_write(context, reg_p, reg_len,
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  78  						  val, val_len);
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  79  }
182c647943b5c0 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c Gregor Herburger  2025-09-18  80  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

