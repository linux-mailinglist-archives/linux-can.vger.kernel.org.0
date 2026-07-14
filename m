Return-Path: <linux-can+bounces-8396-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id smnUKHkTVmpWywAAu9opvQ
	(envelope-from <linux-can+bounces-8396-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:46:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14767753892
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:46:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=YA4RyMD8;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=77YQDKci;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8396-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8396-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27C0B300653B
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5403002B9;
	Tue, 14 Jul 2026 10:46:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99061EFFA1
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:46:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025974; cv=pass; b=Z2ozRNNB31eALcr0Mbaayf5KE0QbHNsAnDs2YLoOAV3WrkJNPAwGnaU83adxiIFrhE5B9QqEpXkuBBAapSdq1eQ+zBe3aVQ8ofjtZ55KcpSwGbJTXlZ3fJXZ/XsYB6GdMmUocfR6SQynbSZe5EReOdq1ZzbMJrtluIdx46++Bb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025974; c=relaxed/simple;
	bh=tSNyZ2cS2QdnGKKietIW2zZNfj2/GjawKXO6CWpCC/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehPCcbnVmFVPs5c3ZtWVDiixvr4QRMdjvJPNnHQ7BrkEhK3KZ3ah2qcU0wzlMCrHoY8rHBUWh+eV2KqNB11bNHjrNfxHK30VjIbOwF++I74Hj+IGDod+A8kTXoFFf5Bvs4U8NJanjjB7EUYvERIkka3YBvlYsjc7ZQQdDmoqNL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YA4RyMD8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=77YQDKci; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal: i=1; a=rsa-sha256; t=1784025967; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y3gyvhMdkZR3CS36areYtxmk6UQXy/VuX+s8EcDCkCI48FiLBzWg36ovFXEVQ9vtYJ
    g8jtveo1eSwu6By4d8HfaYvhHVw9IYZodwGiYYGKCvNkgWaZC2kr5ILGtxr/FPWoDQTE
    VjoeAWiM2VP6QvtRxIvplbjKadDOckmtls+Xh4RGLBz1rytaraxmOVOqMwNmFBbESb0b
    ucZyHFXrD1E2SsfaK6nvxHIC9CMzKMGQN41dNpXWa2b2v/bcVs0HCocFtYAsxdPMn4Ot
    Lo/nbFb/wehiE46JNSV5DQC0CRORKPLU52EH/jOZ7YZeSBd8QZbPJ375vtBXoq2rRfZF
    A8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025967;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PL4uF5S6bxoSH1oZ57EmOcoXDVAB98ojwXO3EqjS5nc=;
    b=X8RLsc5dsJChWKYfStnIcl/RWj6gom0ouJW04TUt/wbtEzAgEBrETZCrNmXN2rmvmA
    hlO/4qpiYn727SZwu2f9WyVJlQ+ZldJ9RVrfpznCJOCkHnfXRYq0gmiuXI2W7z/AAy6o
    SnUQWJaLJqIt3ajn+zjFLKQc+eZj1wgjaPk2oiBmeL2AWGFqn/1oeYXGWj/xdhyyjfpZ
    Qmmj36RWv5Jvc9H2uDG9q8WRP+CKErC3n5pzBOOCBYV7NImBZ6TiWltLTdcB8RGm88Lh
    Pp+r5nLqZakkf1YK5jArhoaVCjB6512SqIFFdUWnllIfI96CRN6PhOWch75z9fED+iTG
    /qUA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025967;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PL4uF5S6bxoSH1oZ57EmOcoXDVAB98ojwXO3EqjS5nc=;
    b=YA4RyMD8sWKeWFp+R3KKQ257ylCNIUUMwdlCRtGla3nKPdF55kBnPC78WRTnhPMsjb
    bF50CA3/IZSA3Aw9jA+etrSCtAuLTfvLUCqm2EhHtpAv1T6jSTOhjQt9YQtEFGw826Cb
    VRqxc6VQZTVH+bUHgtCdJx95zEtVx2sIekJmVMgIhBqg83lf/WYi+VUSGI1Fy7YEhqD9
    8ZcEr6NmoPw8oboz0csPQiZ1D6akvGgz804OaWyiswbYOjslzPhAhuqbkJF68cVtrlyS
    Ki04zA1wUx9ERLUUFaHwHfFlvNCjdxk+FIAmhqqWp/upKL/YyrFnFssQDHKGWZmUIU+T
    RP3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784025967;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PL4uF5S6bxoSH1oZ57EmOcoXDVAB98ojwXO3EqjS5nc=;
    b=77YQDKci9L0J6RUFs7gfMn/hXzWzXj+qsq5qfw2MBPnYpJm8kCatw4yKJ5GUq5bs7I
    DgCbOjfIdlWv2vUJKVDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EAk6jBJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 12:46:06 +0200 (CEST)
Message-ID: <a4ff0df6-4101-41c1-81c9-d0d2b6913d9a@hartkopp.net>
Date: Tue, 14 Jul 2026 12:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/11] can: bcm: add missing rcu list annotations and
 operations
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-5-fd667c61099a@hartkopp.net>
 <20260714103234.2F1681F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714103234.2F1681F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8396-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:from_mime,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14767753892



On 14.07.26 12:32, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] In `bcm_tx_setup()`, when updating an existing `bcm_op`, the CAN frames array (`op->frames`) is overwritten directly from userspace data using `memcpy_from_msg` without holding `bcm_tx_lock` and without using a staging buffer. This introduces a data race with concurrent transmission. Crucially, the direct overwrite stores user-provided frames into the active array before length validation. If an invalid length is provided, the function subsequently returns an error, but the corrupted frame remains active in `op->frames`. Concurrent or subsequent timer executions will transmit this malformed frame to the CAN driver, leading to out-of-bounds accesses and kernel panics.
> - [Medium] Timer values in `bcm_tx_setup()` (`op->kt_ival1` and `op->kt_ival2`) are updated directly without holding `bcm_tx_lock`. Concurrently, `bcm_tx_timeout_handler()` running in softirq context reads these 64-bit `ktime_t` values without locks. On 32-bit architectures, this leads to torn reads, causing unpredictable timer behavior.
> --
> 

Fixed in patch 6

> --- Patch [5]: [PATCH v13 05/11] can: bcm: add missing rcu list annotations and operations ---
> commit 74409df5d31bac1c2081de9ebaae45419726cd9c
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: add missing rcu list annotations and operations
> 
> This commit addresses missing list_add_rcu() and list_del_rcu() calls in
> the CAN broadcast manager to properly initialize and clean up bcm_op
> structures. The operations are updated to protect concurrent procfs
> traversals that use rcu_read_lock().
> 
> Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.kernel.org/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 38c3f690c1cd0..940cd9df1cca3 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1009,6 +1009,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   	struct bcm_sock *bo = bcm_sk(sk);
>>   	struct bcm_op *op;
>>   	struct canfd_frame *cf;
>> +	bool add_op_to_list = false;
>>   	unsigned int i;
>>   	int err;
> 
> [Severity: High]
> This is a pre-existing issue, but does this code overwrite the CAN frames
> directly from userspace before validating their lengths?
> 
> In bcm_tx_setup() when updating an existing bcm_op, the frames array is
> updated directly without holding bcm_tx_lock and without a staging buffer:
> 
> bcm_tx_setup() {
>      ...
>      err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
>      if (op->flags & CAN_FD_FRAME) {
>          if (cf->len > 64)
>              err = -EINVAL;
>      ...
> }
> 
> If an invalid length is provided, the function returns -EINVAL but the
> corrupted frame remains active in op->frames.
> 
> Could concurrent or subsequent timer executions transmit this malformed frame
> to the CAN driver, potentially triggering out-of-bounds accesses and panics?
> 
> [Severity: Medium]
> This is a pre-existing issue, but are the timer values updated locklessly?
> 
> bcm_tx_setup() updates the 64-bit ktime_t variables kt_ival1 and kt_ival2
> directly without holding bcm_tx_lock:
> 
> bcm_tx_setup() {
>      ...
>      op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
>      op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
>      ...
> }
> 
> Concurrently, bcm_tx_timeout_handler() in softirq context reads these
> values locklessly:
> 
> bcm_tx_timeout_handler() {
>      ...
>      if (op->kt_ival1 && (op->count > 0)) {
>      ...
> }
> 
> On 32-bit architectures, a 64-bit read/write is not atomic.
> 
> Could this result in torn reads where the timer handler sees a mix of old
> and new 32-bit halves, leading to unpredictable timer behavior and erratic
> transmission intervals?
> 
> [ ... ]
> 


