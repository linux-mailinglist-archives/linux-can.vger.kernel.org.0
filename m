Return-Path: <linux-can+bounces-6365-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKAaJQw+emlB4wEAu9opvQ
	(envelope-from <linux-can+bounces-6365-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 17:49:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0981A62A7
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A30EF305670D
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31FA2FFDE4;
	Wed, 28 Jan 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PcPOh0+7";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mPnK/y5u"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BF2505AA;
	Wed, 28 Jan 2026 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616877; cv=pass; b=pmAumjBTO0/i1kkEaHtg7o78g5Oo2stG43pqLH30nvAd14ultYfF2c0yckiivie79xfvYKXfRnXIjnlY3IMHG+fQa99LeGhDQD8Q6lR7cifmtuIJ8Bq1Oik1GbE60zCXqgcpOofW/nlViZyWFysQjHR+mmGQYyNNMihgcN3zBkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616877; c=relaxed/simple;
	bh=T8lOT1r9FCMnJJ5mjTSjtNJO5V8ZEKy6GMrk2MsNYEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hL9iFTaT0nxjk1ExitTrL/v8EmneFT9ZH9kr1onNhVD1h/n9wR5f0hrHGtDTzIa5akG5E4RO8XjkdVkce6qT9QuFyDpWjoL3GnSySv1q8ThzSjmGjhC97hX1qqOQWuxQl0p+/vPtrCGZgAar0E6WnjglM9c25wf0PcgvsrGwhiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PcPOh0+7; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mPnK/y5u; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769616864; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hD0hvPUrZKw1UuO4MAPGnJ8wkmW+TPAUB7+qxEO+FUE/JW5IbRzNSRQ5n20xaP5E02
    emn1o1CFw7ob242Ebb5itri4V7m0qIGJXYRM3PDdr1rZVKeOdcgHesdSmn60exJ4rP1x
    xAwiKaPoLyFttXiCGjNwTD0pPljX6Qtbz8otLnOrBE7jrdVScPm3mViHod7xd+PrX9AO
    wdLvz5UIQp8Y48+1wybS2AEQGnbB4rZHVbxYbPH5c0xyfS3b2xKPd7sAAZwAszaDTPYu
    wjxIbEwgqgYvgXArajzd7dQkbO/lY+aIzXYR1j7c79YK2q+GctG9Rw3rEosncDoKTSu1
    cvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769616864;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Rgivxb3Z81y6Qb6v1l10xZ7GiL3PGy4JsTYhrtyv72Y=;
    b=Po93EeDQh5r90bRHDOMFL632ZWhoiXkJrNzrUBzL2vZTgrd2lGCA1LHnAS7NeGZtSj
    ShTg4ZqbuzxwKmCMDKq7MqthyuBu/hc5EOSaKjck5htXL6jgBD/jn6CdzjviZbzG5yh8
    ZtV5PQrez7iCY0Q25RvypMPAwvEZlT7xWgHu/juQpPEKu5WWMiJOpKYfRAvputFPaKHA
    7xevonXliK0MJHzxNGaXJlInXvQSohOjAZer+6QdtgV7MNzT3EYnPBD68QRioGQ/5jQh
    I4+j1PB1sa0NVLaLjGC6vR+67lyxYgcnAcC2DgJ45jA5ZHm2eKMubBZ2HAg45jza63Mv
    inJA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769616864;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Rgivxb3Z81y6Qb6v1l10xZ7GiL3PGy4JsTYhrtyv72Y=;
    b=PcPOh0+7B2z2xYeZEdLwuogdmFGLWKsoIHMjoRE3ZLj2+0/3O8SbbCWtBGnG2LyuAf
    /2UPopfpk4Gpted2oIr0OwS/zvYYanz1F5RUuulLO8hbReugwHq6qhrrH00+DJ4q0cSn
    XnhN7hGUfi2wyO5NSlMMXPWtRQ7kLdU4HgZ511QhEaCRp6szXH6Nx1nVCHtH0iqQ9vut
    8aqYxXMbb/9FtwX/+NEqNI8kDApMeciNzsWjlVcNL7cR9hu/EaTKhGV3TtLb/5emFWAi
    sFsCdiuiz9m4lAehyUxj0KyTF0d+WOWsm1uQ++ywacHob5fNBy0/0whjE6BjO/3i1y/p
    /jBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769616864;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Rgivxb3Z81y6Qb6v1l10xZ7GiL3PGy4JsTYhrtyv72Y=;
    b=mPnK/y5u1JSv5zNXYtKYX8P2Ohf4asCItjTbiFm8ksPTw+EbPRpTVc6UcDg/7ASqzk
    mOpZbfYM6EU9yiLyK9Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20SGEOnzE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 17:14:24 +0100 (CET)
Message-ID: <e2033d96-e900-4013-a18a-c2e0ffa269d3@hartkopp.net>
Date: Wed, 28 Jan 2026 17:14:24 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
To: Florian Westphal <fw@strlen.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org> <aXn0iLuRqdOdcIBN@strlen.de>
 <4909066f-cf9c-49ac-b02f-d2e16908bbd9@hartkopp.net>
 <aXoMqaA7b2CqJZNA@strlen.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aXoMqaA7b2CqJZNA@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6365-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0981A62A7
X-Rspamd-Action: no action

On 28.01.26 14:18, Florian Westphal wrote:
> Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>> When the first extensions were added all of them could be enabled
>>> at same time, but I think that has changed.
>>
>> IMO we do not need to 'union' extensions as long as automatic enum
>> calculation does it job with the enabled Kconfig options.
>>
>> My only concern would be distribution kernels that have an all-yes
>> config policy ;-)
> 
> Well, thats the norm, no?  Allmodconfig.
> So we have two issues:
> 1. Turn active_extensions in sk_buff into u16
> 2. Growing memory usage of the skb_ext blob.
> 
> No need to add this 'union' now of course, but I think its something
> that should be kept in mind: originally, all extensions could be
> turned on for the same skb, but it looks like we now have mutually
> exclusive ones.

Ok. But then I don't see any real pressure to do the extension right 
now. There doesn't seem so much changes adding new skb extensions users. 
  And we still have a free slot even if all users would have been 
enabled (which is not the case due to the mutually exclusive options).

>>    static void skb_extensions_init(void)
>>    {
>> -       BUILD_BUG_ON(SKB_EXT_NUM >= 8);
>> +       BUILD_BUG_ON(SKB_EXT_NUM > 8);
> 
> True, the last valid extension id can't be 8, but
> SKB_EXT_NUM could be.
> 
>> Should I send a proper patch?
> 
> You can, otoh I think we should have consensus on what
> to do when the 8th extension is added, do we just s/u8/u16' and
> eat the growing memory cost for the skb_ext growth, or do we go
> to a drawing board and figure out how to best merge mutually exclusive
> extensions to save space?

The good thing is that skb extensions are very efficient. Which leads to 
the bad thing that we only can detect the problems at build time with

BUILD_BUG_ON(SKB_EXT_NUM > 8);
BUILD_BUG_ON(skb_ext_total_length() > 255);

For (SKB_EXT_NUM > 8) the upgrade of active_extensions to u16 should 
simply make it. Probably with some #ifdef magic only.

But thinking about BUILD_BUG_ON(skb_ext_total_length() > 255):

Shouldn't this be SKB_EXT_CHUNKSIZEOF(struct skb_ext) + sum of the skb 
ext user data which can be up to 255 *  SKB_EXT_ALIGN_VALUE (= 2040) ???

The offset calculation with the multiplication of SKB_EXT_ALIGN_VALUE 
(== 8) is the real magic in skb_ext_get_ptr(). therefore it should be 
something like

BUILD_BUG_ON(skb_ext_total_length() - SKB_EXT_CHUNKSIZEOF(struct 
skb_ext) > 255 *  SKB_EXT_ALIGN_VALUE)

right?

We could create a new BUILD_BUG_ON with all SKB_EXT_CHUNKSIZEOF'ed skb 
ext user data sizeof(structs) being < 255 * SKB_EXT_ALIGN_VALUE

IMO there's already plenty of space.

Best regards,
Oliver


