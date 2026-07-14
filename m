Return-Path: <linux-can+bounces-8414-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KqI6Ai8mVmpP0AAAu9opvQ
	(envelope-from <linux-can+bounces-8414-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:06:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA235754426
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:06:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=UlJn+NuA;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=7U4Hb6dC;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8414-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8414-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0835732ACE73
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEDE381EAD;
	Tue, 14 Jul 2026 11:47:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60B38399B
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:47:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029676; cv=pass; b=kZTbx9+Dg3CJtqhBpfUDiZVTGSM+pdy8up3WET9xim8H9Yq6OAlX8F6TVkmQOjOBuHbBxyd54Pq/9ml+1tnMhLGMMwn+J5HfgjAxRZqEcJULGDn97El9EI3zluIGzW67+U2NiY6dMkh3juw5g26Mie/eCZHOv4lGCim1A+6zAzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029676; c=relaxed/simple;
	bh=f3TqkgRoXgFadJ3Zw5quD61+Nj3I+Wq9hEgD37F0W48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTz1yT/xwoc6ED+Bsyp4H9UaA84gqvhjA7yNWCpv2GdA2N5XudJezNTdPmd+/yikv/DKFcae3+4R7XooMFGZ73RqAgOurQl0Pt0HbQZ/yurxthxlBsioUWBhDKnJvpxS54LxWbd36c55Do7a7iZzpVjIdQWt8Cn1fM30C5kMO1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UlJn+NuA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=7U4Hb6dC; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal: i=1; a=rsa-sha256; t=1784029655; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NXMVUufWkfQ0ulRHtoPwlMEiSktyluEwLhxRPJFT2hIZZIK/agRBSj5/9qowc0wZHM
    AH2bkE6s1E+nq65apZEVTI8uJwiaweg1DNDYhxbA1nlwcyod2cVVMTwvlLe0yRsn+EkT
    rE89SjJ6LIDdbOS41Mt35Y8pZLPaxPJYkQG5q6wREFcqWXvbCK1G8gWr5BrMXr0LF0hA
    pVq/2nCLOpXLXRIhctZchaAd5l+VOT/rlK3eO7ZsRC0adjNYk3/WIFBaz/nGgfdZZMFC
    sH9xygtkYSsO7bCRyI9abKila1XIaqEl+PXTDTST+awn8ddyNJueI7VW3HQWtr1Z9GTc
    w4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784029655;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ulGlExmyGIJwwDpR21HQW+x4M19jopiWKr2LjYr80os=;
    b=nOS2DsnYTuV2YR9ETCqrH0gIzE8jTQompGgorXKUW73PrRavQrfOoLJSkebpuI7+Qq
    te6FJvpIyKwNuq9rMdj7A8n25z7cQ0pOgjaimZIUWpNqhZr9EatVF4gVJlhLm79qdXnL
    USgTyR99VrAbPaKC+eEnLaFmxJ32BTmt1uUItdKlzvI4AT7FCvzORUh1dCl0xFW4tRns
    uNzYOkIbDjqajECmxwqaw4rUv4OlWbnoboqJbWcg2C8oH6es8Ddmca3RBLDDAk/mTkt6
    C9s2HsOq8PF2fp1y32FaIP1nzs9/EmEwTnYDkdfkH2QEy+Xfa53brtuv01tGsFkYjNxR
    81gA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784029655;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ulGlExmyGIJwwDpR21HQW+x4M19jopiWKr2LjYr80os=;
    b=UlJn+NuAog3tTVNSgMUqyLnmydhrJ6p2iPOlFTjfNLlJ+UkdzxV+n0mVJZnuomdMUp
    Ht9smUIX445+E+DceGXBMUMv0hV07jnuQSQCNrzhJmEJgLZY5PqxD3bDiE+TnsF6m52U
    xdcuMvlQU2nsNvrrv5bduPTQWi0Lrhhv3Fm6lnfsgwUsWZh47/JRBeJh6uNaSOL1JeeO
    Q/eN95ROUTUEsEKOXFJDFXDas8v2vH1QzZrIMk4aw5Pp5j5tg1BzQjsTSjTrON/0IIZr
    KyK9D2Y2iK7gyWPCZkH57fLPhE2sxuqrCLx21K1wXSZpZaIdVZoyiKZvXj9RtYbvIxRw
    SVuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784029655;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ulGlExmyGIJwwDpR21HQW+x4M19jopiWKr2LjYr80os=;
    b=7U4Hb6dC8FhHiK5r5xfadiuQgOGcmIP4HUixDU0avcF1NLUGVFhyW19LcUenWlkb9V
    VOYbLltWjKBqzQGFJgCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EBlZjt3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 13:47:35 +0200 (CEST)
Message-ID: <1a521f25-0aee-4eae-a0da-3eb7f0702e84@hartkopp.net>
Date: Tue, 14 Jul 2026 13:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: sashiko-reviews@lists.linux.dev, Oleksij Rempel
 <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-9-fd667c61099a@hartkopp.net>
 <20260714104431.65C751F000E9@smtp.kernel.org>
 <2c2bc659-fd26-4c48-a5f4-e9e6a3c43003@hartkopp.net>
 <20260714-towering-phenomenal-nyala-ad406f-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714-towering-phenomenal-nyala-ad406f-mkl@pengutronix.de>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:sashiko-reviews@lists.linux.dev,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8414-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:from_mime,hartkopp.net:dkim,hartkopp.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA235754426



On 14.07.26 13:41, Marc Kleine-Budde wrote:
> On 14.07.2026 13:24:17, Oliver Hartkopp wrote:
>> On 14.07.26 12:44, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>
>>> Pre-existing issues:
>>> - [High] Unprotected concurrent access to op->rx_stamp and op->rx_ifindex in bcm_rx_handler causes data races and torn 64-bit reads on 32-bit architectures.
>>
>> Fixed in patch 10
> 
> Pre-existing issues are not a shot stopper, _new_ issues for a patch
> series are...usually are.
> 
> Hopefully upstream will accept that you fix issues in a later patch that
> sashiko claim to be introduced by a patch in the series.

Is it?

Patch 10 Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")

not anything in patch 9.

Best regards,
Oliver


