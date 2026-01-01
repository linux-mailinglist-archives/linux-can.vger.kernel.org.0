Return-Path: <linux-can+bounces-5981-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E937CCED17B
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BE5A300B824
	for <lists+linux-can@lfdr.de>; Thu,  1 Jan 2026 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8D627FD54;
	Thu,  1 Jan 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="j8rpIw2P";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CbgMQItq"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDD283FEA
	for <linux-can@vger.kernel.org>; Thu,  1 Jan 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767280121; cv=pass; b=Pr/lYqDJYCDkqBzYXADYRirlwKuasDGXIlbXqSCMxuT+KVtgEXh+3cePl8dqYHo2i4KSPRhSxJxp7oAheZuAMMJd0yVafZLy14fqDydV1V8WRIuaAJyCa1YruoKCvVDw9RiwLtRCIpi2kPnEUwZlgHRUHbKYoGkYaQ66jY5349w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767280121; c=relaxed/simple;
	bh=+dUYjhqyAveiV7PfQ3jROm7DsNf4AuYCzqMrViBLb0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfL+xbeyJ/u26Wch6a7D+dio36ILrcQJz0Wx+CiEKNijUDsbFE5IhtCzG9eQgv6u48eDhHJPcM2L5vDQ8OTmmbj/t2SWCp570smaSrRpqkwqb32BPc+nhR6VMAqDdcvs6iBjNciIguU7a0YsvyFOmQGptiZs+8kJFm7G6P76Q+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=j8rpIw2P; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CbgMQItq; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767279384; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BNHzEslbVtz0es2A+mtUg7WtyyBb3b0/ZiurZp4CoPoLDmzHv6bStgqqYa5m/iht/q
    yaORgLogJWXLl28DGZ4QCfAtVcAkEJUTxuFlvTnzXyeD3MbTr5afbZQKnQbDvy8xgb7u
    qpXZ6P1LIqmy2BakfuOz4jbEk4YhNet4AwXBpj3iSf9AjS+eGZCzYPrPWI7IVejPhw9g
    Ntve7HHj+ArA6n/cLKhaZvt3L9dC0SirezhKSrm7wNa9xAKh59ok+zN4SDgPZpw/w8JO
    xYOU6wsJJ6fXKggIU9O1oUbY1/ZoPN9A55s7OTELnLUjk4Ii8jNKQqWT1LM/ZgPGdPvD
    NXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767279384;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/HYrXuSOWhdTsA1efalp8wjXlPq0xa41Vf54u2QrVvo=;
    b=Kjmmra+EOEtPiTC1WIOao34Ncgp4/x/v67oGpxlfz/uB5C9lWRSR42/qDPXjQRlCec
    O9Oc18bW1flvP5PhvCUVJPklgrJ0xgoXKjf4KTJndBJOfcfCb05mYowtBJoTOtqoWinW
    yB005gXJuM929lYqpOKl+ngP9SpPtcp9J4BbQZhofoTvOWh+gKnuIwkdrAsWQR8hhL95
    ZQo6RN9vTMZcnG+N3zIgLhwg+KE/x6+Ubk5q2edzOafwLUyp6RRWXe06Vnk4BpiQ+Kz+
    /gzkL7MeJ41j3KkpLydvPMynlrK/cFrboA7YwvVq/aB2Eda1E57eaW6UUhb1uGHlduSW
    8AeQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767279384;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/HYrXuSOWhdTsA1efalp8wjXlPq0xa41Vf54u2QrVvo=;
    b=j8rpIw2PeO2DpKJpDcQfjtJtoKwbX3tl2YqwpVTnePjKVPbGP9eja7+UhZYnlDiDb+
    r6RjTf16oC/ve+WrqNyDOZuZETvvs8kybuYtpejjxKvj8BTdiOPpUVDevSzFWQI2B2wk
    ce8wwrpaDcQBB4F+Aw1Pecgmdq4heNjgvbMkbkrtDmBnalzEwCyoks3xr3vWcXla5nVk
    qMAnaUx2q/bDG3PGlZlPCXPpP1h5dlM+7yKE5NShwNJ5F9zIwcp2JsU3DPa8LwvTYm+a
    UX01p+iyqO3E9PkAmvZ209Lp+lm1Wv85qmsZlD1WpfxMoV6g+lcu8t6HXy1Ld3jDklcv
    Q1Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767279384;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/HYrXuSOWhdTsA1efalp8wjXlPq0xa41Vf54u2QrVvo=;
    b=CbgMQItqbBCdeVLnfInP/gqWm10XkZIkdDngAhj8Roy2t5aE3wYei40ONP8u5ntdNT
    rf0f2EHZN/PVFGdDwVBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b201EuOdLp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 1 Jan 2026 15:56:24 +0100 (CET)
Message-ID: <8255d7ff-eaea-4265-8c7e-6a09d9d0384b@hartkopp.net>
Date: Thu, 1 Jan 2026 15:56:18 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: propagate CAN device capabilities via ml_priv
To: Arnd Bergmann <arnd@arndb.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20251231165127.4206-1-socketcan@hartkopp.net>
 <b5fce247-12b8-4a2f-bad4-c20ea4ed0811@app.fastmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <b5fce247-12b8-4a2f-bad4-c20ea4ed0811@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Arnd,

On 01.01.26 13:31, Arnd Bergmann wrote:
> On Wed, Dec 31, 2025, at 17:51, Oliver Hartkopp wrote:

(..)

>> With this change the CAN network layer can check the required features and
>> the decoupling of the driver layer and network layer is restored.
>> Therefore the Kconfig and Makefile changes/fixes are reverted too.
>>
>> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN
>> frames")
>> Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by
>> default")
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> No objections to the patch, but I don't understand from your
> description here if there is a remaining regression in the current
> upstream version after the 5a5aff6338c0 ("can: fix build dependency")
> fixup, or if this is meant as a cleanup that can wait until the
> next merge window.

To me it is a regression for code which was introduced in the 6.19 merge 
window, as we bundled new dependencies of the CAN network layer and the 
CAN driver layer that where not needed before.

E.g. you were able to build the network layer without configuring any 
CAN driver - and building the netlayer stuff as built-in code and having 
the CAN drivers/infrastructure as modules was also possible.

So the entire sequence of needed fixes for my can-raw patch generated 
the regression IMO.

Best regards,
Oliver

