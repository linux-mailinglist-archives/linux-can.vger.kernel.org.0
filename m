Return-Path: <linux-can+bounces-6067-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D966D08ED0
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 12:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D30B300D2B2
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708633375D;
	Fri,  9 Jan 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Gig344XN";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AqxqVXt+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04371946C8
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958426; cv=pass; b=rZnYL8ZRcw/GYYfTAmJoSQwgNexsCHUJS8OQg7K8sSjZ14Q2y2QgYOyWv2+nAzATGf60Ud2vJVlQRtE5k5UCoOyW3H3LDKf2awxkClAVkUI32UYz0Mjdfq0o9MdDr/PjpOm3EEwjlJA3VCrDPiat/BQEdpWgU4c/5LEPmuT9EsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958426; c=relaxed/simple;
	bh=DHEk//GPEn9RhqfvUHYW00lIMQpPl/nBqJ+JUoajz5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNL3JT0yvHO9RZscyW4d10b8zLaDKyxQeCha/aq+172a21Rm8tglOMvKmjU+6XvRHbuPAQ2oot6GOHF7QN0+uLWfvsQH+snZF5lFZX7N6sarwXLVOU26RopwOWjAbYZUzZW4QFrJjhEUzQdYOyIxUvWPq6T7LlK4BDyviiMaZT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Gig344XN; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AqxqVXt+; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767958413; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oDj4bduq7ClykWaVms0vSRiaYACAXvX1NgN6BBZdCwKv7il2RvdqfngoI7x8oXdIjJ
    J4LAzyxWLbcDHjp3rqOKePWVosdK0TUIBuNDu4oGa7ThH8wJrPwSvni5TR+EWqAsAXbG
    Wibft8jLKZzfcQRrxtweHRI8bs3/9zYWEQBiyJyquI9B3+82uWLxsZvJQADiyc3IxBKD
    U2mWXGOmoJtF+AOYlON6qcw6f9Y9sIU0w/ROvextvreqdT2VPUm955cZ8Xm4C3S7zZI/
    x3NjNlErKxMSLAnxDWBT2osjTdKBvbvBUDj04fGV2v6VAm5WHU3Xp9YY6TkfgF3ghonE
    aBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767958413;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RzAu9dEpqOZxFf28V/PCyoUzOZM5xDlK2sTKu8Z96AQ=;
    b=g4dq/g64qZc6tpqd/OfhetQCHP5HLf3L4oY60GafA3vRoqsgTKqdhkqlj/M54x99xW
    fNV68CnRwmpHvtUGF+njEuy/iJs7lVqG39RyQJmwWcqu5Mw7W+1sPwguAf/APe6Hgaxx
    xuLYA9mvZW+f+r4ZLPFg9adZuCfB9qBZavMmsMFcCskVOHmKoRWe7X5/IvRlvkQU0xm5
    /aGCNOsZz8MkEd8sHZ4e+bOWpF+0evAwKYnTpIe1fS7Ewe89G/Cm1/pl3AiEPjUeS3KQ
    JDs6Q8FiZxolIneikv90oXppyvYBcWvuKmbV85qb6qEwrls2OsDHfLVJeIyvBqGEenVp
    Q0WA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767958413;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RzAu9dEpqOZxFf28V/PCyoUzOZM5xDlK2sTKu8Z96AQ=;
    b=Gig344XNQ2i0eRI7NM0zM99mTAtdvHiLv5M+T75p8jCfco1X2dPDvVJQZBgaxTfYZi
    U2bB3+JHm3p8zlykJgtuTgbXnAjkB27VtiuZdOUw3A23+vxsaAqHPW5jF3K4oWLj4yrz
    1UZd6CCq1eapv9xpqLiRIONXN1pLNZBlnTvr5ev4EaJv6xzN1UWhB7x7sRqmqOa3XdaQ
    VVDLDt0z9L+s65NTC9SqWCoiiy8H5rRSy4Blu3QNEogFjD7t8AyZ4iqAgA2i4CKaP1Nz
    awzT0ntsCoChs+n53f8J5bynvmNlHlHShgiXLyYnnWqT/2YC817JOHxwvU/DohchF0X0
    pn+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767958413;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RzAu9dEpqOZxFf28V/PCyoUzOZM5xDlK2sTKu8Z96AQ=;
    b=AqxqVXt+Z1y4gT/4mwlHE2Hxpd+ivavNj6M6/pPQSGBM9Sj7z6CfbJELwOPI975GDe
    GBN5vAn3YZYG8S1yAuCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b209BXWO4W
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Jan 2026 12:33:32 +0100 (CET)
Message-ID: <1420bd40-24ed-4bff-9273-7dfb2c8dbbbe@hartkopp.net>
Date: Fri, 9 Jan 2026 12:33:32 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: raw: instantly reject disabled CAN frames
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
 <20260101191330.1836-3-socketcan@hartkopp.net>
 <20260109-gainful-sheep-of-promise-5a0721-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260109-gainful-sheep-of-promise-5a0721-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09.01.26 11:41, Marc Kleine-Budde wrote:
> On 01.01.2026 20:13:30, Oliver Hartkopp wrote:
>> For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
>> modes indicate whether an interface can handle those CAN FD/XL frames.
>>
>> In the case a CAN XL interface is configured in CANXL-only mode with
>> disabled error-signalling neither CAN CC nor CAN FD frames can be sent.
>>
>> The checks are now performed on CAN_RAW sockets to give an instant feedback
>> to the user when writing unsupported CAN frames to the interface or when
>> the CAN interface is in read-only mode.
>>
>> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   net/can/raw.c | 23 ++++++++++++++---------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index f36a83d3447c..aa6e8b19be22 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -48,11 +48,11 @@
>>   #include <linux/socket.h>
>>   #include <linux/if_arp.h>
>>   #include <linux/skbuff.h>
>>   #include <linux/can.h>
>>   #include <linux/can/core.h>
>> -#include <linux/can/dev.h> /* for can_is_canxl_dev_mtu() */
>> +#include <linux/can/can-ml.h> /* for can_cap_enabled() */
> 
> I think we can remove the comment, please keep the list sorted.

Ok. Will do.

> 
> otherwise LGTM, thanks
> Marc

Thanks for review!
Oliver
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


