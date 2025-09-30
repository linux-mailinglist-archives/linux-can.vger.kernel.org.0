Return-Path: <linux-can+bounces-5060-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C69BAB819
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 07:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE8D3B240E
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 05:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866B2765C4;
	Tue, 30 Sep 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lenag9U2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02C34BA4C;
	Tue, 30 Sep 2025 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211101; cv=none; b=j77VX61OnsdXructpFk68ehN0e1f/IKIYY+TVMcxSEQXES2kYw/EYGkF/kpiaow7h+kbQFWqRRW2C3q06Ku1vxKHLUF0KVYUk9I/iJtTTb+xUMFCfEWCDwb0eZ7s1vO9SJgIwMdnU8/RarCLOr50Ic9yrNOCzU5fF3RPbU+ZjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211101; c=relaxed/simple;
	bh=a78Qm9QHMfIuLD6QX+5pcxjGrWzdwlk1atDpLyjau+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwI5qFk3k/4qHlykrymcQv5FSpEiqKwn1NKvR+NzPpaUxFgWZbBs61Qx54TdUCzZg4u3nFbpE0g3ETRKPTNKCize8mnZpMG7u+Eau53z0MqTGcN03uaRnBCDZW8/zGuQGDQ9oLx9U73E0+Zotph0Qdh++A/HCD9hT55u3NP+mIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lenag9U2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E962C4CEF0;
	Tue, 30 Sep 2025 05:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759211100;
	bh=a78Qm9QHMfIuLD6QX+5pcxjGrWzdwlk1atDpLyjau+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lenag9U2etd8ReaixEBEnjvNRnOy71LZfh3OW0NIrtmelMLnE+QJggR2+z5xlyIBv
	 KOzWcMnCD6Vx+lBJmiubP4DSOTWkgmerpQyol0CRrOYjD9b5K/WvW1lkTMcLAak3wj
	 x1eQX/haoIcrmybg6Eg8UjAf7ekz+9rft4PqWwWeMwjWCH/n3kOU6Og+djsM13w9eK
	 sD4qu2A9dWUpuMr0mFYgyAZ8jAgBHMCBTG75FpIg/CHMUKSyCBsuSqMAwDfyMJ0a1W
	 87eB0R6JIVeg7cuXzRq+G/E7l4IUwdAta+Dek03K5zaieTnf8Iw2kO9+tg9i8MCQ8E
	 GMi7iUK5y+TlA==
Message-ID: <7d35d8ca-f711-41b2-b058-08a19a207160@kernel.org>
Date: Tue, 30 Sep 2025 14:44:55 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/can/gs_usb: increase max interface to U8_MAX
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Maximilian Schneider <max@schneidersoft.net>,
 Henrik Brix Andersen <henrik@brixandersen.dk>,
 Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250930-gs-usb-max-if-v3-1-21d97d7f1c34@coelacanthus.name>
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
In-Reply-To: <20250930-gs-usb-max-if-v3-1-21d97d7f1c34@coelacanthus.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/25 12:06 PM, Celeste Liu wrote:
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 intefaces device to
                                                        ^^^^^^^^^
interfaces (missing "r")

> test so they write 3 here and wait for future change.
> 
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel type in gs_host_frame is u8, just
> increase interface number limit to max size of u8 safely.
> 
> [1]: https://github.com/cherry-embedded/HSCanT-hardware
> 
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

The patch is good as-is. However, speaking of the interface numbers, there is
another issue in this gs_usb driver: net_device->dev_port is not populated, and
according to the documentation, this is a bug.


See the description here:



  https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-net



  What:		/sys/class/net/<iface>/dev_port

  Date:		February 2014

  KernelVersion:	3.15

  Contact:	netdev@vger.kernel.org

  Description:

  		Indicates the port number of this network device, formatted

  		as a decimal value. Some NICs have multiple independent ports

  		on the same PCI bus, device and function. This attribute allows

  		userspace to distinguish the respective interfaces.



  		Note: some device drivers started to use 'dev_id' for this

  		purpose since long before 3.15 and have not adopted the new

  		attribute ever since. To query the port number, some tools look

  		exclusively at 'dev_port', while others only consult 'dev_id'.

  		If a network device has multiple client adapter ports as

  		described in the previous paragraph and does not set this

  		attribute to its port number, it's a kernel bug.



Would you mind sending a separate patch (with a Fixes: tag) to resolve this?


Yours sincerely,
Vincent Mailhol


