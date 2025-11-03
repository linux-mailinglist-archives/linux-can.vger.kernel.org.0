Return-Path: <linux-can+bounces-5308-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA6C2DE12
	for <lists+linux-can@lfdr.de>; Mon, 03 Nov 2025 20:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63579420120
	for <lists+linux-can@lfdr.de>; Mon,  3 Nov 2025 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDDD347C3;
	Mon,  3 Nov 2025 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Lr7njc1q"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BABD1F91D6
	for <linux-can@vger.kernel.org>; Mon,  3 Nov 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197380; cv=pass; b=TiVnDdAMvEEXQ9OeChp84o2vGYcYwUzPXZjtIHaRw/Wf0XK11oBiSK8+FPIAX4XCfWd3Brjk85pYoOzg8cvc+WyNQ29kLrEj+CpMwYZiqYlA5/AGKmuar69v8lJ9pxFdnqEnLTMnXkcZY2QJLsy+i5uMnOkdptf+TUWk2urNyqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197380; c=relaxed/simple;
	bh=mK4QroItEe1nEUhRvDqNtHTF6gyFvMbAdvnrXnWjX/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phEjTOXOguRL6ngj8ikTdTPAwk5s0pSwzswHaSJrpblAoOJTQMku6buU1VQYB7zJiuX6ncTyuh/hYFPOVkt0j1qaVyLIgdJCaKiVrRpREkSglqa6RiMsGf1R09LUjWKdyOBq3hkm0NZbuz7M6wce3OtVhX/+lcqU4LPQuEmyo70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Lr7njc1q; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762197366; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L21Dmyb/Fs4B5cvI+z0Rx0h0mXPSWZJXYD13a9Zj/XASD49uxcrIrWTNT76XyB6HdM
    aTQYkfQga5MXuP0VfBXbJhleanMbraGFyspKaf56wFKMj9vIInL6EabrDOV748dzMPeN
    VCpyQZxMZS+uO5cipWrXDW+BpSjbS7f5WO3RnWymjTtgY/ajY075McWUkwtY4h822XZW
    kMwm37TAUmsyM4MmpOOLPcR3i1ndKgviFkw6vzbQUEsv38BLsLjivZg6SstKbvVRm0Ig
    q+ZWsLHJ0IDtbrTvJEEmxSTehtpNscLLN0u+jsqAzn0S6dVmiJgxL0V3Bb54YVbmGEJv
    aqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762197366;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=92GZVwmSMcMDtWWNCQfkFSu58FrTHooxFT+qGdplXTs=;
    b=GY1E9kf/3PkawbayR/xUiAAacz0LmtXLLD1V0OzABpgKvyUUMqaSkvV57QORfYbC3h
    d4Mw1pdwhffPwLSNLLMVntf5pGW7BNNVjp3eZVXnmzoHeLhQSsPhyvhKRpA0OnMRu9HR
    teB4XHnyVcmlwQeF8TiJmi5rwk7nJFVwm6iDw1mP8Aa2Z5r8BISZa0m8aQxDnrQyJTmK
    KmIHtNIxbKAas3iyxnEJiCKUa5b+HmcZ/kzyEBk+hpAz8GJuaG1i+QsOO8eqAwELXrJ1
    GQKfuAvUuJIL8V1h9Txb41Xrkk8gaaMACnGepPStZ+b0F2nToHhOuIZoAeQFU6Z/3jym
    ED0g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762197366;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=92GZVwmSMcMDtWWNCQfkFSu58FrTHooxFT+qGdplXTs=;
    b=Lr7njc1qga8MjAUCIVFiPZuTAo5Ou9xNMjnJYqEvahosL4SAFUlTZl6g+/S1rgC3Vz
    +EiM5kstHpo/8qlmkff9nRJKZqBvfULsU64nvf2nILjyxOIA52slSJhEUud3QjuuEgzC
    3Pz47EEqQB4EZkaIK+Pq5DQ6wq2vyCKVBRWYRwh968CvHXhk8S9k4CmzOxg1K721IhWi
    SOV3Yax0DYbDiUc8K7YDmYs2+bOsBZylbISIA+IWedFyxJXb+p+vzH7gfsJhGd9xqoz4
    SgtGxUxguDULgkqsql+VAdQFJggTQXabFIya5DED5aO3W1Wk+tlCQVXVE8MmJd8zQLUu
    B4Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d01A3JG65wt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 3 Nov 2025 20:16:06 +0100 (CET)
Message-ID: <3d7521ba-bd71-46b0-9642-728a5222f2d6@hartkopp.net>
Date: Mon, 3 Nov 2025 20:15:59 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] can: netlink: add CAN XL
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net>
 <69303466-a9ed-44cb-a1a9-30ac1451e7cb@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <69303466-a9ed-44cb-a1a9-30ac1451e7cb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 02.11.25 23:11, Vincent Mailhol wrote:

> I just sent
> 
> https://lore.kernel.org/linux-can/20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org/
> 
> to address the problem. Let me know if this works in your test environment and I
> will merge it to the main series.

Very elegant solution. I started some coding into this direction too.
Good that I didn't post it ;-)

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

For the series. The 'nominal' left over was also a good improvement.

>> 2. In the "xl on" "tms on" mode only CAN XL frames can be sent. So we need to
>> drop CC and FD frames when they are sent, e.g. via CAN_RAW sockets.
>>
>> Therefore
>>
>> [PATCH v2 02/10] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
>>
>> has to be extended. And my proposed patch too:
>>
>> [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on CAN XL interfaces
>>
>> https://lore.kernel.org/linux-can/20250909092433.30546-1-socketcan@hartkopp.net/
>> T/#mcb0ebd94e45c34a2d0590ded2dfeed97edd05adf
> 
> Thanks for re-sending the patch! I remember we discussed this in September but
> it somehow went out of my mind. I just have a quick look so far on the new patch
> and so far it looks good. I will do a few more tests next week before adding it
> to the XL main series.
I just sent a V2 patch for it:

https://lore.kernel.org/linux-can/20251103185336.32772-1-socketcan@hartkopp.net/T/#u

The so-called 'mixed mode' with TMS off and ERR_SIGNAL on allows the 
transmission of CC/FD/XL frames.
But it looks like, that the combination CC/XL is not intended for the 
'mixed mode'. In all the documentations and videos it is the combination 
of FD and XL.

The CANXL-only modes are TMS on OR ERR_SIGNAL off. Both cases currently 
correctly force FD off. But it also should force CAN CC to be disabled.

Long story short:

# ip link set can0 type can bitrate 1000000 fd off xbitrate 4000000 xl 
on tms off

is currently allowed and leads to

# ip -det link show can0
8: can0: <NOARP,ECHO> mtu 2060 qdisc pfifo_fast state DOWN mode DEFAULT 
group default qlen 10
     link/can  promiscuity 0 allmulti 0 minmtu 16 maxmtu 16
     can <XL,XL-TDC-AUTO,XL-ERR-SIGNAL> state STOPPED restart-ms 0
	  bitrate 1000000 sample-point 0.750
	  tq 6 prop-seg 59 phase-seg1 60 phase-seg2 40 sjw 20 brp 1
	  xcanb_can_nl: tseg1 2..512 tseg2 2..128 sjw 1..128 brp 1..32 brp_inc 1
	  xcanb_can_nl: dtseg1 1..256 dtseg2 2..128 dsjw 1..128 dbrp 1..32 
dbrp_inc 1
	  tdco 0..255 tdcf 0..255
	  xbitrate 4000000 xsample-point 0.750
	  xtq 6 xprop-seg 14 xphase-seg1 15 xphase-seg2 10 xsjw 5 xbrp 1
	  xtdco 30 xtdcf 0
	  xcanb_can_nl: xtseg1 1..256 xtseg2 2..128 xsjw 1..128 xbrp 1..32 
xbrp_inc 1
	  xtdco 0..255 xtdcf 0..255
	  pwms 1..8 pwml 2..24 pwmo 0..16
	  clock 160000000 addrgenmode eui64 numtxqueues 1 numrxqueues 1 
gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 
65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

But IMO the 'mixed-mode' must have a CAN FD mode too:

# ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd on 
xbitrate 4000000 xl on tms off

Which is currently not enforced.

And then my V2 patch also works as intended.

Best regards,
Oliver


