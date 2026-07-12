Return-Path: <linux-can+bounces-8337-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3XuSCw2PU2pybwMAu9opvQ
	(envelope-from <linux-can+bounces-8337-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 14:56:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 830AE744BEB
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 14:56:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UwHBqLqc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8337-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8337-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79C1230094E4
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B7E3A450A;
	Sun, 12 Jul 2026 12:56:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980E358D00
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 12:56:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783861001; cv=none; b=pelYIcLcpTcv1T8xVcv+Usrps2m8HYG+zemCPFfSelvLnFkzojhbc7poYr8h3oGwUZ3gPBPEGHIMxLFbwuFPJhnM47bz2X9eAAvkwxk4bynEM+I9zCfqvVNaMfPfi4WYIHArzNbWGuasZpBVKa9vTKeka5aHTRcux7D39FCsm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783861001; c=relaxed/simple;
	bh=CnOBmgd6w1bV3bLrdr2fAEyt8Um85PZ/17B1kuDJhEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQA02DRjSdgskRxxlFOV5lM0HZ6nOImfYJHtLS2zhaw6tbmbbXLhk+H0am+rkT1a4il+ktv2pbyRzlw0aAOp8ugyN+09T96rgopqaEhQgf49OurV7B0Bld436u35q5Zxdz4uzAmczkVb6vb+1eWyDEf2E7MzuYgw/zl8XZvgYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwHBqLqc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2521F000E9;
	Sun, 12 Jul 2026 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783860999;
	bh=NunNTxoyTyUAFtjSb+ewYWsOf81sBPX+WEasOyJk5B8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UwHBqLqcBSFcXhACXPAxuTsNi/x74S3DVxgP3hK3kM72ZFlMiNk5XVXuWxK4/7j/8
	 ydXtViAOjxGI0oDoFpijYmAOKEC5prbWSkVxO5sWF97t6rZLnE/Ze6QEy6pWu4IbFE
	 N42JFFYycCMPhIGnGEKehmz4WXbv8Np0MSF1gOt3+fxSSqyJbK5mKAgT4VZ3BLzU7X
	 fezFSymFSYP6vNDcqlQYxHKqXm5AX997e49EyTLFuqAIXf6SCvyLmjHZQA5yZUA4f5
	 e7szhYSZjeZ6ytWzMtve4cSXVR8K51PgrLWNG5rnFWeTarTNTgnxZ7IAx+TYsc5umW
	 9GC6abfJk+rcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] can: isotp: fix state machine corruption on
 signal interruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260712-isotp-fixes-v8-4-c39220a4e442@hartkopp.net>
References: <20260712-isotp-fixes-v8-0-c39220a4e442@hartkopp.net>
 <20260712-isotp-fixes-v8-4-c39220a4e442@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 12:56:38 +0000
Message-Id: <20260712125639.2C2521F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8337-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 830AE744BEB

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `so->tx_gen` mechanism fails to protect against delayed local =
echoes from aborted transfers if the CAN payload matches, leading to protoc=
ol pacing violations and timeouts.
- [High] Signal interruption during `wait_tx_done` causes racy state clobbe=
ring of concurrent transfers due to a stolen wakeup and lockless state upda=
te.
--

--- Patch [4]: [PATCH v8 4/4] can: isotp: fix state machine corruption on s=
ignal interruption ---
commit 7dee50f317c5e02a3ea6610e45f4dde065c0b96c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix state machine corruption on signal interruption

This commit fixes a bug where a signal interrupting a thread waiting to sta=
rt
a new transfer incorrectly aborts an ongoing transfer. By returning the err=
or
directly, it avoids executing the cleanup path that forces the state back to
ISOTP_IDLE.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c5b44d298618b..ceb590ae058eb 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1047,7 +1047,7 @@ static int isotp_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  		/* wait for complete transmission of current pdu */
>  		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_I=
DLE);
>  		if (err)
> -			goto err_event_drop;
> +			return err;

[Severity: High]
This is a pre-existing issue, but does a similar race exist later in
isotp_sendmsg() when handling wait_tx_done?

If Thread A waits in wait_tx_done with a signal pending, and concurrently
the transfer finishes (setting state to ISOTP_IDLE and waking waiters),
Thread B could wake up and claim the socket locklessly:

Thread B:
    while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) !=3D ISOTP_IDL=
E) {

Before Thread B increments so->tx_gen, if Thread A wakes up, evaluates its
wait condition, returns -ERESTARTSYS, and jumps to err_event_drop:

Thread A:
    if (wait_tx_done) {
        err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOT=
P_IDLE);
        if (err)
            goto err_event_drop;
    }

Would Thread A then incorrectly reset the state back to ISOTP_IDLE while
Thread B is actively using the socket?

Thread A in err_event_drop:
    if (READ_ONCE(so->tx_gen) =3D=3D gen) {
        so->cfecho =3D 0;
        so->tx.state =3D ISOTP_IDLE;
    }

>  	}
> =20
>  	/* new transfer: bump the generation (gen is used below and by

[Severity: High]
This isn't a bug introduced by this patch, but does the so->tx_gen mechanism
fully protect against delayed local echoes from aborted transfers?

If a transfer is aborted while its CAN frame is already queued, and a new
transfer begins with matching first 4 bytes of payload, could the delayed
local echo from the aborted frame arrive and be falsely validated?

In isotp_rcv_echo():

    if (so->cfecho !=3D *(u32 *)cf->data)
        goto out_unlock;
   =20
    gen =3D READ_ONCE(so->tx_gen);
    ...
    if (so->tx.state !=3D ISOTP_SENDING || READ_ONCE(so->tx_gen) !=3D gen)
        goto out_unlock;

Since gen is read directly from the current socket state (so->tx_gen) rather
than being persistently attached to the SKB, does this allow a stale echo to
prematurely advance the new transfer's state machine, leading to pacing
(STmin) violations and timeouts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-isotp-fixe=
s-v8-0-c39220a4e442@hartkopp.net?part=3D4

