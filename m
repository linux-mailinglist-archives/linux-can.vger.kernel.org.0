Return-Path: <linux-can+bounces-7832-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HGW3B9zsK2p1HwQAu9opvQ
	(envelope-from <linux-can+bounces-7832-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:26:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00211678F67
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:26:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UbVjTVS6;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7832-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7832-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 099F83081317
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8F3B7B72;
	Fri, 12 Jun 2026 11:26:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336323D091A
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:26:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263576; cv=none; b=IvOzRr1Z3LDSRIsDKY+yr8uq3rwYk7oQ3LxahhoCEVuN3YYeCyyeCRvfM8dfnjIIR2Y+vvDLwuV+1IWW9kkM6oR3cJKztDCQdMBhorEs4xIQTt6/uaD7m/cD3QZTdFqeE2zlkV/WDDmFQYEUBNutfwjNZxpEkoDtt6pyY2WY27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263576; c=relaxed/simple;
	bh=Fe7ATOFDtEgAM1+y0rmeqgEZ/PY1lwWoKZ/b/NfD9Rs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XREH9sRPSSv5HsK7wzT8no/Tuafgn3CCMwF8OvrhiGnr8YlRcRldQ2fGhWawakJ/YVMe6Lo1ZUvH4k2TAuTNyk3GnHaHC8Tpkw/KKOm4NTJ5xsHYcI9AQB/Uxk7BMV0kzTb9j+zcWFPf1cPv7Kzvbk0m58o8F8hrUIHtCDaa/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbVjTVS6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1D41F000E9;
	Fri, 12 Jun 2026 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781263571;
	bh=+70oBuvmISLNa8rgtwqxTIKvbuuAUI7S+XTYZddogdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbVjTVS6ywkNiq6zt5DXAOXLx0Hf+zM1c/PuKPKAUbp+OBrZLUo4mvnolBzEJISUf
	 kPOC7JQgiOSRwPWh75Oq1suHQkTRLV0salyvLIdXBfKDu65dANNnjy0kg0jU+dexJz
	 x+iKpvRZPCv6KQRA5dkjriSir/AWAMZIOlJU+KZmZVLLH9quiXIdwLkJumDrj8eCBO
	 /W0I4/3I9qlwmgF5BZReZ4fqY06Zk3UsRNgTQLLML6B8YSAizcrnBnmPzwsYd72t6p
	 p2Kyw9ptDuiFiCxfvIgnu1cJQtMmVjp12Abm0isin57CbU12YS+bKiKXUsw01ons9H
	 D2KLApd50RZHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] can: bcm: defer rx_op deallocation to workqueue to
 fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260612-bcm_fixes-v1-1-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-1-ca2fa07ee70f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:26:10 +0000
Message-Id: <20260612112611.2C1D41F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7832-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00211678F67

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deferring timer cancellation to a workqueue fixes a UAF on `bcm_op=
`, but exposes a Use-After-Free (UAF) on `op->sk` because `bcm_release` doe=
s not wait for the workqueue to flush before freeing the socket.
--

commit 9591bb7d40d0a4fbd45c8700cf885c74ad1dcfec
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit defers the cancellation of timers and deallocation of bcm_op to
a dedicated workqueue. This prevents a use-after-free when a concurrent
RCU reader re-arms the timer after the RCU callback is scheduled.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..c49b09f3229fa 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -806,6 +813,14 @@ static void bcm_free_op_rcu(struct rcu_head *rcu_hea=
d)
>  	kfree(op);
>  }
> =20
> +static void bcm_free_op_rcu(struct rcu_head *rcu_head)
> +{
> +	struct bcm_op *op =3D container_of(rcu_head, struct bcm_op, rcu);
> +
> +	INIT_WORK(&op->work, bcm_free_op_work);
> +	queue_work(bcm_wq, &op->work);
> +}

[Severity: High]
Could this deferral to a workqueue expose a use-after-free on op->sk?

If a socket is closed immediately after an operation is deleted:

1. bcm_delete_rx_op() removes op from the socket's rx_ops list and schedules
   call_rcu().
2. A concurrent bcm_rx_handler() running under RCU re-arms op->thrtimer.
3. bcm_release() closes the socket. Since op was removed from rx_ops, it is
   skipped, and bcm_release() drops the final reference via sock_put(sk),
   freeing the socket.

Because the workqueue execution is asynchronous, bcm_release() does not wait
for it. If the re-armed thrtimer fires before bcm_free_op_work() can cancel
it, would this trigger a use-after-free?

bcm_rx_thr_handler()
  bcm_send_to_user()
    reason =3D sock_queue_rcv_skb_reason(op->sk, skb);=20

Since op->sk is assigned in bcm_rx_setup() without a corresponding
sock_hold(), does the deferred cleanup need to hold a socket reference to
ensure the socket outlives this work item and any pending timers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-bcm_fixes-=
v1-0-ca2fa07ee70f@hartkopp.net?part=3D1

