Return-Path: <linux-can+bounces-5176-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19138BD70F0
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 04:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76EF4035DA
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 02:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB63043AF;
	Tue, 14 Oct 2025 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAKOiRRH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6F303CA4;
	Tue, 14 Oct 2025 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408371; cv=none; b=FH/VeqWsi3Gldd00ML8+nfV0+JDAJgv4KmEbZO8jpfjAO/TFBF9BgPCqbQBZ0yZikXRWbCxYVsufck8hHCY+DZE1YMHVkJN8fk4ebl+tMocllJ6yDUsB+ECs8WmRjS0oRWoUwIWD5c/o90b4vdBEOpIn0Bdhw0+pjEPLhpNw2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408371; c=relaxed/simple;
	bh=s1c7WyB+mDCpvOuwyUCk9ctu6CVOf4kEgJ0FvxQ7Ox0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sKIxaUYOj7VHBLNYQOdfDTZawgiG0H+n+zdAfEKO5nwTS+c1XYRvM/J5bzZHD9jt4JKbPonbv0XNlSSJGEpua1yeyhYiv5V99iDSVDcItbtZkYa3UmRq63H2dbuiBUuHZP60T9wY71fx5xOzYkcQult8/OOBNQirPDaXJBtClCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAKOiRRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537ADC4CEE7;
	Tue, 14 Oct 2025 02:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760408370;
	bh=s1c7WyB+mDCpvOuwyUCk9ctu6CVOf4kEgJ0FvxQ7Ox0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uAKOiRRHdR1d+MVBfQc6WCLn9CI4TfsFNOERBMSHBzgLaecYIEUekaOAX6PplL8T3
	 XY+XlBkb1rU26PakGrnBBzWly2Z6t0qgj9Wbly0a2+P/jeS231yxjIDnDYrBrIpwk3
	 VViNKTr5oIDJl4QHN3llwAwEkDyxGJqii9v7WESYJWmpAKwR1qVty/IVWkq33ZIA8w
	 s8KLwFiexlqbu+ZcCknjry+9G6WatGr69YJQ4J/Hofhu/EMrSkCBDgt4XEISniXkBn
	 ICE0+P9eBgsS9eWruyHZwVpcizBoGLvLiXvuXXWNtTONo1X4t8Xdqu2KuFMk/4cXFE
	 J95iKQoHeZjIQ==
Message-ID: <289f4023-9559-4b84-b4fe-b6eda646e858@kernel.org>
Date: Tue, 14 Oct 2025 11:19:28 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] can: calc_bittiming: add PWM calculation
From: Vincent Mailhol <mailhol@kernel.org>
To: kernel test robot <lkp@intel.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: oe-kbuild-all@lists.linux.dev,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-8-f422b7e2729f@kernel.org>
 <202510140553.qo3f0I9s-lkp@intel.com>
 <b4a32eff-1ca8-4707-b48b-b3b4dd04c25f@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <b4a32eff-1ca8-4707-b48b-b3b4dd04c25f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 at 11:05, Vincent Mailhol wrote:
> On 14/10/2025 at 06:21, kernel test robot wrote:
>> Hi Vincent,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on cb6649f6217c0331b885cf787f1d175963e2a1d2]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-dev-can_dev_dropped_skb-drop-CAN-FD-skbs-if-FD-is-off/20251013-191232
>> base:   cb6649f6217c0331b885cf787f1d175963e2a1d2
>> patch link:    https://lore.kernel.org/r/20251013-canxl-netlink-v1-8-f422b7e2729f%40kernel.org
>> patch subject: [PATCH 8/9] can: calc_bittiming: add PWM calculation
>> config: riscv-randconfig-001-20251014 (https://download.01.org/0day-ci/archive/20251014/202510140553.qo3f0I9s-lkp@intel.com/config)
>> compiler: riscv64-linux-gcc (GCC) 10.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510140553.qo3f0I9s-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202510140553.qo3f0I9s-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>    In file included from include/linux/can/dev.h:18,
>>                     from net/can/raw.c:53:
>>    include/linux/can/bittiming.h: In function 'can_calc_pwm':
>>>> include/linux/can/bittiming.h:204:1: warning: no return statement in function returning non-void [-Wreturn-type]
>>      204 | }
>>          | ^
>>
>> Kconfig warnings: (for reference only)
>>    WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
>>    Depends on [n]: BINFMT_ELF [=y] && ELF_CORE [=n]
>>    Selected by [y]:
>>    - RISCV [=y]
>>
>>
>> vim +204 include/linux/can/bittiming.h
>>
>>    200	
>>    201	static inline int
>>    202	can_calc_pwm(struct net_device *dev, struct netlink_ext_ack *extack)
>>    203	{
>>  > 204	}
>>    205	#endif /* CONFIG_CAN_CALC_BITTIMING */
>>    206	
> 
> I see, this only occurs if CONFIG_CAN_CALC_BITTIMING is not set.
> 
> What is surprising enough is that can_calc_tdco() has the exact same
> issue but we never received a report.

Actually, can_calc_tdco() is not getting a warning because it returns
void. But this doesn't change the fact that it should be returning an
error when CONFIG_CAN_CALC_BITTIMING is not set.

> I will first send a separate fix for can_calc_tdco() targeting
> net/main and send the v2 for this series once the can_calc_tdco() fix
> reaches net-next/main.

N.B. this issue does not impact the code when
CONFIG_CAN_CALC_BITTIMING is set. So you can continue to review while
this problem is getting addressed.


Yours sincerely,
Vincent Mailhol

