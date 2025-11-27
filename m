Return-Path: <linux-can+bounces-5759-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68973C9051B
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 00:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11AB3AAC87
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69B2FE05F;
	Thu, 27 Nov 2025 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RPoRKEoK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ficm2aUs"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DB2BE630;
	Thu, 27 Nov 2025 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284658; cv=pass; b=PnqnbVmQkbzVs0AqIFYMtWlVkFy1Xo+ufXOxVz01csphjhCXHOLDbDIjk/X95LT+swMK1ZRGLWP6h/pwMm3rgjqgunw3Ysz+dbj8BG8u6cau4+fvv6+olFMywzg4nkJTrT1DKb0OZOxQF3U9mInsiMKQcrGdpBJiqEy/wTbB+UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284658; c=relaxed/simple;
	bh=C2p6qOebRpgTDw06fgGq6TMQSoBDCcB73rqcZe+fnMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r84jR5NDMdewavSmhSZqQDH63W5Sig3uV1EvA1ZKOw2dCPEJGl0SJBM7xC7mpZbdZLwPWDsiDBxNO9ASkTCN4q9t+ge9JIeWdkx1ECAhpAWGdiDRJO82A68Ka4o14GkZRKBEE7Qoj6gsn1gG1J4w3rHL1542vNgfaBEPzWi18as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RPoRKEoK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ficm2aUs; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764284633; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dRyIm3bx048Q2Lt8NtKiNfKFYdP4qm7ToJ8MCajJWlkWSRDmJG66lFNR/ZS/eaFzbn
    RpXUZxPV3LUa5QtHv/vpNeu6GaINBecFvsCV/UUBBwsLddVG2H0o5MoPPTydtFgPizyf
    hWwk4NJORAJw/QkCqGYj7GRdMFgEsdB9bPWIsOfPQLmZ//RTU86S0bXfxFrFIS602yKp
    q8mz/YRgAfkxeU2c3oMeEHzm++omVdeMMvEI4kaBhe3HMJfaFAMxhrap2KNxqvgAXDXE
    EZLMgipwtCSMyLZ2jqciFVrBu3Cll7u34YeRwndSys51yPNAzwfSmyiOUqMqVGpu6Wyy
    BFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764284633;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AecRqHznbtlc5GuSqFfuKz0yT4OMKTlkV8Ilc3sLOWY=;
    b=ihZ34opnUNuGrlPseCQ7RQuNnuSZ23aqUgeU+AhLpEo3dd69WzMRo/FloxV1tYUQsN
    WqChUSrAHVnEWkP8Wa7nAnVH6xm2XUMIfnvqaADeeDZPEP+BtCa0atJw59syzMELhhIH
    V86cO5qHP6jBbUbX/hxmZQ8dW4YhVK7+kc8U5xeuTp1vSkeiiLq8dXrTuk+jDqCwJXfe
    1+t0woSbH26L2rl66ubaHdfqBWHy25E3GeTC0azV6YR0JBpAX7ErCi0/abTeebaInXm+
    E3bAYKfMJTLIvPvPqS7/1Feo8DDhOp0StAud8v4FOIJe4NcigjS5cFfFfbEEJQqVn857
    hIJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764284633;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AecRqHznbtlc5GuSqFfuKz0yT4OMKTlkV8Ilc3sLOWY=;
    b=RPoRKEoKJVORwUt9bpmWj8mi3Dy6L2D/v5fdLc+QjVoXxs5k/6H7f/Nvvgga/ZKbLK
    vE+DCVmS71VGhWCp8GVRC4RX6nZREc5ogbfD30/tMqx4EoFPbPTD6gmT1Ko+BF+GVTF2
    Zc0ZcLblHq4bIJKhTpJUbDlVZSvidA8eaYE/4tqft+zyWaVX6Q6ZVQK3YrPrlKM2yKts
    CkfTU4JXULatCfbCsGuOsBPbZSXpDcbuMM3DHLvEOaiQ8uXFOxpTLWtcJJEiQwVt9XIU
    bzAQuTyFj3iRHNDskkAd2Wosd1why2qeIH0e0bRlbCDPZ6CxcuHaDnbjFYtZeJdVVF2i
    m4jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764284633;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AecRqHznbtlc5GuSqFfuKz0yT4OMKTlkV8Ilc3sLOWY=;
    b=Ficm2aUsT4x4RU+IN+1zv1IzsABP5LuX4KhgqMZf861Chq6nfb0LgzdobtTqdpQXWd
    DpIj/yypo5Su1p8vYVBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ARN3rdLO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Nov 2025 00:03:53 +0100 (CET)
Message-ID: <7e2f6939-2528-41c8-aa55-6631ca0b936c@hartkopp.net>
Date: Fri, 28 Nov 2025 00:03:53 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] can: raw: fix build without CONFIG_CAN_DEV
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
References: <20251127210710.25800-1-socketcan@hartkopp.net>
 <20251127-inquisitive-vegan-boobook-abac0e-mkl@pengutronix.de>
 <f3393f50-02a8-4076-9129-6e8a1b8356f2@hartkopp.net>
 <20251127-hypnotic-platinum-snake-041707-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251127-hypnotic-platinum-snake-041707-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

On 27.11.25 23:43, Marc Kleine-Budde wrote:
> On 27.11.2025 23:35:48, Oliver Hartkopp wrote:
>>> That's not sufficient. We can build the CAN_DEV as a module but compile
>>> CAN_RAW into the kernel.
> 
>> Oh, yes that's better.
> 
> It's nicer, but it will not work if you build CAN_RAW into the kernel
> and CAN_DEV as a module....Let me think of the right kconfig magic to
> workaround this...

No need for it IMO.

I built my kernel with the CAN netlayer stuff into the kernel and 
disabled the CAN_DEV stuff.

As you defined

static inline struct can_priv *safe_candev_priv(struct net_device *dev) {
	return NULL;
}

in

include/linux/can/dev.h

this function is now inside raw.c which compiles excellent.

Building without CONFIG_CAN_DEV is not a valid use-case anyway.

It would only make sense, if someone wants to create an out-of-tree CAN 
driver without netlink ...

Best regards,
Oliver


