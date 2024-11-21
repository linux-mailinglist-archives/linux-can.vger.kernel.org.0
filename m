Return-Path: <linux-can+bounces-2167-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA49D53BA
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 21:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663C4B229A8
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 20:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832F1BD9EC;
	Thu, 21 Nov 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ly93oaHX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="B9ioq4ei"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF243AA1
	for <linux-can@vger.kernel.org>; Thu, 21 Nov 2024 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732219841; cv=pass; b=VZuTHWTmP0OhSdfYi+GEBfFrXc48n3k13/rxt1P9H55ufsPxY5/VwQCNM5aFOfmz2oAqQq0Lm8nwcUT12CHoOtHKms+N8+AhMIDXatLxWvERmdfZKMGq2MxtxfFYEchoJJ520659CEUJQfuofAWagOz+jVMdPKMUnyCpmb6rGRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732219841; c=relaxed/simple;
	bh=l41HFwcy5nX2xmm3RsmSr5VjmIrtKWIEjlakc8MIkKE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sd/XDHnvh2di8s65B8zQ/cvYo1M/JSG0wMCOgc87jxRpM3uQvCB0ePOrIew+1uNwRdrZb4XwEg4efCyh8xmuk+QTKM4eTaivxljLaJiRy7b+XOazW7I6h2zJHdzUejdbnA4wXJQSZLibimYmmn5PcX7oJXsEatHCbbyxCbf0g8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ly93oaHX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=B9ioq4ei; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1732219834; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cPll9RQYFPZ+EpQCUtwqMGzpDCmSqE178wQvduYuthDjmO+H/FXMI9VNgNhHsYTMtp
    RROSAMdIrgv7mcVdHlFoksDkzdGLHSNlMGO5gmfewrOUHpR4jlONF/muvqGC0rn5iGik
    XoonFSnNkFYbPHTOhnvr8ETgW0BRtFJw76QjAe0l+gVjvadGeRkcrMPAlngh3JOFuq2I
    rVu9pqVxGr90BeMKrjje4MWFT38BZP/T7jr2+c302eSGWjRfqPhH06bxzxas09WgK9sT
    u43oZNpLURkOz/9srlYVtsRg/HaJuGoZrrK0yxBeJ4PnXi9xihrVzHwwX2IA6RRIVHyD
    U0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1732219834;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=me+J27R3JvCMkTL6KbgmZcoL4JkwRdyeCu+14zBUX+Y=;
    b=hFsYeONwwN35yYu0mVEg6NMerF5E2T8ybYeRlIN5kiea3166Li3SZEVXAOnc3rYxCH
    jhxZJug3lZ+ny6LbMaqkwcwjuFevE2JUfN/S1gEs5nWbCBuiAK/XSLDPI1ZFgv5Lp2Iu
    WNiwbukOlHVcE7D+It5kno88mZQ+3xE+XjCB4/mCNKlYdCXnZm4mOj2ovykKeL5EtNY+
    8P5HmrxhbyKIp6v3zLIPDFxb9/b5ZJoUb1HHn0cQ85jh2NFRxwVpvJzx9+d+LBW2z4eN
    j3jTkA2kALw+UVi4wPF+O1Dh5cdcxbzQWbNzo+uo3FBbN15dQ137J8d7/iyq04XEJ3/A
    SPYA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1732219834;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=me+J27R3JvCMkTL6KbgmZcoL4JkwRdyeCu+14zBUX+Y=;
    b=Ly93oaHXT6GWFart5WPvaRmTlEnREOdM7YhBZxpCXTkMTOtzCbHtMJ/BpNKfnQj2TL
    dPDOxG4yfpboweFs5CChsdzx1wpQhvxwgrd82MGeKpeyCtUOjlqoPZ6hrlxvop5aJk6B
    zlRCrEmvTQI2yXZFAfZdaDKvLbwG5C69WW0sZ/CNrhLOG6EkDqVmkFjuS5acteMTY+xo
    2w/NmGQPWIRUijnIQaFFYl9xYkd4xSY2/2hlEukViohkhtrXtZ+voodm5CGD7fz52QPX
    XzE+xKlbhZ3qXJmkEpvwS1s9mqpzZHgDWOZYjyLrYVhZAvWS/Ae/VJKb1IM5kEXz6SoP
    LIaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1732219834;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=me+J27R3JvCMkTL6KbgmZcoL4JkwRdyeCu+14zBUX+Y=;
    b=B9ioq4eiKa1Px5cQcYprEQX2jEuEjsjmHE8l1khhX7gohkwBAXS1rONYtGk/xZBJzs
    eoPJhExZzQo/Xy0dUOCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from [192.168.20.116]
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0ALKAY5dt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 21 Nov 2024 21:10:34 +0100 (CET)
Message-ID: <12e013c2-d6ff-42b2-91ef-921db4e7ee0e@hartkopp.net>
Date: Thu, 21 Nov 2024 21:10:28 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net>
 <a9d8eb65-c88d-4bc9-b0c2-c0e0799ea5bd@wanadoo.fr>
 <23c914cf-0af2-4619-9f83-e4b6339ef65f@hartkopp.net>
Content-Language: en-US
In-Reply-To: <23c914cf-0af2-4619-9f83-e4b6339ef65f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 11.11.24 16:32, Oliver Hartkopp wrote:

> No problem! I will give some feedback when I managed to integrate the 
> extended netlink API to my driver.

I managed to set up my CAN XL dev board with the latest Linux kernel 
(6.13 merge) and upgraded to Ubuntu 24.04 LTS.

Applying your RFC patches for the kernel and the iproute2 package 
(including the sed hack) works great.

While the xl transceiver switch and the and the PWM configuration (with 
3 values with 6 bit each) are still missing I tried your current code as-is.

# modprobe dummyxl
(created can0)

# ip link set can0 type can bitrate 500000 xbitrate 8000000 xl on 
dbitrate 4000000 fd on

# ip -det link show can0
7: can0: <NOARP> mtu 2060 qdisc noop state DOWN mode DEFAULT group 
default qlen 10
     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
     can <FD,TDC-AUTO,XL> state STOPPED restart-ms 0

Should there be a XTDC-AUTO too?

	  bitrate 500000 sample-point 0.875
	  tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 1
	  dummyxl nominal: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 
brp_inc 1
	  dbitrate 4000000 dsample-point 0.750
	  dtq 12 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 2 dbrp 1
	  tdco 15 tdcf 0

Should the tdc* values be placed behind dbrp 1 without a line break?
The gso/gro stuff below also heavily exceeds the 80 columns. And it is 
more in the same shape like with the CAN CC settings.

	  dummyxl FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 
dbrp_inc 1
	  tdco 0..127 tdcf 0..127

same here

	  xbitrate 8000000 xsample-point 0.700
	  xtq 12 xprop-seg 3 xphase-seg1 3 xphase-seg2 3 xsjw 1 xbrp 1

xtdco/xtdcf missing here?

	  dummyxl XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 
xbrp_inc 1

xtdco/xtdcf missing here?

	  clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 
gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 
65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

Best regards,
Oliver

