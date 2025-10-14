Return-Path: <linux-can+bounces-5175-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7ADBD70AD
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 04:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EDA18A35A0
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 02:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05119303A31;
	Tue, 14 Oct 2025 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZmiJ1DH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE4303A26;
	Tue, 14 Oct 2025 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407516; cv=none; b=KVAD/lIfN5OGdJ4ZdGjMRukPGM5rGegwZlaKgfqIRxXsZ3fIz72+qCOVrGMGySJDrI8bK2uxjQ+11nYUOpnEz09de7NvxI+SSZKpgBYLxNT/Z/XYJJge3+sZowt+mdre84ghDlQUktcSEkOgO7JF2vRRV66t4kYFaakXI9KPw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407516; c=relaxed/simple;
	bh=MHF6KTPOkm+eoXwI8E+1sYE6F2IK2Ts90lqpHjVWOuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gszlXCANz/PgWwd2YCWinjHIbzB4rtnYFLAvR5ZuTVO/gD+CeU/U7xDMXokLauPc5xJIIlBTJa693azugXDGp3BdyglowHwMIYCtw6BtFSLyvtQJQBmy6Hg675jXdUKw+t4tTNTFxdMN6Mh6+gz0nRYl93RoZgGKbiaZlfaILkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZmiJ1DH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1928C4CEE7;
	Tue, 14 Oct 2025 02:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760407516;
	bh=MHF6KTPOkm+eoXwI8E+1sYE6F2IK2Ts90lqpHjVWOuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iZmiJ1DHGYiMw2scYQuU6nLUOVSDlFHgyVIYoBCfkeol+wjcdOQHtxIs6LRNw5v9G
	 9XqLTvcpkRWNfLB0vfc+QvPBAHi5IgJgmLRE7rlzXxc4kNAJfGucNquBXwMDzZcPOF
	 ZQ84gAeRj5ksNVC5Hv2qmPG3JVrsT3CoPkLpOof4EkUasaWAX84EuoECy/kM8OJQ0l
	 ti2IRq0otAP12wANAtlypGoeZoyaqfmUgXCF/Y/TB2OUjEEfPo746il0UJOkcU0Ckx
	 9/oO/THvnnPvyizgRpMup9q4mQBtkUYXPm9BlnzhfxV2Kgw3EJKUOhriHpdYGNE+7R
	 Jq2TlS1ycmw9A==
Message-ID: <b4a32eff-1ca8-4707-b48b-b3b4dd04c25f@kernel.org>
Date: Tue, 14 Oct 2025 11:05:13 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] can: calc_bittiming: add PWM calculation
To: kernel test robot <lkp@intel.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: oe-kbuild-all@lists.linux.dev,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-8-f422b7e2729f@kernel.org>
 <202510140553.qo3f0I9s-lkp@intel.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <202510140553.qo3f0I9s-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 at 06:21, kernel test robot wrote:
> Hi Vincent,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on cb6649f6217c0331b885cf787f1d175963e2a1d2]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-dev-can_dev_dropped_skb-drop-CAN-FD-skbs-if-FD-is-off/20251013-191232
> base:   cb6649f6217c0331b885cf787f1d175963e2a1d2
> patch link:    https://lore.kernel.org/r/20251013-canxl-netlink-v1-8-f422b7e2729f%40kernel.org
> patch subject: [PATCH 8/9] can: calc_bittiming: add PWM calculation
> config: riscv-randconfig-001-20251014 (https://download.01.org/0day-ci/archive/20251014/202510140553.qo3f0I9s-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510140553.qo3f0I9s-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510140553.qo3f0I9s-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/can/dev.h:18,
>                     from net/can/raw.c:53:
>    include/linux/can/bittiming.h: In function 'can_calc_pwm':
>>> include/linux/can/bittiming.h:204:1: warning: no return statement in function returning non-void [-Wreturn-type]
>      204 | }
>          | ^
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
>    Depends on [n]: BINFMT_ELF [=y] && ELF_CORE [=n]
>    Selected by [y]:
>    - RISCV [=y]
> 
> 
> vim +204 include/linux/can/bittiming.h
> 
>    200	
>    201	static inline int
>    202	can_calc_pwm(struct net_device *dev, struct netlink_ext_ack *extack)
>    203	{
>  > 204	}
>    205	#endif /* CONFIG_CAN_CALC_BITTIMING */
>    206	

I see, this only occurs if CONFIG_CAN_CALC_BITTIMING is not set.

What is surprising enough is that can_calc_tdco() has the exact same
issue but we never received a report.

I will first send a separate fix for can_calc_tdco() targeting
net/main and send the v2 for this series once the can_calc_tdco() fix
reaches net-next/main.


Yours sincerely,
Vincent Mailhol


