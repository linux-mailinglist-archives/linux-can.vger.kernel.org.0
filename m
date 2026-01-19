Return-Path: <linux-can+bounces-6225-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44992D3A0AF
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 08:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D863304C91E
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BBB3385A8;
	Mon, 19 Jan 2026 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gpD8FKwR";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I/CewlTi"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30021E9B1A;
	Mon, 19 Jan 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809150; cv=pass; b=gnPWScX2/HOA4cMK+IWqcTWPdz5ElmZSLq1ozvusCGj5AVkpWjUIwzJGsfIvK3+GuTVaMXe2PlBpuL/B9rjHxMuN2lidKoTsKaHLinh2DRY5o0epx9U+u9zu1tDKA+3wSyPZDy6ye8YODK7JbyPFEwIdxjewU7I81MuBzMYxLck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809150; c=relaxed/simple;
	bh=VlkRWaLxwXVReU1bXdGVxRx4lUApAnUNyPYSZNZD4vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7CLRELFSo4yrA+t0JWOjNpt1tccBMB7JEt6J4Qc286QJRQbWrW+ky+Ku0zzihICoILCPQlMPwyET/z6bqxVvkvAQjDIp9/2fcJFGZyx2iRErugIGOZuBg6gc7CHzBWAnnnVTnyuSkcAqEkQqAClVAC663Mzi4pBHd170uYMf8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gpD8FKwR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I/CewlTi; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768809141; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Oomo7WlWgSLAonkCV//PhRkPHEqtYUHLYJJeL55v3N5mcxuY57u2ydoWkFo+NbDsmL
    fMltxwrr1wSHFj8sLHprTt0cDy35KOEHMrs+ILMZkJMJNRHhMTRSQuj5R7hPgaAu4W16
    tL38qUu9SSIoUWAsbv54f7ce5nTzSwn/OcrmG+Qy0XcbpXi6NrsKu/6mmuWAffh5T00u
    736DfPioKAC85z6qGNXIPn8LJn9DSyZH9PcufraG3jkgCnD0xxmvi+smLqDuVpB3hYGb
    5Mex4D8Jl7T68XLMTkJkPENATo9ArRBjshSYnl+p+5hvA78zdx0dUKIoS2rQk4SUZ8uS
    ADtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768809141;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BTPrTKNEXxEQoO6zf25oS4/1pJqbIPQ1TTC+Ksf+cbA=;
    b=dUxz5bYlaLuCVRp0RAFKh1DO9lJdkeXwAIrvqgCDMz8R0ves31yuYkUjjUkAv0Y0v2
    wAm4zXH7Ak4RNR8VHO+08NF9UYi535OP9EZa9ucCNgSJWtsfGJhKahY7ywrnCFOp5bjd
    JslgWm1UmVYcxmKbd6ErusbhwXQkenavfnqaI9BCSwHl0BJ7YQljDrJPVYHR5G2UJ1CL
    6rPauAldwqRMlKHWwbrQD11q59jRRUZS5nCI8Mk6mG4icOngd3dl9SQTeNpq3DExcixC
    ELwNQ3MsKvblxpEPPaLV96HwDa2wXQ0jIbTQgguVg5LWcLkyrA1JC7T+FPPqmXPqIcw6
    cDJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768809141;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BTPrTKNEXxEQoO6zf25oS4/1pJqbIPQ1TTC+Ksf+cbA=;
    b=gpD8FKwRZXZxw5wXycthP7Sja4e3LoHRNGPCPAg7F2k+8BkvyBCnRMOVCfKkshMM9x
    hLNfyENhk+Ng5JdHYblfsK+VceCjaUWX/bEYv3EWGZPJNBWscF8w+B7T8Rsw8EhMOMpZ
    OCZrFp/sypIzDNKc30cSjTZGEBLiTibThv3vheDC0jHYn1Epx6OTS45bBVzmVkyiZK4o
    jpnaIse4uHUdVbky6R/EMnkHiS02A14G3HoKZtM6bYXt2l1QdpPzJLyIYiTJyJTb3Mrg
    4Bsgq5z/ZklEk7BuRYeIlUV7B2OI1Stq/zPy4APQrBKoTHBp07NdHlMLXmSUn+c3xgIG
    AzIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768809141;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BTPrTKNEXxEQoO6zf25oS4/1pJqbIPQ1TTC+Ksf+cbA=;
    b=I/CewlTiogTG0OCZvOQK6P6UTjKjdIJ8yptFqgIjC50Lhoiv6GdxNsWeS6eBVWY70W
    Rm5eqITO57/ohS/q6ODA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20J7qLajC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Jan 2026 08:52:21 +0100 (CET)
Message-ID: <be555a81-9448-48cc-9b17-0e3f8c005ad1@hartkopp.net>
Date: Mon, 19 Jan 2026 08:52:15 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.19.0-rc6 CAN regression
To: Francesco Dolcini <francesco@dolcini.it>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260119071753.GA14836@francesco-nb>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260119071753.GA14836@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Francesco,

On 19.01.26 08:17, Francesco Dolcini wrote:
> Hello,
> there is some issue with CAN on the latest linux 6.19 RC,
> canfdtest fails with `send failed: Invalid argument` fails on various
> SoC (NXP i.MX8MP, i.MX8QM, i.MX6 ... and TI AM62 and maybe more).
> 
> Is this known and already being addressed? I have seen some recent PR
> and patches, but I am not sure they are fixing this issue.

Yes, this is already fixed here:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/?h=testing

in this patch:
"can: dev: alloc_candev_mqs(): add missing default CAN capabilities"

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/commit/?h=testing&id=375629c92fd842bc2a229bb34c4453f62e097169

The PR is waiting for upstream:
https://lore.kernel.org/linux-can/20260116200323.366877-1-mkl@pengutronix.de/

When you apply the above patch, it should just work again.

Best regards,
Oliver

