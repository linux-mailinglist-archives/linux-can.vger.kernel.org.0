Return-Path: <linux-can+bounces-5982-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C604CED1A6
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 16:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7606300A1C1
	for <lists+linux-can@lfdr.de>; Thu,  1 Jan 2026 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBAA2DD60E;
	Thu,  1 Jan 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I3I/V9e4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QEdrhu9d"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B52DCBFD
	for <linux-can@vger.kernel.org>; Thu,  1 Jan 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767280893; cv=pass; b=FOrw0yWCyD0pl5iE5ml5StF06GrW0d0yKmPl8yt5Z1Z8ONtKk50wEb2qugtucXs5Cty/SJnmkJQ4xJukHXHxxZGXlYao57NiIafpNiU2jra+N153M2O5UGSRLRNPmCaaFzspuh09c5zZBqKCOPACY3FV6v1m+aAdgnN6yXUYDxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767280893; c=relaxed/simple;
	bh=yxz5ezQV44KiFd9ljELJAjrG99/u1CGH+K9HwwFFMZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRpqVTSg/bCuNqRHfDCp3gwe3sxin32zyr/WNpIu9WUY97hITEJwU65abbyQ3IuhCphnOJQRBnCWiJgd7M95Kt3I4FXH+J6KsFrPtp9wnfiS2eJj9wEYt4cAffPvgWbSs5/JlbwrYZr7RAetg/OAaY/2n+brBao9KBPbWweef64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I3I/V9e4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QEdrhu9d; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767280880; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RLh5Dk3Z0i9B0+2aYNtKPT8YZHxWP56euaHVPAA2oAvao25vdUUCmmtPd4YTgwh/VE
    3hdG9WrnoEs823iwQoSjbJvc1PU8XfHyZodq9S43CPKrjucH+Ml4oc6X94zXziiOc9Yh
    iokQbpO7bPoXYZ2VStCwLeH+oPyukW0pRRLTuE1CFnTz0qJ5RIXDXlCQLjRbakFNwUHF
    mOgOLZn+ncYqrV5h8pPD2iIGp0dq69u1Y2zp98xBJAZpKCw6n2mxy1eXEuBsT4fFoo2B
    Zdyey+TjBAKV2jV5hmfoO27PGd1yvAb8/EjrHZS849mwsAEU90Nu8+aOEBWA0+HDFT/i
    /MEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767280880;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rwaPQi0vhy9RCbWVDZTHuCoQnwjM6OFUdalRJyc7oS0=;
    b=ToRf0rbst0sDGxD7zQxZYyKHYXzJ+gjiIJGNEwwKIr4aKwCO17YzbeTybSiYseGrL6
    Xqa1rI8MysPjsm0OrQC9G6N7OGQBBDmeHlRJT3MMZ9cgoPOWFbs8zoMefE7ds+/HVT46
    In9des6rnkLefOISS8Q8CKIvNbfur71LoEUhLhBOtdw4z6in9HKomhp8aRW2254J4KDv
    NNZozgiXWNFnvqEHMuBcVkgtwnf6rs4TX97xeRXonYp2mHCw4qbl7qRFf0S6CO3sUQyZ
    GmwyW1VsYhzdbBtJJOKsXP08kdNgMvLa54STqv10j5Tv03i1hENCcYNx6tt7/A0aK7mi
    gqBA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767280880;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rwaPQi0vhy9RCbWVDZTHuCoQnwjM6OFUdalRJyc7oS0=;
    b=I3I/V9e42YS8vQK1mmGlQtpHQ3Mi42Pfifte141YxXFVqqYIZkRwu2fAWa0y5zBIxk
    iU6PIDrfAwE1kZnYj4wbvdnLprBrPWJV41yEDtNsGoOvqgnHtNomAjV5v8KYFncIqqDt
    q4gcbUhFNbXwr/ShY7K4Bw+EVt/KMy8mvRYRUJmoSJuDiAfpyl62whaNHeLiKQNbXt0X
    mKqHBiz0X/WetRIPmiLB7o/srtRPR2fsok+ojMG8Qd1YbUsZgAa0G2m4cAVQuz5irwXJ
    RLVRrZc5iexrFaPYGNZcT0Ie5QEEEmRRxHAF3vXMrrIQkMV1y5rZx/1lrGDeRhxaqexm
    G8kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767280880;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rwaPQi0vhy9RCbWVDZTHuCoQnwjM6OFUdalRJyc7oS0=;
    b=QEdrhu9dOrHMekmkhKXgHvVGT9OmPVUyNddgP8t9QnaIFqw0Opnr+audxbxXoDWQja
    GsImi7pW8NyAKsOkiODw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b201FLKdPb
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 1 Jan 2026 16:21:20 +0100 (CET)
Message-ID: <42afa819-1d23-41d8-a763-2e98d52a2810@hartkopp.net>
Date: Thu, 1 Jan 2026 16:21:20 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: propagate CAN device capabilities via ml_priv
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
References: <20251231165127.4206-1-socketcan@hartkopp.net>
 <93df46ef-c1db-4df7-a90f-088dbacf12c6@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <93df46ef-c1db-4df7-a90f-088dbacf12c6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 01.01.26 13:25, Vincent Mailhol wrote:

> Happy new year to you and to all the members of the CAN mailing
> list!(and also to Arnd who is listed in CC ;))

Thanks! Happy new year to you too!

This year CAN XL will lift off with a first native CAN XL netdevice 
driver and likely also with a new ISO-TP variant for CAN XL \o/

Looking forward to both of it!

(..)

>> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>> Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/Kconfig       |  7 ++++--
>>   drivers/net/can/Makefile      |  2 +-
>>   drivers/net/can/dev/Makefile  |  5 ++--
>>   drivers/net/can/dev/dev.c     | 19 +++++++++++++++
>>   drivers/net/can/dev/netlink.c |  1 +
>>   drivers/net/can/vcan.c        | 15 ++++++++++++
>>   drivers/net/can/vxcan.c       | 15 ++++++++++++
>>   include/linux/can/can-ml.h    | 24 +++++++++++++++++++
>>   include/linux/can/dev.h       |  8 +------
>>   net/can/raw.c                 | 45 ++++-------------------------------
> 
> This is a huge patch.

88 insertions(+), 53 deletions(-) => adding 35 lines.
Not *that* huge ;-)

> I think it should be split in smaller pieces with
> the reverts and the new code in different patches. What I would suggest
> is to split it in 3 like this:
> 
>    Patch #1: revert 1a620a723853 ("can: raw: instantly reject unsupported
>              CAN frames") and all the Kconfig subsequent fix attempts.
> 
>    Patch #2: Introduce the new logic.
> 
>    Patch #3: reintroduce 1a620a723853.

Right, that's at least easier to review.

> Reverting 1a620a723853 and reintroducing it later is kind of necessary
> to have each patch of the series in a working state.

Hopefully patch #2/#3 will still be accepted to restore the 
functionality of the 6.19-rc1 kernel then ...

I will send a set of three patches as suggested.

Best regards,
Oliver


