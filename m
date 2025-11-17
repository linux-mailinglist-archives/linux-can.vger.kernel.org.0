Return-Path: <linux-can+bounces-5473-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6048C666B1
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 23:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71884351C15
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB9264F81;
	Mon, 17 Nov 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="f0eh4p0x"
X-Original-To: linux-can@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81523EABB
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417748; cv=none; b=ld9c4t4+r/b6GnubUTGYQEBo70IrAkRUMQ0uU/34e2H42hgR5617ijEkJOGt+WY67HSKrFroyRD1pUV82fZy8ya4UrVFcRVER4CJIGHLko9WgAFn5bQW1q8w/upRrTL71t56bAso9bm8X5VpR2UW+qW84Ju/y6bzKTGLQbWHlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417748; c=relaxed/simple;
	bh=Z+J/p00XcyZO+ov4fpGwnpvMmWcSBc2AMJMrvGxidv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vx6ho1cN+MJ5QeDOyVc/rprW6lC1i9h8cIr58LOiRFM/KZm7OC6XtAq00SbwxmhS+0lO/c1NNqnjwkejJy1wijABtQ9P1OKkWIqQfjQEkg5GaWnBXl5vhsJ4fOcNYxp130DWVXYdP61iaj4kUG8rmpJER5GqgACB83y1U1yciAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=f0eh4p0x; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B5F6B240028
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 23:15:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1763417744; bh=Z+J/p00XcyZO+ov4fpGwnpvMmWcSBc2AMJMrvGxidv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=f0eh4p0x6zPEweP/WnxptPnF52xP/UWd6k4wvd25tH0RJb+5LfkDNtUSXA9wIN1BE
	 JZOkSoNwnAIT3343116/RJt4nonH5fVC2dgXg6XcEWXhJuuVnNQ2rMaVPtfjnoc0AH
	 0CXARUcRh2o0m7og5yj65oQ0R41hszKamMD6qMxaUx649Scbv3TEu5nw5MwZzBD9qI
	 xYmlrzdOBD5BVWhY4PgHMqv2xh1QAEqd/1bA1+R1TST5v9XCfVp31h8QmYWN6Ic5tC
	 CGZTDw4by5eZRoTwnTFMZJkqGCGeSZXozcmfTn7jTIWuNfBaU2Q2Xz+WE2NTsi9TNr
	 0mPeN9JnRRbHw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4d9MWh0V46z9rxF;
	Mon, 17 Nov 2025 23:15:44 +0100 (CET)
From: =?utf-8?Q?Thomas_M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,  Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] can: sja1000: fix max irq loop handling
In-Reply-To: <20251116-inescapable-festive-kiwi-40724d-mkl@pengutronix.de>
	(Marc Kleine-Budde's message of "Sun, 16 Nov 2025 16:25:33 +0100")
References: <20251115153437.11419-1-tmuehlbacher@posteo.net>
	<20251116-inescapable-festive-kiwi-40724d-mkl@pengutronix.de>
Date: Mon, 17 Nov 2025 22:15:44 +0000
Message-ID: <875xb8b90w.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Thanks for reviewing.

Marc Kleine-Budde <mkl@pengutronix.de> writes:
> On 15.11.2025 15:34:56, Thomas M=C3=BChlbacher wrote:
>> Reading the interrupt register `SJA1000_IR` causes all of its bits to be
>> reset. If we ever reach the condition of handling more than
>> `SJA1000_MAX_IRQ` IRQs, we will have read the register and reset all its
>> bits but without actually handling the interrupt inside of the loop
>> body.
>>
>> This may, among other issues, cause us to never `netif_wake_queue()`
>> again after a transmission interrupt.
>
> Applied to linux-can and added stable to Cc. Out of curiosity, what
> hardware are you using that has an SJA1000 IP core built in?

It's a B&R APC3200, relying on the sja1000_isa module. Currently
debugging something there. However, this I actually found from staring
at the code and data sheet for a while.

Best,
Thomas

