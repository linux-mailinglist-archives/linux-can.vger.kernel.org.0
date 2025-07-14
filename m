Return-Path: <linux-can+bounces-3976-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B5B03829
	for <lists+linux-can@lfdr.de>; Mon, 14 Jul 2025 09:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A39017A3D0
	for <lists+linux-can@lfdr.de>; Mon, 14 Jul 2025 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DAB23506E;
	Mon, 14 Jul 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8WxH4jp"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1F1F0994;
	Mon, 14 Jul 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478887; cv=none; b=jMoWnWxGGGO53cxJjrm7ULK5mr+bJ8z2YL0PbVDjqSrFla4fERaJcnROGrOzj7gnrVp7UitHuC6wMOoOcjV5qm/yN3J7++ZIzMj4RdxzE1wNTpKdg4TN0ynHl6gbLoiH+rngaVxmqxJQIrCA77jYfJ9DE0R/GJ8XUc4HOeb25y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478887; c=relaxed/simple;
	bh=5e5RQmuI6QLwg7c3Xg/Mm5DxMg6eElClvZSIdk0WH5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKotvaVJcJiHAT527OP2jkKYZ4LGr60xrNDYkFcrDE93f1fGd5FttLn9d5KwoRQwrctwQEsCVeYfGN4atnwF8vFPusSRJoNy3If92sKA20j7ZbVd62TkZtkFJLfwDGwqWQkHaJCt8AZX0MXyQOSTo4pxvgQdv4xGnBdD9MWGIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8WxH4jp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752478885; x=1784014885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5e5RQmuI6QLwg7c3Xg/Mm5DxMg6eElClvZSIdk0WH5o=;
  b=O8WxH4jpFjjUiXDi47CVLEYayo8dVgpRhGgei9gELOIDKY9IlK6pOW/9
   mD0nUTASn2GsM1ngBKhsQsSJAr2v7yQg4/nD7OPC1L12nkD8wDKKfx7JO
   f4j+Yw7BRxSvd1LaL8m7/kyTGLH/5Nr4jtK8v/wpJhjEz6+SMi6bJCmSS
   VO+GmQR/oCx/Rc/kYSUShBpROch1n2cigbam8vQyoZKDd0enN9s/PEDxx
   9O7pJWhchPl3go7O6QgN0n8f56fDwo4HDZmmG6TaynmxQ3yDje1BApfq+
   reD5W0WiUW0f56uKPEQ3Ye7umTU0bIz8q+vB6XBX5gaP4U3x4FFw1L6Gp
   Q==;
X-CSE-ConnectionGUID: bLKe1tJTRSqOINebS0caZA==
X-CSE-MsgGUID: 5IJUi5KpSwSibHIni5T86A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57274066"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="57274066"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 00:41:24 -0700
X-CSE-ConnectionGUID: qsBQGGHeS/ecmausZCxVLw==
X-CSE-MsgGUID: +F0b9SFhRSOnipvhJMFmFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="156496992"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Jul 2025 00:41:21 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubDoO-0008eN-0h;
	Mon, 14 Jul 2025 07:41:20 +0000
Date: Mon, 14 Jul 2025 15:40:54 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH 3/3] can: tscan1: Kconfig: add COMPILE_TEST
Message-ID: <202507141417.qAMrchyV-lkp@intel.com>
References: <20250713-can-compile-test-v1-3-b4485e057375@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-can-compile-test-v1-3-b4485e057375@wanadoo.fr>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on a52f9f0d77f20efc285908a28b5697603b6597c7]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-ti_hecc-fix-Woverflow-compiler-warning/20250713-160616
base:   a52f9f0d77f20efc285908a28b5697603b6597c7
patch link:    https://lore.kernel.org/r/20250713-can-compile-test-v1-3-b4485e057375%40wanadoo.fr
patch subject: [PATCH 3/3] can: tscan1: Kconfig: add COMPILE_TEST
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250714/202507141417.qAMrchyV-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250714/202507141417.qAMrchyV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507141417.qAMrchyV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/can/sja1000/tscan1.c:14:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/net/can/sja1000/tscan1.c:89:6: error: call to '_inb' declared with 'error' attribute: inb()) requires CONFIG_HAS_IOPORT
      89 |         if (inb(pld_base + TSCAN1_ID1) != TSCAN1_ID1_VALUE ||
         |             ^
   include/asm-generic/io.h:643:13: note: expanded from macro 'inb'
     643 | #define inb _inb
         |             ^
   include/asm-generic/io.h:542:14: note: expanded from macro '_inb'
     542 | #define _inb _inb
         |              ^
   drivers/net/can/sja1000/tscan1.c:90:6: error: call to '_inb' declared with 'error' attribute: inb()) requires CONFIG_HAS_IOPORT
      90 |             inb(pld_base + TSCAN1_ID2) != TSCAN1_ID2_VALUE) {
         |             ^
   include/asm-generic/io.h:643:13: note: expanded from macro 'inb'
     643 | #define inb _inb
         |             ^
   include/asm-generic/io.h:542:14: note: expanded from macro '_inb'
     542 | #define _inb _inb
         |              ^
   drivers/net/can/sja1000/tscan1.c:95:10: error: call to '_inb' declared with 'error' attribute: inb()) requires CONFIG_HAS_IOPORT
      95 |         switch (inb(pld_base + TSCAN1_JUMPERS) & (TSCAN1_JP4 | TSCAN1_JP5)) {
         |                 ^
   include/asm-generic/io.h:643:13: note: expanded from macro 'inb'
     643 | #define inb _inb
         |             ^
   include/asm-generic/io.h:542:14: note: expanded from macro '_inb'
     542 | #define _inb _inb
         |              ^
>> drivers/net/can/sja1000/tscan1.c:138:3: error: call to '_outb' declared with 'error' attribute: outb() requires CONFIG_HAS_IOPORT
     138 |                 outb(TSCAN1_MODE_ENABLE | i, pld_base + TSCAN1_MODE);
         |                 ^
   include/asm-generic/io.h:655:14: note: expanded from macro 'outb'
     655 | #define outb _outb
         |              ^
   include/asm-generic/io.h:596:15: note: expanded from macro '_outb'
     596 | #define _outb _outb
         |               ^
   drivers/net/can/sja1000/tscan1.c:150:3: error: call to '_outb' declared with 'error' attribute: outb() requires CONFIG_HAS_IOPORT
     150 |                 outb(0, pld_base + TSCAN1_MODE);
         |                 ^
   include/asm-generic/io.h:655:14: note: expanded from macro 'outb'
     655 | #define outb _outb
         |              ^
   include/asm-generic/io.h:596:15: note: expanded from macro '_outb'
     596 | #define _outb _outb
         |               ^
   drivers/net/can/sja1000/tscan1.c:143:4: error: call to '_outb' declared with 'error' attribute: outb() requires CONFIG_HAS_IOPORT
     143 |                         outb(0, pld_base + TSCAN1_LED);
         |                         ^
   include/asm-generic/io.h:655:14: note: expanded from macro 'outb'
     655 | #define outb _outb
         |              ^
   include/asm-generic/io.h:596:15: note: expanded from macro '_outb'
     596 | #define _outb _outb
         |               ^
   drivers/net/can/sja1000/tscan1.c:175:2: error: call to '_outb' declared with 'error' attribute: outb() requires CONFIG_HAS_IOPORT
     175 |         outb(0, pld_base + TSCAN1_MODE);        /* disable SJA1000 IO space */
         |         ^
   include/asm-generic/io.h:655:14: note: expanded from macro 'outb'
     655 | #define outb _outb
         |              ^
   include/asm-generic/io.h:596:15: note: expanded from macro '_outb'
     596 | #define _outb _outb
         |               ^
   drivers/net/can/sja1000/tscan1.c:68:9: error: call to '_inb' declared with 'error' attribute: inb()) requires CONFIG_HAS_IOPORT
      68 |         return inb((unsigned long)priv->reg_base + reg);
         |                ^
   include/asm-generic/io.h:643:13: note: expanded from macro 'inb'
     643 | #define inb _inb
         |             ^
   include/asm-generic/io.h:542:14: note: expanded from macro '_inb'
     542 | #define _inb _inb
         |              ^
   drivers/net/can/sja1000/tscan1.c:74:2: error: call to '_outb' declared with 'error' attribute: outb() requires CONFIG_HAS_IOPORT
      74 |         outb(val, (unsigned long)priv->reg_base + reg);
         |         ^
   include/asm-generic/io.h:655:14: note: expanded from macro 'outb'
     655 | #define outb _outb
         |              ^
   include/asm-generic/io.h:596:15: note: expanded from macro '_outb'
     596 | #define _outb _outb
         |               ^
   1 warning and 9 errors generated.


vim +89 drivers/net/can/sja1000/tscan1.c

2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  @14  #include <linux/io.h>
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   15  #include <linux/ioport.h>
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   16  #include <linux/isa.h>
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   17  #include <linux/module.h>
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   18  #include <linux/netdevice.h>
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   19  #include "sja1000.h"
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   20  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   21  MODULE_DESCRIPTION("Driver for Technologic Systems TS-CAN1 PC104 boards");
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   22  MODULE_AUTHOR("Andre B. Oliveira <anbadeol@gmail.com>");
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   23  MODULE_LICENSE("GPL");
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   24  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   25  /* Maximum number of boards (one in each JP1:JP2 setting of IO address) */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   26  #define TSCAN1_MAXDEV 4
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   27  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   28  /* PLD registers address offsets */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   29  #define TSCAN1_ID1	0
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   30  #define TSCAN1_ID2	1
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   31  #define TSCAN1_VERSION	2
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   32  #define TSCAN1_LED	3
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   33  #define TSCAN1_PAGE	4
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   34  #define TSCAN1_MODE	5
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   35  #define TSCAN1_JUMPERS	6
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   36  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   37  /* PLD board identifier registers magic values */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   38  #define TSCAN1_ID1_VALUE 0xf6
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   39  #define TSCAN1_ID2_VALUE 0xb9
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   40  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   41  /* PLD mode register SJA1000 IO enable bit */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   42  #define TSCAN1_MODE_ENABLE 0x40
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   43  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   44  /* PLD jumpers register bits */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   45  #define TSCAN1_JP4 0x10
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   46  #define TSCAN1_JP5 0x20
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   47  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   48  /* PLD IO base addresses start */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   49  #define TSCAN1_PLD_ADDRESS 0x150
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   50  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   51  /* PLD register space size */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   52  #define TSCAN1_PLD_SIZE 8
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   53  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   54  /* SJA1000 register space size */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   55  #define TSCAN1_SJA1000_SIZE 32
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   56  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   57  /* SJA1000 crystal frequency (16MHz) */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   58  #define TSCAN1_SJA1000_XTAL 16000000
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   59  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   60  /* SJA1000 IO base addresses */
3c8ac0f2ad53a9 Bill Pemberton    2012-12-03   61  static const unsigned short tscan1_sja1000_addresses[] = {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   62  	0x100, 0x120, 0x180, 0x1a0, 0x200, 0x240, 0x280, 0x320
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   63  };
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   64  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   65  /* Read SJA1000 register */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   66  static u8 tscan1_read(const struct sja1000_priv *priv, int reg)
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   67  {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   68  	return inb((unsigned long)priv->reg_base + reg);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   69  }
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   70  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   71  /* Write SJA1000 register */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   72  static void tscan1_write(const struct sja1000_priv *priv, int reg, u8 val)
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   73  {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   74  	outb(val, (unsigned long)priv->reg_base + reg);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   75  }
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   76  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   77  /* Probe for a TS-CAN1 board with JP2:JP1 jumper setting ID */
3c8ac0f2ad53a9 Bill Pemberton    2012-12-03   78  static int tscan1_probe(struct device *dev, unsigned id)
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   79  {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   80  	struct net_device *netdev;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   81  	struct sja1000_priv *priv;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   82  	unsigned long pld_base, sja1000_base;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   83  	int irq, i;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   84  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   85  	pld_base = TSCAN1_PLD_ADDRESS + id * TSCAN1_PLD_SIZE;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   86  	if (!request_region(pld_base, TSCAN1_PLD_SIZE, dev_name(dev)))
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   87  		return -EBUSY;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   88  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  @89  	if (inb(pld_base + TSCAN1_ID1) != TSCAN1_ID1_VALUE ||
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   90  	    inb(pld_base + TSCAN1_ID2) != TSCAN1_ID2_VALUE) {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   91  		release_region(pld_base, TSCAN1_PLD_SIZE);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   92  		return -ENODEV;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   93  	}
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   94  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  @95  	switch (inb(pld_base + TSCAN1_JUMPERS) & (TSCAN1_JP4 | TSCAN1_JP5)) {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   96  	case TSCAN1_JP4:
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   97  		irq = 6;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   98  		break;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18   99  	case TSCAN1_JP5:
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  100  		irq = 7;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  101  		break;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  102  	case TSCAN1_JP4 | TSCAN1_JP5:
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  103  		irq = 5;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  104  		break;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  105  	default:
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  106  		dev_err(dev, "invalid JP4:JP5 setting (no IRQ)\n");
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  107  		release_region(pld_base, TSCAN1_PLD_SIZE);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  108  		return -EINVAL;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  109  	}
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  110  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  111  	netdev = alloc_sja1000dev(0);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  112  	if (!netdev) {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  113  		release_region(pld_base, TSCAN1_PLD_SIZE);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  114  		return -ENOMEM;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  115  	}
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  116  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  117  	dev_set_drvdata(dev, netdev);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  118  	SET_NETDEV_DEV(netdev, dev);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  119  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  120  	netdev->base_addr = pld_base;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  121  	netdev->irq = irq;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  122  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  123  	priv = netdev_priv(netdev);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  124  	priv->read_reg = tscan1_read;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  125  	priv->write_reg = tscan1_write;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  126  	priv->can.clock.freq = TSCAN1_SJA1000_XTAL / 2;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  127  	priv->cdr = CDR_CBP | CDR_CLK_OFF;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  128  	priv->ocr = OCR_TX0_PUSHPULL;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  129  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  130  	/* Select the first SJA1000 IO address that is free and that works */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  131  	for (i = 0; i < ARRAY_SIZE(tscan1_sja1000_addresses); i++) {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  132  		sja1000_base = tscan1_sja1000_addresses[i];
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  133  		if (!request_region(sja1000_base, TSCAN1_SJA1000_SIZE,
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  134  								dev_name(dev)))
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  135  			continue;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  136  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  137  		/* Set SJA1000 IO base address and enable it */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18 @138  		outb(TSCAN1_MODE_ENABLE | i, pld_base + TSCAN1_MODE);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  139  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  140  		priv->reg_base = (void __iomem *)sja1000_base;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  141  		if (!register_sja1000dev(netdev)) {
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  142  			/* SJA1000 probe succeeded; turn LED off and return */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  143  			outb(0, pld_base + TSCAN1_LED);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  144  			netdev_info(netdev, "TS-CAN1 at 0x%lx 0x%lx irq %d\n",
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  145  						pld_base, sja1000_base, irq);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  146  			return 0;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  147  		}
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  148  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  149  		/* SJA1000 probe failed; release and try next address */
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  150  		outb(0, pld_base + TSCAN1_MODE);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  151  		release_region(sja1000_base, TSCAN1_SJA1000_SIZE);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  152  	}
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  153  
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  154  	dev_err(dev, "failed to assign SJA1000 IO address\n");
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  155  	dev_set_drvdata(dev, NULL);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  156  	free_sja1000dev(netdev);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  157  	release_region(pld_base, TSCAN1_PLD_SIZE);
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  158  	return -ENXIO;
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  159  }
2d3359f8b9e6b3 Andre B. Oliveira 2010-10-18  160  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

