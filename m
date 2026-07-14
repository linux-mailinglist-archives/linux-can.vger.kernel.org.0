Return-Path: <linux-can+bounces-8368-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IsfUAJzdVWpGugAAu9opvQ
	(envelope-from <linux-can+bounces-8368-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 08:56:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47353751B0A
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 08:56:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=d622f33W;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=etdyy+R1;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8368-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8368-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0008302837A
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 06:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91B3DA5C8;
	Tue, 14 Jul 2026 06:55:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBE2F8E94
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 06:55:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784012142; cv=pass; b=c59BfS/YCVAjRohXT+K/yf9pQWZSePvxDJIrHRXldoUN1WFGgsIXg8mBgfQdlB4WdaWN5WM+XkCJD8VxqbLGyx3qju8rddaoYUJz0gtmVzO9vqfqAm0q2FvVm+E98/hV12sOun0lsu5I7bZpfuBYWG4pD9ZcM3fj1dPZwy9ogyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784012142; c=relaxed/simple;
	bh=QRWtVA9wgcNyv+f9leP1783jLw1wzGW2D3lBilO8J+0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n68YEv37GJwPUs4GhhTIfJ0ODcOvdF52fvyA96iLCmJ0+2GCh4dEFjwXvzgojP83F1ativw+ZIzo/TSuovgyVKGLqiuI30kd7DWD9Gs4Mt7CWFzZhYKTk4xxVG5GdBszrQGajawBVbeJoNOwVUcyU/x/Xfa2VH1g+4HaDmoseTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=d622f33W; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=etdyy+R1; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal: i=1; a=rsa-sha256; t=1784012137; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a4/dOO2azujUUg7kdo/NyhJblQgD1/Swel8HcFAJqf/UArIju/QEmIXFZxyegvQ3bR
    d2k4b9z8DoIf0M/d373zDoo6ZC2T99pmfUnQAbaoZNxMwkliwI1DpmunZUlmt3Gt894K
    UVePuAHJBqQg8M0oG795AObclWBP7iD0ve/BWS+1arAqEGoamgagSxi5sLbhtnaygyHI
    fyyJGHaDyFUYCC79NN6cJzpK14Xnu4X7P3YPCHexo50IDvtDAPPXYHvyXgUSZM5yl8Sm
    UQC0MB15fIIDdpQO4VXUAB8ur2Ul3U004GVR1P8sSho8QGXGReMlbW56s+91m3GF0S8z
    ltxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784012137;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pchMorTaqErddRwQXAjSxNA2caQdaVp+TJIOORU3lYw=;
    b=LBtNuNjv8B3YGKQgTqEk8KGYppEEzwsWLjiGnw+bXHq0z0S0YmAgVtKlT7U/+3dZ04
    kx3lUfPDs/OMrFdJr4x4SANwU/vE18ImtR8QUOmmGwQBNnWaleGT5u7aLywNx7z57nVn
    99KIXHvTbJzvXVX5C7MAJn4Fqs8DNHF70+/ZqPfLsTZnqnaOzpa8D1B/4ZbzDxwnQqI1
    NJNLsbe/wZ2HUgg/JHNLtUTTTL78uxU4t2ooDgY46VZgJXk/h+8N7RbDLVdndRdLYuqU
    O9nqHAFfJK+rX8htzFEhhfBw4ISnzY5XFQ7/SPQMNxhzHuRE2Et8P1JMkIJSxHGw3RDq
    1Xhg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784012137;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pchMorTaqErddRwQXAjSxNA2caQdaVp+TJIOORU3lYw=;
    b=d622f33WWz3Z6b/r87XbLHG3zUTDDllTN2dIoGlxCLSZFSNaBx3JMzaw9BUja7K5i8
    pblbuS2/WbtzaCAL7MNtXW+xVMxP26GRvs0a9PMl2rcpmJWdYiTXefi1svxYnayYbL6h
    9oK2kXq0RvVHh3a9vFbcZ0Gr7wXWDvMv2QAZk095y2WRh+wWYiyWVM9prI6/M7G3w7iF
    QF3tR747NyElzzkG8IKQrDUBG6eP06p+2TARWIMNlAJHxqcfAi2ga/eAwz/Eocey3vPB
    fhyyLz0IQg+MNxOKKXYjFZOTshuA2jHSbPG0b5zpEo95yzMF9vq59uiwooFTH6R+2LFf
    KI0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784012137;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pchMorTaqErddRwQXAjSxNA2caQdaVp+TJIOORU3lYw=;
    b=etdyy+R1Q5B6Mp+7ntMFwpMVD5tuSmo7Vu+NuLNhXgGjCRz6FBkHdhw7Z9sES4Je8N
    Xr2fIejfBSDOAJWnakBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26E6tbgwp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 08:55:37 +0200 (CEST)
Message-ID: <ef991c9b-276d-44e9-a48c-7bf52f69ea0a@hartkopp.net>
Date: Tue, 14 Jul 2026 08:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Weekly net upstream? - Re: [PATCH] vxcan: fix Kconfig description
 stating no local echo provided
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: mkl@pengutronix.de, mailhol@kernel.org
Cc: linux-can@vger.kernel.org, =?UTF-8?Q?Alexander_H=C3=B6lzl?=
 <alexander.hoelzl@gmx.net>
References: <20260619090035.17769-1-alexander.hoelzl@gmx.net>
 <1f3a3c0d-71a6-4c7d-9e08-5e19f1999af2@hartkopp.net>
Content-Language: en-US
In-Reply-To: <1f3a3c0d-71a6-4c7d-9e08-5e19f1999af2@hartkopp.net>
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
	TAGGED_FROM(0.00)[bounces-8368-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:alexander.hoelzl@gmx.net,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:from_mime,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47353751B0A

Hallo Marc,

I would be glad if you could upstream this patch together with the now 
sashiko-approved fixes for can-bcm and can-isotp:

https://lore.kernel.org/linux-can/20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net/

https://lore.kernel.org/linux-can/20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net/

Those are at least the fixes I'm aware off.

Best regards,
Oliver

ps. a later update of can-next would be nice too.

On 19.06.26 11:34, Oliver Hartkopp wrote:
> 
> 
> On 19.06.26 11:00, Alexander Hölzl wrote:
>> The Kconfig description of the vxcan kernel module erroneously stated 
>> the the vxcan
>> interface does not provide a local echo of sent can frames. However 
>> this behavior was
>> changed in commit 259bdba and vxcan interfaces now provide a local echo.
>>
>> This patch changes the description of the vxcan module in the Kconfig 
>> to reflect this change.
>>
>> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Thanks Alex!
> 
> Best regards,
> Oliver
> 
>> ---
>>   drivers/net/can/Kconfig | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
>> index e15e320db476..e68b5bcee3a2 100644
>> --- a/drivers/net/can/Kconfig
>> +++ b/drivers/net/can/Kconfig
>> @@ -40,11 +40,8 @@ config CAN_VXCAN
>>         When one end receives the packet it appears on its pair and vice
>>         versa. The vxcan can be used for cross namespace communication.
>> -      In opposite to vcan loopback devices the vxcan only forwards CAN
>> -      frames to its pair and does *not* provide a local echo of sent
>> -      CAN frames. To disable a potential echo in af_can.c the vxcan 
>> driver
>> -      announces IFF_ECHO in the interface flags. To have a clean start
>> -      in each namespace the CAN GW hop counter is set to zero.
>> +      To have a clean start in each namespace the CAN GW hop counter is
>> +      set to zero.
>>         This driver can also be built as a module.  If so, the module
>>         will be called vxcan.
> 


