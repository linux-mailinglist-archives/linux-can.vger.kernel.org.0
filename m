Return-Path: <linux-can+bounces-6174-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBDD2F964
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 11:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72FDA300FE33
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41630DEDC;
	Fri, 16 Jan 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="J9bPJdT8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OKn731lL"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83930DD1F;
	Fri, 16 Jan 2026 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768559504; cv=pass; b=MCJ8YY0ojjxgukIABB3O1b3I2ogK33BZhLdRCPRRFyJnDOInNdNIMW0f/+td8L10AE8MDnw5+mMIx6tCAb2Uj6R58paNRkugc86RY8xlVSM2fM8BcR+dvBuFke00ZpUuJC2xJODB6EducKnsMlE9RvsR+WeDmmU5E3Znlxu3sNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768559504; c=relaxed/simple;
	bh=F+E86gmFwJgzHMYe1opEevnrLt7o5OIpKlmd0HhoCYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjZJZItokFhN2IXfqtsig+/MuiswZgr7nZAw4ecvzvLyVYux4dIBuYweFUZxFR5lzq0xyDCj5+LRBQ+8omwoUFxIq2UTOeZYHHdl3KauR5+Gu6Zl9sD0zFX2Iar+M1zxG22AhfmhmzX6lxBwDuJZN2itw5DXGGKerLpSTdchWGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=J9bPJdT8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OKn731lL; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768559480; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VkbqpgfoGAEG5X17cx6hm+EnpXyhRUP5CP76GjQ6+Ka7P+BcYfvySoaVEX8pBagvch
    LlMgCaY6MPiOaND/n/ub+ZNI/5i5Kj7IwzmOn0LMIu19M/SBLmV1PnSqKx7CaL0yNQe7
    0cQStWS71YQ3xW559L4vm55zzRT8Qo/zAdm5PF9lFt23+8xhWnMFhKw2UP2riaM5nlUI
    m5b2dY3OR2CdP+aBWpkggLW6oldUwmeyyofy8MvBBU6NeB3Wxqt++Sdg8fGtCVyJzSJM
    MkMbQhchhUXqDPaBfAru97K4qwgHvmObE71SsUvY9rwa5O4eXMHY9SxQvSYnk6YqYOP8
    XFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768559480;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Qq9gdM9vprxxFGgf7/BOYBAvs6L7HF7wuAMDd8isSI=;
    b=cMZrjbYfxEhb2IbC3u2KrFuHmk/QvBt84jwcUfe++qxoCyrlHqUzu2MFYGecPYgs4k
    mZgotzRcXHHawhroiSRO4DJZ0eHSi+m5KYG7P7pli9BmgLGK4dK/hTGwKQBTXvE2rwry
    TUYbInYUUa+J9nUVhZLCArMz2ppd9LKK4fJbiMqLG7WOfDCQEMGZ+0dN/c17fQLefOsA
    8mYMM+i9ueYGskT+eIqvsO3g6qQSmJQeg8MVtn8Xbx1V1qqckW4KSgLv2HtwjW6I3RrV
    Ck4qQPHI44LE5LCjGxaZoHYawqtbr6hlCZDOUmp+sD/Tsoubb4VIctBbS4pAzARw4jum
    0isQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768559480;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Qq9gdM9vprxxFGgf7/BOYBAvs6L7HF7wuAMDd8isSI=;
    b=J9bPJdT856n2KX3eXWgLXIOXpVWQi0WwHRdk4w/0hS8v11422yZxExNTh68VFeYroi
    qzjBhMQnAOEiqBYoH5DUGqjVTqvCbTb0oa2FjF+3weDTZHhipyX+gKBquO6W22jm5n4p
    HDTyQXW1Y6I9CEKdxOepMpq0du85jAnj2Y0tWNJIsOWFKdIqHDBcj8tPoaTmnvMpdrtB
    8tyxMagcRZPoKvZvrWxAeuugHc5nkFz0l89Ve6wDWP4oJgkIkapwX0nOeuc9iyVX/fNJ
    Tz0WDwJizbEZ4hdFw5lly7CG/x8Js9g1IL4tHusot9Y8O3Ns5pXxsgAfqLgU7QP1BlRN
    orTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768559480;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Qq9gdM9vprxxFGgf7/BOYBAvs6L7HF7wuAMDd8isSI=;
    b=OKn731lLeZsjbtCCngXIr9uYqp0w9zeRbTBjQU7wB8B0P11/k3GLDXZ9G9x2CKDj8e
    5fuTngaZiYnwmGUGvGCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20GAVKAkM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Jan 2026 11:31:20 +0100 (CET)
Message-ID: <f2d293c1-bc6a-4130-b544-2216ec0b0590@hartkopp.net>
Date: Fri, 16 Jan 2026 11:31:14 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
To: Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 davem@davemloft.net
References: <20260112150908.5815-1-socketcan@hartkopp.net>
 <a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Paolo,

freshly created CAN skbs only contain a fixed struct can_frame (16 
byte!) where dev/priority/mark/tstamp are set together with

skb->protocol = htons(ETH_P_CAN);
skb->ip_summed = CHECKSUM_UNNECESSARY;
skb->pkt_type = PACKET_LOOPBACK;

All other settings that are relevant to ethernet/IP are unused and left 
at their initialization values (e.g. network/mac/transport headers or 
inner protocol values).

A single CAN skb can be passed to the driver layer and back several 
times. Because we need to place some additional data along with CAN skbs 
this was formerly stored in a 16 byte private skb headroom (struct 
can_skb_priv).

IIRC we had three issues (KMSAN, etc) with the headroom as someone 
between netif_rx() and can_rcv() was using the headroom for his purposes 
so that the access to struct can_skb_priv via skb->head was broken and 
not reliable for CAN skbs.

Skbs are mostly used for ethernet/IP and developers do not really 
know/care about CAN skbs. That's why this patch set aims to remove 
private CAN skb headroom infrastructure - and to minimize the (risky) 
interaction with other ethernet/IP code.

On 15.01.26 16:37, Paolo Abeni wrote:

> Could you please explain in details why the metadata_dst option has been
> deemed unsuitable?!? I *think* something vaguely alike the following
> would do?!?
> 
> ---
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 1fc2fb03ce3f..d6ee45631fea 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -13,6 +13,13 @@ enum metadata_type {
>   	METADATA_HW_PORT_MUX,
>   	METADATA_MACSEC,
>   	METADATA_XFRM,
> +	METADATA_CAN,
> +};
> +
> +struct can_md_info {
> +	int can_iif;
> +	int len;
> +	int uid;
>   };
> 
>   struct hw_port_info {
> @@ -38,6 +45,7 @@ struct metadata_dst {
>   		struct hw_port_info	port_info;
>   		struct macsec_info	macsec_info;
>   		struct xfrm_md_info	xfrm_info;
> +		struct can_md_info	can_info;
>   	} u;
>   };
> 

Yes. I came to the same simple extensions for data structures but then 
looked into dst_metadata.h and the users code with mallocs, per_cpu 
code, unclone, refcounts, etc. - which was hard to understand for me and 
introduced complexity that is again needed and maintained by ethernet/IP 
users only. Not really appropriate for a CAN skb that transports 16 byte 
of data IMO.

For that reason I propose the common pattern to wrap a union around 
dual-usable skb space, which is simple efficient and easy to understand.

On 15.01.26 16:37, Paolo Abeni wrote:

 > I don't like much that the CAN information are scattered in different
 > places (skb->hash and tunnel header section).

This is not the case. According to the documentation the skb->hash is a 
value used for RPS to identify skbs. We would use it as intended.

And the tunnel header section is marked unused in CAN skbs. By setting 
"skb->encapsulation" to false (the init value) this section is not read 
by anyone. Wrapping a union around this dual-usable skb space is a safe 
solution here.

 > Also it's unclear to me if
 > a can bus skb could end-up landing (even via completely
 > insane/intentionally evil configuration/setup) in a plain netdev 
interface.
 >
 > In the such a case this solution will be problematic.

The CAN drivers and the CAN network layer code always checks the 
processed skbs for ETH_P_[CAN|CANFD|CANXL] and ARPHDR_CAN. So CAN skbs 
created by the CAN netlayer can only be sent to ARPHDR_CAN devices.

The only way to create weird CAN skbs is via PF_PACKET sockets that 
sends ETH_P_CAN skbs to ethernet devices. Beyond such PF_PACKET skbs the 
now suggested CAN skbs would not harm any driver or network layer as the 
described skb settings do not have any problematic content.

Netdev drivers can cope with it and the netlayer code using 
ETH_P_[CAN|CANFD|CANXL] or ETH_P_ALL is fine with it too.

Long story short: Using the common pattern to wrap a union around 
dual-usable skb space is the most efficient and least risky solution IMHO.

Best regards,
Oliver


