Return-Path: <linux-can+bounces-7884-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aBAuDa0TNWrJmgYAu9opvQ
	(envelope-from <linux-can+bounces-7884-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 12:02:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F96A518A
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 12:02:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=YeBlseUD;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=ps18kzAK;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7884-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7884-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A3AA30B73FF
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AEC3655DB;
	Fri, 19 Jun 2026 09:59:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBB36B048
	for <linux-can@vger.kernel.org>; Fri, 19 Jun 2026 09:59:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863154; cv=pass; b=r0xvukyS+qcJGKc6taIKLu7Wyq8d+5bA55u5rq5zDkaSiQZ7PdyD6UpMLKTBxiYtpURkKGgWI1+G9Lp8PJA0zp/II0hTnhfspkAJmUvBPCpQgopNlSqRge55UdCmo7af0ejyYLwb6wU1ZtRUJYlRjGYo6g1dONYS4VCXBrUUYLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863154; c=relaxed/simple;
	bh=Yj98rl9RYiBqCTTwqaF0SXd956Xaa33lUwiW/a79bYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9hR096zJY6OVtkbRubJTUTn2in6dg0IK28TL/8r7L2jlUjugB7XRsQl9X+AmXpZ9OQS7XEHhSNG5oJqMOjH5AbzmRLQAuqXm0cepls2tK13DPqrcQJ2KgzOKWAESA9Dh03EK5IbI+HbFIiiggPU2FDQ10V3Jagzyd31iPR70/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YeBlseUD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ps18kzAK; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal: i=1; a=rsa-sha256; t=1781861702; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NCZdvw9WCUsbj1QmO8V2E1H6FGuEG8yG6rAWR8UoxJgdVtNYzthWIaI7lEZYP/hnd+
    5GxWjEgleuHAF1pXQgFGpAx5K+TfHRnw4qo4q7SIz7saQWGg9KXJr4ILf3BL8YJSbwy1
    oWE58oGRp4GYMpMX08Xf2t3FyVzBKQ25TY+bI3QPIBo09iCfRmthtUu1yubZFCvheBvB
    fkcR8+3ILYfltsF6o2F4pKDtb4yIGSLioKVA3WkCzuwNoE6uqwacPYc+tUoXqzm7B2FZ
    bxgkpEmxyv1zmQb1pQeMibjFZYGOyxus/vHmE1acUADfTsjGdbEh0rOOnaujjIYNOF+m
    j02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781861702;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NhTE3kVihPjw1wWBCrABPHbhmlMXJFlRs+NbA3/1c/U=;
    b=gaPw5Ues64c5Y4RPPOcfKCScq31QzXBn17eCK1B4DKmaTUH7cYZZxC1/klGsZtOc9v
    VGHXn83l9il+IWumH0lErRDKt9QY8UZLb3SelPNeeS6YcO7bYuZZdF+dUzV0U1rbzUMJ
    WQJjN5lddLxHyPv4YZJto+wUkNUPBmMrd/NsILSFP8hwZL+j9oyYFgTJwck075lKqLYG
    wBCWlmAiUUgXEbDW7AHlJNWwZRIc2XvtLFUvBCegLE/6nj7Kvkalo1Fkej2MaH3VdBnt
    frHrmdu/xoI30CZr/YDJ3/7eck8OIRlNTSZCJZ0J7r4nAXbCpDOztOuYAQhghXu99EEK
    u70A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781861702;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NhTE3kVihPjw1wWBCrABPHbhmlMXJFlRs+NbA3/1c/U=;
    b=YeBlseUDV0wo3ucbch6lz+so0QsQxz53AMNuUQ9xqa7q0/RXA3SbK7yaCweUcY5MgL
    CMW8Nt1B1p4rrG3iLiEpod7p8Vw/Gsk2xtdFP0mQLqEaX+yPgzGWMIjx3FxIqKVjJnMX
    9mEWzoXK5aANt0e12APIC02HY9Fff6Qu/i8tjBqRg61SLC37fpqoU3hPOV1QBVyFfkls
    4tEF2cMQuAQunhN15B7n9oT9KA+CgsxZauEcKW6FHLkR6ztDPtt4hGpJogqVde4m1PYj
    hxMQ71gpnWeTPg7Akah6mxvosc3nKerBAbqOGQ/bv2kfjoCentZ7yyvifgi5Tfs+piz1
    CXwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781861702;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NhTE3kVihPjw1wWBCrABPHbhmlMXJFlRs+NbA3/1c/U=;
    b=ps18kzAKNrpUcn8OHvSLeV0gZRWQEEP05+7E30YgZiZkVbcCFFozXdVx4GD8w7LVFk
    rXFeawgOvS8V8FCCkODA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25J9Z1Qzm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 19 Jun 2026 11:35:01 +0200 (CEST)
Message-ID: <1f3a3c0d-71a6-4c7d-9e08-5e19f1999af2@hartkopp.net>
Date: Fri, 19 Jun 2026 11:34:55 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vxcan: fix Kconfig description stating no local echo
 provided
To: =?UTF-8?Q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
 mkl@pengutronix.de, mailhol@kernel.org
Cc: linux-can@vger.kernel.org
References: <20260619090035.17769-1-alexander.hoelzl@gmx.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260619090035.17769-1-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7884-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.hoelzl@gmx.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.net,pengutronix.de,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E2F96A518A



On 19.06.26 11:00, Alexander Hölzl wrote:
> The Kconfig description of the vxcan kernel module erroneously stated the the vxcan
> interface does not provide a local echo of sent can frames. However this behavior was
> changed in commit 259bdba and vxcan interfaces now provide a local echo.
> 
> This patch changes the description of the vxcan module in the Kconfig to reflect this change.
> 
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Alex!

Best regards,
Oliver

> ---
>   drivers/net/can/Kconfig | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e15e320db476..e68b5bcee3a2 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -40,11 +40,8 @@ config CAN_VXCAN
>   	  When one end receives the packet it appears on its pair and vice
>   	  versa. The vxcan can be used for cross namespace communication.
>   
> -	  In opposite to vcan loopback devices the vxcan only forwards CAN
> -	  frames to its pair and does *not* provide a local echo of sent
> -	  CAN frames. To disable a potential echo in af_can.c the vxcan driver
> -	  announces IFF_ECHO in the interface flags. To have a clean start
> -	  in each namespace the CAN GW hop counter is set to zero.
> +	  To have a clean start in each namespace the CAN GW hop counter is
> +	  set to zero.
>   
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called vxcan.


