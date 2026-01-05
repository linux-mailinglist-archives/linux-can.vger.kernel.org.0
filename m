Return-Path: <linux-can+bounces-5998-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD66FCF3FC9
	for <lists+linux-can@lfdr.de>; Mon, 05 Jan 2026 14:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1133330A0DB8
	for <lists+linux-can@lfdr.de>; Mon,  5 Jan 2026 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C82C11CA;
	Mon,  5 Jan 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="C9mFnACE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TCKWuXsN"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B972F25F2;
	Mon,  5 Jan 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621026; cv=pass; b=dNXzhT0siEPIK7y8Vl1r2glUc8X55oJKhDeS+73JZH5I3Oy4YqFmDaruN6zMWnKTzWdpZ2+Xt2i4hiSqgXT4ya8lB4vfP744kk5G6cb3xolmbgG0ZA9lED9ZqYGMXJvhu67pPmfQZjCwYIxiV/ugXc19KJrYPnXiCJk4chnm//4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621026; c=relaxed/simple;
	bh=HouKd4wOEh8PqbGhSBEe9QsciwMOPBnBFvCpSs9Mb8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj+03+tb6bSJVr9F2/GOnH0SPzVQy5vr42o/rFiS5fCAfsSvmvYtMno2hhuwSmZ6kD2O6lsRJ8kGH1bDNKkbGaFjitrupLtJb4WhtQeAl4Rv46AwvHstaZpw+bnhq3Ymvas6+rH5G8UCERaKoqNh6ekcJTb6/G3+ban8BTVV2l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=C9mFnACE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TCKWuXsN; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767620834; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QAnMaw8PYjGtxdCn6vkJlNnfkG1pZSQAYcoaMLJVjsFChMBPWK8ysAb+7aS61hFzjn
    SgwZIGjDVQXWmvX8nIJ3yNqyOuJf845Eo87gDwIVAUzm6MowYBMuYhOZ054xOli0EtF1
    ewk5cIx080732hanayefzXtKtrXsBL4UQoTxK1NDArTHYsTKa/mSnJ571uiLc5EQHwAk
    xIWsSuHt0D2/uJ2HXBcXzAc7jZai6VokUXz2gXk0XDR+39mkAeJj1DgVYFm7AfMD44S4
    8glq9mLf2s+6GSa9VSJtyEPzgDMyUvUvTIw4wpat/GXzhbqxeRnkhBEZIHLwsBKXt7xO
    +aZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767620834;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CtHwz5w/HHP+ZiOOcGWfPKvo3HalzEg4Ro6wcnsP30w=;
    b=fMdC4L7/Xg93pPVP9ebBhyL2dTsC5n28qt9IyccN+UdVrB0K5z/PJSvXqy8rXHtac1
    +7lYzqGzB/lc3VfhKILnqJdxuH0qs9+rkCMs3Dh1JU7BrOsAGQQ17uz+kqmzKdIifueU
    ehpZ1lopaM6Wk6dhk9EH6CgbUK4hz1LndEy85tAu2QFeZCE+RIkCNJ73PGgCrWarGQae
    Ekro484GyRTHlZAJvjvLZJC9GdOOIIHE6LHs1kNhHtI2frNnHkKAbwOJ/pT5U6AM9DW9
    Q+85UG55XfG31SaLdl5ypenh77N1LxbwdO+unQRfuwFOeOZanEvSHKrP0/b8xVXmyhWz
    7jYg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767620834;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CtHwz5w/HHP+ZiOOcGWfPKvo3HalzEg4Ro6wcnsP30w=;
    b=C9mFnACEN48PGg4DTPai74Z15xO3rHYYZ9bw6p+biOo9itLKL6rWSFcJmggBZ7MiLe
    8tluTEFrrL5im5bYbTsDVtBfkBzG2zMTuKNm4AJ7TiwCxm09n1BCYLcjmvhf7+7ITf0Q
    ztKzIpBJ6G9H4BOH80gc8E+VqnJu05wCb8UYFOf2S8ccfYjj96+wlliyCdWUvWZR9u/3
    bFt8zvWXO0C5v/gbqNo+DF4t2jEeUfQnjdMIWrinA64CLf5+9T7lTLiGuL+WSGB3beOx
    mL4fWXYhXDoFcMGcIdTZfFfVh7HYz2P4Nu1eiW1yP5y9CR4w4u7NnJgHKSKgHTP5U4gn
    zifA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767620834;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CtHwz5w/HHP+ZiOOcGWfPKvo3HalzEg4Ro6wcnsP30w=;
    b=TCKWuXsNK2R7P8M+iX+zGY97oeR23YW5R/1MT+hNbtHWpdLnSkv8zTdPpVIKYVcskP
    RzMwZ6girVhagN9BFpDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b205DlEwCY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 5 Jan 2026 14:47:14 +0100 (CET)
Message-ID: <fac5da75-2fc0-464c-be90-34220313af64@hartkopp.net>
Date: Mon, 5 Jan 2026 14:47:08 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
To: Jakub Kicinski <kuba@kernel.org>, mkl@pengutronix.de,
 Prithvi <activprithvi@gmail.com>
Cc: andrii@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 netdev@vger.kernel.org
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
 <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
 <20251220173338.w7n3n4lkvxwaq6ae@inspiron>
 <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
 <20260102153611.63wipdy2meh3ovel@inspiron>
 <20260102120405.34613b68@kernel.org>
 <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
 <20260104074222.29e660ac@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260104074222.29e660ac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub, all,

On 04.01.26 16:42, Jakub Kicinski wrote:
> On Sat, 3 Jan 2026 13:20:34 +0100 Oliver Hartkopp wrote:

>>
>> When the skb headroom is not safe to be used we need to be able to
>> identify and solve it.
> 
> Ugh, I should have looked at the report. The struct can_skb_priv
> business is highly unconventional for the networking stack.
> Would it be possible to kmalloc() this info and pass it to the socket
> via shinfo->destructor_arg?

I did some more code investigation about struct skb_shared_info which 
aims to be "invariant across clones".

Our struct can_skb_priv does the same and looks like this:

/**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
  * @ifindex:	ifindex of the first interface the CAN frame appeared on
  * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @frame_len:	length of CAN frame in data link layer
  * @cf:		align to the following CAN frame at skb->data
  */
struct can_skb_priv {
	int ifindex;
	int skbcnt;
	unsigned int frame_len;
	struct can_frame cf[];
};

Where ifindex and skbcnt needs to be invariant across clones.

The frame_len is some intelligent length value caching which might be 
solved differently.

As the skbcnt is used as some incremented identifier to identify the CAN 
skb in the receive path with RPS, we might use the existing skb->hash 
space for it.

For the ifindex I would propose to store it in struct skb_shared_info:

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d..f7233b8f461c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -604,10 +604,15 @@ struct skb_shared_info {
                 struct xsk_tx_metadata_compl xsk_meta;
         };
         unsigned int    gso_type;
         u32             tskey;

+#if IS_ENABLED(CONFIG_CAN)
+       /* initial CAN iif to avoid routing back to it (can-gw) */
+       int can_iif;
+#endif
+
         /*
          * Warning : all fields before dataref are cleared in __alloc_skb()
          */
         atomic_t        dataref;

Would this be a suitable approach to get rid of struct can_skb_priv in 
your opinion?

If so I would send three RFC patches:

- remove the need for can_skb_priv::frame_len
- make use of skb->hash instead of can_skb_priv::skbcnt
- move can_skb_priv:ifindex to skb_shared_info::can_iif

Which finally removes struct can_skb_priv and the highly unconventional 
skb->head construction.

Best regards,
Oliver


