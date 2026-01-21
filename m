Return-Path: <linux-can+bounces-6248-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGnTG17RcGkOaAAAu9opvQ
	(envelope-from <linux-can+bounces-6248-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 14:15:10 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D28BB57681
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 14:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCAA34E166E
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8231E3385B5;
	Wed, 21 Jan 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="skPdkwbH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tMJCrRXi"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5C296BD5;
	Wed, 21 Jan 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000342; cv=pass; b=PQRkWieG/cuRs0awTWefGt+2/ERo6wygR5qI42v53Q2nu/nzWIa9291/FJY+eF2aF1IPzlu6Sy4g3+nPxH9bxlkclAKK69bnaCKowoVYS3v6tCJ465PIY6w0QibqJhJagWeFcc/kHd8tTQiA4wTQxE2Ne/xWwijbEVKTQFfyEes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000342; c=relaxed/simple;
	bh=+iAoSfJZuCSMKc8sxjqMr4boSWNlzCfyGKaN9Z4xxrE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rfIsfinoVMrU3mAXHOClr8f9ppMY57Kay1MDtYWnW8r/+4oT9654ag3LZxXAzb1Q7XzISUGpVy9HRt7dbBwznuN4nsfF7gz+vjHo9GaYDWkzYa6QGQJ0R+Q/lEtocmtd2HF4mO6Tk4TZs2VBJ7dw20GY0MhUfTDuw1PktX78cCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=skPdkwbH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tMJCrRXi; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769000148; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WcnImml581UzzxBQwv6IW5EJJNV56lrrKtH9uWOjV3LirfAZdHAETB40Ql4tfLutme
    ud/8FWuG6nFMYCZuRWzFeDtEh/Cxi3+C+61DzOvEz7TaL7bVwt3Up5Spw8NK3y2LzKgb
    HJMXRDMcYZNx+rEGrMhHFw5Ln7JMXzAFwxYVPdgNPDhoKHkrhJ1ZdNa1merCm6W6tODg
    S0rBVwfAnhpAhJdZXHvYabSGkpocKzaJWbGGgtRfRwQX8lVDqfB+k4IVRKDWwMA4SOjY
    SoE4sRhhkLoK9jiyUEJPhgX2UKW5FgqWxESG1xHpzfLk5yEe9/RCxiOCKqeIP7iPbxWA
    jquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769000148;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=M20p8Gr2Dtm0AH0k9Lgp094CPcABGcGMWnUGDWwpUCc=;
    b=KW3p769nOMg41Zj6JRDx1NUvWOuBpZIQB55li8US64T0TxZf7slfGc25+1zB/jYbdl
    t9zoVflL1ctVqpkMeYNKEIsGN1dZM7Gr1eanbr+Jt6lubTEiZzo04gxel1OgH7cHYIn1
    GvnBfYfkj1BSmU7C635Na023vvNmbqhrP24hB6OrLpYMR2fBal5CK0GWaMT8rKjOxGwr
    1LXHhOs6yFL6xkS8wwIsz2p1kLJUE80PT6TPDgaNLy3p8BcfrlperuXE+aP70a3BRFSm
    zMSdYBoXFpQ4vE4Dmx6myXLoiDobVprCfk6/gdmx79fs9cYvlh8XI29mmGHs/l8M+4xu
    oYaA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769000148;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=M20p8Gr2Dtm0AH0k9Lgp094CPcABGcGMWnUGDWwpUCc=;
    b=skPdkwbH/R15rZZN4Fg8iAzBsarnOOaKlwQ6UcKE6VHxCjEzuPZTRp9htUIj9opmYK
    M/PsqYbd87V+W7sL85lRH9W4hKyDrMc2ruwu8upoIrIi6Lvav25NW16k76Jcls0JWM6M
    4+EyQJwRdViGy6Sx+tWRMAxs/0eg3TabbTjrYyYc7tvuovNuD1NDDpF8dEk8jYaLU87e
    /Y1wJqGD8PcgYrLUdBEtp5vP5C+lFOA3GJvflu4QOK4pEkXtHOtvHFiTCugxhzRrNEnq
    4VlCwAYbGWFaUoo24Ph+NP/tHIMv3RmGpWdc44YfTXBMf49NyPY8c28VT+Yi2TW7+LsI
    TUqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769000148;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=M20p8Gr2Dtm0AH0k9Lgp094CPcABGcGMWnUGDWwpUCc=;
    b=tMJCrRXiJzXDCOExuguU4LsNVCyFuUK8F75iP6hA5OFNZc1Yuaz6OP762d788PYCQW
    +hS1mFcD47YWio0bnpDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20LCtmAQd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Jan 2026 13:55:48 +0100 (CET)
Message-ID: <39794159-c0cc-498b-a162-44e77b6c371a@hartkopp.net>
Date: Wed, 21 Jan 2026 13:55:47 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 davem@davemloft.net
References: <20260112150908.5815-1-socketcan@hartkopp.net>
 <a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
 <f2d293c1-bc6a-4130-b544-2216ec0b0590@hartkopp.net>
 <20260117091543.7881db1a@kernel.org>
 <dfbcab83-095d-4ed1-ae98-baada95d4cad@hartkopp.net>
Content-Language: en-US
In-Reply-To: <dfbcab83-095d-4ed1-ae98-baada95d4cad@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	DMARC_POLICY_ALLOW(0.00)[hartkopp.net,reject];
	TAGGED_FROM(0.00)[bounces-6248-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: D28BB57681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Marc,

I'm not sure how intense you followed my discussion with Jakub and Paolo 
about my attempt to move the CAN skb specifc content (8 bytes) away from 
the problematic skb->head reference an hold it directly in struct sk_buff?

Meanwhile I sent a v2 patch set which has been dropped from netdev 
patchwork because of its can-next mail subject:

https://lore.kernel.org/linux-can/20260117132824.3649-1-socketcan@hartkopp.net/

I've been running the patches for quite a while now and feel very 
confident that the solution is very efficient and safe for either CAN 
skbs and non-CAN skbs.

To be more clear in the struct sk_buff changes I would change the 
comments in my next respin like this:

	union {
		/* skb->encapsulation = true */
		struct {
			/* eth/ip encapsulation / tunneling */
			union {
				__be16	inner_protocol;
				__u8	inner_ipproto;
			};

			__u16	inner_transport_header;
			__u16	inner_network_header;
			__u16	inner_mac_header;
		};

		/* skb->encapsulation = false */
#if IS_ENABLED(CONFIG_CAN)
		struct {
			/* CAN skb content (ETH_P_CAN*) */
			int	can_iif;
			__u16	can_framelen;
			__u16	can_gw_hops;
		};
#endif
	};

And I wonder if it would make sense to add a WARN_ON_ONCE() in can_rcv() 
and friends?

What is your opinion about the patch set?

Should I make it a net-next patch set to restart the discussion there?

Best regards,
Oliver


On 18.01.26 13:53, Oliver Hartkopp wrote:
> 
> On 17.01.26 18:15, Jakub Kicinski wrote:
>> On Fri, 16 Jan 2026 11:31:14 +0100 Oliver Hartkopp wrote:
>>> Long story short: Using the common pattern to wrap a union around
>>> dual-usable skb space is the most efficient and least risky solution 
>>> IMHO.
>>
>> The concern is that we're making a precedent for, let's call it -
>> not-routable-networking technology to redefine fields in skb that
>> it doesn't need. From the maintainability perspective that's a big
>> risk, IMHO. I fully acknowledge tho that using md dst will be a lot
>> more work. Which makes this situation an unpleasant judgment call :(
>>
> 
> I checked out more of the "destination cache" code, the dst_metadata and 
> its users.
> 
> And also this scary union in struct sk_buff:
> 
> union {
>          struct {
>                  unsigned long   _skb_refdst;
>                  void            (*destructor)(struct sk_buff *skb);
>          };
>          struct list_head        tcp_tsorted_anchor;
> #ifdef CONFIG_NET_SOCK_MSG
>          unsigned long           _sk_redir;
> #endif
> };
> 
> Despite the fact that the required 8 bytes content for the CAN skb has 
> nothing to do with destinations or other of these above use cases that 
> share the unsigned long pointer magic above, I doubt that the current 
> flow of CAN skbs between socket layer, driver layer and forth and back 
> would survive this.
> 
> My first approach to "just" extend the skb header space for CAN skbs did 
> not work out because people obviously have other things in mind with 
> skb->head. I'm sure I can count the days until something breaks with the 
> CAN specific SKB data when attaching them to the next infrastructure 
> build for ethernet/IP use cases for the same reason.
> 
> After all these experiences I would tend to add the required 8 bytes 
> directly to struct sk_buff covered by "#if IS_ENABLED(CONFIG_CAN)".
> 
> Or save those 8 bytes by using the "inner protocol space" and 
> additionally setting skb->encapsulation to false. Which is a safe thing 
> to protect the CAN specific content against accidentally assaults and 
> can be clearly proved to be correct.
> 
> Best regards,
> Oliver


