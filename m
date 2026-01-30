Return-Path: <linux-can+bounces-6419-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIY3BcqrfGkaOQIAu9opvQ
	(envelope-from <linux-can+bounces-6419-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 14:02:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B18ABAD62
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 14:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FCAB300D17B
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80546134CF;
	Fri, 30 Jan 2026 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KE/c5SjM";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qb3jgcOR"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFAD27E
	for <linux-can@vger.kernel.org>; Fri, 30 Jan 2026 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769778104; cv=pass; b=cAFVa7fziLs/EU2zbr2ACM5Ij6I7KBsZvMerSBcw4j/Cd7htjPCTiJQYlRA1zne8qhNdtRpOZQQxs3R4270n9mC7oGFgMV41RrwZRG0sMIKG0q5owgTa44r4po+1+iDzpY1QCi/5FX7LzdqTMJHIeDh90+clvB6sy4orRCsJHoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769778104; c=relaxed/simple;
	bh=JlEMBGsDUgA7BaNj+fVIrBRSZBV0VWeU//QA4gYPgWw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UXRN85E2ut26mR2ESXhZ15xt4Y/XonElXPusoyGBhKQJj/6jTWFuC0BMGqTOVRwi3iHIyDVME9nvPHHn8K77ByrlMdZz5SgwA53Aa27aZziMDuutJl9Inm3y6MmP3ZinzH/2LdlZJ1r3ot/sbTxFD2kknBhHhO6GWT7kxzPNjiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KE/c5SjM; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qb3jgcOR; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769778094; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hVBg+ktz/bxhL4zYk7w+wrJzO9UcQ6JRHdqmvM1sGqdzp6h6178GUs1CHKL/WmBw7Q
    XkoVrQhQjdw9tWHXqwzph8HmFdBujcVx0WBUzRQl8RSJfdMJAcehWrLzCFy4n6Cbg3Ly
    vcx4pwnHRzb9rnTUtf9FV4RC0DfParV4yqsOhTFyE9vfKQsh7gWTEEkf3+mSRfmWYkqL
    Ghow/9K507yYiLsiGWAl2XYF7tOvYP++hxtr7fIabCRHXaN/QkgnCiLWansbQFXLvSrf
    EUwFnjM94LzyPpMDQNUlh5NbsMmwv8u8bIIjijP2dn604wupOzWG6u6hBASHAjRLaS36
    TTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769778094;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xfXK8+8EO8kDqHd66OokrqzHC6iaBwCHqhCkNE1EgDM=;
    b=PCTJQHw1z5w+YDIp67pszkLK52qrd/YKAATS3ANX/sVISUYKw79GOe4Ehm/hNME5ij
    yBcoEd76ZvvJ4G1AhqaTF2AWBYLPMgnpsl01UcafGI5YIxqmv4zQ0v/Jr2eps3QjXcb2
    G1YmhL9K5Efi91JM9kutwtnKo7ZWzg5I4LHYdCBPmlBpPiOlcAlyIwjQwgfeQNZmL4XV
    PMJiYl0ayNNlPdU6JRnLkKl4jUJiRKaaOZpL8ZkBWUagLC0y5xwa/DtwtoewLcBTxWG1
    /Xvn+YQ9owzG3FIyvf+nsGI3S7UvuoS6cgMSvV9fk7fWV5PsZ7xLXQyheyUg6QPc6DpA
    9yyg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769778094;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xfXK8+8EO8kDqHd66OokrqzHC6iaBwCHqhCkNE1EgDM=;
    b=KE/c5SjMw/I61jiU4lw49qI3NLnDA4txpMIDCWb44aHFEb8GgPJAyrvzJeGC2WAMYv
    ZpdelgcvOvlTbV3rlGrjdEkhPqGpbgXLr4wxhgvDZ+rN2sZRhnprfqc2316Gz4KEHJ18
    1x3797RkE2L4wqPjQpvmVhE/33JhBuDgByf4el7km1Q8PUkqBGL7+HH6+uxtXt4u2zzy
    iqk40Bg/jlIdfX/kG6YrTtYI/HNsRTlU3i70UJAcX3ld13NLpRhdp6Iu62vDXzno5E3D
    UWVGAOBM2W1SAdXVTtQ1Uqpfpkz4VoWntMcQUHPWdLYzbmEDp+4Xk47ArrvUDGgwKG9t
    oSUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769778094;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xfXK8+8EO8kDqHd66OokrqzHC6iaBwCHqhCkNE1EgDM=;
    b=qb3jgcOROToUNA/w4V3PvhwUk3YNFZKgt5KAjKrIvx9N+vR+5kFnuscrj8fnAs+P7J
    VQJ/Kc63Exu+MTZKrCCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka861020UD1X55D
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 30 Jan 2026 14:01:33 +0100 (CET)
Message-ID: <c057ddbc-02c2-473a-8e52-50945b43e04f@hartkopp.net>
Date: Fri, 30 Jan 2026 14:01:27 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: CAN ML only - Re: [PATCH net-next v6 6/6] can: gw: use can_gw_hops
 instead of sk_buff::csum_start
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org
References: <20260130-can_skb_ext-v6-0-8fceafab7f26@hartkopp.net>
 <20260130-can_skb_ext-v6-6-8fceafab7f26@hartkopp.net>
 <93d61e1c-5cdf-498e-8699-43e57cbb221b@hartkopp.net>
Content-Language: en-US
In-Reply-To: <93d61e1c-5cdf-498e-8699-43e57cbb221b@hartkopp.net>
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
	TAGGED_FROM(0.00)[bounces-6419-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B18ABAD62
X-Rspamd-Action: no action

-netdev

Hi all,

On 30.01.26 10:29, Oliver Hartkopp wrote:

>> @@ -62,11 +64,14 @@ static netdev_tx_t vxcan_xmit(struct sk_buff 
>> *oskb, struct net_device *dev)
>>           kfree_skb(oskb);
>>           goto out_unlock;
>>       }
>>       /* reset CAN GW hop counter */
>> -    skb->csum_start = 0;
>> +    csx = can_skb_ext_find(skb);
>> +    if (csx)
>> +        csx->can_gw_hops = 0;
>> +
> 
> We are dealing with a cloned skb here, where we can not be sure that the 
> original skb ("oskb") was not cloned before too.
> 
> Therefore we need to take care that the skb extension can be written 
> without affecting potential clones of oskb.
> 
> csx = can_skb_ext_add(skb) would do a potential cow for us and also sets 
> can_gw_hops to zero.
> 
> Therefore the only change for vxcan.c should look like this:
> 
> if (!can_skb_ext_add(skb)) {
>      kfree_skb(skb);
>      goto out_unlock;
> }
> 

We have some other CAN code cloning skbs

af_can.c:           newskb = skb_clone(skb, GFP_ATOMIC);
gw.c:               nskb = skb_clone(skb, GFP_ATOMIC);
j1939/main.c:       skb = skb_clone(iskb, GFP_ATOMIC);
j1939/socket.c:     skb = skb_clone(oskb, GFP_ATOMIC);
j1939/transport.c:  skb = skb_clone(se_skb, GFP_ATOMIC);
raw.c:              skb = skb_clone(oskb, GFP_ATOMIC);

And especially

include/linux/can/skb.h with

/*
  * returns an unshared skb owned by the original sock to be echo'ed back
  */
static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
{
         struct sk_buff *nskb;

         nskb = skb_clone(skb, GFP_ATOMIC);
         if (unlikely(!nskb)) {
                 kfree_skb(skb);
                 return NULL;
         }

         can_skb_set_owner(nskb, skb->sk);
         consume_skb(skb);
         return nskb;
}

With this patch/change above I would have integrated the skb extensions 
support for gw.c but after thinking about the cloning and the refcounts
I think the can_skb_ext_add(skb) or skb_ext_add(skb, SKB_EXT_CAN) has to 
be applied to some other skb_clone locations in the CAN code too.

In the above can_create_echo_skb() and in can_send() in af_can.c we need 
to create a (writable) copy of the skb extensions IMO.

In raw.c the skb is only cloned to send it to the user space where skb 
extensions are not needed as the skb is never routed back down again.

The same seems to be correct for j1939_sk_recv_one() in j1939/socket.c 
and MIGHT be correct for j1939_can_recv() in j1939/main.c

j1939_simple_txnext() in j1939/transport.c is a open question for me.

Can you (especially Oleksij) please take a look for a short review and 
advise?

I'm not pushing for getting this CAN skb extensions patch set [1] into 
this merge window. But if we would catch it, it would be nice.

Best regards,
Oliver

[1] 
https://lore.kernel.org/linux-can/20260130-can_skb_ext-v6-0-8fceafab7f26@hartkopp.net/

