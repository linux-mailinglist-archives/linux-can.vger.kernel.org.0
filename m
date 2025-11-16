Return-Path: <linux-can+bounces-5453-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F72C61C22
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 21:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA23535B645
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 20:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236C8D531;
	Sun, 16 Nov 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IlVFIGtg";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JAWCLxT3"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFD23EAA3
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763323566; cv=pass; b=U84k9C/CienycvScFHj3VgtY001v/exFfNxMDrWCN7tJXlQjy33/ew7lmi/DFonO6AnnyAfGv34xwmvXJCbHyjhWgbQh1VsR1MWtMrOZBEs1BZAQv6bUjLfm0/t0a0v6MNyi2kgripz0Uyo0AJXfvSvn7ot0xXOnisEFxi7auKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763323566; c=relaxed/simple;
	bh=7Qh6OF6Pqq3tEWGmlpfbawsGjLp7D3BurkIJ1XDxlu4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BF+gy0DqmZpvgG66igRZJyxyTT0kaqSzBermhtiKm9VBpWC6Knt18cIavqmDTvhrTjwQub3wtOwZNJKICnHAH9q3K7eDRgNq/n0yvMGHSKjpeQvaeZhUg5Ci/uRCX5i5PULR/h2hZsXJ7G2Qd3QxlHj0CAYdpQysx8KJ7+XP5v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IlVFIGtg; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JAWCLxT3; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763323544; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=d2lAl02rhT0B/4J/u7It5y8ufynOZ54/WprLIi8qe/7EtHSq5IALoKdATXXxU8/SPu
    /tVs8CPnsJkyK7Fnf1t4ZfXK7P/wSlOpWqcVlqJJObaN4uca4ctddAQnmgEfrG7rvS9B
    FxkCj6pmMZ6JxfJkxervBEzIea21jUzGADUx3GRsuQpSNZKIHZ0CifWvXpUzvWiSgppF
    Op9E2P8TVQ1C+KNwp1YzCi8tAiKxmu4GJ5OWy8uQvGC8Nk95J3LfIF5yIEZgBjeuC9lH
    eBAtO6WiXKAWNvJb/jy3U+PQkj/fyG4l9D6zLLo149QDqOvak6PFzb+9wQdc6NQrpSH0
    igMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763323544;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sgSMgljdTyFwB7YRS8K0gwlUxVuZw+ijCSRxgTTRM9k=;
    b=XiA/8v3MddRKxiBA/ilm2ZfmYsQDUtpjCDaMromQyq5sPwzMjGgwYLee2mT2KPbyKc
    IKtsOyNs081BWYmrP2faqNI1khVj+O+0agpmENCen+J0H8wyW6wp5YRmvYDQGG4Nq7m+
    vu+guJVKsMXxcjrXzm4v7lUZUVgUzMtKrR2fqP9+v1k289V+ncJxFJCZ0VNcpChBeltl
    8tsNtOLNBJNroxb/1nLLAUwYAu3wdbEP4ypXqB+vsrNrevEt7NLt0mZDshWlsoP5Uu/v
    RHTOMu9QmQex2FNoyPFpqIvlz6DVE/1aOIp65Y5RqrPKjeO604kvEsDICkjGdI9g+r90
    UmiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763323544;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sgSMgljdTyFwB7YRS8K0gwlUxVuZw+ijCSRxgTTRM9k=;
    b=IlVFIGtgtJIoslni4vljWy1xhehf6uFT4NYrJktDI6fpoAy5RyUXp9ReLC3OKw48xt
    c8BnD8m+A6SB2zPoCzBg1YiR7CWR+FxzsPhFXpmQmTEc0f7jpL0jxcFYroL0ryCZQiIv
    kBdUSq939uCoemRINN3tYF7uaDsx4YPpSTBPiO+oCa/LxYuMt5ErR+rMWS6qgt3kLlV/
    s7qQf1q9jgzfxLAKmgDF5qoQ9WiRu4yIPyQsR5xQ3OvjbRYS7uepWxdJRysHqzSes9k1
    Ah3CH1V/MpWpaO35gl5crfySucX/NSMfPoL3CYgxzJieyykIB1TQsE7jY4Z3CIoOHkUU
    1SSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763323544;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sgSMgljdTyFwB7YRS8K0gwlUxVuZw+ijCSRxgTTRM9k=;
    b=JAWCLxT3LKWwvido8rmA7/Vfn3j+7QAvdiBrf5jIwCyMBwK6zsBqAl8CH9sDt9qUqF
    gQTiWBKck7e5dJs37fCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AGK5ihPr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 16 Nov 2025 21:05:44 +0100 (CET)
Message-ID: <69fb9682-82ab-4a3b-a79e-74fa24da23be@hartkopp.net>
Date: Sun, 16 Nov 2025 21:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v2 13/15] can: calc_bittiming: add
 can_calc_sample_point_pwm()
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <20251115163740.7875-14-socketcan@hartkopp.net>
Content-Language: en-US
In-Reply-To: <20251115163740.7875-14-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 15.11.25 17:37, Oliver Hartkopp wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
> 
> The optimum sample point value depends on the bit symmetry. The more
> asymmetric the bit is, the more the sample point would be located
> towards the end of the bit. On the contrary, if the transceiver only
> has a small asymmetry, the optimal sample point would be slightly
> after the centre of the bit.
> 
> For NRZ encoding (used by Classical CAN, CAN FD and CAN XL with TMS
> off), the optimum sample points values are above 70% as implemented in
> can_calc_sample_point_nrz().
> 
> When TMS is on, CAN XL optimum sample points are near to 50% or
> 60% [1]. Add can_calc_sample_point_pwm() which returns a sample point
> which is suitable for PWM encoding. We crafted the formula to make it
> return the same values as below table (source: table 3 of [1]).
> 
>         Bit rate (Mbits/s)	Sample point
>         -------------------------------------
>           2.0			 51.3%
>           5.0			 53.1%
>           8.0			 55.0%
>          10.0			 56.3%
>          12.3			 53.8%
>          13.3			 58.3%
>          14.5			 54.5%
>          16.0			 60.0%
>          17.7			 55.6%
>          20.0			 62.5%

I tested all these examples.

root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
4000000 xl on tms on
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
2000000 xl on tms on
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
5000000 xl on tms on
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
8000000 xl on tms on
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
10000000 xl on tms on
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
12300000 xl on tms on
Warning: bitrate error: 0.0%.
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
13300000 xl on tms on
Warning: bitrate error: 0.2%.
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
14500000 xl on tms on
Warning: bitrate error: 0.3%.
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
16000000 xl on tms on
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
17700000 xl on tms on
Warning: bitrate error: 0.4%.
root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
20000000 xl on tms on
root@de1soc1:~#

In the case of xbitrate 12300000 the feedback is
Warning: bitrate error: 0.0%.

The calculated bitrate is:
xbitrate 12307692 xsample-point 0.538

12307692/12300000 = 1.00062536585

So it is 0.06%

root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
13300000 xl on tms on
Warning: bitrate error: 0.2%.

The calculated bitrate is:
xbitrate 13333333 xsample-point 0.583

13333333/13300000 = 1.0025062406

So it is 0.25%

Would it make sense to add another digit and probably additionally some 
round-up to omit a 0.0% warning?

Best regards,
Oliver

> 
> The calculation simply consists of setting a slightly too high sample
> point and then letting can_update_sample_point() correct the values.
> 
> For now, it is just a formula up our sleeves which matches the
> empirical observations of [1]. Once CiA recommendations become
> available, can_calc_sample_point_pwm() should be updated accordingly.
> 
> [1] CAN XL system design: Clock tolerances and edge deviations edge
>      deviations
> Link: https://www.can-cia.org/fileadmin/cia/documents/publications/cnlm/december_2024/cnlm_24-4_p18_can_xl_system_design_clock_tolerances_and_edge_deviations_dr_arthur_mutter_bosch.pdf
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   drivers/net/can/dev/calc_bittiming.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
> index 9b2d0e458518..be6726dcd7e7 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -20,10 +20,25 @@ static int can_calc_sample_point_nrz(const struct can_bittiming *bt)
>   		return 800;
>   
>   	return 875;
>   }
>   
> +/* Sample points for Pulse-Width Modulation encoding. */
> +static int can_calc_sample_point_pwm(const struct can_bittiming *bt)
> +{
> +	if (bt->bitrate > 15 * MEGA /* BPS */)
> +		return 625;
> +
> +	if (bt->bitrate > 9 * MEGA /* BPS */)
> +		return 600;
> +
> +	if (bt->bitrate > 4 * MEGA /* BPS */)
> +		return 560;
> +
> +	return 520;
> +}
> +
>   /* Bit-timing calculation derived from:
>    *
>    * Code based on LinCAN sources and H8S2638 project
>    * Copyright 2004-2006 Pavel Pisa - DCE FELK CVUT cz
>    * Copyright 2005      Stanislav Marek
> @@ -90,10 +105,14 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
>   	u64 v64;
>   	int err;
>   
>   	if (bt->sample_point)
>   		sample_point = bt->sample_point;
> +
> +	else if (btc == priv->xl.data_bittiming_const &&
> +		 (priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
> +		sample_point = can_calc_sample_point_pwm(bt);
>   	else
>   		sample_point = can_calc_sample_point_nrz(bt);
>   
>   	/* tseg even = round down, odd = round up */
>   	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;


