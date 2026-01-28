Return-Path: <linux-can+bounces-6333-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Af5OnfieWm50gEAu9opvQ
	(envelope-from <linux-can+bounces-6333-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 11:18:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2BF9F5D1
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 11:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0EC23031319
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C41919C546;
	Wed, 28 Jan 2026 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aFFlQZUP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tzKFvR1L"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F02DC791;
	Wed, 28 Jan 2026 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595451; cv=pass; b=TQZvM6My8fmUnK+g8RxOmWHCvCG2zn2o0mujqe6M5GRVa/KQcBbRlgbAyXfkqHJj7kTJcmgv6XTtxT3pGwnQLjsOMk6U6/BIplHH6QsmU3xJ7cTKQllYr23HXkt5qocFPGMQE50YzVhb1q0WlKM1P7f56qH6Ot73hYLJCoq8NtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595451; c=relaxed/simple;
	bh=xmq+xeoli88jDyA1F0PUrkVYfYeMP0i3gmFODwVQTfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRJruZOsPZpcUAVntPJnJbnkZacFvj1LWtrzETZ/gZ2iMo4nT9flL7m2rZeoYzPoLn4YUCWkuceCeFQbGowmtlORKCvhp/ByS0ZyBAPT5PwZM+p0gdZlBENOUWZOYPRbJABjfFIghVohk0Pzd/qVsNw//c9hoQQpk2pLs2zOXv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aFFlQZUP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tzKFvR1L; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769595440; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=s/E8wWyTMn0xmuGMar5cOpjWI5yiU438dL+JfF30KhHwVQ40U7Ba3TLcMt/OBoe7FZ
    0L9GrAQPcsVc8hkd+7E3JhfkOx05JZtr/qLcgp0rUZCtl56h4rkQBFnn0z1vM9alGYkd
    4U24yw7y5niOOpYvDZKHVa5G4r0ITOMu/dzBp0E2Sm+rsu4o8bJHsDfV7XZaz6Y6s6Ix
    TvsZdtwIX5lxY7U8O8t9rMMFyc5nJAMTo0uHqapa3oYEbMEWoUJaj+fV1A+9ih3iUGEn
    RGEwyQZTlsJiRDyr5PR6NVdD8LbV4htW4iHRoZtDAoyz/Xba240KPQyWfajsXb2l9QzS
    Rbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769595440;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+03VpZOpxRwSZDIGepRERpUpATI+KbCQQgYl+eWVP58=;
    b=D+9uYz938B70iW+HUbfUK91mMSbRnBhS+OxHEHR5EU17cjg/NIhPzWe+x99Kw0btBG
    JaygbqCTYIJGivvJn5cWTORZx3Dka2ttvQ+QBujFVcqeRfrs4le9LKQWRDImy5y9bkOy
    209DjmzI3kzxnm6A75VoQ4R5GSABUiXpRwuBtPFa8RxgrDgswJHczSFzZ+dkL3waCj3n
    JYe8FDYi+DgKIS8TXyEj1zWFfMO9KZSW7s2hHSL87ssbUN4OuGu/5os7fj3ERSp20EBq
    uijc5lyys53EP+aH9WhvX7IaQeCd6BWzv2T7N8na18mO4WfzL+QOTs3jQPZJkVLzg2Sb
    5+1Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769595440;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+03VpZOpxRwSZDIGepRERpUpATI+KbCQQgYl+eWVP58=;
    b=aFFlQZUPrljmDf8DZIiLS0VG4A3qR4O8FfNVzpafTwIWzArqEBINzwEjm2yLQfm9Gw
    jn/8XRBIbV01nZJva/CoGM1x+ay19MViXNVR5aTVsjuI5F0ym9PTF9mLUCBIRIYVNnv7
    JqKikzbdozDz0PVwyfiRHfwlAXOcbl4ppSQXj14DyXTYPKjQvH67Y8Vtbn09P9I0JKNd
    ZzrdssJosJ2C2M2ho2gLJVGDn/16uCGpsK4BSWKEd9gmHlSfjdPIHIDP2ofMlCzfyer3
    uY28ncLdUiMUkhgWRACgDmOfajItUoYWA7Ke5bThMd7bA/5R48NSwNXRsWayHurBWnYy
    9QOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769595440;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+03VpZOpxRwSZDIGepRERpUpATI+KbCQQgYl+eWVP58=;
    b=tzKFvR1LYmmezXqTpM2MlY0k0KKfiK1A6TqYU8xZnebkbTjROw/48kgqkfIxw9YPOq
    ufd+USsh3pozi7WojpDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20SAHKlEU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 11:17:20 +0100 (CET)
Message-ID: <e159066a-d957-4b42-a6ba-2439e837d9cb@hartkopp.net>
Date: Wed, 28 Jan 2026 11:17:19 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260128-keen-owl-of-emphasis-ca7f18-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260128-keen-owl-of-emphasis-ca7f18-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6333-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rzone.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid,pengutronix.de:url,strato-hosting.co.uk:url]
X-Rspamd-Queue-Id: 9B2BF9F5D1
X-Rspamd-Action: no action



On 28.01.26 11:04, Marc Kleine-Budde wrote:
> On 28.01.2026 10:07:13, Marc Kleine-Budde wrote:
>>> In fact patch 6 stuck in my providers mail system which responded this to
>>> (only) patch 6 ¯\_(ツ)_/¯
>>>
>>> 5.7.1 Refused by local policy. No SPAM please! (B-EX
>>> 155302::1769588601-AC38E895-223F95BA/10/71040183929) see https://www.strato-hosting.co.uk/faq/product/why-are-my-emails-not-being-delivered
>>> [MSG0011]
>>>
>>> As this could not been solved since Sunday I'll kindly ask Marc to send the
>>> attached v2 patchset (including your __u32 remark) to the mailing list, so
>>> that also the AI bot can take a look at it.
>>
>> I'll do. In the mean time, please have a look at b4, it has support for
>> sending patches via a web hook.
> 
> Your ISP's mailserver also classified Patch#6 as spam when I was sending
> it :/
> 
> | Reporting-MTA: dns; metis.whiteo.stw.pengutronix.de
> |
> | Action: failed
> | Final-Recipient: rfc822;socketcan@hartkopp.net
> | Status: 5.0.0
> | Remote-MTA: dns; smtpin.rzone.de
> | Diagnostic-Code: smtp; 550 5.7.1 Refused by local policy. No SPAM please! (B-EX 149500::1769594129-F202EB70-729865BA/10/71040183929) see https://www.strato-hosting.co.uk/faq/product/why-are-my-emails-not-being-delivered [MSG0011]

Yes. I was looking in my inbox where it was missing too o_O
Fortunately it showed up in patchwork :-)

I'll add that to my problem report ...

Best regards,
Oliver

