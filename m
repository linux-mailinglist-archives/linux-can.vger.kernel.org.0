Return-Path: <linux-can+bounces-8074-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uOE1N3fhTGrnrQEAu9opvQ
	(envelope-from <linux-can+bounces-8074-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 13:22:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 750CD71AE21
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 13:22:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=GoLZO6zc;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=3mXSIjc6;
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8074-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8074-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E52E93044C13
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA13F5BDD;
	Tue,  7 Jul 2026 11:19:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44A3F1AD7
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 11:19:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423156; cv=pass; b=G0QdW6Iwwo0jrlDfcrrIj8xGlk/Qc7oZ+yDv+D/2sHiRIvMstpsFD+Es0AAGrBg9+fIDREKaL/EzXkiNmA1gPIOVaN88Rg31y5zF/+YRAQ9LyT0ytiLO8j5JWpJ6XqTLDHj2/ddwR6cW3EWC9LReZItTmqOrgpo908PIEt2TQfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423156; c=relaxed/simple;
	bh=JSTuF6LtZ4Pl5wJ+dxLLIzMTT83sCV51zMHu1Q9izcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVYNNhpcE+t1cdnCVsYJzhaBItSwQ29MOlWpTFMEQ+DShTPCho32mnzSgZjl1/pzFxtiAiBwAWsJdlY2K/8+njmO7TG37ySaCFditJl5rupsqPE/501lUjCkqfdGZqENlA12pPLqq2mHdx/vLdMlCz9VB0+v2uCx+fEI9o4g1Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GoLZO6zc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3mXSIjc6; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal: i=1; a=rsa-sha256; t=1783422964; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Cs538x0FwIYNoF1DFTjmbQ/5wsDazqjX17hrDEjdS39g1UEhLFbuR4osmJqeL75PjE
    KcGNQO1Zr8/RVb4k2mF9hKhn7NxU8kLDzFOLZLyBFDLDYUj1afVo/ZktSQaDJtT7kUfT
    TyxlM0IiQi/SGI0ym4YY/iTMSO4frs4m2qrZf5cM/z8yxRByuwhz+u/7oM6rlo162oZq
    +sZF6mNKm1KIjp9i7/gQtyKVQTFOX1E6s1MpKDQPoRYV1On8kCDHLyrMRJydwXJbAWDw
    qQJMVsVscx3AZ5/PawgusOl5maYEz38fgytBUbgcB2PltrXJpWj2u3AxcUQGF34FCAwg
    f3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783422964;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1NaFoHQsqCkc3NBemvV7RQrKxBxP4mb+yhYBqiPJwZM=;
    b=AxhAi/HF8iBmo7JavDl0cwM/Y+O4OVuWXdm80vDIrflk51H2jLvcP8CgbdvPQtRhJh
    qLwi21JcCtgsG8qmEyimn3ev9RtzrTC+vQFfDYs5CLeFfjtvOcxUIte2u9Rm2QBi9n6O
    ECuxS935Xe1prjJ49/qHYkDU5AvvNHLgfWXkXVVNlQHhxDtVpQE19vWsG+3JhO75m2GB
    v74b8vCiFgdBCuiRrjReBL5mA2tn+ie8Coj1IWURs9nZVfNAKrb7TymL20qrg7nnFwyH
    L5cQ0YIK9M+GJGvcMlQCK+FIKAADGLSg1cRQre0AZR0goP2QDcM1/ftmGTy2J7QNYuI6
    EdTQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783422964;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1NaFoHQsqCkc3NBemvV7RQrKxBxP4mb+yhYBqiPJwZM=;
    b=GoLZO6zc7crzOqWjQdGVmpvNtOE+oeMr4i/p/bsR8ZkNiEXbu65FWYkgs+9ry5jEb1
    EIC0yJFvZ85fL1qdh4rR7gpu4FN3eHGjwFZK87V78v2HDVYHYqZ77y6rnX9efIVKnsyR
    1yxmi/nqkGe1RD3nF5YTihVjoQQBa+VVZ32z11Uc9/aKssYURFOASFp4YjouvOI66vyx
    Rg8Fenb1PnT4ClKg5iJOkCvDYiSSW4Ks/r8GfAxJtZn3iBxP08TFpQNmQqCRlwu+Byo5
    PLso7wVirzj5dgksj2sbw08NOEEzRVesdxk9XVq4gUuhLKS6yyKqDfrXIKqepX+fQ+M9
    F1Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783422964;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1NaFoHQsqCkc3NBemvV7RQrKxBxP4mb+yhYBqiPJwZM=;
    b=3mXSIjc6VlKsIKXcNg1h8JpSr6WErzzzDXZN8afGmlBsjz6w307wXCE9ahJrppDWTK
    6/z+NPa9VYhHjgdUzdDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.154]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb267BG3Sk3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 13:16:03 +0200 (CEST)
Message-ID: <cad6842a-67ab-44b4-bfa9-60b9015465df@hartkopp.net>
Date: Tue, 7 Jul 2026 13:16:03 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
To: sashiko-reviews@lists.linux.dev
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-2-84600ca6d889@hartkopp.net>
 <20260707102931.A5E091F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707102931.A5E091F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8074-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hartkopp.net:from_mime,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 750CD71AE21



On 07.07.26 12:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unprotected and non-RCU-safe list manipulations on `bo->tx_ops` and `bo->rx_ops` cause data races with lockless procfs readers.

Fixed in patch 5:
https://lore.kernel.org/linux-can/20260707-bcm_fixes-v3-5-84600ca6d889@hartkopp.net/

> - [High] Concurrent update of `op->frames` causes a data race with softirq CAN TX processing, sending corrupted frames.

Fixed in Patch 3:
https://lore.kernel.org/linux-can/20260707-bcm_fixes-v3-3-84600ca6d889@hartkopp.net/

> - [Medium] Concurrent update of `op->frames` causes a data race with softirq CAN RX processing.
> --

Fixed in Patch 3:
https://lore.kernel.org/linux-can/20260707-bcm_fixes-v3-3-84600ca6d889@hartkopp.net/

> 
> --- Patch [2]: [PATCH v3 2/7] can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure ---
> commit 8b8711c2150aeadcb80c48a64d2a2f7206bc9502
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
> 
> This commit fixes a race condition where bcm_sendmsg() could read an
> inconsistent bo->bound and bo->ifindex state during concurrent socket
> operations. It addresses this by moving the ifindex read and bound validation
> inside lock_sock(). The patch also fixes bcm_rx_setup() to correctly return
> -ENODEV instead of silently succeeding when a device disappears concurrently.
> 
> Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index bdf53241bd7b3..b612135b017d1 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> [ ... ]
>> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   
>>   				op->rx_reg_dev = dev;
>>   				dev_put(dev);
>> +			} else {
>> +				/* the requested device is gone - do not
>> +				 * silently succeed without registering
>> +				 */
>> +				err = -ENODEV;
>>   			}
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does the concurrent update of
> op->frames cause a data race with softirq CAN RX processing?
> 
> In bcm_rx_setup(), when updating an existing RX filter, the code copies from
> userspace without excluding the softirq path:
> 
> bcm_rx_setup() {
>      ...
>      err = memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
>      ...
> }
> 
> Since memcpy_from_msg() can sleep and the CAN RX softirq runs concurrently,
> bcm_rx_cmp_to_index() might execute mid-update. It locklessly reads op->frames
> and op->last_frames to match multiplexed CAN frames:
> 
> bcm_rx_cmp_to_index() {
>      ...
>      if ((get_u64(cf, i) & get_u64(rxdata, i)) != (get_u64(cf, i) & get_u64(lcf, i))) {
>      ...
> }
> 
> Can this lead to torn reads where the BCM spuriously triggers or fails to
> trigger filter updates based on corrupted matching data?
> 
> [ ... ]
>> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> [ ... ]
>>   	switch (msg_head.opcode) {
>>   
>>   	case TX_SETUP:
> 
> [Severity: High]
> This is a pre-existing issue, but do these list insertions lack RCU write
> barriers?
> 
> bcm_proc_show() iterates bo->tx_ops and bo->rx_ops locklessly using
> rcu_read_lock(). However, bcm_tx_setup() and bcm_rx_setup() insert new
> elements using list_add() instead of list_add_rcu(), which lacks the
> smp_store_release() write barrier required to safely publish initialized
> bcm_op structs to concurrent RCU readers.
> 
> Additionally, bcm_proc_show() appears to use the non-RCU list_for_each_entry()
> macro for bo->tx_ops, omitting the required read barrier. Could an unprivileged
> local user reading /proc/net/can-bcm/* concurrently trigger a panic?
> 
> [Severity: High]
> This is another pre-existing issue, but does a similar concurrent update of
> op->frames cause a data race with softirq CAN TX processing?
> 
> In bcm_tx_setup(), when updating an existing TX operation, memcpy_from_msg()
> overwrites the payload in op->frames without acquiring op->bcm_tx_lock or
> excluding the softirq:
> 
> bcm_tx_setup() {
>      ...
>      err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
>      ...
> }
> 
> Concurrently, the hrtimer callback bcm_tx_timeout_handler() can fire and invoke
> bcm_can_tx(). bcm_can_tx() retrieves the frame pointer under the lock, but
> accesses the underlying frame data locklessly outside the lock:
> 
> bcm_can_tx() {
>      ...
>      skb_put_data(skb, cf, op->cfsiz);
>      ...
> }
> 
> Could this allow the softirq to transmit a partially updated or torn CAN frame
> onto the physical CAN bus?
> 


