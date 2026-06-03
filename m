Return-Path: <linux-can+bounces-7747-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qerhFk3+H2rjtgAAu9opvQ
	(envelope-from <linux-can+bounces-7747-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 12:13:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A355D636720
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 12:13:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LxPQK9pE;
	dkim=pass header.d=redhat.com header.s=google header.b=Uv1kWKgy;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7747-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7747-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3164830182B3
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 10:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C3B426D1E;
	Wed,  3 Jun 2026 10:06:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9343D4E3
	for <linux-can@vger.kernel.org>; Wed,  3 Jun 2026 10:06:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481183; cv=pass; b=sUnDE2c7cYmc2vfoIOWCsa+uXAqrL7sHpWR/NRDNzrt4rwInm4hpaLQ6pOg1X4SP9lgNVG+vXehz+87xkDsCsV/IAOpXpRgo5sxZ80vsL1mNYov0KSnAM9JEa7ZcA9chzyb8UrLA2L6rwwt9fFEGUgZcaZ3gXBXN/3QdnfSOWAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481183; c=relaxed/simple;
	bh=PVRWCeqoQfFcGEkI94WpSvOM/jrm67OKH/kG9CG7SK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjGcAOwUDGwb+SWgQ0CJNf+o5XxbKCGNUveiYqx1DXvzr1WP9llPMZbv1OQ2TqQ5W3sNTJ6LaE3HyeBve1zS0fX4Fk+7LO89e9GaODHbdX3XWoZ9LepZFTQtaNdAFjKnBvVZ88lVCf7u1Cn27vLeqdc45oXBfjGWTPCOVvcTUpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxPQK9pE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uv1kWKgy; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780481180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szmw41mx+6XBYQACHrQkcIv+dFLdnR82AVyDnrz/Mp4=;
	b=LxPQK9pEEYDJ3YQ0YeWDF3EvlSC5EuEx9ttwSkQ3h/H2Gl8a2TVy5rovckKE+dDGAB3Zsm
	4x1ayJzugkpIDrDz+/yx9QkZnPJ+iAlC90+T/BJFA1Qr3VdmGpFCQYHJp6CLo6/1kRXm8E
	tXlsejqAxejQqzvAkUg9oRwXTBsDjS4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-H7bqm-fdMuKDwXgeAjS1Gw-1; Wed, 03 Jun 2026 06:06:19 -0400
X-MC-Unique: H7bqm-fdMuKDwXgeAjS1Gw-1
X-Mimecast-MFC-AGG-ID: H7bqm-fdMuKDwXgeAjS1Gw_1780481178
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3967739401aso2666311fa.2
        for <linux-can@vger.kernel.org>; Wed, 03 Jun 2026 03:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481178; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/4DIvOjQ0NKv+/ro8HcA40bSoz8fS8NrrKn5iPeyq/TvciEqpPUKz8hoDVD3BschR
         PBWobkzo2vO5dHthu6qcIdwQSb4pT6JQ4+f3UT5LeyBLLBZnzJgFBmLfYdzpycNFHX47
         S0P5vF14CsPAHVJKAqpRMANPx/zpPG05PpCAa3tOocPaJpv86nAH440xWHMBFjYfAaDS
         oI4kI4yCu9MiRY46XBfabsj7Ni/nNjSgK+9NZokqarHfllPg2bk9tG7vss33HmoOodFz
         2P4V5h/d+U9NuyjnwhfEasvuGnguPRu2ya6qlHTN9Tbt8XSvYCJTubFSYIiXwKpEzpgA
         4KEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=szmw41mx+6XBYQACHrQkcIv+dFLdnR82AVyDnrz/Mp4=;
        fh=mL1cWJLPhh8AxTBo7ywn4G+Enymx6NwqtWl+KR424i4=;
        b=CtVs3/PDYv9w2nUHYdbeekKFPzAIjm0fugqDkzgewcH0xRagD/lPTzLy9lr+/ZP5uI
         X6udVDuvkgcSW+2DFUKGUDjisRT2dbOLXI1A7vVpnLp/8ihZFqVAXsb5EVvWPt8IuQyC
         AST6u0XFsXXf420G3/A78jETkEww8ZPc6VVxTjgDWzz7/ncfR88EXCgVFr4EB+IVCVPj
         guctzfWyGvn3WcHxMZZvhMu+2uEQR8TEXCu7sPyf2ABfnqgOYt9RiNtqx7a+lSH0QjC2
         d7CQvcQBMGg2r+J9+AfGTfQnHgKxRWg7wC+gihxMGZA74SPlESj8UIa/sj95d0c9YtRf
         cREg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780481178; x=1781085978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szmw41mx+6XBYQACHrQkcIv+dFLdnR82AVyDnrz/Mp4=;
        b=Uv1kWKgyFHNmjv9vd6r7Yp2ty6AazyiO6Jot01FY4E8JEcy4DpBiRXqTAFyWufE+TT
         X6cM25kTO3Ks/mUQphnLt5aJNo63F5Uq0MvduKZMsjUUZsjxv7hRLDAwFmo6YwMm+15D
         csax9xggtyZ3od040Lgk81SnhDJXyDLI7QOUFa1NsVqwnBIWv7E+SyYnbX7ArjFoCNfu
         jGijwRjJGdEp3TvZHcCWZP0YwIAbmCWfRZWFogmepIGcTp7gbmNqLHqvqS9xFh9H0vam
         b2IwyarqacckRvcQ8znSg3umKaeVhC1SJFUZFN617NvSRRwj4E2zbLmZ3vhX93zK0043
         0mHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481178; x=1781085978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szmw41mx+6XBYQACHrQkcIv+dFLdnR82AVyDnrz/Mp4=;
        b=JUOA/CdD5Ujus4jk9hqkB1caJX4aVpIVqTXsxdUOkGGED6WzYxFdoXTS48z/BEyTas
         LZPQH7EG9MUWdCZDQJewOIHIyorkYnPKueitm15Mt9fqxvjZj1LnY3sQNIdGeTroS2AJ
         Uui6aIMlBpPAA3D5kqryYM3c4f3GogsFdoplwpOD3VTXDmM/mTlE/YdEuVDsECAXrq31
         QjJDJQn19NSX6pRfLciAq2muPYMYL+seecEq96BDV1AdgJKukMtHcx7edFNDespGGlPQ
         nmVHmsoRrDU4tkermuZF6zyQ71wRKwGwd/OUbsyWahREiRJleJvr2QZfP4IWjcrXxCaG
         s9Bg==
X-Forwarded-Encrypted: i=1; AFNElJ8eICYd/WkVlSYxJ5Lj9EbgZYi8LWQd99ABZafBjaOEA2kqDpVsQ5P5wzltMPNMqaEsjWJqNsDiFQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWk4KxgY7lz/RdfiO/3RA/xY07+iNGvZ2mQfJNfNLUNO/EfrE
	rKm6ZNQbyehzReNx+5ZxVVRy1R4pj5doAkF1C+tYfi6GGfR4OWGbrxUQK7hTN4yjEvsSfoJCtS8
	29fxmfs1irMZwUhX2UrJX12fyXB+rLNWlrjEATHkoxukr2FpALAA7SyNShjZ7ZKbV6jg33XdfoY
	NQc6CUD0612qPriXYOCL0aGIaoEV0HX6zd+Yuh
X-Gm-Gg: Acq92OFPg3mpRGkPDUHOiekXiLBjyvsnOidFOcckYkOQvRwFYxejegesWhjN5s7xmVl
	eBak7C9tTN0P4yAGB210qIo6mLuD5wX5tBkdr0W4umTIimBnz4dfJYg1y5yPjYGmNve06KkdDgO
	WOiwbzvitQDZgT+P49BplfZZgZdIqrf4nk/hCLHSABcQcOVHfug0uqYRmchADE8Y2OJdb9r1773
	lJ7duDne67TTt+R
X-Received: by 2002:a05:651c:315:b0:396:87d2:3b1b with SMTP id 38308e7fff4ca-396ac1f9945mr3945641fa.2.1780481178002;
        Wed, 03 Jun 2026 03:06:18 -0700 (PDT)
X-Received: by 2002:a05:651c:315:b0:396:87d2:3b1b with SMTP id
 38308e7fff4ca-396ac1f9945mr3945461fa.2.1780481177385; Wed, 03 Jun 2026
 03:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com> <20260603071342.641874-2-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260603071342.641874-2-ciprianmarian.costea@oss.nxp.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 3 Jun 2026 12:06:05 +0200
X-Gm-Features: AVHnY4LQCfd00tH5rxiK5efFUUkj2NKbx685IUyczLcBMy4pwr5STR5N8-L7DP8
Message-ID: <CALE0LRvQfsD7MZ2To5S1Yh90pVNKvqNWy=FGpXuGcPa1yEZSkA@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/8] can: flexcan: use dedicated IRQ handlers
 for multi-IRQ platforms
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7747-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:echanude@redhat.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[eballetb@redhat.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eballetb@redhat.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A355D636720

Hi Ciprian,

Thank you for the patch series.

On Wed, Jun 3, 2026 at 9:14=E2=80=AFAM Ciprian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:
>
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
> registered to the same flexcan_irq() handler. Since these are distinct IR=
Q
> numbers, they can be dispatched concurrently on different CPUs. Both
> instances then read the same iflag and ESR registers unconditionally,
> leading to duplicate frame processing.
>
> Fix this by splitting the monolithic handler into focused parts:
> - flexcan_do_mb(): processes mailbox events
> - flexcan_do_state(): processes device state change events
> - flexcan_do_berr(): processes bus error events
>
> Introduce dedicated IRQ handlers for multi-IRQ platforms:
> - flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
> - flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
> - flexcan_irq_berr(): bus-error-only, used for berr IRQ line
>
> The combined flexcan_irq() handler is preserved for single-IRQ
> platforms with no functional change.
>
> Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Adding here because it doesn't seem to have a cover letter. With the
full series applied on top of the current mainline

Tested-by: Enric Balletbo i Serra <eballetb@.redhat.com>

Tested on the NXP S32G399A-RDB3 with loopback and high-rate traffic.
No regressions observed: CAN frames transmit and receive correctly,
with no duplicates.
Frame reception showed no errors under stress testing.

Thanks,
   Enric
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 128 +++++++++++++++++++++----
>  1 file changed, 111 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503f..f73ff442d530 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1070,16 +1070,14 @@ static struct sk_buff *flexcan_mailbox_read(struc=
t can_rx_offload *offload,
>         return skb;
>  }
>
> -static irqreturn_t flexcan_irq(int irq, void *dev_id)
> +/* Process mailbox (RX + TX) events */
> +static irqreturn_t flexcan_do_mb(struct net_device *dev)
>  {
> -       struct net_device *dev =3D dev_id;
>         struct net_device_stats *stats =3D &dev->stats;
>         struct flexcan_priv *priv =3D netdev_priv(dev);
>         struct flexcan_regs __iomem *regs =3D priv->regs;
>         irqreturn_t handled =3D IRQ_NONE;
>         u64 reg_iflag_tx;
> -       u32 reg_esr;
> -       enum can_state last_state =3D priv->can.state;
>
>         /* reception interrupt */
>         if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
> @@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>                 netif_wake_queue(dev);
>         }
>
> +       return handled;
> +}
> +
> +/* Process bus error events */
> +static irqreturn_t flexcan_do_berr(struct net_device *dev)
> +{
> +       struct flexcan_priv *priv =3D netdev_priv(dev);
> +       struct flexcan_regs __iomem *regs =3D priv->regs;
> +       irqreturn_t handled =3D IRQ_NONE;
> +       u32 reg_esr;
> +
>         reg_esr =3D priv->read(&regs->esr);
>
> -       /* ACK all bus error, state change and wake IRQ sources */
> -       if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
> +       /* ACK bus error interrupt source */
> +       if (reg_esr & FLEXCAN_ESR_ERR_INT) {
>                 handled =3D IRQ_HANDLED;
> -               priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_=
WAK_INT), &regs->esr);
> +               priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
>         }
>
> -       /* state change interrupt or broken error state quirk fix is enab=
led */
> -       if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> -           (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE=
 |
> -                                          FLEXCAN_QUIRK_BROKEN_PERR_STAT=
E)))
> -               flexcan_irq_state(dev, reg_esr);
> -
>         /* bus error IRQ - handle if bus error reporting is activated */
>         if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
>             (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>                 flexcan_irq_bus_err(dev, reg_esr);
>
> +       return handled;
> +}
> +
> +/* Process device state change events */
> +static irqreturn_t flexcan_do_state(struct net_device *dev)
> +{
> +       struct flexcan_priv *priv =3D netdev_priv(dev);
> +       struct flexcan_regs __iomem *regs =3D priv->regs;
> +       irqreturn_t handled =3D IRQ_NONE;
> +       u32 reg_esr;
> +       enum can_state last_state =3D priv->can.state;
> +
> +       reg_esr =3D priv->read(&regs->esr);
> +
> +       /* ACK state change and wake IRQ sources */
> +       if (reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT)) {
> +               handled =3D IRQ_HANDLED;
> +               priv->write(reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ES=
R_WAK_INT),
> +                               &regs->esr);
> +       }
> +
> +       /* state change interrupt or broken error state quirk fix is enab=
led */
> +       if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> +           (priv->devtype_data.quirks &
> +           (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_=
STATE)))
> +               flexcan_irq_state(dev, reg_esr);
> +
>         /* availability of error interrupt among state transitions in cas=
e
>          * bus error reporting is de-activated and
>          * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
> @@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
id)
>                 }
>         }
>
> +       return handled;
> +}
> +
> +/* Combined IRQ handler for single-IRQ platforms */
> +static irqreturn_t flexcan_irq(int irq, void *dev_id)
> +{
> +       struct net_device *dev =3D dev_id;
> +       struct flexcan_priv *priv =3D netdev_priv(dev);
> +       irqreturn_t handled;
> +
> +       handled =3D flexcan_do_mb(dev);
> +       handled |=3D flexcan_do_state(dev);
> +       handled |=3D flexcan_do_berr(dev);
> +
> +       if (handled)
> +               can_rx_offload_irq_finish(&priv->offload);
> +
> +       return handled;
> +}
> +
> +/* Mailbox IRQ handler for multi-IRQ platforms */
> +static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
> +{
> +       struct net_device *dev =3D dev_id;
> +       struct flexcan_priv *priv =3D netdev_priv(dev);
> +       irqreturn_t handled;
> +
> +       handled =3D flexcan_do_mb(dev);
> +
> +       if (handled)
> +               can_rx_offload_irq_finish(&priv->offload);
> +
> +       return handled;
> +}
> +
> +/* Bus error IRQ handler for multi-IRQ platforms */
> +static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
> +{
> +       struct net_device *dev =3D dev_id;
> +       struct flexcan_priv *priv =3D netdev_priv(dev);
> +       irqreturn_t handled;
> +
> +       handled =3D flexcan_do_berr(dev);
> +
> +       if (handled)
> +               can_rx_offload_irq_finish(&priv->offload);
> +
> +       return handled;
> +}
> +
> +/* Device state change IRQ handler for multi-IRQ platforms */
> +static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
> +{
> +       struct net_device *dev =3D dev_id;
> +       struct flexcan_priv *priv =3D netdev_priv(dev);
> +       irqreturn_t handled;
> +
> +       handled =3D flexcan_do_state(dev);
> +
>         if (handled)
>                 can_rx_offload_irq_finish(&priv->offload);
>
> @@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
>
>         can_rx_offload_enable(&priv->offload);
>
> -       err =3D request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name=
, dev);
> +       if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> +               err =3D request_irq(dev->irq, flexcan_irq_mb,
> +                                 IRQF_SHARED, dev->name, dev);
> +       else
> +               err =3D request_irq(dev->irq, flexcan_irq,
> +                                 IRQF_SHARED, dev->name, dev);
>         if (err)
>                 goto out_can_rx_offload_disable;
>
>         if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
>                 err =3D request_irq(priv->irq_boff,
> -                                 flexcan_irq, IRQF_SHARED, dev->name, de=
v);
> +                                 flexcan_irq_boff, IRQF_SHARED, dev->nam=
e, dev);
>                 if (err)
>                         goto out_free_irq;
>
>                 err =3D request_irq(priv->irq_err,
> -                                 flexcan_irq, IRQF_SHARED, dev->name, de=
v);
> +                                 flexcan_irq_berr, IRQF_SHARED, dev->nam=
e, dev);
>                 if (err)
>                         goto out_free_irq_boff;
>         }
>
>         if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>                 err =3D request_irq(priv->irq_secondary_mb,
> -                                 flexcan_irq, IRQF_SHARED, dev->name, de=
v);
> +                                 flexcan_irq_mb, IRQF_SHARED, dev->name,=
 dev);
>                 if (err)
>                         goto out_free_irq_err;
>         }
> --
> 2.43.0
>


