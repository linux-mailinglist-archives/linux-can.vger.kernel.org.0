Return-Path: <linux-can+bounces-6129-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4DFD1DCAF
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0CCA3000DD7
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566AB38A2A2;
	Wed, 14 Jan 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HP0kkJxH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6uv8YWW1"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0234389E03;
	Wed, 14 Jan 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385069; cv=pass; b=AYdIGAX8c5aDxSf/0t6P6zBuYYLfie8QQkxDVXDrN7Ddj1q89q4/6Dm4fTMcS+O/RV1PoHGQYBUyK3sJx7elMJBAPiHj1X4hNGBbKNMRU5lFWOY41AvrvGHO4uu16anmMzonjBeiy4EPcFuwsEQr0NKxeTdIPLKQZYQJaJ3WOwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385069; c=relaxed/simple;
	bh=XjRWVkOzNJL5uonb34PEOwV7IuFGkr9Rktxf7cdtdnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmw9NzX/5KmfDggufJz2F51vlOWHkPJILyyn5JYVYMy/yVZIssdkF/Dd9taZZ+hXd9cqfFK8NRQkTZudc5pinPLFA3ZQ8TTGURIrSyMdSnZJB3Ez4M26Ux1UXw5MFfIvk9xbiRwKl8ypPPzbcXZHD4y8T0/JiuGTilWW9ZDPjeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HP0kkJxH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6uv8YWW1; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768385058; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nwzNrfAfFwQIUTmd4YqbcIfQHk5ib3Ub5kVPFfubcgoGRaqIOqPgMLPl1ik991ft6e
    7fo0xAPxkTke7eTeAUvl1O/jV08+W/agq07H3fGmKS9R9yySU3BnRaoxalqIWJtG8KF8
    z0/CDIByOXruxYvCJ5iEL2d9mAI5VH+N0kv3GSynwo7sxbl60oR7wdWtkGbUgJ/FBihB
    0jgFe0nreoEanhC6Dx3BhriYG9sLYFFKZuwyg95DGYiKxXU1LhVlo67RAppT+GQnHvJG
    TGZXsaIL0b+8D1SPJTtOoumxznsCIpUqgIAehFCpj59F4NUNby+C2XJg/ue0ANfxiUdf
    nG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768385058;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LOIdvuV0kMrXLVF7E4zZUrOYsDIA5tm3HtfBQDctlw4=;
    b=jjurJPTjDsFtT5ZSIReZEk1l6/uQ3xSxRmTxU3JlrlNM7XyebvESTSEtHtYpehlmmj
    G7monMFmQTMzv6j5nq0oDPI7JfjG5Fe9BcorkBV8uduAR7Fv0bLS5GlfZ+9kpVZ8TjYX
    mestHI0/pfTNgZMkxG4lnbwq4YGaJbMdbRDYK8H/ctRU76+/vTerOtf/8I+S2ygR/349
    7eGUEDee25iki1Of+t1ErTtNEbWkuPGqZjzvXm74YDSpWgGrc4Xsa51VqhhW4ZJ1Pg4J
    KMTn2vFmBFjwouvOC1R2o/ufKku1145AOYQe7qwfZEwh29MSRCAduIkWqsje500kIdhM
    l8vg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768385058;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LOIdvuV0kMrXLVF7E4zZUrOYsDIA5tm3HtfBQDctlw4=;
    b=HP0kkJxHvFkJs8TvCbZBNX1mSWs4uhSk9Hrt4GDQ/P8m1rsRC4DI9A+CL7Fl74YzUs
    JzuJfXdJ3mE47KIPb3pB1/IRfRuO3KIgXhbnMeIdOzaDuaNNsDa1DFh/ZPta/vHx8Cp6
    OOl1DrAewf1k/isABHi4gfj5u1Cfh8uPDo1DMxPRibrFcx59b9mhCWbHQJZJXy7NshEK
    +friZAYPN1Z81eMrFlGGxVktOoz9Ac5D1BD6CQQHDlKuFwPOQ87o0Ao7VhfMOJ6D0Ufr
    49JwwdiHGwRUc18ZR2Id+FgtctJqgtggXwuTKKJ3dwsPFuESbT4FhzEZ2ozwHPbTrEb0
    7rXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768385058;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LOIdvuV0kMrXLVF7E4zZUrOYsDIA5tm3HtfBQDctlw4=;
    b=6uv8YWW1sSJsEHI3SAzelaj4zrYwbTDz/zzpRY3hbd72ijf8VIFeOz56J0HiwedyFE
    4YA39gNcgS0oMK28JADA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20EA4Hrgt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Jan 2026 11:04:17 +0100 (CET)
Message-ID: <5b5c8a8b-5832-4566-af45-dee6818fa44c@hartkopp.net>
Date: Wed, 14 Jan 2026 11:04:11 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can 0/5] can: usb: fix URB memory leaks
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Wolfgang Grandegger
 <wg@grandegger.com>, Sebastian Haas <haas@ems-wuensche.com>,
 "David S. Miller" <davem@davemloft.net>,
 Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu,
 Yasushi SHOJI <yashi@spacecubics.com>, Daniel Berglund <db@kvaser.com>,
 Olivier Sobrie <olivier@sobrie.be>,
 =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= <remigiusz.kollataj@mobica.com>,
 Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

does this patch set need to be reworked due to this (AI) feedback from 
Jakub?

https://lore.kernel.org/linux-can/20260110223836.3890248-1-kuba@kernel.org/

The former/referenced PR has been pulled - so that specific patch might 
to be fixed again, so that usb_unanchor_urb(urb) is called after 
usb_submit_urb() ??

Best regards,
Oliver

On 10.01.26 18:28, Marc Kleine-Budde wrote:
> An URB memory leak [1] was recently fixed in the gs_usb driver. The driver
> did not take into account that completed URBs are no longer anchored,
> causing them to be lost during ifdown. The memory leak was fixed by
> re-anchoring the URBs in the URB completion callback.
> 
> Several USB CAN drivers are affected by the same error. Fix them
> accordingly.
> 
> [1] https://lore.kernel.org/all/20260109135311.576033-3-mkl@pengutronix.de/
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Marc Kleine-Budde (5):
>        can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
>        can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak
>        can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
>        can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
>        can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
> 
>   drivers/net/can/usb/ems_usb.c                    | 2 ++
>   drivers/net/can/usb/esd_usb.c                    | 2 ++
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 ++
>   drivers/net/can/usb/mcba_usb.c                   | 2 ++
>   drivers/net/can/usb/usb_8dev.c                   | 2 ++
>   5 files changed, 10 insertions(+)
> ---
> base-commit: 7470a7a63dc162f07c26dbf960e41ee1e248d80e
> change-id: 20260109-can_usb-fix-memory-leak-0d769e002393
> 
> Best regards,
> --
> Marc Kleine-Budde <mkl@pengutronix.de>
> 
> 


