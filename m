Return-Path: <linux-can+bounces-8437-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i1UuGNtqVmrH5AAAu9opvQ
	(envelope-from <linux-can+bounces-8437-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 18:59:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574677572BD
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 18:59:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cYK+tjTO;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8437-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8437-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 694503004D8C
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF474E376C;
	Tue, 14 Jul 2026 16:58:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA44DD6FE
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 16:58:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048324; cv=none; b=GTEcU7lhXgXPu6cdFOzaG4M7RjUojSeflqn7r6sAcRV9jSiV5WbO0FpYSknhorY/riVJHfPzZwBQ/PcHmaURv9WrszCqBn8XM+DRFp2Fde3YvFZTrx2iGfBxm+LyKpKgbv0pZzC9k6kOrZ+zfWkMNGQD3ez7ECXQ6KkbDYHp8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048324; c=relaxed/simple;
	bh=PMWkGEDy7EexoemkWJBbWz6CQNhUnQc1sG3UKHXKn4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3xVqRFdvurWQ8ExdbQLQWlFkLt2UAYaj494KwcTZyPkHm4WpL7gtHEupynwCLqi/ORjkGBUrNHFCIU3e4bpjMCBRijpf8OD1PfKDgBXJIwc3DCUrsjV0J7rOPnBavD150WWlLRKQh7lABWn8DYesOrkQxw2aCFSyerfgKTeWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYK+tjTO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923281F00A3A;
	Tue, 14 Jul 2026 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048323;
	bh=0pGunXII3U4EDPZqzX1qtVA0XvnXle3oGjJIllYWcgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYK+tjTOl7X/jIthqyWOled9s91E07w2CSpPuAWuXL47LTEQQWCPkEu/FAtk2Dz5b
	 Izg71/0dADO6TbazdhPj2F3yWseayXMkySZH3gicgj+5n+kcRE8Ec/NdAiECzFmNaM
	 XMDv31iDhxXEGeL2lHhspkuDYLESnWY0COtEE0SJ4hKv7oqGtff1tbAdGVrcKVZ92u
	 L/DrAMXsvbNWVd6G2X95B9wP3Mh+h5iZRVZlxOR3T8LeFYnjJUdM8z206EfPQiuS5+
	 gcU//V+YOXj+Q0lFgpiWkPIcPQ5GUPpxt300w3XoNNrbEijGMQcC37rhsGbwdo/E+f
	 r/UoyLM65SNCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: c_can: keep controller in init mode until
 bittiming is configured
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lucas Martins Alves" <lucas.alves@lumal21.com.br>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260714164839.771123-1-lucas.alves@lumal21.com.br>
References: <20260714164839.771123-1-lucas.alves@lumal21.com.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:58:42 +0000
Message-Id: <20260714165842.923281F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8437-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,lumal21.com.br:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lucas.alves@lumal21.com.br,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 574677572BD

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Configuring bit timing temporarily clears the CONTROL_TEST bit, wh=
ich silently resets the TEST register and breaks loopback/listen-only modes.
--

--- Patch [1]: [PATCH] can: c_can: keep controller in init mode until bitti=
ming is configured ---
commit b7bd06d474febb092c757ff6270ed7de9b22644e
Author: Lucas Martins Alves <lucas.alves@lumal21.com.br>

can: c_can: keep controller in init mode until bittiming is configured

c_can_chip_config() was programming C_CAN_CTRL_REG without CONTROL_INIT,
which may allow the controller to become active before c_can_set_bittiming()
finishes. This patch adds CONTROL_INIT to the writes in c_can_chip_config()
so the controller stays halted until bit timing is fully programmed.

> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c=
_can_main.c
> index 3702cac7fbf0f..32a3975b9d692 100644
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -597,20 +597,20 @@ static int c_can_chip_config(struct net_device *dev)
[ ... ]
>  	if ((priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) &&
>  	    (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)) {
>  		/* loopback + silent mode : useful for hot self-test */
> -		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
> +		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST | CONTROL_INIT);
>  		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK | TEST_SILENT);
>  	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {

[Severity: High]
This is a pre-existing issue, but does the loopback or listen-only test mode
actually survive the initialization process?

When we configure C_CAN_TEST_REG here in c_can_chip_config(), we set the te=
st
bits. However, shortly after this block, the function calls
c_can_set_bittiming() to configure the timing:

drivers/net/can/c_can/c_can_main.c:c_can_set_bittiming() {
    ...
    ctrl_save =3D priv->read_reg(priv, C_CAN_CTRL_REG);
    ctrl_save &=3D ~CONTROL_INIT;
    priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT);
    ...
    priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
}

When writing CONTROL_CCE | CONTROL_INIT to the control register, the
CONTROL_TEST bit is explicitly omitted. Doesn't clearing the CONTROL_TEST b=
it
silently reset the C_CAN_TEST_REG back to 0 in the hardware, destroying the
configuration we just set?

Even though ctrl_save eventually restores the CONTROL_TEST bit in
C_CAN_CTRL_REG, the configuration in C_CAN_TEST_REG appears permanently los=
t.
Should c_can_set_bittiming() preserve the CONTROL_TEST bit when writing to
C_CAN_CTRL_REG?

>  		/* loopback mode : useful for self-test function */
> -		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
> +		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST | CONTROL_INIT);
>  		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714164839.7711=
23-1-lucas.alves@lumal21.com.br?part=3D1

