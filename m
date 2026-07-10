Return-Path: <linux-can+bounces-8286-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /2VgLM3kUGoP8AIAu9opvQ
	(envelope-from <linux-can+bounces-8286-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 14:25:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4073AC16
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 14:25:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yg3UU52L;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8286-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8286-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF7B301C8A5
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4D225788;
	Fri, 10 Jul 2026 12:25:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84D408014
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 12:25:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686338; cv=none; b=f8otvqodOeMibJUuS00q26jyC8PBwAr3yJCnDh0GyFKmlc17ReHI626tm+sj/F/4gCCkZhUSW+d2NLxTLW6IxIoDl2LLCGbFRVDLDyWNj/kN/YVobWh8u4V1WuUSbevCmCQuK9a5+fsTP6mN/M8XKbYZtFC/dlTqAyCmM0s2/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686338; c=relaxed/simple;
	bh=9iSDW3nlxmZu8GuuYT1cHaGw4wvqHFXCEZHuZzjJuEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u3oJKqhsXqJTQpt/pvIWUgL8+fUrrpihf9XnU+aKpuOJJkg47edzFMgvBmc8JrBh5NY09C1/jVRfXFRBVLoAhoa8Xh6cMNw73dKIs26RZdVXTWQVgu2FQospotabvRZc4aC/WbBoeoc75Ofnn0+k1y7l7ZLYZW45xTgX2AGB30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg3UU52L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419D91F000E9;
	Fri, 10 Jul 2026 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783686336;
	bh=aSQMyn5tA5RzhOxGlqLEquJou6SSWLlWDKhAGLE1R1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yg3UU52LKtnj6U5164z67UKLzE/IpOeUBvub6/jePp2NtcIUiuyqPFdOXYAq1E+NA
	 faud6ct++76sr1bSJ0cPusthKIy3tUmUityC46izTr316JF/R1JDXBUdYmzcygYt/R
	 CRgFipeVuFNdAQzRK62XwdK6TRFtPxu6LlN3fVrJfNkKo4VBwefVgpThYr2zaeqLiT
	 yfQqbVXzK5zg5p4G2BFpH8DezAhtdJicsMDnXi7qK2FN3+VuM0FQ6T2G8JMenCjdlg
	 3nO8kkNxW+Mi0b5pGU9bdBZ+wpqzSzEzs2YfEVmso7MPHWmpU0I7MPqgELPBZqX3on
	 FuoJdUjrERuMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v2] can: m_can: switch to rx-offload
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260710-m_can-rx-offload-v2-1-aa6597eb194e@pengutronix.de>
References: <20260710-m_can-rx-offload-v2-1-aa6597eb194e@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 12:25:35 +0000
Message-Id: <20260710122536.419D91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8286-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: F0C4073AC16

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Closing a peripheral interface with pending TX causes a NULL p=
ointer dereference and leaks SKBs due to incorrect teardown ordering.
- [High] Missing synchronous hrtimer cancellation in device teardown leads =
to concurrent MMIO access without clocks and use-after-free.
--

--- Patch [1]: [PATCH can-next v2] can: m_can: switch to rx-offload impleme=
ntation ---
commit 5cf910484c596d7ed3917c0539c9c6c2d33f1e19
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: m_can: switch to rx-offload implementation

This patch unconditionally configures the driver to use rx-offload in=20
m_can_rx_handler() from the IRQ handler instead of using NAPI for
memory-mapped devices. It removes manual NAPI handling from the driver.

> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index eb856547ae7df..866c4b501dadd 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c

[ ... ]

> @@ -1846,11 +1782,10 @@ static int m_can_close(struct net_device *dev)
>  	if (cdev->is_peripheral) {
>  		destroy_workqueue(cdev->tx_wq);
>  		cdev->tx_wq =3D NULL;

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference and memory leak here during teardown.

Earlier in m_can_close(), m_can_clean() iterates over pending TX operations
and sets their skb pointers to NULL:

m_can_clean()
    if (!cdev->tx_ops[i].skb)
        continue;
    net->stats.tx_errors++;
    cdev->tx_ops[i].skb =3D NULL;

When destroy_workqueue(cdev->tx_wq) runs right after, it synchronously
executes any pending tx work items. m_can_tx_work_queue() retrieves the
NULL skb and passes it to m_can_tx_handler(), which dereferences it
unconditionally via (struct canfd_frame *)skb->data, causing a panic.

Since the SKBs are also not freed when set to NULL, they appear to leak.
Does m_can_clean() need to free the SKB instead of just nulling it out,
and does the work queue need to handle a NULL skb gracefully?

> -		can_rx_offload_disable(&cdev->offload);
> -	} else {
> -		napi_disable(&cdev->napi);
>  	}
> =20
> +	can_rx_offload_disable(&cdev->offload);
> +
>  	close_candev(dev);
> =20
>  	reset_control_assert(cdev->rst);

[ ... ]

> @@ -2589,8 +2515,7 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
>  void m_can_class_unregister(struct m_can_classdev *cdev)
>  {
>  	unregister_candev(cdev->net);
> -	if (cdev->is_peripheral)
> -		can_rx_offload_del(&cdev->offload);
> +	can_rx_offload_del(&cdev->offload);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed the hrtimer might
not be fully shut down during device teardown.

If a user disables the CAN interface or unbinds the driver while the
hrtimer (m_can_polling_timer or m_can_coalescing_timer) is executing on
another CPU, we could hit a use-after-free or bus fault.

m_can_disable_all_interrupts() calls hrtimer_try_to_cancel(), which returns
without stopping the timer if it is currently running. The timer could then
execute concurrently after hardware clocks are disabled via m_can_clk_stop()
in m_can_close(), or after the device is unregistered and freed.

Should there be a synchronous cancel like hrtimer_cancel() during the
teardown path to ensure the timer is fully stopped before disabling clocks
and freeing memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-m_can-rx-o=
ffload-v2-1-aa6597eb194e@pengutronix.de?part=3D1

