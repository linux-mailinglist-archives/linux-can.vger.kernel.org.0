Return-Path: <linux-can+bounces-6445-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJpoMskof2kMlAIAu9opvQ
	(envelope-from <linux-can+bounces-6445-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 11:19:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68775C56AD
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FF7D30022C7
	for <lists+linux-can@lfdr.de>; Sun,  1 Feb 2026 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417629D270;
	Sun,  1 Feb 2026 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I5KsOEj5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="y5hRD9Z6"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BB2E92D2;
	Sun,  1 Feb 2026 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941188; cv=pass; b=h5KcOlJu7asV6qBmZKCtw0/XhJL8GLfJw0xzhIA6kB8/nXthrua6FfBRUyscG9vGOFn9bAro6GEMPBOTVPtacUsb7N7ErnPGd23+OrDE8J/h6JZKaSOSJDxC/irgZKv++H19eJzy/ymrIkQccC0WqXLx4YTg5BVUmHDQ+cw81cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941188; c=relaxed/simple;
	bh=P1ySafr64yRRhIJF8kGUUuqtgO4fe+0ln9/E+t88dfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYicLCvOLowl0GyaT3/bwnhScW5DbagryVC49SGEU4xiQKE/onFepYT42pl1JHPMXP5vW75GRmMVPbKefzXj+/UxaX4a8qqYHYI2Ckoc7AmkGhOPwm0Ua/2DhiZzt6jlB11kWwDoulCkcEu9yWT5aawN4fFTyfQoDIU2VbIU1nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I5KsOEj5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=y5hRD9Z6; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769941171; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sXpUENVCcnlVHatL9yMVl8xyUFpzVUFm2s7eKdk8894PzTnT02dCJLJhg4aBabq/n7
    VEJBQ6CRMmvVt6aqSnArF3rTzry1TC2N0kBXFGtnVYFI0Lqz20EpQRmeUkNhxh5CRppQ
    lv1zJIrz1U8xuqm0PdG8tTdGxlZOn/+o6EnjTJpk+PsU/QsT6fNRsx3Uj7UYuJgS3rRT
    xQFeXZ1CWyDIEiWWce83P/1l5zrysmqQ0Jm4UguD0B0FePYJ6i/78On8dIQrXaRD4NoS
    aAm2YekkYP5abxdQDB8MnXOCA0oinVRhc1KDKOQbMqPCIPNJRBBqxwirtJ22dxHTrLeX
    OhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769941171;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4tn16xmFpwhwTTM5O4lCOTl79rFgysO7dlq297NyIMY=;
    b=Q7D0idebw7qqBRcsNCdq7mK+dGAraTW5xzenNtmIh/h5wva57Ke5+YvC+iC/wx+3Xk
    vFrAu8tnw2JNpVdLmrMvgPCsstixjps2w5fx5fRVdZyR+9C1tJIAoOq/ngjwae/jRCvg
    6J8LoNjMBZFdVIvbld2bh9siFtukNJ8SPQvXuTILHebcWxP2uqUH9po+vfKEGEwOA5t2
    4+d3yaVBrNSKCrJuTWz/QSPslhZIh2LkHp7PZdu+X+ElxVSooV3AIqdbLe+dVE03R6wo
    H3eM0o7bsQHtT63etVEgnQfv+CT5SPHoHXJE+VrkGHmygm5EDjWpJExamUTT1C7bwuHa
    NItg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769941171;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4tn16xmFpwhwTTM5O4lCOTl79rFgysO7dlq297NyIMY=;
    b=I5KsOEj5VwL6bywjZqEdsR9ZtVDlRHBLUW57Lt/rWIdrNzf8KsU5EBVTdTxjOR4c71
    +QIOOYyAkkctUBSiy7+ZwB7YWpR8LX9zQZ08jcLRsh7p0y2bUyOJVows3Xb28UkDt2Jy
    oISLIi8RoplVINPdon7DMGV7qhRyrQ86KedX3yxPD84yP+OxnX9QBvwGRqdzI+RTIJxd
    k08wpXFkcyjfEOu7QeE8ZrJStkSffS7nwr5yOdRfpEearEh2URtDi4uWfmJcPmNJdrKl
    HhNLwSsZaW4ZR9dospyLTYwFnsap25PqpJWF7EEu1a6rGyqCfT1oxuC/0ilFWN6oqBz6
    2SZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769941171;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4tn16xmFpwhwTTM5O4lCOTl79rFgysO7dlq297NyIMY=;
    b=y5hRD9Z6Tugwyl7rkBrAk6Y+7JfivJbs3rI20zG2ZNvc6GR7PbqtvK2lRyY0SO2FHj
    1oBUXDO1VjMpaaO47iCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka8610211AJVEIX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 1 Feb 2026 11:19:31 +0100 (CET)
Message-ID: <2c6a431a-6391-4274-a791-fe67036d2fb8@hartkopp.net>
Date: Sun, 1 Feb 2026 11:19:24 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v7,2/6] can: add CAN skb extension infrastructure
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 robin@protonic.nl, netdev@vger.kernel.org, linux-can@vger.kernel.org,
 davem@davemloft.net, mailhol@kernel.org, linux-kernel@vger.kernel.org,
 o.rempel@pengutronix.de, kernel@pengutronix.de, mkl@pengutronix.de
References: <20260131-can_skb_ext-v7-2-dd0f8f84a83d@hartkopp.net>
 <20260131180025.1124810-2-kuba@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260131180025.1124810-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6445-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 68775C56AD
X-Rspamd-Action: no action

On 31.01.26 19:00, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says:
> 
>    Not sure about the first issue, I think you mentioned we have
>    an extra ref? The uninitialized errors should probably be fixed
>    "in net", before this series? :(

Fortunately there have not been uninitialized ret values before.
E.g. the sock_alloc_send_skb( ..., &err) calls set the ret val before 
going to the out/err labels.

In the other goto/return cases the existing code sets the values explicitly.

Therefore setting the missing err values within the newly added code 
completely addresses the uninitialized ret value problems.

Additionally the kernel test robot discovered an indention issue in the 
original j1939 code from 2018 which is no candidate for net/fixes either 
and can be silently corrected.

I'll send a v8 patch set when the 24h grace period is over 8-)

Best regards,
Oliver

> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> can: add CAN skb extension infrastructure
> 
> This patch introduces CAN skb extension infrastructure to store per-frame
> metadata (interface index, frame length, gateway hops, flags) using the
> standard skb_ext mechanism instead of the private CAN bus skb headroom.
> 
>> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
>> index f14c6f02b662..53d7d9046f85 100644
>> --- a/drivers/net/can/vxcan.c
>> +++ b/drivers/net/can/vxcan.c
> 
> [ ... ]
> 
>> @@ -39,6 +40,7 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
>>   	struct vxcan_priv *priv = netdev_priv(dev);
>>   	struct net_device *peer;
>>   	struct net_device_stats *peerstats, *srcstats = &dev->stats;
>> +	struct can_skb_ext *csx;
>>   	struct sk_buff *skb;
>>   	unsigned int len;
>>
>> @@ -63,6 +65,18 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
>>   		goto out_unlock;
>>   	}
>>
>> +	/* the cloned skb points to the skb extension of the original oskb
>> +	 * with an increased refcount. skb_ext_add() creates a copy to
>> +	 * separate the skb extension data which is needed to start with a
>> +	 * fresh can_gw_hops counter in the other namespace.
>> +	 */
>> +	csx = skb_ext_add(skb, SKB_EXT_CAN);
>> +	if (!csx) {
>> +		kfree_skb(skb);
>> +		kfree_skb(oskb);
>                  ^^^^^^^^^^^^^^^^
> 
> Is this a double-free of oskb? Looking at the code flow:
> 
>      skb = skb_clone(oskb, GFP_ATOMIC);  /* line 60 */
>      if (unlikely(!skb)) { ... }
>      consume_skb(oskb);                   /* line 62 - frees oskb */
> 
> At this point oskb has been freed by consume_skb(). If skb_ext_add() then
> fails, the error handler calls kfree_skb(oskb) on the already-freed pointer.
> 
> This can occur under memory pressure when skb_clone() succeeds but the
> subsequent skb_ext_add() allocation fails. The kfree_skb(oskb) line should
> be removed from this error path.
> 
>> +		goto out_unlock;
>> +	}
> 
> [ ... ]
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 4bb60b8f9b96..94103fe654ff 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
>> @@ -1005,6 +1022,13 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   		goto err_out_drop;
>>   	}
>>
>> +	csx = can_skb_ext_add(skb);
>> +	if (!csx) {
>> +		kfree_skb(skb);
>> +		netdev_put(dev, NULL);
>> +		goto err_out_drop;
>> +	}
> 
> Does this error path return an uninitialized value to userspace? The variable
> err is declared without initialization at line 959 and sock_alloc_send_skb()
> only sets it on failure. When can_skb_ext_add() fails after a successful
> sock_alloc_send_skb(), err contains garbage.
> 
> Other error paths in this function set err explicitly before jumping to
> err_out_drop. Should this add err = -ENOMEM before the goto?
> 
>> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
>> index 1589e8ca634e..fc28a7677369 100644
>> --- a/net/can/j1939/socket.c
>> +++ b/net/can/j1939/socket.c
> 
> [ ... ]
> 
>> @@ -895,6 +897,12 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
>>   	if (!skb)
>>   		goto failure;
>>
>> +	csx = can_skb_ext_add(skb);
>> +	if (!csx) {
>> +		kfree_skb(skb);
>> +		goto failure;
>> +	}
> 
> Similar concern here: ret is declared without initialization at line 891.
> sock_alloc_send_skb() only writes to ret on failure. When can_skb_ext_add()
> fails after successful allocation, ret is uninitialized when returned via
> *errcode at the failure label.
> 
> Should this set ret = -ENOMEM before goto failure?
> 
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index fb4f9c854df0..03438e9bc535 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
> 
> [ ... ]
> 
>> @@ -956,6 +958,12 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   	if (!skb)
>>   		goto put_dev;
>>
>> +	csx = can_skb_ext_add(skb);
>> +	if (!csx) {
>> +		kfree_skb(skb);
>> +		goto put_dev;
>> +	}
> 
> This returns -EINVAL (from line 923) when can_skb_ext_add() fails due to
> memory allocation failure. Should this be -ENOMEM instead? The
> sock_alloc_send_skb() above this code returns -ENOMEM for allocation
> failures.


