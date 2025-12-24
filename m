Return-Path: <linux-can+bounces-5928-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB87BCDB2E4
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 03:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8192D3021E7C
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924742882BE;
	Wed, 24 Dec 2025 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FruSbvzs"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464D2857C1;
	Wed, 24 Dec 2025 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766543452; cv=none; b=OqaunWpB46Gsm/+xjS/hnPTnZtUzY3GHElrcsJ2a8FIuo+/HLLiJldM7D0EgdO+jjvCDIo0mAQwbaExEFQ/QUReVSNL5SL9osNZg0en6T57zTfvPedseCSqyAiq5ejW4bEbz+8oVKaV8KBDetVMQw3j49wV3sx48dvp/BVCgg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766543452; c=relaxed/simple;
	bh=w4pwBDpX0ndWKuH8tbElcaiKaQ+mnetkmvCjkt14seo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0rKLlNO+MQayJY62f03qQhEZm+5/nPX8lSGcRrguz1SN2P1vydDah7mfKATNGK34yRs/09ScKHNjgD7kat6U+UWGuo/+e3VuXzWn1ut5lWUfP4W0iIp3+956HD87ybAISE0V2GwrNxcRLv5rOfWSI7DgkgzNYHCeogyXy3c3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FruSbvzs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766543451; x=1798079451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w4pwBDpX0ndWKuH8tbElcaiKaQ+mnetkmvCjkt14seo=;
  b=FruSbvzsRG0jXHSaubKXWdyE17VXpxCqCx85sYoPg7mhYCmz6rMzdpp7
   5wxFctZYFruC/+s1YqE3gOC2iKiqdUUiaqbQ0wdIzGvvjolaFRp79EipE
   +SiymPX4SeHy0kInx18cZ2IPP8roij2bQMGPLc+u6sfUp3R2D688ZlIo2
   0/ujuzfH2cwreRo2K3V/DYWlO81NOcBN4V4uNDfCYXcTlzjpwzE7uqocE
   uxI3ULIiB00kYyKm+UrdWYQJTOxM15sKTvJTozw8lKEMRlsHfEIesswOh
   X1MhBYqIYcSOEKcC/u1xKwysbhVUKOZvCziMts3pDzrp9OtpBfpHco+vm
   A==;
X-CSE-ConnectionGUID: mBFmcMg0Rmire2rNUN1WZA==
X-CSE-MsgGUID: YqO8dqrKTN2pVWtQ38Hcpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="55956611"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="55956611"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 18:30:50 -0800
X-CSE-ConnectionGUID: 88GaVRchTY6TIWFj2Rdn2g==
X-CSE-MsgGUID: 0rB+r1M/TFisMXV6Be13Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="204456803"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 23 Dec 2025 18:30:47 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYEeD-0000000065Y-2epx;
	Wed, 24 Dec 2025 02:30:45 +0000
Date: Wed, 24 Dec 2025 03:29:53 +0100
From: kernel test robot <lkp@intel.com>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de,
	mailhol@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN
 controllers binding from txt to YAML
Message-ID: <202512240358.V4rXhlja-lkp@intel.com>
References: <20251223105604.12675-3-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223105604.12675-3-arun.muthusamy@gaisler.com>

Hi Arun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4001bda0cc911fcdd3dde36963a17f4eac173d7d]

url:    https://github.com/intel-lab-lkp/linux/commits/Arun-Muthusamy/dt-bindings-Add-vendor-prefix-for-Frontgrade-Gaisler-AB/20251223-190933
base:   4001bda0cc911fcdd3dde36963a17f4eac173d7d
patch link:    https://lore.kernel.org/r/20251223105604.12675-3-arun.muthusamy%40gaisler.com
patch subject: [PATCH v2 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN controllers binding from txt to YAML
reproduce: (https://download.01.org/0day-ci/archive/20251224/202512240358.V4rXhlja-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240358.V4rXhlja-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: MAINTAINERS references a file that doesn't exist: Documentation/sphinx/parse-headers.pl
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
   Warning: arch/powerpc/sysdev/mpic.c references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
   Warning: arch/riscv/kernel/kexec_image.c references a file that doesn't exist: Documentation/riscv/boot-image-header.rst
   Warning: drivers/clocksource/timer-armada-370-xp.c references a file that doesn't exist: Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
>> Warning: drivers/net/can/grcan.c references a file that doesn't exist: Documentation/devicetree/bindings/net/can/grcan.txt
   Warning: include/rv/da_monitor.h references a file that doesn't exist: Documentation/trace/rv/da_monitor_synthesis.rst
   Warning: rust/kernel/sync/atomic/ordering.rs references a file that doesn't exist: srctree/tools/memory-model/Documentation/explanation.txt
   Using alabaster theme
   ERROR: Cannot find file ./include/linux/pci.h
   WARNING: No kernel-doc for file ./include/linux/pci.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

