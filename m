Return-Path: <linux-can+bounces-6271-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCq9DfVscmlpkwAAu9opvQ
	(envelope-from <linux-can+bounces-6271-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 19:31:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 600AB6C74A
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 19:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9CCB3013D3F
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F70347FE2;
	Thu, 22 Jan 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PCHkTQ00";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="L2KcWY3J"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A935B642;
	Thu, 22 Jan 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104238; cv=pass; b=jmzi1P2NJzmgQcZLu3YV2+bGBlfzCaALlxtd8MYs8EK9ydGyBoTXCZBMSE6SwOGYWk1wvrT0GnrqApDhZTzhnLHRQTOycbo2+ypF42jtQHIaCdlwG5ult8WYJgVQnapjXCPsv2UR0Y2Oa9XDppNRYBP4rPkIVfFXBYGLImht7Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104238; c=relaxed/simple;
	bh=tGrzWkLhjnAEfFxT1oi+WtPFy/mSjKtU8l556k/obDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bd7KLuNp5JvdBK+g5J1fLu9tlh0R0G7iSDUoGQr/9Al7kyo2pRr7Ad3evjTUPjERp0UV3w7iApa/SUCOG4WL6+vzIPOf+o74gkWquGYPdsbsYtNUwOV603cVXeTdwcBIuhj+41JkJ+ds5dgiXyn+8tQ0Fb5zAhgfO9nWFFWmJrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PCHkTQ00; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=L2KcWY3J; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769103846; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dW2V0RCU3jIaxqVSgESin/nNP29sRVC5jQIS2E/Bii2OX0fhl8x18gDjkrRKzx8asj
    CLcQNCntwqJBHstBvD+1f7GkS5ZjKmnO9Zy04NWH7tI7OzoQUJRZ/eZVSZl0WG263WsD
    SMZuFtyCXnrsH+X72f/o4TbnlZxpgyMoRLTDxbh9xv5t8IpymFrc3Yx5A7MXBJSRZeUw
    E0e1SwCBFKxsTkNdscpWHM4oD6CDl3X2rp7f4om/Iit+PSy0ay6nSiF3f//I0pvLB0K6
    kU+vRKapAuXSQ2nvrpF4FA4BC9FoSZI+PNlwyQUvAoMNLNTsa9SQ42dbk+vyOc6t/WB9
    YIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769103846;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+25POAsRvfSlSmqdEcVpT6kQwuEnidLNTRuRibF3xXQ=;
    b=sjHm/wUGBFwI7ExrZWIb9kdecf38hK8TJjWbcsrjq9Ik7il1jgKAIdd3l4rPc9B9+W
    0cZ9eeyIPtGOlQ95tXPWrhZ2shwKLKQYbwjLxIRofgs5hCdkobSGik53uIR5f0bDrYKl
    p1LCD30jOxXFUfxGPC3FZasfIUeBl1buZPrcjtjz5/Q06TwEH9E/vLokbFabpFMadELG
    JP+xWEj0znlbnAZILip9KUEDf3oxEidFhnGqffuGA9Jbu99bB3ZzepTrQXOUC8CSO2al
    qs95+gXGHyZzl3qm5cLftwY2f9y1b507mIsdVvjEesoGEd3ogh4zd+mkDcDFyYPdB0y6
    RuEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769103846;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+25POAsRvfSlSmqdEcVpT6kQwuEnidLNTRuRibF3xXQ=;
    b=PCHkTQ00WXtswRwK7LUYKEW265brCm0qRekBAas0qUkJrn9i36TlDd699OWltgVZu1
    +8d9Zys3FQZ3e18P0r6+fjFewAQJxN81Jc9ilfKwf7dJfgat0pMz2gbStNq84X7gE5/y
    XclzTHa20Pg34yreRIBCGWaYZSX1oXmaNdmx5oEHHDGmhbYQuGmH5xxR4yyMKBTIVhmR
    NFcKw2MoE4WLmU/kNjdt7KUd3CxGQRXg4BgSDc5DfxDYyypJyUSLD2UIWTDVQCyt1EEc
    RE9RFHIXKHZjKsIAsAvCDEDibRjB4NzXPjfpT7PlrUctfE2hc37RSnQiAWFofXmKBOZx
    hkMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769103846;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+25POAsRvfSlSmqdEcVpT6kQwuEnidLNTRuRibF3xXQ=;
    b=L2KcWY3JFjzCx57ONuqgYihGfR1hT2kBM4bt3pf1U1KkWC2InGq0haLIx3x5lnVxZc
    GUPqzQQtCIAv9Q6BfxAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20MHi5Mtp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Jan 2026 18:44:05 +0100 (CET)
Message-ID: <b539ae8a-fcdb-4486-a03b-8a755ee090cc@hartkopp.net>
Date: Thu, 22 Jan 2026 18:44:00 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 davem@davemloft.net
References: <20260112150908.5815-1-socketcan@hartkopp.net>
 <a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
 <f2d293c1-bc6a-4130-b544-2216ec0b0590@hartkopp.net>
 <20260117091543.7881db1a@kernel.org>
 <dfbcab83-095d-4ed1-ae98-baada95d4cad@hartkopp.net>
 <39794159-c0cc-498b-a162-44e77b6c371a@hartkopp.net>
 <20260121-illegal-impetuous-honeybee-e6ef40-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260121-illegal-impetuous-honeybee-e6ef40-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6271-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 600AB6C74A
X-Rspamd-Action: no action


On 21.01.26 15:37, Marc Kleine-Budde wrote:
> On 21.01.2026 13:55:47, Oliver Hartkopp wrote:
>> I'm not sure how intense you followed my discussion with Jakub and Paolo
>> about my attempt to move the CAN skb specifc content (8 bytes) away from the
>> problematic skb->head reference an hold it directly in struct sk_buff?
>>
>> Meanwhile I sent a v2 patch set which has been dropped from netdev patchwork
>> because of its can-next mail subject:
>>
>> https://lore.kernel.org/linux-can/20260117132824.3649-1-socketcan@hartkopp.net/
>>
>> I've been running the patches for quite a while now and feel very confident
>> that the solution is very efficient and safe for either CAN skbs and non-CAN
>> skbs.
>>
>> To be more clear in the struct sk_buff changes I would change the comments
>> in my next respin like this:
>>
>> 	union {
>> 		/* skb->encapsulation = true */
>> 		struct {
>> 			/* eth/ip encapsulation / tunneling */
>> 			union {
>> 				__be16	inner_protocol;
>> 				__u8	inner_ipproto;
>> 			};
>>
>> 			__u16	inner_transport_header;
>> 			__u16	inner_network_header;
>> 			__u16	inner_mac_header;
>> 		};
>>
>> 		/* skb->encapsulation = false */
>> #if IS_ENABLED(CONFIG_CAN)
>> 		struct {
>> 			/* CAN skb content (ETH_P_CAN*) */
>> 			int	can_iif;
>> 			__u16	can_framelen;
>> 			__u16	can_gw_hops;
>> 		};
>> #endif
>> 	};
>>
>> And I wonder if it would make sense to add a WARN_ON_ONCE() in can_rcv() and
>> friends?
>>
>> What is your opinion about the patch set?
> 
> We have to convince the netdev people why we cannot use metadata_dst or
> skb extentions but put things in other more os less arbitrary places.

I was only looking into metadata_dst which looked scary to me.

But the skb extensions look promising. It's pretty good to understand 
and sticks to the skb until it is free'd. And cloning/freeing works 
automatically and handles the skb extension seamlessly.

So it mainly costs another kmem_cache_alloc() ...

I'll give it a try.

Best regards,
Oliver

> 
>> Should I make it a net-next patch set to restart the discussion there?
> 
> Rather continue the discussion :)
> 
> regards,
> Marc
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


