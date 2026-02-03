Return-Path: <linux-can+bounces-6484-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKSgNGFKgmmGRwMAu9opvQ
	(envelope-from <linux-can+bounces-6484-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 20:20:01 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42949DE1D7
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C7C3015CAE
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 19:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75B31AF36;
	Tue,  3 Feb 2026 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F4xiqoXv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rfX7FFgs"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0623D2B1;
	Tue,  3 Feb 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146396; cv=pass; b=Zcdc0o7ba/EmplgqtuH0cXbq/FKU3lLxvA61jI/0B/AYc3EWdh5DILRb1nYVCb8VZxRJF3zW1pP7GVnuKHanE5YNbARfGmO2ykVaY4a3xAz4JTQkXRjR7QEhl7F6PgSTdctHrx9KLfGHVUQKzJvxLj7Gl6NWE+U+KSSDo+RpUuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146396; c=relaxed/simple;
	bh=Eu32B2kTrLqGd8xnvrrM3BNC67bXjwiwiB/WLW42Wc8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UO2S1Iv9O2MaZPBVB1maU0l0LUwCrznF4Jiwp5jNMkmcWJSJiMsX0MEnbilWHgCswJxeAs8d6OZdnLxoANOAsEW/BMYBB8K6k/TVCeX3uKgVQkfaENQZTPerf43OpmKNQ5ffMHiDzhhesey415KcG8Gt1JZoZIiGdK6o0u1e1eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F4xiqoXv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rfX7FFgs; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1770146380; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a1TlrfctBhyp3PACtFwVbpgDyATKdQ4RXez+vewnUIp13E40AjwAsKinI2bHKyz+7Y
    SMl1n8LLBYcU+umZfHwfecPSZWZQXB4jZ3LTb618PWJg1dfc6UCyBK3v0QBqQE4/BACH
    Pruw3FvyJYUwIg768uBdLkRS9LJLa2KNOsmvWHBUFDUzZNYxngllaCNmQacxxXcN7ncF
    itMHQoK8akPnPGIZonVhm78jVn3ISobZte09FpwXrxQH0ycGdNBTjePKnY06YTIOjOm2
    AFoF4tfgUbBVmcCUjbLrJnwOPW48MKMve59wiXmF5arvTwMuOhKr37g+xSw18Ami2JFJ
    dKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1770146380;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:Subject:From:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F5jFldpNkmwZqtNurvra9cofNKkaRsKmUCDCcCnHqNc=;
    b=TfBEYXZ2d5/wTpR4EZf/+MJbhhujtMXzy5SxXWD+WS6pijqJVOvkHPWmy8MTAZTf+U
    XeNwrZdH1xpcTHCxYGfyK0BsRmcXm80umxqzYYjoncH6tnKXF/0s5wqPolkOntTkYz4M
    AmqCKaC7/fLVaB9XOkatXRXCfv0eRyJfZ07ealIco878o8VGv+TDMsftZrfFKBfaAY6t
    P19wKlgjVs6pLAhVh3XS2qIQwA0GOBWsR2dkjVnGAs7mOst8c0FZNVuqHKpNps4mURDN
    qU6zDBPZ2vYSRTXiyGfiJ/Bvo5XnYiuZtqSX/YrXUBPYcMzQFjUo/f7EMLuPCMQNt/+E
    OwlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1770146380;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:Subject:From:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F5jFldpNkmwZqtNurvra9cofNKkaRsKmUCDCcCnHqNc=;
    b=F4xiqoXvgXXDuFw0EVfApOSSh9iLWtZ6d1tSGjanmMvTHF7DQP0/xhTzHDjYuMWjrJ
    Rk/z001mwonh4ZTXSdQxLo2G9ApE52vR+3cP0/2gdpM56qovG7tdW4UJ5Ctuf5s94bQN
    V9XBcNDEE5MMfYC+yKamoHRGv05S4rBm4B+R/19Y5bDlCszmZ5gwjkpwFJpte2Bsltdp
    IsSe0+LZWnRu8knf6/2GzuzXx9REZvqeUS2oNN8a/CBFpVEgiWl1mo+Fu6iMANa7xIgX
    sFHw/xa1JcVxCs4hpKWjAXP24vhtj1CtZ2MYrHsruraQgXHvEhGY5y+zDyI7NHuk70Qw
    u4lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1770146380;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:Subject:From:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F5jFldpNkmwZqtNurvra9cofNKkaRsKmUCDCcCnHqNc=;
    b=rfX7FFgsBvHFnsvxr1Pkaw+S0xjleRooWxZBdHgomV9TfOlrHtXGBJLl/B9NOMfoRA
    uhs6l5dLCw6oj9lLA+Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka8610213JJcRT6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Feb 2026 20:19:38 +0100 (CET)
Message-ID: <c5929461-8da5-4c77-bf3d-796c7645d7f9@hartkopp.net>
Date: Tue, 3 Feb 2026 20:19:31 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next v8 0/6] move CAN skb headroom content to skb
 extensions
To: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
 <7d544645-8699-409f-89c0-6fc606113627@redhat.com>
Content-Language: en-US
In-Reply-To: <7d544645-8699-409f-89c0-6fc606113627@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6484-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:mid,hartkopp.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42949DE1D7
X-Rspamd-Action: no action

Hello Paolo,

On 03.02.26 15:40, Paolo Abeni wrote:
> On 2/1/26 3:33 PM, Oliver Hartkopp via B4 Relay wrote:
>> CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
>> CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data. Those
>> CAN skbs do not have network/mac/transport headers nor other such
>> references for encapsulated protocols like ethernet/IP protocols.
>>
>> To store data for CAN specific use-cases all CAN bus related skbuffs are
>> created with a 16 byte private skb headroom (struct can_skb_priv). Using
>> the skb headroom and accessing skb->head for this private data led to
>> several problems in the past likely due to "The struct can_skb_priv
>> business is highly unconventional for the networking stack." [1]
>>
>> This patch set aims to remove the unconventional skb headroom usage for CAN
>> bus related skbuffs and use the common skb extensions instead.
>>
>> [1] https://lore.kernel.org/linux-can/20260104074222.29e660ac@kernel.org/
> 
> Could you please share how skb_ext size change with this series?
> (possibly breaking down the actual size to each separate extension).
> 
> Ideally/hopefully the  skbuff_ext_cache size is not going to change, and
> that would ensure that this change will not cause any indirect regressions.
> 
> /P

I'm not really sure what your question is about and how I could actively 
change the impact of this series.

When CONFIG_CAN is enabled the skbuff_ext_cache element would increase 
in size by 8 bytes (sizeof(struct can_skb_ext)) on my machine (see 
pahole output below).

So when everything is enabled it would be

CONFIG_SKB_EXTENSIONS
8  bytes sizeof(struct skb_ext)
CONFIG_BRIDGE_NETFILTER
32 bytes sizeof(struct nf_bridge_info)
CONFIG_XFRM
88 bytes sizeof(struct sec_path)
CONFIG_NET_TC_SKB_EXT
16 bytes sizeof(struct tc_skb_ext)
CONFIG_MPTCP
32 bytes sizeof(struct mptcp_ext)
CONFIG_MCTP_FLOWS
8  bytes sizeof(struct mctp_flow)
CONFIG_INET_PSP
8  bytes sizeof(struct psp_skb_ext)
CONFIG_CAN
8  bytes sizeof(struct can_skb_ext)
---------
200 bytes total skbuff_ext_cache element size
(255 * 8 = 2040 bytes max space for skb extension users).

Does this answer your question?

Best regards,
Oliver

static const u8 skb_ext_type_len[] = {
#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
         [SKB_EXT_BRIDGE_NF] = SKB_EXT_CHUNKSIZEOF(struct nf_bridge_info),
#endif
#ifdef CONFIG_XFRM
         [SKB_EXT_SEC_PATH] = SKB_EXT_CHUNKSIZEOF(struct sec_path),
#endif
#if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
         [TC_SKB_EXT] = SKB_EXT_CHUNKSIZEOF(struct tc_skb_ext),
#endif
#if IS_ENABLED(CONFIG_MPTCP)
         [SKB_EXT_MPTCP] = SKB_EXT_CHUNKSIZEOF(struct mptcp_ext),
#endif
#if IS_ENABLED(CONFIG_MCTP_FLOWS)
         [SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
#endif
#if IS_ENABLED(CONFIG_INET_PSP)
         [SKB_EXT_PSP] = SKB_EXT_CHUNKSIZEOF(struct psp_skb_ext),
#endif
#if IS_ENABLED(CONFIG_CAN)
         [SKB_EXT_CAN] = SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
#endif
};

CONFIG_SKB_EXTENSIONS
struct skb_ext {
         refcount_t                 refcnt;               /*     0     4 */
         u8                         offset[3];            /*     4     3 */
         u8                         chunks;               /*     7     1 */
         char                       data[] 
__attribute__((__aligned__(8))); /*     8     0 */

         /* size: 8, cachelines: 1, members: 4 */
         /* forced alignments: 1 */
         /* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));

CONFIG_BRIDGE_NETFILTER
struct nf_bridge_info {
         enum {
                 BRNF_PROTO_UNCHANGED = 0,
                 BRNF_PROTO_8021Q     = 1,
                 BRNF_PROTO_PPPOE     = 2,
         } orig_proto:8;                                    /*     0: 0 
4 */

         /* Bitfield combined with next fields */

         u8                         pkt_otherhost:1;      /*     1: 0  1 */
         u8                         in_prerouting:1;      /*     1: 1  1 */
         u8                         bridged_dnat:1;       /*     1: 2  1 */
         u8                         sabotage_in_done:1;   /*     1: 3  1 */

         /* XXX 4 bits hole, try to pack */

         __u16                      frag_max_size;        /*     2     2 */
         int                        physinif;             /*     4     4 */
         struct net_device *        physoutdev;           /*     8     8 */
         union {
                 __be32             ipv4_daddr;           /*    16     4 */
                 struct in6_addr    ipv6_daddr;           /*    16    16 */
                 char               neigh_header[8];      /*    16     8 */
         };                                               /*    16    16 */

         /* size: 32, cachelines: 1, members: 9 */
         /* sum members: 30 */
         /* sum bitfield members: 12 bits, bit holes: 1, sum bit holes: 
4 bits */
         /* last cacheline: 32 bytes */
};

CONFIG_XFRM
struct sec_path {
         int                        len;                  /*     0     4 */
         int                        olen;                 /*     4     4 */
         int                        verified_cnt;         /*     8     4 */

         /* XXX 4 bytes hole, try to pack */

         struct xfrm_state *        xvec[6];              /*    16    48 */
         /* --- cacheline 1 boundary (64 bytes) --- */
         struct xfrm_offload        ovec[1];              /*    64    24 */

         /* size: 88, cachelines: 2, members: 5 */
         /* sum members: 84, holes: 1, sum holes: 4 */
         /* last cacheline: 24 bytes */
};

CONFIG_NET_TC_SKB_EXT
struct tc_skb_ext {
         union {
                 u64                act_miss_cookie;      /*     0     8 */
                 __u32              chain;                /*     0     4 */
         };                                               /*     0     8 */
         __u16                      mru;                  /*     8     2 */
         __u16                      zone;                 /*    10     2 */
         u8                         post_ct:1;            /*    12: 0  1 */
         u8                         post_ct_snat:1;       /*    12: 1  1 */
         u8                         post_ct_dnat:1;       /*    12: 2  1 */
         u8                         act_miss:1;           /*    12: 3  1 */
         u8                         l2_miss:1;            /*    12: 4  1 */

         /* size: 16, cachelines: 1, members: 8 */
         /* padding: 3 */
         /* bit_padding: 3 bits */
         /* last cacheline: 16 bytes */
};

CONFIG_MPTCP
struct mptcp_ext {
         union {
                 u64                data_ack;             /*     0     8 */
                 u32                data_ack32;           /*     0     4 */
         };                                               /*     0     8 */
         u64                        data_seq;             /*     8     8 */
         u32                        subflow_seq;          /*    16     4 */
         u16                        data_len;             /*    20     2 */
         __sum16                    csum;                 /*    22     2 */
         u8                         use_map:1;            /*    24: 0  1 */
         u8                         dsn64:1;              /*    24: 1  1 */
         u8                         data_fin:1;           /*    24: 2  1 */
         u8                         use_ack:1;            /*    24: 3  1 */
         u8                         ack64:1;              /*    24: 4  1 */
         u8                         mpc_map:1;            /*    24: 5  1 */
         u8                         frozen:1;             /*    24: 6  1 */
         u8                         reset_transient:1;    /*    24: 7  1 */
         u8                         reset_reason:4;       /*    25: 0  1 */
         u8                         csum_reqd:1;          /*    25: 4  1 */
         u8                         infinite_map:1;       /*    25: 5  1 */

         /* size: 32, cachelines: 1, members: 16 */
         /* padding: 6 */
         /* bit_padding: 2 bits */
         /* last cacheline: 32 bytes */
};

CONFIG_MCTP_FLOWS
struct mctp_flow {
         struct mctp_sk_key *       key;                  /*     0     8 */

         /* size: 8, cachelines: 1, members: 1 */
         /* last cacheline: 8 bytes */
};

CONFIG_INET_PSP
struct psp_skb_ext {
         __be32                     spi;                  /*     0     4 */
         u16                        dev_id;               /*     4     2 */
         u8                         generation;           /*     6     1 */
         u8                         version;              /*     7     1 */

         /* size: 8, cachelines: 1, members: 4 */
         /* last cacheline: 8 bytes */
};

CONFIG_CAN
struct can_skb_ext {
         int                        can_iif;              /*     0     4 */
         u16                        can_framelen;         /*     4     2 */
         u8                         can_gw_hops;          /*     6     1 */
         u8                         can_ext_flags;        /*     7     1 */

         /* size: 8, cachelines: 1, members: 4 */
         /* last cacheline: 8 bytes */
};

