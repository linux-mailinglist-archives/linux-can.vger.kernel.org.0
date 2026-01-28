Return-Path: <linux-can+bounces-6337-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE43Fe4Hemn11wEAu9opvQ
	(envelope-from <linux-can+bounces-6337-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 13:58:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E6CA1AF9
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 13:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F5230075D4
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B734FF59;
	Wed, 28 Jan 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MARtANKl";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/4SFIFVt"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145481F19A;
	Wed, 28 Jan 2026 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604980; cv=pass; b=g6hh5kdEPSQYF7ymWsAPFuiOfQvx5ZB4LT88BU4/qqo29PAb5WTUBGHEo+Ipt08Y0vrhyjzDlBucNQ/ukKNPMPl7kpl5DmuWQiNCEt/vPedFWSK+u9vNfWg7N9j8JzrqxHUlfXZPk0HgNenOYxMytqVYP8cc4MBpr8vzYk5Fw7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604980; c=relaxed/simple;
	bh=7f1b7lLSt7KzsBiMqFQxyddM/EoABeMExoSua98AEI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egMt0Pv8fO6n8b/GteZ4D74KzRxtvUCe/+zs4r/UD0ZWMBP0r7Zwy2/D8NLQiY185m4VtbttDdmGeMmh1SRwOJB99731LAZsNsn380PB60in6nXbwEvV3UIeb7+N91/ZyrY6CHRILvxkOlUuLFJ5tODMNsO94FNaobYvIE7DmbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MARtANKl; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/4SFIFVt; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769604785; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=h0Q4KxSWZqZ+ZA6qCN16vafwiyWE0ioFgHOp/+bv0L1qUjYBfXbBPtoGuEeoLi0Ig3
    nHvRk/QF+Dsh+elQ9zbYBICnfXzJS5rn2lO4L6ndQ/emaX0OTOCAkO3driESVRORmnpn
    44G9AByhAFQCgZdYBURPccuvhZxsbvMAz6jaGR6jUiOOM9j59sUtHkwucd05/udZdFUt
    tzURlsQUXQ5tDvcqapCuNLzvz+e4kr/7MQE8+LzcGou67W707bp4IgNGuXeOIcNsd2Y6
    jwKlpUBFcwqu1oYiyuXME3jBlqRofRYU+FhwdDGFuXXjDE6V9H4yhybYe2RkWWef0CWe
    JkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769604785;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Wfcjn4ErLr/aSFLRMwtSn9aEKFoYfsMLh4tx9/f3COM=;
    b=Vr3X1gnUCmPFezcO/AWOObuUWvFTj4j3xx/cjxnf72cADWfA7rCoOZPLc+fmQFYktr
    brj0tv9zW60hpEVhnT26IiKVz2hpnPmj1CyPYqYGROThkToWr2Dtc0JBaPvUl3oZf2lV
    7TxR1U3IzQYRn22HUzSrq6IdMXpSVwa7UqssgbNLu9Iew34l1CPnYvldShyRUPltuZqB
    +AicnS9Ik9ndUb+VuqvDZbcURa2AjGAymKTkuWSUzFEkz2WFaHxUNT5/b4p/kykJTeIr
    kfzhqHScU8EsITq0UdcNBLF94oaC5q93TXhUaW0hOy45AJi9lzRvk3mKB0ZfzbPFDfiu
    aRoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769604785;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Wfcjn4ErLr/aSFLRMwtSn9aEKFoYfsMLh4tx9/f3COM=;
    b=MARtANKlBYR/QOLetF0i980OQM/zUo6KH7HkC4B+dSkrkMwE/tFf1SJZmhpuUC29nH
    Fnu+daTpYbQFNz8Bl8/jyNU7fHkJrqsALa7HlvyofrBf92gKwUILEdhPyrBh2R3xxL4M
    nRcUY0Qq0GEbSubqFpClmYv+hUlYRcFxZhzoanEZKzuFFMkh10OLS3wZNj4sg7RynWM5
    0q7W3iuokN6+PKk3fwRnsHJ9Zqz7VU1BV5/wrdH0X2zisrszVzB8VpZYNLF77P0oh3kv
    jfGvcnwjuw1EWn+UghkqrbIJsGXHpBtzv1u/5zYfvKPDABvVxYYJ92FI+23W9sDWTXXJ
    a2MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769604785;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Wfcjn4ErLr/aSFLRMwtSn9aEKFoYfsMLh4tx9/f3COM=;
    b=/4SFIFVtjVL5c9IhmajFZpmZ3n7m8bdVLI+3eXEh9aEaNy55MESu+Q0nUqLTUyjSlO
    LEc4yrQUHtH7fX3quWDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20SCr4mSU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 13:53:04 +0100 (CET)
Message-ID: <4909066f-cf9c-49ac-b02f-d2e16908bbd9@hartkopp.net>
Date: Wed, 28 Jan 2026 13:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
To: Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org> <aXn0iLuRqdOdcIBN@strlen.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aXn0iLuRqdOdcIBN@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	TAGGED_FROM(0.00)[bounces-6337-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3E6CA1AF9
X-Rspamd-Action: no action



On 28.01.26 12:35, Florian Westphal wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
>> This is fine. Wish we could make md_dst work, since skb_ext still burns
>> a bit in the skb (last extension bit in fact, next user will have to
>> bump the filed size). And you very much do not route these frames,
>> so dst would work perfectly fine. But whatever.
> 
> An alternative would be to 'union' extensions that cannot be
> active at the same time.  Something like the br netfilter extension
> for example.
> 
> When the first extensions were added all of them could be enabled
> at same time, but I think that has changed.

IMO we do not need to 'union' extensions as long as automatic enum 
calculation does it job with the enabled Kconfig options.

My only concern would be distribution kernels that have an all-yes 
config policy ;-)

Btw. while we are at it ...

With my patch set the enum would now look like this:

#ifdef CONFIG_SKB_EXTENSIONS
enum skb_ext_id {
#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
         SKB_EXT_BRIDGE_NF,
#endif
#ifdef CONFIG_XFRM
         SKB_EXT_SEC_PATH,
#endif
#if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
         TC_SKB_EXT,
#endif
#if IS_ENABLED(CONFIG_MPTCP)
         SKB_EXT_MPTCP,
#endif
#if IS_ENABLED(CONFIG_MCTP_FLOWS)
         SKB_EXT_MCTP,
#endif
#if IS_ENABLED(CONFIG_INET_PSP)
         SKB_EXT_PSP,
#endif
#if IS_ENABLED(CONFIG_CAN)
         SKB_EXT_CAN,
#endif
         SKB_EXT_NUM, /* must be last */
};

=> SKB_EXT_NUM is then 7

When we (correctly) add another extension, SKB_EXT_NUM would become 8 
which is still fine IMO. But then the BUILD_BUG_ON check in 
skb_extensions_init() would need the below fix, right?

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 648c20e19038..609851d70173 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5156,11 +5156,11 @@ static __always_inline unsigned int 
skb_ext_total_length(void)
         return l;
  }

  static void skb_extensions_init(void)
  {
-       BUILD_BUG_ON(SKB_EXT_NUM >= 8);
+       BUILD_BUG_ON(SKB_EXT_NUM > 8);
  #if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
         BUILD_BUG_ON(skb_ext_total_length() > 255);
  #endif

         skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",


Should I send a proper patch?

Best regards,
Oliver

