Return-Path: <linux-can+bounces-8108-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vxUUO65DTWoaxgEAu9opvQ
	(envelope-from <linux-can+bounces-8108-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 20:21:34 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7A71E996
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 20:21:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fKyrLLjW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8108-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8108-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE7E304C7ED
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA343C7CA;
	Tue,  7 Jul 2026 18:18:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F143B6C6
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 18:18:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448314; cv=none; b=SNF0uT+ZsInbruJGCMLqVIlqEsvpGjrc6ShlYeU0gFo+Yj5ik5ZZn/kA0qNdTTUdS1TaUukzQFsaKkjY1yfA9EP9bakafH6p3r5s6HQufWi0sIC8gYErIDHasyE8kCbZPBpbgmFl+gD4ozj2x9YtXc5dQK/pDjOR23+0oZh6Eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448314; c=relaxed/simple;
	bh=WdhbLvEdwglSE5QpDtBlkQLOXAYoMzqgrqYlyaaIk3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TjCQdmTWCjmR+0vgkwjCP3b6jadfwNkLVTapWeKgtK0S2HeVy17+oBfjdokyJU+T0VSgxHsRbPQWYJ69c2iVAhcfrEWvsgjLepiKjCXcp+RdKQealTedEoCQJSfOInGffuvuhTzUL8IuIanoNtZN3IVK0w0xtzlYSDcciEctL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKyrLLjW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9C21F000E9;
	Tue,  7 Jul 2026 18:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783448313;
	bh=373A0gWeuomzYsnJCZoI6fHu3OyOBfyaUZEduVWNfn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fKyrLLjW5125bE+g2zYtX4UDQcE0Q4f5mzUn5eeuLak3J1LFuzx5wYBjM0FeJFFPq
	 7MIMSguRFTbEt4NSIhVtLgB9pQdYXbMjCyl83ni4OULp3k6815O1g7U+0v5MfeOi9w
	 UqG58arWTksjLkPTFSMassYEQpzg+5IzqsY7euN8yJ0f0NuuN80rWXTnUBiis0rNR/
	 1KkcnL0P1KzsdcubUU+s6cIO9bA7JF7aU8Z5ACYsTd3j6DFNH7xAyPTRBaDQIUuPNn
	 +U7NgaolAiiIA9++eCPFPHfMhFG90/dKYSzP79Y9++rwBmgTLP7b1my7qzZQCLNA1i
	 pe6pW/hNnVXBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] can: bcm: defer rx_op deallocation to workqueue
 to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260707-bcm_fixes-v5-1-c3c74f8d8ff7@hartkopp.net>
References: <20260707-bcm_fixes-v5-0-c3c74f8d8ff7@hartkopp.net>
 <20260707-bcm_fixes-v5-1-c3c74f8d8ff7@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 18:18:32 +0000
Message-Id: <20260707181833.0A9C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8108-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20D7A71E996

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Invalid CAN frame length bypasses validation during BCM TX ope=
ration update, potentially causing driver-level out-of-bounds reads.
- [High] Missing RCU-safe list addition and traversal for tx_ops and rx_ops=
 lists.
- [High] Data races when modifying existing CAN filters and frames concurre=
ntly with network rx/tx paths.
--

--- Patch [1]: [PATCH v5 1/8] can: bcm: defer rx_op deallocation to workque=
ue to fix thrtimer UAF ---
commit 19a74c15fd3018b3b148c40380ac7643f49b00f3
Author: Lee Jones <lee@kernel.org>

    can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
   =20
This commit replaces the direct call_rcu() with a deferred workqueue
item for freeing the bcm_op structure. This safely cancels the
timers and deallocates memory in sleepable process context, preventing
a use-after-free condition.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1060,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);

[Severity: Critical]
This is a pre-existing issue, but does the frame length validation handle
invalid sizes correctly before they become active?

In bcm_tx_setup(), when updating an existing TX operation, user data is cop=
ied
directly into the active op->frames buffer before it is validated:

net/can/bcm.c:bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

    if (op->flags & CAN_FD_FRAME) {
        if (cf->len > 64)
            err =3D -EINVAL;
    } else {
        if (cf->len > 8)
            err =3D -EINVAL;
    }

    if (err < 0)
        return err;
    ...
}

If the provided cf->len is invalid (e.g., greater than 64 for CAN FD), the
function returns -EINVAL and exits, but the invalid length has already been
written into op->frames.

Since the existing op is still active and its timer continues ticking,
bcm_tx_timeout_handler() could eventually transmit this malformed frame to =
the
CAN device via can_send(). CAN drivers rely on the core stack to validate
lengths, and processing a length greater than 64 could cause out-of-bounds
array reads (e.g., in can_fd_len2dlc) or other memory corruption. Could an
unprivileged user sending a crafted payload trigger this?

[Severity: High]
This isn't a bug introduced by this patch, but does this code need to use
list_add_rcu() to ensure safe concurrent traversal?

The tx_ops and rx_ops lists are iterated in bcm_proc_show() under
rcu_read_lock() without holding the socket lock:

net/can/bcm.c:bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

However, new operations are inserted into these lists in bcm_tx_setup() and
bcm_rx_setup() using the standard list_add() macro:

net/can/bcm.c:bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
    ...
}

On weakly-ordered CPU architectures, this lacks the necessary
smp_store_release() memory barriers, meaning concurrent RCU readers in
bcm_proc_show() can observe a new list node before its contents or its next
pointer are fully initialized, potentially leading to data corruption or
crashes.

Furthermore, bcm_proc_show() iterates over tx_ops using list_for_each_entry=
()
rather than list_for_each_entry_rcu(), omitting the data dependency barriers
required for safe concurrent traversal. Can userspace reading
/proc/net/can-bcm/* while configuring a socket trigger this?

[Severity: High]
This isn't a bug introduced by this patch, but are there data races when
updating existing CAN filters and frames concurrently?

In bcm_rx_setup() and bcm_tx_setup(), when updating an existing bcm_op, the
user-provided data is copied directly into op->frames without holding
bcm_tx_lock or any lock that synchronizes with the network datapath:

net/can/bcm.c:bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    if (err < 0)
        return err;

    memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
    ...
}

Concurrently, bcm_rx_handler() (running in softirq context) iterates over
op->frames and reads/modifies op->last_frames locklessly:

net/can/bcm.c:bcm_rx_handler() {
    ...
    if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
    ...
}

This could lead to memory corruption in last_frames or matching against
partially updated frames.

Similarly, bcm_can_tx() retrieves a pointer into op->frames under
bcm_tx_lock, but drops the lock prior to calling skb_put_data() (which reads
from op->frames):

net/can/bcm.c:bcm_can_tx() {
    ...
    skb_put_data(skb, cf, op->cfsiz);
    ...
}

Does this allow a data race where a CAN frame is being transmitted at the
exact same time it is being overwritten?

>  		op->ifindex =3D ifindex;
> =20
>  		/* initialize uninitialized (kzalloc) structure */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v5-0-c3c74f8d8ff7@hartkopp.net?part=3D1

