Return-Path: <linux-can+bounces-8455-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmsXHECGVmqs8AAAu9opvQ
	(envelope-from <linux-can+bounces-8455-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 20:56:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8456757FBD
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 20:55:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=S3TiRwGz;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=VGzye6s2;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8455-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8455-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F6673151428
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B933C480DD4;
	Tue, 14 Jul 2026 18:53:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F6481241
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 18:53:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055224; cv=pass; b=EQKI1Ew/frWtQkd2A4LnDIMmN1l5VrWRlOv1tXvO33xIWVewNmo8YFuRU59aLGkv7ZEtOQUUGa0eBRPTo9qVSmmjHJm6JVAdci0yHuXJrQ/nYrXkxJQq6ODJMprI49kwUs/EMLFFKEs4HPyD+dBSHKXpMACwH9KcwmJLS7h46xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055224; c=relaxed/simple;
	bh=e690s6MK1WDXrJg2xgQiUh1+TQ7Mzwks2eIlFIjzZwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvNmSa3lOV9WSNCdhGqR3c/Q2R6B57CErlbm/2DqI9VYyLy1T+H9ajATOKDoY4f6kGddXZ20IbvseNydyti6VGKT1adQ+prqnMvI4FbGnOc6aZQPWGejvzq1WhLumXzTBaQPXw5udZ5D+swUvHbLrcBY9C6Cmh3iRCIN4VxnJHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=S3TiRwGz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VGzye6s2; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal: i=1; a=rsa-sha256; t=1784055175; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OyClI9EWxaZByspCku2DOo9DGLwN/ClNC2rvLqawDAEC30Vz5vmiK+4J62DhQQBHnS
    W6EatJhR1WP5dluDH91fs/+c/RfO+VzVBltMR+gSOev5/tXS+isdZs9VNjgOQRGuNYXD
    1NC0GGP4zYeLEcdaQBtmgmKsCHsPNAu7sieXyfias/k4qWVOZQtwhm1DknV/3VdiQhfH
    y/dHiBnaESreIv7Yri+4M1OoRHMwlCrjrDgDHSLuY7t8W+y/5WBXOkdUp4Lu8dumXGeI
    wXr8TyX+HMXwGKRgGmo3mCn251XNMiFDgL/wBhltzoOCgg5QVrjEcxOnx85mNLhzCez/
    HRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784055175;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m0jUCdpxm05YpRidOhrc19eE+bnyWajWRrQLHcifxxs=;
    b=qpyy9QLpelYGTa6+hUSXv7PHQZwf5dXqNv14yEuuyx7yJfW/puifN/Bgoi4jIe7TRt
    1XsLxOQqGHVp0Ad1T0BjKTvrwiDY5tHgp7fE8C28oaKjT/UYTgHPDwnSWOIlnvmIkwcc
    hvEbakPqTMU38aHVQXii49sa5VZQO1jQCYKVm5bT+BCGrlZyJ4Gwe71aLmBAlsIPaFT9
    dlM7bDWgml3y13hQX9rMRhmJwJrnX5OmD9HW3gzzpIgB/U6OE6y8CIUdTv1PTj8SvhdI
    VT9Ndbobm9glM7nX30tcMwFD0Zfs3LCllZmdMUqWVytennnTuY8BQTfHiEJcYGJC+Fdh
    eQUw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784055175;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m0jUCdpxm05YpRidOhrc19eE+bnyWajWRrQLHcifxxs=;
    b=S3TiRwGzlCAsnzE09e/M4HTW6IHwT80x0tZParJNlktL0ODEx8jq7yK7OHM4E+PaYH
    KzJ3WY1rNHTgsQcNxqTkCvMen1LEq1QzlH3OwhsupgdmKks+zhYI740mZj0mapYXTZz/
    4gLLyA039qbGPFnVgBpigSbUKu5dwqMeWC1XhzZSlwrBBwl2z5HGB5ffSJpgIN6+vrD6
    z/aZ9zVvpKTR2sTkpoz3C3+dq9t61RdH/ivce+JFgwPvGjwi8lwN+6QqXdgo+fUryGGq
    orkXH6A/wdKYsKcM76B7kdAadagGiaj8EEsJmujXfpixSwxOoJirC2X6UeclY4XmqAcy
    VMfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784055175;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m0jUCdpxm05YpRidOhrc19eE+bnyWajWRrQLHcifxxs=;
    b=VGzye6s2JdnNL2Ui2EamqBOiB7/HOhxy81exgU1ERa4UsJZkeNO3V7ll4h6c0brKwY
    4TO02QRdbYd7fv/gKqDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EIqtmPa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 20:52:55 +0200 (CEST)
Message-ID: <b5b49ad6-c7e4-4971-83dd-8a0f8214e8c2@hartkopp.net>
Date: Tue, 14 Jul 2026 20:52:55 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 05/11] can: bcm: add missing rcu list annotations and
 operations
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, sashiko-reviews@lists.linux.dev
References: <20260714-bcm_fixes-v15-0-562f7e3e42da@hartkopp.net>
 <20260714-bcm_fixes-v15-5-562f7e3e42da@hartkopp.net>
 <20260714170429.6F2FA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714170429.6F2FA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:sashiko-reviews@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8455-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:from_mime,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8456757FBD



On 14.07.26 19:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Unconditional `list_add_rcu()` on the success path in `bcm_rx_setup()` corrupts the list for existing operations.
> - [Critical] Removing `list_del_rcu()` from the registration error path in `bcm_rx_setup()` causes a Use-After-Free for existing operations.
> --
> 

Great!

This is a correct fix. Nothing to do here.

The other problems related to this review are fixed in patch 9.

Only the sashiko-bot review 7 queue is stuck but had not problems in V14.

=> no potential regressions

https://sashiko.dev/#/patchset/20260714-bcm_fixes-v15-0-562f7e3e42da%40hartkopp.net

Best regards,
Oliver

> --- Patch [5]: [PATCH v15 05/11] can: bcm: add missing rcu list annotations and operations ---
> commit 493e1bc1997871e18b09125c187a88444720b12c
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: add missing rcu list annotations and operations
> 
> This commit updates the broadcast manager (BCM) to use proper RCU list
> operations when adding and removing operations. It addresses missing
> list_add_rcu() calls in setup functions and ensures ops are unlinked
> before being handed to bcm_remove_op().
> 
> Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.kernel.org/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 03c98e4cc677d..5c1e83eeb4ff3 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> [ ... ]
>> @@ -1449,10 +1450,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   					      bcm_rx_handler, op, "bcm", sk);
>>   		if (err) {
>>   			/* this bcm rx op is broken -> remove it */
>> -			list_del_rcu(&op->list);
>>   			bcm_remove_op(op);
>>   			return err;
>>   		}
> 
> [Severity: Critical]
> Does removing this list_del_rcu() cause a use-after-free for existing
> operations?
> 
> If a user updates an existing BCM RX operation for a specific device that
> was unregistered, the op remains in the list but op->rx_reg_dev is cleared.
> 
> If the update occurs and the interface is gone, dev_get_by_index() fails,
> and this error path is taken.
> 
> Since bcm_remove_op() frees the operation via call_rcu(), removing
> list_del_rcu() leaves a freed operation linked in bo->rx_ops. Any
> subsequent operation traversing the list, such as bcm_release() or procfs
> reads, would then dereference freed memory.
> 
>> +
>> +		/* add this bcm_op to the list of the rx_ops */
>> +		list_add_rcu(&op->list, &bo->rx_ops);
>>   	}
> 
> [Severity: Critical]
> Could this unconditional list_add_rcu() corrupt the list if the operation
> is already linked?
> 
> When updating an existing operation that needs to be re-registered (for
> example, if the interface was unregistered and a new device reuses the
> ifindex), do_rx_register will be 1 for an operation that is already linked
> in bo->rx_ops.
> 
> Calling list_add_rcu() on a node that is already part of the list corrupts
> the list pointers, which could lead to an infinite loop or panic during RCU
> traversal.
> 


