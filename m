Return-Path: <linux-can+bounces-6500-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJwoEEKPhGl43QMAu9opvQ
	(envelope-from <linux-can+bounces-6500-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Feb 2026 13:38:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825FF2A5A
	for <lists+linux-can@lfdr.de>; Thu, 05 Feb 2026 13:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4698330055D5
	for <lists+linux-can@lfdr.de>; Thu,  5 Feb 2026 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C23B8D5C;
	Thu,  5 Feb 2026 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aP9MMrLa";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aj8AP0cR"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C263B8D45;
	Thu,  5 Feb 2026 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295075; cv=pass; b=uS0Cb6FK8E2MDx/0Md03SanOxgies6a0n2Y5ycg7ikB7u9Wf6E+D4GAxi6vyjm+LSZ2fGAt9C7xD6ug6t2TKYjfgdFWhnsURMlEKu57nxFCubA56f/y7S/u0HEIQexhLEIhcMGDnLq5wH5WSkwDuxdTrhEGhSYT02jcd87Lwrk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295075; c=relaxed/simple;
	bh=GBMkB4o9WcLTSXKBQt+xzkvNBT0Qhi+eBBuT9O9uzvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2/sx+k+kcpxJ+BzZAPWl/uKrZa6Hq+N9eZEvlV7eY3NyRgf0t6rbPV6Uxq0X6VZH3C3CEXRiXmkeMP1ewobY22aGuMdm/9Iz4unv/ScCiAsaTY3hkS/8gfPPOsx4REDmwnRuCB+3NDlIwQnC+sbBDemQ+nQYn/Yi/butoaqza4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aP9MMrLa; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aj8AP0cR; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1770295061; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UEzyu7y6r53NGbwQ1xsH33PCSbHsOFDXvvoNQFZ9KcutSq//WNr9BDjqwSsuatI8uf
    IuZ7ASdA4lpYWku8tqjz3VbiELrl+hBb5SopAYI7DVXszlxpYNO0diP0/FlJhcKLT6UR
    lmIIVX0BwP4AlvZX5WeAZxt2HztJFwEop+pnduZcZLSeAw7mL4ZQx/BDgCNKTM6PwfCY
    E5jBD/hVuOUVK+dXIBMhioSkvxDoEyNd5HPruYB4jMrOuHzMPbv1125uxxBk887+d+k7
    WcuXaNN5FJmLzE6EsYwinyxMgjjq4KqM59IF8M575jiN1OaRWINOvLPqRgN4ix4DxXAM
    YtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1770295061;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ycObMmukcMI66Lhr9urdh/yvv/CL5qN2yOCXbq4VArg=;
    b=WcYMx6arX6ewkIQVyoGsBSa8aFH5TXH2t0XlguSjHVYooYamDGEANZNcoZullswQT2
    FLOTegJ61yCtPcSKwMi48QU+4aLx/tXr+A7CdbGB8IWJ8xS/Z5fGo/5sXaXjRewnGamx
    Ixf72gd6mHdLp8GN/BuTQl/XoTLXD4cyQ35CyNX9sddXvWtvm5uHsMa91D4CY59/XqpP
    0dDi3MFwgwN3K+LXrXd5Ows4IHYwZ6hJuyM9jrc0mwTNuhrrGVE2H9bnMGSIYSMkNaAQ
    AxrCe5NmwAq7Cy7tc/aV6QDcZQXmWr2Qg/kBwaHEMEPViiVcjzQQyxq9yR00hYoS0hbb
    bmvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1770295061;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ycObMmukcMI66Lhr9urdh/yvv/CL5qN2yOCXbq4VArg=;
    b=aP9MMrLagMWVVcVV27Y5fTKuSiUJTlfJsSKkb1Eu61r1jRYPAhKK5YykBb7noH2MEK
    8d1+rPUcs5dtxvGiZHguBNHjg3ujlueaZS+4f2Z/S9Ed7ENhOa/r6XpR2xYcZF4oDD7o
    4KmPBt1c8QiWlu+8KC0e7+JU8fYCoxaAr80o5VgrASi7x229U0+s8a3LiUKY0xJXAUu3
    tT4OTjNDa8GT2qxghBOKjK7seY1GULhWEbqTl12hCo0d3f1M0IXHxI/nqdoeCgv+6SY6
    8FJlnY+TwqLoUNHMbUAIk54kRrJo3R2rqxGfwk+teS88Ab5P5i+nsSs6KL+RZtscgerK
    9gCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1770295061;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ycObMmukcMI66Lhr9urdh/yvv/CL5qN2yOCXbq4VArg=;
    b=aj8AP0cRBufFHpfJ7EX7zeacBmvHKpOg0BOahsKeb0qWT+GrEqktasWxQxI6GKR0q0
    4JKMyAqu6gibNPe1TVDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka8610215Cbeb8Z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Feb 2026 13:37:40 +0100 (CET)
Message-ID: <89bb75ac-9dca-4593-8a0f-995eefb843c6@hartkopp.net>
Date: Thu, 5 Feb 2026 13:37:40 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <c5929461-8da5-4c77-bf3d-796c7645d7f9@hartkopp.net>
 <c880cc98-7246-4a27-96ca-9c1b9cab9596@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <c880cc98-7246-4a27-96ca-9c1b9cab9596@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6500-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5825FF2A5A
X-Rspamd-Action: no action

On 05.02.26 11:54, Paolo Abeni wrote:
> On 2/3/26 8:19 PM, Oliver Hartkopp wrote:
>> When CONFIG_CAN is enabled the skbuff_ext_cache element would increase
>> in size by 8 bytes (sizeof(struct can_skb_ext)) on my machine (see
>> pahole output below).
>>
>> So when everything is enabled it would be
>>
>> CONFIG_SKB_EXTENSIONS
>> 8  bytes sizeof(struct skb_ext)
>> CONFIG_BRIDGE_NETFILTER
>> 32 bytes sizeof(struct nf_bridge_info)
>> CONFIG_XFRM
>> 88 bytes sizeof(struct sec_path)
>> CONFIG_NET_TC_SKB_EXT
>> 16 bytes sizeof(struct tc_skb_ext)
>> CONFIG_MPTCP
>> 32 bytes sizeof(struct mptcp_ext)
>> CONFIG_MCTP_FLOWS
>> 8  bytes sizeof(struct mctp_flow)
>> CONFIG_INET_PSP
>> 8  bytes sizeof(struct psp_skb_ext)
>> CONFIG_CAN
>> 8  bytes sizeof(struct can_skb_ext)
>> ---------
>> 200 bytes total skbuff_ext_cache element size
>> (255 * 8 = 2040 bytes max space for skb extension users).
>>
>> Does this answer your question?
> 
> Yes, thank you for the collaboration!
> 
> I think there is mistake above: sizeof(struct skb_ext) should be 16 when
> more than 3 skb extensions are enabled.

Oh, yes. You are right!

struct skb_ext {
         refcount_t                 refcnt;               /*     0     4 */
         u8                         offset[7];            /*     4     7 */
         u8                         chunks;               /*    11     1 */

         /* XXX 4 bytes hole, try to pack */

         char                       data[] 
__attribute__((__aligned__(8))); /*    16     0 */

         /* size: 16, cachelines: 1, members: 4 */
         /* sum members: 12, holes: 1, sum holes: 4 */
         /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
         /* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));

After I enabled all kernel configs that would increase the skb 
extensions I just copied the missing pahole structs into the mail - not 
looking for the struct skb_ext again ...

> that means that the total extension size already exceeds the 3
> cachelines (192 bytes) boundary when all extensions are enabled and
> adding the CAN one should not cause any regressions is such scenario.
> 
> Note that the "all skb extensions enabled" is possibly/likely NOT the
> most common/relevant one, but I think there is some space we can squeeze
> elsewhere if needed.

Right.

Many thanks!
Oliver


