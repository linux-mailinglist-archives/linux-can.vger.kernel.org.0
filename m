Return-Path: <linux-can+bounces-3507-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65673AA40C3
	for <lists+linux-can@lfdr.de>; Wed, 30 Apr 2025 04:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA003A9D73
	for <lists+linux-can@lfdr.de>; Wed, 30 Apr 2025 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D1EB640;
	Wed, 30 Apr 2025 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="YPEBkj05"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-65.smtpout.orange.fr [193.252.22.65])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63C288CC
	for <linux-can@vger.kernel.org>; Wed, 30 Apr 2025 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745978470; cv=none; b=uT5Xz6tRjZaum44FYoxIp7Rx+Xrd53nc0lx20XJGpGl3Jef72uGKE0Zz36FXgDEBHM/u9MHo+y/sCTIqbMusBWUBNGCStRC6mJRostzYPg8bEBGhxISfZ1Fxz/S2FJ57bFMNBelHcLpMHb8F6tVCkHrL3gcdLZmxRdNF/S4IYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745978470; c=relaxed/simple;
	bh=6Af5iE74cXVUYbcoihxg8mufgRyiyUpOikWsjUhA7lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPpb/Sdu0kxNmeQ6qTB3czmxUe3bbABT1WCnGi9BwRY+XKKdzS/EXTnhf93nYUz/TOyD3mL1KPR9dhB7YZjC0GPOzIQYWhVHZIGiDUnDuEVkItGtbF88p2fkb8/JoioWSv+zxkPO92en3S7WzROkibm3aGo3HlUMoVkHqwdqoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=YPEBkj05; arc=none smtp.client-ip=193.252.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 9wkmuAX1yLLfO9wkruHCH6; Wed, 30 Apr 2025 04:00:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745978459;
	bh=SkVvQFjBeBgwsqRrpEjIEQwUcxvB9gByaV4GIWe5LP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YPEBkj05ds/+OlBD3LyDVWf7JdTY/qzWaLbKphWTCVigbMeEaDVKB2K40p6Y0LDNK
	 Zlfi9J0ZzilBm1zK+dYujdsy9BVLu8h0gw3So+Ak3M1f561aG4fOFY8pITn3vq0P8z
	 kHnkzi+i77NWfyWjF2YUwbfuN2e5VExAPW1oc1l3EyxwZZFeiKCatxuojWOpvXqFs9
	 2FUOAFeSkzXo7u88o6PTdKRY9zwHtsN2L96JrHaoKU+VfLR6Cxsh860yeSdXPaDwaA
	 F83/XHvnFBrE8F6Ne6bBMekfogaII+qYiZzdjOJQskStpvfXe/WOjo9FoY8sU4Y4dm
	 KQhKye9ks6joQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 30 Apr 2025 04:00:59 +0200
X-ME-IP: 124.33.176.97
Message-ID: <87c3e3b0-f069-4053-b10a-5091cedbb940@wanadoo.fr>
Date: Wed, 30 Apr 2025 11:00:52 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] can: mcp251xfd: fix TDC setting for low data bit rates
To: Kelsey Maes <kelsey@vpprocess.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250429173221.52101-1-kelsey@vpprocess.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250429173221.52101-1-kelsey@vpprocess.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2025 at 02:32, Kelsey Maes wrote:
> The TDC is currently hardcoded enabled. This means that even for lower CAN-FD
> data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC is configured.
> This leads to a bus-off condition.
> 
> ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC) is only
> applicable if DBRP is 1 or 2.
> 
> To fix the problem, switch the driver to use the TDC calculation provided by the
> CAN driver framework (which respects ISO 11898-1 section 11.3.3). This has the
> positive side effect that userspace can control TDC as needed.
> 
> Demonstration of the feature in action:
>   $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
>   $ ip -details link show can0
>   3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
>       link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>       can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>   	  bitrate 125000 sample-point 0.875
>   	  tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
>   	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>   	  dbitrate 500000 dsample-point 0.875
>   	  dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
>   	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
>   	  tdco 0..63
          ^^^^^^^^^^

Did you update this part of the message after introduction the manual mode? This
should have read:

  tdcv 0..63 tdco 0..63

after the update.

>   	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
>   $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on
>   $ ip -details link show can0
>   3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
>       link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>       can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>   	  bitrate 1000000 sample-point 0.750
>   	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
>   	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>   	  dbitrate 4000000 dsample-point 0.700
>   	  dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
>   	  tdco 7
>   	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
>   	  tdco 0..63
>   	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
> 
> There has been some confusion about the MCP2518FD using a relative or absolute
> TDCO due to the datasheet specifying a range of [-64,63]. I have a custom board
> with a 40 MHz clock and an estimated loop delay of 100 to 216 ns. During testing
> at a data bit rate of 4 Mbit/s I found that using can_get_relative_tdco()
> resulted in bus-off errors. The final TDCO value was 1 which corresponds to a
> 10% SSP in an absolute configuration. This behavior is expected if the TDCO
> value is really absolute and not relative. Using priv->can.tdc.tdco instead
> results in a final TDCO of 8, setting the SSP at exactly 80%. This configuration
> works.
> 
> The automatic, manual, and off TDC modes were tested at speeds up to, and
> including, 8 Mbit/s on real hardware and behave as expected.

Thanks for also adding the manual mode!

> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
> Reported-by: Kelsey Maes <kelsey@vpprocess.com>
> Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com
> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>

Congrats for your first patch! Notwithstanding of above nitpick:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


