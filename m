Return-Path: <linux-can+bounces-8355-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8j86LmObVGrEoAMAu9opvQ
	(envelope-from <linux-can+bounces-8355-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:01:39 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E0748760
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:01:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=hmdMNuu3;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b="/aZs55V1";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8355-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8355-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D65304D467
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8445B399377;
	Mon, 13 Jul 2026 07:56:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB24399346
	for <linux-can@vger.kernel.org>; Mon, 13 Jul 2026 07:56:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929419; cv=pass; b=i7ft6wvdsvWCjKhSROWvep1ilM/0OJqbm+geMXgAKppLkBOD/xP8Tt0DurL5Ce6OOOjEoKJao4ntbUoEqmWg5xJUCPYEAI0t3UGGudgM7yq/Hx3MqlJlDyb4Wg9Syq1L/R5nGGqY1S7OWDr2Nz32Leev8wl+BVHFYGLdislewNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929419; c=relaxed/simple;
	bh=JIJxtZg9pirwXwbQzi1OU+lzXYNe9iPkV0Vhrx7LQVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDYUrfM5skJO7iOmNvh1p759/hJZv5ZJ0PDvUFbG6RzrswHrbWVOb1LwzUdNYSQh1j6eYPZR8/GThe0OUdS/6yAAfA/Mk2pVLspi18GXxbcsdb4yl+CH37ltPbQMpeTFmkq8Sx6dC26DqDLqPpp4e6qxQmlW+7lI2xLDZmlakhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hmdMNuu3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/aZs55V1; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal: i=1; a=rsa-sha256; t=1783929398; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fhK2HNqM8ASFqkgFXxojtD6YxfAy/G0xUTcHa/+heAP4zBN6YyXb9/CDkZOj2n69Jz
    o6QsQnng4d+KnJtU3JU/XyQY/LmFZQOUCB2b1phvFceIKOJs3A/803L+/wAAHG3yudxH
    mfPOajmqRV1hdpPpWRaslrSJjwdwOztZh9BjXVBEtemBQprRuWPpo/m2vSVIyRlhDv2d
    wHbc9g/Jh/zi0vRRoOhMY/OZlCUGfJ2KhK9KnH4IM+FWchx4Jo+cF2HbdNzpW5Qhjq+V
    GkawGVPcMSQzQrqeBqRSH15KjbVer9EtXAgOqhoX03vxZsRmaqcxjfbVNhmdXRGHUWHy
    W4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783929398;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=G6fwV1lsybGLIy4+Ze2TBEYeosUmqc6lpy1oP3kJ5XY=;
    b=LdQ6GvFGhHEgFohBXN2pfBMOT9A30ymfjZqKAtQGT6if0tka2HVh2gljsX1wJNcysf
    k/vWNyOM7PIff9Jq14ww01O9qi+27m/z6XtqeEH5vr3JxGB/rTp5UinOvD8h/NG42nQA
    xCMfDM58reSuAjhdHkFVZ2eGj46rCUG8AKpOiFPP/hAbLODsMjHQToci6uBJ+BP3gjS9
    QxRnLC7WIp5cEkUao+7vtatjomrvrkWhfO7v5K3GxmBwIjEej3mhJCyF4rfkeB/j7R45
    BNm4OdEKq2yxqzCNu0FrtMcpkCF4HGMF+E99Fu9S168EKIb6RLJqSBfMZeoxs+6jgpSV
    DV4Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783929398;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=G6fwV1lsybGLIy4+Ze2TBEYeosUmqc6lpy1oP3kJ5XY=;
    b=hmdMNuu3EzmoI+GL/OjllHXhyeOF+Tn4I7bC/UBwMqwSv24JYQHE18oxcpVQuqvO2a
    PKAzk5kqy0gamgahdF10AKErq1ZnkwkqR9r+suu1xzlJSMZ5ls6TIyl0ERGevEVrE5tl
    iZzqcGWmD+ThZ85C3ioRxoDj0oEz0Fp4026/PCGQuojef4F3oOd8fgAaNY3w7elw+ztx
    HOUOh/0VceN7RuSxqpdSUdCakBzKuy/6TI0rOVl5SVJGwauo//glccJqezzaT8PkPXXE
    zIpzPRH2RJdVBHE90CZ2UiwSveKPH2xaq240GzQanQ7P4mqFq/sout9aWAKl6ajlQwEa
    ufgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783929398;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=G6fwV1lsybGLIy4+Ze2TBEYeosUmqc6lpy1oP3kJ5XY=;
    b=/aZs55V1FT5F/NMRQrhaJNce2E9dGWOM7RmwHH4vBh/0O/aJnm/C6Tu2H5oHX2wiJR
    gaFjyhm7CgV6z4AivFBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.236]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26D7ubZEa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 13 Jul 2026 09:56:37 +0200 (CEST)
Message-ID: <a2afe72f-5098-4a6f-9df7-b993f186337a@hartkopp.net>
Date: Mon, 13 Jul 2026 09:56:32 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vxcan: Support per-netns device unregistration.
To: sashiko-reviews@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
References: <20260712212113.181121-1-kuniyu@google.com>
 <20260712213422.DB1111F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260712213422.DB1111F000E9@smtp.kernel.org>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8355-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:kuniyu@google.com,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	RSPAMD_EMAILBL_FAIL(0.00)[socketcan@hartkopp.net:query timed out];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 639E0748760



On 12.07.26 23:34, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch calls the undefined function `unregister_netdevice_queue_net()`, resulting in a compilation error.
> --
> 
> --- Patch [1]: [PATCH v1] vxcan: Support per-netns device unregistration. ---
> commit 882fcd31630d9ce6b0a57cc99738c2ad0579763f
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> 
> vxcan: Support per-netns device unregistration.
> 
> This commit updates vxcan_dellink() to unregister local and peer devices
> safely across different namespaces by using xchg(). The change aims to
> prevent double-queuing of device destruction when RTNL is removed.
> 
>> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
>> --- a/drivers/net/can/vxcan.c
>> +++ b/drivers/net/can/vxcan.c
> 
> [ ... ]
> 
>> @@ -281,24 +284,25 @@ static int vxcan_newlink(struct net_device *dev,
>>   
>>   static void vxcan_dellink(struct net_device *dev, struct list_head *head)
>>   {
> 
> [ ... ]
> 
>>   	unregister_netdevice_queue(dev, head);
>>   
>> -	if (peer) {
>> -		priv = netdev_priv(peer);
>> -		RCU_INIT_POINTER(priv->peer, NULL);
>> -		unregister_netdevice_queue(peer, head);
>> -	}
>> +	priv = netdev_priv(peer);
>> +	dev = unrcu_pointer(xchg(&priv->peer, NULL));
>> +	if (dev)
>> +		unregister_netdevice_queue_net(dev_net(dev), peer, head);
> 
> [Severity: Low]
> Is this missing a prerequisite patch? It appears that
> unregister_netdevice_queue_net() is not defined anywhere in the kernel
> tree, which leads to a compilation error when building vxcan.c.

The referenced veth.c patch was applied to net-next:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d7fda2c776b2a969b9d78c5ad00e30824df43add

where also unregister_netdevice_queue_net() exists.

So this is a net-next resp. can-next patch.

Regards,
Oliver


> 
>> +
>> +	netdev_put(peer, peer_tracker);
>> +	netdev_put(dev, &priv->peer_tracker);
>>   }
> 


