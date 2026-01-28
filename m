Return-Path: <linux-can+bounces-6323-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAv5NvvLeWmOzgEAu9opvQ
	(envelope-from <linux-can+bounces-6323-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:42:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD429E4D6
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC823009514
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7F30FC39;
	Wed, 28 Jan 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BL67SVLD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rXWdar3h"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A04086A;
	Wed, 28 Jan 2026 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589751; cv=pass; b=LlQ9sg1CTuJs0It0Q1YGnKEoyPhgd3ox4kcYJoF0g22zkRvkj2SgCxlH/gtA+LZUBo3JaXpzH1DH4ZxdmFkzCfCXKCJ9F0RLPW6Hbzyydfd0ncGQ7hvvPf5ZBPW+89KPwFjBzWzCaSnEJ0SuUUfl6hvGlgbJTQtJE4SBnarmcts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589751; c=relaxed/simple;
	bh=NPNSmc/yr4Ha9C4nX6ZdnGi69gUdiflPaySsL98h2zo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=UvPGVUXkZHwYWTTggUQlztoR10RJ96T1VgPYKIlNwTo8q14NJCf4Gww6AZch/sCcoptRON1k5eKRunGir67WHB93Q8YysO73y+zvtonvaaDnVEOj5/zy59CjwIgeuOKEAsVVpbQOi0lIv6UcQOmtrZoMHVRfCWSv+y+6x1Zf89w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BL67SVLD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rXWdar3h; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769589741; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G3vkh0lQ81+5HQY7uBlOgHol353sXL3h7ls54MgPAEU3gxzJk7YrDPuDfjfdy/dRnQ
    pKJLzjIzCr4d1cgFhdrmwkpaimDSjScy2+V1DejuaqK08E+eQ8Ngvrb+nXNBQo/JfOgR
    g/rvx2bofNHU/txi/2Wj4hBCZVzociPCS+iFIa8ZIvSEE9yJ9jxR01+BootslDrde5Iz
    6NAXuImrig50PF0SitK8CUJWk1iNa+V0MeG5XdeH1kEBKK4GtC9Vn7E0GxAXpQUuh0Dl
    fBWSfYY1hpWojMXXmOpOPdMizTexg3kUEF4uaijJI3AuCOyvKl+rq1tGpK9g+RpZj9aW
    5xJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769589741;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aEaJFACDS5iHCwMFzsaE1egpoLtcleROk5J0aslJ/FI=;
    b=gLxk6QB9XDxp0mtC3e/fgUEa48aSh+6WLpeJ9c+JT68eLKcb2liFFlCFpbfN86lez2
    L7gJ0oJQjYqaOEDmjaZ9HezxKQpCLysqzrI/wsQXA5DUJU4IiD2C+hz1teK0TrjIqkIS
    lgRq15ANoeSvuUXAM5WYur5XmD2sKrUj8SfJeXZEfYZVg6nge13Qb1kLM2YfniPoPIjw
    Io30CepgL6LQ8E69mfHJDaqGd4oYZpe80ZXzqfjjWRobQ3/xsAmn3A6osS+QGfXiUMCN
    m+A3HTutj42d4xDc9zsq/GVp7KHWqD7TvttUd6lAZRjumRI7vyFThACeHmLSWE2gKk2R
    0Ggg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769589741;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aEaJFACDS5iHCwMFzsaE1egpoLtcleROk5J0aslJ/FI=;
    b=BL67SVLD93Q+B4hh+nyb7IfITo6a6yJVwN5+M0btD15H0uC1zsqc3KPVtBBkuHbVvb
    4RT8PAR7Q7BDXL1G/7uTXHe9QAbCjEdXKSlM0CguU8/P6cKr2EpCiuPVpus3DLM2mPzO
    sn0PX/gFd9dnnxpzRCkZnb0n3cf6fzeIz5SZQhtXOQAvY0ZmkQj1hpazO5ACW25JNiMy
    unj1Z/WdW68+U3I37LQkRkYt4+tF0yFnjRCbEg/u99YsJtop6IW2/Ou4Dh3WxpXDZM9S
    UM0/B5gPO1H8u+bpiK9cvABP4fyk3ZqKnlSaRezU2pxaQ1CfN2jAXey2p06QjyuQZXsI
    BWAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769589741;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aEaJFACDS5iHCwMFzsaE1egpoLtcleROk5J0aslJ/FI=;
    b=rXWdar3hNBtO7uix3Ba2IVvLfHiGFM2BSWxcd9q+cl4jRXujN+DbFyxwxtLap/CbCU
    JuC2LMewW0GSQbxcxzDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20S8gKka6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 09:42:20 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------6QGoLdhiL1XxhQB2k0ikNLHb"
Message-ID: <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
Date: Wed, 28 Jan 2026 09:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
To: Jakub Kicinski <kuba@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260127174937.4c5fc226@kernel.org>
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6323-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strato-hosting.co.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: EBD429E4D6
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------6QGoLdhiL1XxhQB2k0ikNLHb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.01.26 02:49, Jakub Kicinski wrote:
> On Sun, 25 Jan 2026 21:15:55 +0100 Oliver Hartkopp wrote:
>> CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
>> CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data.
>> Those CAN skbs do not have network/mac/transport headers nor other such
>> references for encapsulated protocols like ethernet/IP protocols.
>>
>> To store data for CAN specific use-cases all CAN bus related skbuffs are
>> created with a 16 byte private skb headroom (struct can_skb_priv).
>> Using the skb headroom and accessing skb->head for this private data
>> led to several problems in the past likely due to "The struct can_skb_priv
>> business is highly unconventional for the networking stack." [1]
>>
>> This patch set aims to remove the unconventional skb headroom usage for
>> CAN bus related skbuffs and use the common skb extensions instead.
> 
> This is fine. Wish we could make md_dst work, since skb_ext still burns
> a bit in the skb (last extension bit in fact, next user will have to
> bump the filed size). And you very much do not route these frames,
> so dst would work perfectly fine. But whatever.
> 
> lore never received patch 6, tho, you'll need to repost.

Thanks for looking at it.

In fact patch 6 stuck in my providers mail system which responded this 
to (only) patch 6 ¯\_(ツ)_/¯

5.7.1 Refused by local policy. No SPAM please! (B-EX 
155302::1769588601-AC38E895-223F95BA/10/71040183929) see 
https://www.strato-hosting.co.uk/faq/product/why-are-my-emails-not-being-delivered 
[MSG0011]

As this could not been solved since Sunday I'll kindly ask Marc to send 
the attached v2 patchset (including your __u32 remark) to the mailing 
list, so that also the AI bot can take a look at it.

Many thanks!
Oliver
--------------6QGoLdhiL1XxhQB2k0ikNLHb
Content-Type: application/gzip; name="can_skb_ext.tar.gz"
Content-Disposition: attachment; filename="can_skb_ext.tar.gz"
Content-Transfer-Encoding: base64

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

--------------6QGoLdhiL1XxhQB2k0ikNLHb--

