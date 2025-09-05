Return-Path: <linux-can+bounces-4496-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E1B45B3A
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 16:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F59C16B545
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6573736CDE5;
	Fri,  5 Sep 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDeppUVf"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA99306B3D;
	Fri,  5 Sep 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084130; cv=none; b=Q15/WBoojf1KhrxmAi9O1q7pK8qpMjD68ZwjOY6YWj03PC9eahBmHMIitTj/d975coha9N2n4lgbVS77m2WwmdnqUepcAc1btqFzHTyyt+2kSbXqK8+Hhoa/j0lVQTg7L6xkynn/UP65b8uM2zHpchAdFuQi+3NfVltJNYmsDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084130; c=relaxed/simple;
	bh=OCfVsz4GNG8tZpCHvCp7Pwkr+YCb7Q/NGZO1AQDPduA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biDgpHvD4karHO7T5MtYX71RhY+v+wr2Xecjmxs18sU/X0KxTbUVuW/AqtEi7E4AlbIBjVeJaUN6rkzaJKbcGta6cV9XM9auz0ZatZpWwFis3prfjk/5yh3QbJtcJxioOeYRlvgq2N+fErtaZKCbdcBc+ZYkcNih4ppoGeHuNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDeppUVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433EEC4CEF1;
	Fri,  5 Sep 2025 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084129;
	bh=OCfVsz4GNG8tZpCHvCp7Pwkr+YCb7Q/NGZO1AQDPduA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RDeppUVfo9rdn4rj2lFKj5nH1eCZTL3kk8iGOrmTHtHv9L12slp0wffsBj5avJX1O
	 CVNQOPlLzISjQBwCM+MumnN+DkZ/Gad+sXtsv6pmn+s0gUINahBwBtynWPZQyGMTI1
	 TEuY8NQlC622r863FKWPt1g8+jibRfKzDS4IsZP4Xfmmsxa35DUeB3jHuqJ+4t1XSu
	 CLLh30qM3CmaXDDYsSShE6POIWFAbj3T/Sr5wf9lJhD+i3qhGdYbs4Ab2LzYeG+WtY
	 a3P5aqBY2EhytsicqAHajqw2dDHfq6Wtndd0hy8jV3dWFvZ9wR9SHB/si7YeNcKXL8
	 jLT6cSfo8wucg==
Message-ID: <8009fd35-421b-4091-99a5-fda86e1cfaaa@kernel.org>
Date: Fri, 5 Sep 2025 23:55:26 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/21] can: netlink: add can_validate_databittiming()
To: kernel test robot <lkp@intel.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-6-904bd6037cd9@kernel.org>
 <202509050259.NjPdQyAD-lkp@intel.com>
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
In-Reply-To: <202509050259.NjPdQyAD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 at 03:46, kernel test robot wrote:
> Hi Vincent,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3]

OK. I will silence it in v2, but I don't think this is anyhow problematic.

> url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-dev-move-struct-data_bittiming_params-to-linux-can-bittiming-h/20250903-170807
> base:   2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
> patch link:    https://lore.kernel.org/r/20250903-canxl-netlink-prep-v1-6-904bd6037cd9%40kernel.org
> patch subject: [PATCH 06/21] can: netlink: add can_validate_databittiming()
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250905/202509050259.NjPdQyAD-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509050259.NjPdQyAD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509050259.NjPdQyAD-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/net/can/dev/netlink.c:111:6: warning: variable 'is_on' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>      111 |         if (ifla_can_data_bittiming == IFLA_CAN_DATA_BITTIMING) {
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/can/dev/netlink.c:119:6: note: uninitialized use occurs here
>      119 |         if (is_on) {
>          |             ^~~~~
>    drivers/net/can/dev/netlink.c:111:2: note: remove the 'if' if its condition is always true

That's it. This if condition is always true at the moment because all the
callers specify ifla_can_data_bittiming as IFLA_CAN_DATA_BITTIMING. But I do not
want to remove the else branch because is serves to show to the reader what is
coming up next and help to understand the refactor logic.
>      111 |         if (ifla_can_data_bittiming == IFLA_CAN_DATA_BITTIMING) {
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      112 |                 data_tdc = data[IFLA_CAN_TDC];
>      113 |                 tdc_flags = flags & CAN_CTRLMODE_FD_TDC_MASK;
>      114 |                 is_on = flags & CAN_CTRLMODE_FD;
>      115 |         } else {
>          |           ~~~~~~
>      116 |                 WARN_ON(1); /* Place holder for CAN XL */
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The WARN_ON(1) was to point out that the else branch should never be reached.

I will change this to:

	return -EOPNOTSUPP; /* Place holder for CAN XL */

in v2. This will serve the same purpose as the current WARN_ON(1) but will
suppress the warning.

I will do the exact same on patches 11/21 and 18/21 on which the kernel test
robot also sent a similar report.


Yours sincerely,
Vincent Mailhol


