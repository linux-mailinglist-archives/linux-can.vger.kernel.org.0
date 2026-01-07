Return-Path: <linux-can+bounces-6028-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF86CFFA97
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 20:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5B9E30069B3
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673F318EE0;
	Wed,  7 Jan 2026 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Mm9zf2Iq";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AX/mQRph"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8AC31326C;
	Wed,  7 Jan 2026 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813070; cv=pass; b=UeGcBeQpuczZ2JZ2V6PS2ZuoNksHJwO1bFpr+7OBPnNdKIHX4xgsZ4We2sOjjts4zGLvvOgHqqyhwfinx/EMxUfBAI35GLB3cykrK9E0U6XNcseYyRbt+vGlk9DK5e8g0UMC/ocxDJ4pmQs27wpD8lA7giV82d8sKXvpJb2AtRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813070; c=relaxed/simple;
	bh=7/6P5kqhrnH/hdP9OHNW7wYS0aD/dIDyDiQdzcLXx4A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZHSv4DhjgQX0vnhvNL0MDg/jY97H5DV7XhRg1gZX1XVWZ/dPSmsAjtHSmVpO384W1JgcCwxquKA/SWRbZveW8p63G0QvS/cwnzgR0jDyEM1prUkTgS6nI4ojzsbAS73+avKINwcLL8bjOo1NqJufM1JMljxMhIlMaOfIKvqUaxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Mm9zf2Iq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AX/mQRph; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767813058; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wxyn/xnJAa3hLwfgwX8p7h1gmBR2SPKmeGXxhXYJBycPQv26VT3W4zfby7LsMbfhGD
    SRcem+JppwGQdgp8hd4fK4Zh6C9NL4QxdDjR1AWHpgvi5x1B+SxMpqawz6y7/71DIgWU
    dawspC7vRuepszVWA+AtkCidnNLoilmpPeMa2gbc0T1bbExjXQoduqSFDQZA3XkSDCxC
    /AKge0cq7ywAnQErgj6GkATKRMa07pZ3+N4d8rYoXheJ+hKNuC+lFvL+8GjqWJAonAf5
    +ZoJ3DyDhspeqNWlvk0dwkeMcafwELHC3HWYecG6Dig3tx+AALyT54VIvjY5rr+iiL00
    VFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767813058;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cuuyyK8AJB1JvCg5cXPQk2zK10JVAUsDNfYmLT6RYIM=;
    b=HuGcE/truZiA8gdvslQfjMU5Q6xBY1TNlskbxyub4dtqpjUiW7izsunRlH2M4BqoBm
    vS1hRQT1C6GdmWYYPF5FNXE/HmlGA8IAR8fXGvRxZyCxa8hDbnu7gT1Ig03vzy5HpLWY
    Ue8ogjhI7WTBI6WB6EvkP92dI8FiUI2Dc6pv2XbOUuqQt2XXnQUtCyhVqEyZCFWPP/0p
    BiV4C+D2qNdHdPD7/MROQFCB8vbMIR6LCJ3ylCJq3p7YpPygDntIBAvag2BmWwh4hpXp
    c1+jXWmYA3d+vywZvf1LOyAHlGlvHX753tnrDjm98ZwRFlFaP6NAGWMxMNKxQYa0oBRt
    pPTQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767813058;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cuuyyK8AJB1JvCg5cXPQk2zK10JVAUsDNfYmLT6RYIM=;
    b=Mm9zf2Iqz5r+k0zhYmLXQYxTQXWyDZ8hZWLD/ggpY87wSsWXKKMuHZCiX4p3wMQioy
    NkRgD7QViPkQjdQqJpUCWMpv7vRkKbcyy81LJEH//vHTC3e9u8xsMnu6mh6Hc3071wXU
    aj4V/5/6dUK3/glSyn9o5voTcdcQPwZBgA7dTKJZbxVlm/iVEDDqkxg6sixob1BF3YZ8
    nL3QLP7YLlBBTU1t8zAo5D4G36C6KAADPuEGwoX8Bk8zJtJF8yjlsRgotP9DjfxmfF2o
    6ERh4a9maRa584+L7uMgDb7Qu7qiahlD3MPW18vISFgTc6wh9CXgy9Di1NJqHSahgz/8
    Ckcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767813058;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cuuyyK8AJB1JvCg5cXPQk2zK10JVAUsDNfYmLT6RYIM=;
    b=AX/mQRphzdB5pBq0iUsNYv9CyC7jVzb92JYqtx9J9Mlbx7jCv5HXnbnW9C0CuCQLdJ
    NUShLJ72x+digueIiGCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b207JAwEgV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 7 Jan 2026 20:10:58 +0100 (CET)
Message-ID: <2af792de-77a0-4f77-a6b8-f207089b94b6@hartkopp.net>
Date: Wed, 7 Jan 2026 20:10:57 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkl@pengutronix.de, Prithvi <activprithvi@gmail.com>, andrii@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
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
 <fac5da75-2fc0-464c-be90-34220313af64@hartkopp.net>
 <20260105152638.74cfea6c@kernel.org>
 <904fa297-b657-4f5b-9999-b8cfcc11bfa9@hartkopp.net>
 <20260106162306.0649424c@kernel.org>
 <8b55ae26-daba-4b2e-a10b-4be367fb42d0@hartkopp.net>
Content-Language: en-US
In-Reply-To: <8b55ae26-daba-4b2e-a10b-4be367fb42d0@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry for answering myself:

The below idea using skb->cb definitely does not work :-/

But as we never use encapsulation in CAN skbs we can use the 
inner_protocol and inner_xxx_header space when skb->encapsulation is false:

	union {
		/* encapsulation == true */
		struct {
			union {
				__be16		inner_protocol;
				__u8		inner_ipproto;
			};

			__u16			inner_transport_header;
			__u16			inner_network_header;
			__u16			inner_mac_header;
		};
		/* encapsulation == false */
		struct {
			int can_iif;
			__u16 can_frame_len;
		};
	};


Best regards,
Oliver

On 07.01.26 16:34, Oliver Hartkopp wrote:
> Hello Jakub,
> 
> On 07.01.26 01:23, Jakub Kicinski wrote:
>> On Tue, 6 Jan 2026 13:04:41 +0100 Oliver Hartkopp wrote:
>>> When such skb is echo'ed back after successful transmission via
>>> netif_rx() this leads to skb->skb_iif = skb->dev->ifindex;
>>>
>>> To prevent a loopback the CAN frame must not be sent back to the
>>> originating interface - even when it has been routed to different CAN
>>> interfaces in the meantime (which always overwrites skb_iif).
>>>
>>> Therefore we need to maintain the "real original" incoming interface.
>>
>> Alternatively perhaps for this particular use case you could use
>> something like metadata_dst to mark the frame as forwarded / annotate
>> with the originating ifindex?
> 
> I looked into it and the way how skb_dst is shared in the union behind 
> cb[] does not look very promising for skbs that wander up and down in 
> the network layer. And it is pretty complex to just store a single 
> interface index integer value.
> 
> While looking into _sk_redir to see how the _skb_refdst union is used, 
> I've seen that the _sk_redir function was removed from struct tcp_skb_cb 
> (commit e3526bb92a208).
> 
> Today we use skb->cb only for passing (address) information from the 
> network layer to the socket layer and user space. But the space in cb[] 
> could also hold the content we currently store in the problematic skb 
> headroom.
> 
> Would using skb->cb be a good approach for CAN skbs (that do not have 
> any of the Ethernet/TCP/IP requirements/features) or will there still be 
> networking code (besides CAN drivers and CAN network layer) that writes 
> into cb[] when passing the CAN skb up and down in the stack?
> 
> /**
>   * struct can_skb_cb - private data inside CAN skb->cb
>   * cb[] is 64 bit aligned which is also recommended for struct 
> sockaddr_can
>   * @magic:    to check if someone wrote to our CAN skb->cb space
>   * @flags:    extra flags for CAN_RAW and CAN_BCM sockets
>   * @can_addr:    socket address information to userspace
>   * @can_iif:    ifindex of the first interface the CAN frame appeared on
>   * @skbcnt:    atomic counter to have an unique id together with skb 
> pointer
>   * @frame_len:    bql length cache of CAN frame in data link layer
>   */
> struct can_skb_cb {
>      u32 magic;
>      u32 flags;
>      struct sockaddr_can can_addr;
>      int can_iif;
>      int skbcnt;
>      unsigned int frame_len;
> };
> 
> If not: We also don't have vlans nor inner[protocol|headers] in CAN 
> where we might store the 4 byte can_iif integer ...
> 
> Many thanks and best regards,
> Oliver


