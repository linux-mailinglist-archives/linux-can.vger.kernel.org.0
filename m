Return-Path: <linux-can+bounces-8092-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jqMoNPUVTWpVuwEAu9opvQ
	(envelope-from <linux-can+bounces-8092-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 17:06:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191371D01A
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 17:06:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dcm8II8c;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8092-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8092-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6518330BD70E
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FC370AD6;
	Tue,  7 Jul 2026 14:51:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8C36D9E7
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:51:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435900; cv=none; b=mAdDf8I09TW2Z2S8EC2cpCgsjIiPaS+7BO7AN89dTpVXjmUKQoStuff1RbwLJyGfYR9KNNP+sBkgoPv+JekxBgq80R4/gUKuib/0RNHj8mZgvFEC+9OL+2RozrUQLG5sCMvOM9UoUjT0L2TheaFTAPX+MdNkkp6a0dduFf73e1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435900; c=relaxed/simple;
	bh=lCGOsLaAMv55mAnV9G2QB0BO/UFFgcMDchx0gioLqfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RE6QCDLxRL/iHGr3Y+YZLHpmtPflpTdIWny/m+0Sv6ykzcJXLcKx0Sn3gk9BfyHSY1Om9yk2zvtZmtS1daWumlCxOMy3YouC+2sKf1rckq4YN0pBc23nSSlTzqhe5uNbLwT9uBGzpVCSCg5mWOByK5Aw+3d9OMdvo26k8L0tMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcm8II8c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC831F00A3A;
	Tue,  7 Jul 2026 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783435895;
	bh=uteJPxZ8OTBZhxsU9dbvqJG0zVgZp4UBCRlfWp24Gd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dcm8II8cge8g+HrX5R/3SEIum1T8mPDSXb9ucC+/QTvGtBC7U84r6UzLiq8YSmV3a
	 5I/cSzRYNnuOrNrPsY7Kx3cx5qTPNrBn51ieaTX0+TJgheY6DxU6k5r1v1CsC5jDZ+
	 hZ63qkHA9Vb3517TpEyBSSQIYArVoMDPdrrGpbT33C29n3H/5+fDDUmB47UF9mQVU1
	 19MfGqWbJRhpunhzMzMVqa/qu9aRF+h49fTDIK/kBwO2HWuyQ0O4ff0D2O433AtTu5
	 Zv2qonE6VDXy9CBgn61avqpOFVLNefHfbyg8lHuCNrhYHn2Qo5GJUv+lqLg1QWR7gu
	 s4vljwtc+emEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] can: bcm: validate frame length in
 bcm_rx_setup() for RTR replies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260707-bcm_fixes-v4-7-aa87b8b9d33f@hartkopp.net>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-7-aa87b8b9d33f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:51:34 +0000
Message-Id: <20260707145135.5BC831F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8092-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4191371D01A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race on `op->rx_ifindex` and `op->rx_stamp` in `bcm_rx_handle=
r` leading to incorrect metadata being reported to userspace.
--

--- Patch [7]: [PATCH v4 7/7] can: bcm: validate frame length in bcm_rx_set=
up() for RTR replies ---
commit 1023235e0f18b95b00bedbafd97f5943d8506566
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: validate frame length in bcm_rx_setup() for RTR replies

This commit fixes a missing frame length check in bcm_rx_setup() for
RTR-reply frames configured via RX_SETUP with RX_RTR_FRAME. It ensures
cf->len is validated against CAN and CAN FD limits before installation.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index f04216723e0fc..d4d2c89dc4009 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1467,6 +1482,14 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  	}
> =20
>  	return msg_head->nframes * op->cfsiz + MHSIZ;
> +
> +free_op:
> +	if (op->frames !=3D &op->sframe)
> +		kfree(op->frames);
> +	if (op->last_frames !=3D &op->last_sframe)
> +		kfree(op->last_frames);
> +	kfree(op);
> +	return err;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential data race in
bcm_rx_handler() involving op->rx_ifindex and op->rx_stamp.

When a user creates a BCM socket listening on all interfaces (ifindex=3D0),
and CAN frames matching the filter arrive concurrently on multiple
interfaces (e.g., handled by different CPUs in softirq), bcm_rx_handler()
can execute concurrently. Both CPUs appear to write to op->rx_stamp and
op->rx_ifindex without synchronization before acquiring=20
op->bcm_rx_update_lock:

net/can/bcm.c:bcm_rx_handler() {
	...
	op->rx_stamp =3D skb->tstamp;
	/* save originator for recvfrom() */
	op->rx_ifindex =3D skb->dev->ifindex;
	...
}

Later, bcm_send_to_user() reads these fields to send metadata to userspace:

net/can/bcm.c:bcm_send_to_user() {
	...
	skb->tstamp =3D op->rx_stamp;
	...
	addr =3D (struct sockaddr_can *)skb->cb;
	memset(addr, 0, sizeof(*addr));
	addr->can_family  =3D AF_CAN;
	addr->can_ifindex =3D op->rx_ifindex;
	...
}

Could this lead to torn reads of the 64-bit rx_stamp on 32-bit platforms
and incorrect rx_ifindex values being reported to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v4-0-aa87b8b9d33f@hartkopp.net?part=3D7

