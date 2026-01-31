Return-Path: <linux-can+bounces-6438-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ+UF40GfmmVUwIAu9opvQ
	(envelope-from <linux-can+bounces-6438-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 14:41:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEEDC2090
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 14:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47CCD304FE0A
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 13:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF62D595D;
	Sat, 31 Jan 2026 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ClRRz0Yi";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="En74bnO6"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D934FF65
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866597; cv=pass; b=Hx7667qsqpTsk70HEaL5+Lsh3H1obUbW/7AOC6r0LIRem5QqAgNWD7Ya7eJqVV/99swFCfpkdA6IEpaLg3C8mxLQJm1SR5p0uxB5zMTLBFBKE2dEj+JIDjuFI3CnMhs3n5CF7QlVJcCa3S0bxDsDIkvxZgF0qXSGFAL/Z10ejrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866597; c=relaxed/simple;
	bh=8vb1rD3Xdg2ShM+jrRXZB56pvVEHdUmw/cl2n2JLLt0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RoOU78RcfCEJo/wptObtayf4MoLY0q3GtWnZpswwvzsTE2mbyZP1vYQDVPChVejwA3WM3Y3XfgQUAtzzsJGiR2Rw9iSilh7MnamDsCOuo6f16zA2LGQGCkMFRxFy9VwWcYLSQgWm2XoYklLQ5vdgG4M8OVQME5FpUwIDwqhVp/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ClRRz0Yi; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=En74bnO6; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769866587; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tlsAi4H3twnh96tIuEDZLo4Ly/nH6GyUslQkfmyT6Tg9bTSdYdtjprcJjDk0eX/OnF
    TeolI8Nb6oxg8WlRIaDkT/OulxJqfa/ZMBkpfl9iyK89GWWQY3aoxpMztjb9kr8UeyTm
    scb6HWiJx0fd0bJKMsnPJiLc0KIXUfil9x/Z9fNvkM2Jcf4EfynmuLmDLmXbaGpc2+QQ
    tOPoMQ/cY3aOtG/SVmRFjRowlxu6oo94c+S747KNcMx5h2/4Piz00RCWJ7h+I2PpbXfz
    rHF8JO1dQMnMP1AmGk0nBGHlikkeUAOw4I2lro5MBaaJWQ2z0VMh4NM8QI5VChKPWn0j
    lskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769866587;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I5ZmcwoKX7Gzvn7Lacets3SkLb6UM41zR9isOTiteo8=;
    b=ZVdyrWsP8Zw/YUiv2gaUtsK6ioILa2YefbyRD9fD0iw6o63m6Po/H2uZ0o34EYKxRu
    pt9jAU/W8/t6qck/uJfsPMCbxxjaANlMkOHuR5MIw+U7LTrORiTIjpaaRJKnhNOEK05B
    DGw9OZ89zabOiNDD6PFrcXzdHU0WqXMTCHKRVJ1GtUK9A6UWwR8meedcEhOl/3k5H7gr
    K/FapxtW/k+2U1liXBPnXl2paL06pFqDShocxcDYluQgiOuOr3WgeDT+SpOIEkx6r6sd
    l74nuOLX0qGln4QVnY7lbh6OMos5q3AKiHiblaJe3pcIrYChikgeRUZk7UNN/t/NC7IA
    k7SA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769866587;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I5ZmcwoKX7Gzvn7Lacets3SkLb6UM41zR9isOTiteo8=;
    b=ClRRz0YisJa8I7bCnd4dVQ7vlaUJZnQyYauXjucfBViXMFkhhfIZJZomVM6N8lt75t
    AZielSOe5Ubcn7SKj/iZGmFRuvQHM/A5JdkW3JbT1GxwEZIIUUdmCwmzyi1rf1nDB1TU
    KvbsM2F1kz9NkTicIOB+AgvZzFuwkQTImpp2kGl0xDLUVxZECkderNXfAJk+bMoa4gri
    Hd7GwMlTWMno9Eh5LuP51woa7a+g3A1WBBkK5fC16C/MYpMKLqaj/rGwgABTGGUwD6af
    ZZcegnOfbKuG/eNZoWIDZDin/me43Qjn6OzHH8SVQa7qrtRX1egthI1NBuO8w6x+iy5p
    DqWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769866587;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I5ZmcwoKX7Gzvn7Lacets3SkLb6UM41zR9isOTiteo8=;
    b=En74bnO6tG8Wek+JmlAnJJ727b0lMKiU0+4OUZRQzJdBIAfahPr/m5si2TYAsds7s6
    c0NRtOrf/8j3OepezNBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka861020VDaRCBt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 31 Jan 2026 14:36:27 +0100 (CET)
Message-ID: <eb593a44-526a-4861-9240-4566fa0907ad@hartkopp.net>
Date: Sat, 31 Jan 2026 14:36:22 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CAN ML only - Re: [PATCH net-next v6 6/6] can: gw: use
 can_gw_hops instead of sk_buff::csum_start
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org
References: <20260130-can_skb_ext-v6-0-8fceafab7f26@hartkopp.net>
 <20260130-can_skb_ext-v6-6-8fceafab7f26@hartkopp.net>
 <93d61e1c-5cdf-498e-8699-43e57cbb221b@hartkopp.net>
 <c057ddbc-02c2-473a-8e52-50945b43e04f@hartkopp.net>
Content-Language: en-US
In-Reply-To: <c057ddbc-02c2-473a-8e52-50945b43e04f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6438-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAEEDC2090
X-Rspamd-Action: no action

Answering myself:

I did some more code reading the last day.

We have 3 relevant skb_clone cases:

1. gw.c (modify can_gw_hops)
2. vxcan (clear can_gw_hops for new net namespace)
3. j1939/transport.c (creates many clones that may show up in 
can_put_echo_skb() at the same time and set can_framelen)

The rest is not relevant IMO.

More testing is appreciated ;-)

Best regards,
Oliver

On 30.01.26 14:01, Oliver Hartkopp wrote:
> -netdev
> 
> Hi all,
> 
> On 30.01.26 10:29, Oliver Hartkopp wrote:
> 
>>> @@ -62,11 +64,14 @@ static netdev_tx_t vxcan_xmit(struct sk_buff 
>>> *oskb, struct net_device *dev)
>>>           kfree_skb(oskb);
>>>           goto out_unlock;
>>>       }
>>>       /* reset CAN GW hop counter */
>>> -    skb->csum_start = 0;
>>> +    csx = can_skb_ext_find(skb);
>>> +    if (csx)
>>> +        csx->can_gw_hops = 0;
>>> +
>>
>> We are dealing with a cloned skb here, where we can not be sure that 
>> the original skb ("oskb") was not cloned before too.
>>
>> Therefore we need to take care that the skb extension can be written 
>> without affecting potential clones of oskb.
>>
>> csx = can_skb_ext_add(skb) would do a potential cow for us and also 
>> sets can_gw_hops to zero.
>>
>> Therefore the only change for vxcan.c should look like this:
>>
>> if (!can_skb_ext_add(skb)) {
>>      kfree_skb(skb);
>>      goto out_unlock;
>> }
>>
> 
> We have some other CAN code cloning skbs
> 
> af_can.c:           newskb = skb_clone(skb, GFP_ATOMIC);
> gw.c:               nskb = skb_clone(skb, GFP_ATOMIC);
> j1939/main.c:       skb = skb_clone(iskb, GFP_ATOMIC);
> j1939/socket.c:     skb = skb_clone(oskb, GFP_ATOMIC);
> j1939/transport.c:  skb = skb_clone(se_skb, GFP_ATOMIC);
> raw.c:              skb = skb_clone(oskb, GFP_ATOMIC);
> 
> And especially
> 
> include/linux/can/skb.h with
> 
> /*
>   * returns an unshared skb owned by the original sock to be echo'ed back
>   */
> static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
> {
>          struct sk_buff *nskb;
> 
>          nskb = skb_clone(skb, GFP_ATOMIC);
>          if (unlikely(!nskb)) {
>                  kfree_skb(skb);
>                  return NULL;
>          }
> 
>          can_skb_set_owner(nskb, skb->sk);
>          consume_skb(skb);
>          return nskb;
> }
> 
> With this patch/change above I would have integrated the skb extensions 
> support for gw.c but after thinking about the cloning and the refcounts
> I think the can_skb_ext_add(skb) or skb_ext_add(skb, SKB_EXT_CAN) has to 
> be applied to some other skb_clone locations in the CAN code too.
> 
> In the above can_create_echo_skb() and in can_send() in af_can.c we need 
> to create a (writable) copy of the skb extensions IMO.
> 
> In raw.c the skb is only cloned to send it to the user space where skb 
> extensions are not needed as the skb is never routed back down again.
> 
> The same seems to be correct for j1939_sk_recv_one() in j1939/socket.c 
> and MIGHT be correct for j1939_can_recv() in j1939/main.c
> 
> j1939_simple_txnext() in j1939/transport.c is a open question for me.
> 
> Can you (especially Oleksij) please take a look for a short review and 
> advise?
> 
> I'm not pushing for getting this CAN skb extensions patch set [1] into 
> this merge window. But if we would catch it, it would be nice.
> 
> Best regards,
> Oliver
> 
> [1] https://lore.kernel.org/linux-can/20260130-can_skb_ext- 
> v6-0-8fceafab7f26@hartkopp.net/
> 


