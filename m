Return-Path: <linux-can+bounces-7921-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HJqlDs/LQ2o5iQoAu9opvQ
	(envelope-from <linux-can+bounces-7921-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 15:59:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CAC6E5274
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 15:59:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aw0dVj9k;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7921-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7921-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 521693000BB8
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF33822A1;
	Tue, 30 Jun 2026 13:59:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E684366052
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 13:59:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827978; cv=none; b=hdfDGxTACwj/kl8dDx3/DJ7nzU2SDvfZgIq2yd5mOw5l8GIew1ay17ybo4Wych71lZMidnloLM/L9Q7ARALFtdG/CG6jYW6k2ANpyKwdO71H7zuu85EAkWIIyTs7sykaRP6AkQstbY4oNmuSgB9MOuGpQySLKZ+8vbqjZvbmFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827978; c=relaxed/simple;
	bh=e63Ur68Lv+vfeQ8XNXteXmmCEhY25UBSoPtwkxFFV/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1R9r27FcOLmI8iVf/FnaQiUWKqAIO2E65kmTUWzpE9bb4Tz/gvjIZMTNPdyDIDAMAN4QikVVpSbLkDkVL0usN45FcgyttL+tqWIZJyZUWD+yS2wAzCHqP99c2tBEbB203rOcitfMBsmcItejEDiRK63cpn+1erXJVYa9blEscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw0dVj9k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A51F000E9;
	Tue, 30 Jun 2026 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827976;
	bh=nB8/dl4PLMZucg18RU9rXFF0A6PsemIbYRSiiVEhIpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aw0dVj9k/kmD8cDbucNCwWkjxeeD3pCUvY6l5djzy+Fa+i1Y7dXi9coxizF5EqZOf
	 +zRH++h/WkUlFp/zca3xGaxj3p+YEkllD4hRRrHujmNlZb69knjFiAUbxV8mqvF47H
	 x2PHGRZ01OYaAA3yTPma3GZoPM+01S+RzEyQ0k1cUPRi5oiFChpAb+qL+sP7hwQ/Sw
	 DNJpasDl6RFhVIn4+oU0AgLzqQdB+JjqApAF06I7r3bcE14CnjsliJlYk118lQJkB/
	 p+DN/roba0/5eox9fu26E0j7br2LOwvjvrVppbdHl1MeGLoz7u1KJk1BDPA0njO6rO
	 Ov5A4L014upRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] can: rcar_canfd: Fix dangling pointer on channel
 probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: Biju <biju.das.au@gmail.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, wsa+renesas@sang-engineering.com, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260630135119.104774-2-biju.das.jz@bp.renesas.com>
References: <20260630135119.104774-1-biju.das.jz@bp.renesas.com>
 <20260630135119.104774-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:59:35 +0000
Message-Id: <20260630135936.558A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7921-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:biju.das.au@gmail.com,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:wsa+renesas@sang-engineering.com,m:o.rempel@pengutronix.de,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:bijudasau@gmail.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33CAC6E5274

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a Use-After-Free by dereferencing `priv` imme=
diately after it has been freed, which can lead to an Out-Of-Bounds NULL wr=
ite primitive.

Pre-existing issues:
- [High] The lifecycle of the dynamically allocated `priv` is shorter than =
the `devm`-managed IRQ handlers, leading to a potential use-after-free if a=
n interrupt occurs during teardown.
--

commit e7cd96500f76ea63fe797db226dd1a89ff157846
Author: Biju Das <biju.das.jz@bp.renesas.com>

can: rcar_canfd: Fix dangling pointer on channel probe failure
   =20
In rcar_canfd_channel_probe(), the channel pointer is saved globally
via gpriv->ch[priv->channel] =3D priv. If register_candev() fails
shortly after, the error path uses free_candev(ndev) to release the
memory but leaves the pointer in the global array.

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index eaf8cac780387..5aafbab85da67 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1982,6 +1982,7 @@ static int rcar_canfd_channel_probe(struct rcar_can=
fd_global *gpriv, u32 ch,
>  	netif_napi_del(&priv->napi);
>  fail:
>  	free_candev(ndev);

[Severity: High]
This is a pre-existing issue, but does the use of devm_request_irq() earlier
in rcar_canfd_channel_probe() create a lifetime mismatch with this
free_candev() call?

The driver requests channel interrupts using devm_request_irq() with priv
(which is allocated via alloc_candev()) as the dev_id. If a failure occurs
and we hit this fail path, or during teardown in rcar_canfd_channel_remove(=
),
the memory for priv is synchronously freed by free_candev().

However, because the IRQ was allocated with the devm_ API, free_irq() is not
called until the device's devres cleanup phase, which executes later.

If a spurious hardware interrupt fires during the vulnerable window between
free_candev() and devres cleanup, could the handler
(rcar_canfd_channel_err_interrupt) execute with and dereference the freed
priv pointer?

> +	gpriv->ch[priv->channel] =3D NULL;

[Severity: High]
Does this cause a use-after-free?

The free_candev(ndev) call immediately above synchronously frees the memory
block containing both ndev and the inline private data priv. Evaluating
gpriv->ch[priv->channel] directly dereferences the newly freed priv pointer.

If memory debugging is enabled (like SLUB poisoning), the freed memory might
be filled with poison bytes, which could lead to an out-of-bounds write here
when it reads a poison value for priv->channel.

>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630135119.1047=
74-1-biju.das.jz@bp.renesas.com?part=3D1

