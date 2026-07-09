Return-Path: <linux-can+bounces-8182-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fsNiKYtdT2oOfQIAu9opvQ
	(envelope-from <linux-can+bounces-8182-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:36:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E9572E5BE
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:36:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jDWxWjUU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8182-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8182-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAF8E3010676
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F63E7BB1;
	Thu,  9 Jul 2026 08:34:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005F3ED11B
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 08:34:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586069; cv=none; b=Ze2G/87mjtT57hS4oPDjMCnZNJ/r2bGkKrV14loOECaZUuW8JVF8fU2EM8lTxrowejCsjD8NF5pthFSx1lrc9XgaaA9qhln/1e88FAcNwKRkhXPzGl974ewx2GZI0MQvx1W5rTaqSC48HQuJc2OCfTHGlq382JYBnOaMywSiMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586069; c=relaxed/simple;
	bh=0LYsjZaPy/d1QC/xmGdGmLnwo0Hm19KBcyOEVsMKdZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VBTBxat0qk9RJJz9ite1ClCF4DTGY9S+UXdDAeCOiNgmQHcAC9J8v7uf9nfi/SeGWCUU1NARQvqzBoIoZsCFmKe+/8gfcvnSJxmU74dK/He1ygXC+QVYLsbsB9Z//N+KbXXhdb47EV7PEFF2vuZvgllP3Yun3/2ASwBlbG82Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDWxWjUU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6791F000E9;
	Thu,  9 Jul 2026 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586068;
	bh=QWbQ24ztFiisvH5inF7S81x8cNWT2ASyz1aRNezmoM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDWxWjUUOusuVtwKBN3/jO+NEInyZHu92FkZqe5aGFp0ReLZGHEhIV59KriaxL6w0
	 HA00GBm3XOL66XtqtWyOUwJfh3o7td5/ARO4Ad+kkvJjIOIEi75YP0xuOdF7hRjGES
	 jpCPISUDAAOnGMAgTnW1BTEShz9vcHiySv1iS9IOZmkTs2V0mfu14ru9DDrqDWyE3G
	 WZBhvfMezR//lrFJSwcighOQwT48jM2fuh4iCyzwRrhqNDik3n0T1ttaCPvozK1IzV
	 vHSxXgTApsAIPwzWMbUIoFJFtJQhiVXts3BwYLIlOdenrOyk17uYTCGnLzy5eoOPM+
	 tbB6sYxB3op6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/10] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v9-1-6eebb78ccfb2@hartkopp.net>
References: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
 <20260709-bcm_fixes-v9-1-6eebb78ccfb2@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:34:27 +0000
Message-Id: <20260709083428.1B6791F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8182-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34E9572E5BE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Module exit triggers a kmem_cache_destroy warning because the prot=
ocol slab cache is destroyed before the deferred workqueue frees the remain=
ing sockets.
--

--- Patch [1]: [PATCH v9 01/10] can: bcm: defer rx_op deallocation to workq=
ueue to fix thrtimer UAF ---
commit d847f243125a944d43b2a6970166b528eea27549
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit resolves a use-after-free condition in the broadcast manager=20
rx operation teardown. It moves the timer cancellation and memory deallocat=
ion=20
to a dedicated unbound workqueue, and ensures the socket reference is held=
=20
until the deferred work executes safely in process context.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1869,6 +1898,8 @@ static void __exit bcm_module_exit(void)
>  	can_proto_unregister(&bcm_can_proto);
>  	unregister_netdevice_notifier(&canbcm_notifier);
>  	unregister_pernet_subsys(&canbcm_pernet_ops);
> +	rcu_barrier();
> +	destroy_workqueue(bcm_wq);
>  }

[Severity: High]
Will this sequence trigger a kmem_cache_destroy warning on module unload?

Since bcm_module_exit() calls can_proto_unregister() before
destroy_workqueue(), the protocol slab cache is destroyed while deferred
work items that release sockets back to the cache might still be pending in
bcm_wq.

Should destroy_workqueue() be called before can_proto_unregister() to
ensure all pending socket frees are completed prior to the protocol slab
cache destruction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v9-0-6eebb78ccfb2@hartkopp.net?part=3D1

