Return-Path: <linux-can+bounces-7700-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EcUKaKUFGpfOgcAu9opvQ
	(envelope-from <linux-can+bounces-7700-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 20:27:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A1C5CDA21
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCFA730205D0
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259C35A397;
	Mon, 25 May 2026 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="X76CmhE5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="57Ddboi9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA69360ED9;
	Mon, 25 May 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733655; cv=pass; b=J+9iLGPCcOdvIAkChjLB4y+0m/YXaCEPy24F3pt7kbMIxPVy+lAh9MCsAFwEcWx/6AUe78Iae7VZfCsdPwpmZxzKs82ObQL+2nEOTV9uhlYOOP69Y9AUwATQhLLCa3jpXCqKVgal4IRsVFz9Kece5UepXdC7guR8t/VsM020VD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733655; c=relaxed/simple;
	bh=3zTRPrx5fFPQynO5k+stdvNzASo3dR9tMxn3+poLzvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIZ1U721dUv7gWuyyy1MJKiI4CZqyn96Fv/SvF4pczFP4TqFVHLg/hd2WtMXW2x9Qr8x/ZR2JNPzMa1Zhj4UI45nwes5cwnn6xL2xQJF6scnFd/S6EtborG3oTyI9oPn3+bJnPYUkS4eHR15T32z5tkajePoD+gICI1HGqmJpWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=X76CmhE5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=57Ddboi9; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779732927; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OnDJe/3T1rHAY+lr4sp0fYlfC0zoEQluhKoacQ2IKrTTuas7M1kjdUczt4mZ/lZZ1g
    jg/MLpCBk9MUoHpfMnPscTYlD9KoV0KLlUfFgbuKoq2p6NR9XWqjXgp9jYvSX+5z14P3
    EkQxNVSuBwczAFQN4YXYVDDB8ZrM8J5SxO0TIzapZZR9e55AdfqeXCs/SM+/t3r6aG4c
    5MuDpfLEOJ+4I182pP6LiZjelFnaS4L/r8x373XYLivaibLlulUBf8sNJX170qQsCCNx
    vcvKLbK1AKqarUDye3DcchP/mhSNvsNTJLRuw6XAfGE9N/SRmBupJFOBEiEPqavDb4iI
    3SVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779732927;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4DV9vftK8yjz6qkpxO+ICdiW4u/Yb/Q4Cmw2TrO//ls=;
    b=UPDuc3fJ5lBtw2MhRmwxjEdw+hih1salO4eTqehPtVrCB60chJ7HnrMp9r5/MNP7TF
    LPvitkpMqfGvO2EJfJLgwc21zTzSKYEm+GPDdWAA+5jI6yksgOtZw34JgHP5HyjWer0t
    kxMVXyV5HxXFZz7a867SN+drbrooZNTfHcAWVBYrNTspBmMwcCdUN3ElLWWOLX3t20rb
    AkQ+wtemfYxtRFrhwSz8ruiUh+BEHd3XvKTF7PmsJE/Pav+qNyZr6Svnq4wNq9uHCK4F
    BhVSo0REkqKa3A2ZP/zdYf7h2+FyLk4necKhBIbLoZJCR0Kf2LrFaSTIU1DRpuy2lb7/
    /arQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779732927;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4DV9vftK8yjz6qkpxO+ICdiW4u/Yb/Q4Cmw2TrO//ls=;
    b=X76CmhE5UeWVXdfNTazTmubSMESfejKDi93vv6FuhZg5legG/+8Ttaiv0vntKRyuiV
    2wc5QnetC9JxHQgw2pyp/fNZdW2QLdA5RZUPsJ0QlmDCpE40mqzVlxK0GeRu/xc+f3bH
    dm8MSNDgxj1JnnlC+v+IcSArOp4/55g67S7Q89wxJPxpkfK+eYowHST4R3Z+0w5bhb0B
    RYkmkPY6Mqg8X0BHynPiVEcLWbwXX9Hqm1g+C4CwbH75ZnHMd5rINBbjzpM3OZg+5/Nr
    REydOEZQ+Rr1phJltnIqXOCuryqd5Epe45BQSUhSFB+2uxhlUhxeokHKS9RCzGWAg4+m
    4fNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779732927;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4DV9vftK8yjz6qkpxO+ICdiW4u/Yb/Q4Cmw2TrO//ls=;
    b=57Ddboi9ol3803EsNoaAMOfpKE6VbniJX9kr/AyQf19OcLxIr+qLCDFZ2KXmKXpRZr
    ogn+kta3GX1qusk3PbCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24PIFRZ3J
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 25 May 2026 20:15:27 +0200 (CEST)
Message-ID: <d80a783d-d6b3-4a70-944e-8eb9b0000e11@hartkopp.net>
Date: Mon, 25 May 2026 20:15:21 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: af_can: reject can rx unregister if dev is not can
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 mkl@pengutronix.de, syzkaller-bugs@googlegroups.com
References: <6a124882.050a0220.30ba69.0009.GAE@google.com>
 <tencent_C56D5496D4E8FEEFDECCB07AEE6FC42C450A@qq.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <tencent_C56D5496D4E8FEEFDECCB07AEE6FC42C450A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7700-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[qq.com,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,8ed98cbd0161632bce95];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 08A1C5CDA21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 25.05.26 15:56, Edward Adam Davis wrote:
> When a user binds a non-CAN device to a socket, the vulnerability reported
> in [1] is triggered during the socket's closure and release phase, due to
> the inability to find the expected receive list.
> 
> Added checks for Mid-layer private and type during the rx unregistration
> process.
> 
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> pc : can_rx_unregister+0x124/0x560 net/can/af_can.c:537
> Call trace:
>   can_rx_unregister+0x124/0x560 net/can/af_can.c:531 (P)
>   isotp_release+0x500/0x9d8 net/can/isotp.c:1232
>   __sock_release+0xa0/0x1d4 net/socket.c:722
>   sock_close+0x24/0x38 net/socket.c:1514
> 
> Fixes: bdfb5765e45b ("can: af_can: remove NULL-ptr checks from users of can_dev_rcv_lists_find()")
> Reported-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95
> Tested-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Hello Edward,

many thanks for your investigation an effort to address the syzcaller issue!

Btw. the root cause of the problem, that the receive lists can not be 
accessed is the bonding process that the bonding driver mutates
and modifies the network device states to fit an Ethernet-like
aggregation model. Which destroys the can_ml_priv.

When CAN netdevices are left alone the can_ml_priv data is always valid 
and therefore does not need to be checked. Additionally this bonding 
process and your fix will lead to memleaks of CAN filter data.

Syzcaller can continue its work to test the CAN API also without bonding.

So it seems to be the better solution to reject CAN interfaces to be 
bonded. See my patch here:

https://lore.kernel.org/linux-can/20260525175639.112492-1-socketcan@hartkopp.net/T/#u

I intentionally missed to add the bonding maintainers - and I'm not yet 
clear what Fixes: tag would be appropriate. Does it fix the

commit ccb29637991f [CAN]: Add virtual CAN netdevice driver

??

What do you think?

Best regards,
Oliver

> ---
>   net/can/af_can.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 7bc86b176b4d..72831b4e0776 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -519,7 +519,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
>   	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>   	struct can_dev_rcv_lists *dev_rcv_lists;
>   
> -	if (dev && dev->type != ARPHRD_CAN)
> +	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
>   		return;
>   
>   	if (dev && !net_eq(net, dev_net(dev)))


