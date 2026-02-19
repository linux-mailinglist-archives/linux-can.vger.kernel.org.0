Return-Path: <linux-can+bounces-6591-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI0eDbwHl2lmtwIAu9opvQ
	(envelope-from <linux-can+bounces-6591-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:53:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE415EC38
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CF493002F7F
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26908339870;
	Thu, 19 Feb 2026 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="g6+49kC1";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nVXFMxSU"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C3261B9C
	for <linux-can@vger.kernel.org>; Thu, 19 Feb 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505589; cv=pass; b=LawdI+3hQNLlyqpi3anisU10taN+j2dUpF6GgEyMU4wbsnbHxOW/7nURBCKiKbElkMUxF+f8VD6PxI+DB4WvbcbkqlIwJH/oMf4bwKfm4xyxtY3t5F+kd9nAvm8unRKxjzo+inMJO3mI55/n3U/xAX5Jvj/novJxNB9JDtOS81w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505589; c=relaxed/simple;
	bh=jvfpYXTyOFThtNEPcbiyVLuKqGUN+mufHleTje27KKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsvORThGCSVP47x2WBkkQnRI7e1Ho9I/HvCQIUgwBX8aIPJp5iZHV09KSh8f4s3iWjKICv0k7xkjnjUVrnO4FFWxMmzmXIEaCA6cydfgqhughmPdBvWU/gs0ADvUsSgctjW5VDtxtoaE3TF9D/YR7ixwu8HjIczNehqh6GcMaU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=g6+49kC1; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nVXFMxSU; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1771505585; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Nsk1sCXlJLUgnTyG/DyO8m/J/wxEVeSFz7/omDXsnIcR6XP5jujkzHPGJu1cHnkgdR
    ooAmvU+Opk0B+L1tEcXwhQGT9Hbm2D+ybq9L2bvaCAOgjqb9y16JCu6pzVzzQiifLc45
    fS6AaH/d/pt8Z2FxhMftLCfPCTz+44bAs9cI0eFP7VdWZpDV9KhuaOGhPBXt4KFfdOLe
    /e/+0ayfZFuds8qse9b528RsE5ppxdLRKVux9DUjPod9ePGAsXapW3Mg7MMc1P8ESAfM
    rT5BnAVpjdcPqMyuzuCuz+OC5M2yAGNRPqjryevEU4OT4RPzCzmyIPq3i97pBbs9w7QC
    Q9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771505585;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LGgsJiXrhqCIKAABCJlNnbCOLZPhImbb4eWaADv8fH0=;
    b=Ca09kgQzoceCQoYOs5If6LdLrBvQmmzs+Uoga5qRlM5RgUyHzrKoa3Z74UNIuJm+qt
    kGdagPCjnyw9gG0JcU7y5Iwa5xlSNQFPZ4IOUiRAqYP0jBIMnsru8d8Ek9H9mc7F7Q62
    TYHzqtwNsW1QWzQZ5LKArwRybAPhbpKonOUXVDE3/dHxfVxX2uvj6IMQARjomnjGTXTu
    oKg8Ae4s3A5D1B0a362116U13pxLnUtZedj7+mh7T5Vg+rhVx0XD+LFeCtoDSISOSsgF
    75GcS6SmD0+/dbuwhAA7i9rPU3xaepfmK707I8DHOvaTjLQTytTHEGTFuVC6bFOOarif
    5h9w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771505585;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LGgsJiXrhqCIKAABCJlNnbCOLZPhImbb4eWaADv8fH0=;
    b=g6+49kC1HhbMUhnLHRjys5akVxnqJUhNhr0gTf/yQGMbGDihr1EKSd5nzwk3NvSN6D
    mO71HZ6kb5SgheEo9vFGarXtdOifo5/SeGx8kGXCS5PtFw+OpLsPPPqDkEX95tw/0Gxd
    dQ2Ws9oC5M9ECg/yel/aiE9xhKJJvdUMD4NCntrMOcwNqf446Lj4a7uTeVFO7qe3P5t7
    F9DMSGwCbNiWg8EieBoPelV1ragdFzPWPKLiBycs/dQCU8aUoxd5jpjZcRFxEa5/plcf
    ZSgcYT5cvT06DhhHD3UYTpF2X1EJxQv3gd+Ox1ieH/lFvBgK0ao9hy8i7TB/FuIHvrmd
    r+PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771505585;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LGgsJiXrhqCIKAABCJlNnbCOLZPhImbb4eWaADv8fH0=;
    b=nVXFMxSUIY4NlogAN0rylizKtC8cry7Y8wchjJ/h5S8xnHjQBea3AgH0Jb5MlZBl6u
    FB3hbgwXckupCZlKvkBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka861021JCr5TOF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Feb 2026 13:53:05 +0100 (CET)
Message-ID: <77eacdb9-54c4-49a1-a4e3-1cd26ee1623f@hartkopp.net>
Date: Thu, 19 Feb 2026 13:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: bcm: fix locking for bcm_op runtime updates
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net>
 <bd8fa6fc-3858-4b55-b186-aa5c773e19fa@hartkopp.net>
 <20260219-dancing-waxbill-of-purring-f94271-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260219-dancing-waxbill-of-purring-f94271-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6591-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:mid,hartkopp.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DEE415EC38
X-Rspamd-Action: no action



On 19.02.26 13:34, Marc Kleine-Budde wrote:
> On 19.02.2026 13:22:29, Oliver Hartkopp wrote:
>> I have an updated patch for the bcm_rx_setup() issue using spin_lock_bh()
>> too.
> 
> Ok - Please test your with LOCKDEP enabled.

Yes. I enabled it since a while.

Btw. I'll do some tests today. The code is really easy to understand and 
I've discussed it with Google AI ;-)

Let's see what the Patchwork AI will tell.
Would it make sense to add some more automatic checks to our new 
patchwork instance like we have for netdev?

Best regards,
Oliver

> 
>> So this patch
>> https://lore.kernel.org/linux-can/20260126161711.2374-1-socketcan@hartkopp.net/
>> will be superseded too.
> 
> Waiting for your v2 :)

Done


