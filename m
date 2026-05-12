Return-Path: <linux-can+bounces-7598-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKBfAD/9AmpOzQEAu9opvQ
	(envelope-from <linux-can+bounces-7598-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 12:13:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E14B51E567
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 12:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44AA63064128
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2133A6F08;
	Tue, 12 May 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD3A3Hk5"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA9346AC4
	for <linux-can@vger.kernel.org>; Tue, 12 May 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580439; cv=pass; b=oBBfITyh3UlGbPCD+R6Ckh+NXOCQ3+KLOw3bsTv4mfafOhvTreAFF8itJmzSxXjhSpzbTp3k08MoZrN/P3jSmjb4YXGFTR8Q7PgtShzaeRYPk0Ay3P1dGR2UeEMe0GcNr2WXfyayrtQkaQJv9TzdVVVAlEi4e6HJO99YSFpPR/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580439; c=relaxed/simple;
	bh=TJ3VzpnsDR9+okAebtzJ578WGb/pwkP3it3lhC4rtrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfRqsJ6IbqGj/vWAW0wKoR8946f3CWzSsHXZggiHxmXvctKUq/NgjHvMVIEq8A7hwCzPXqvmKRyB5yoi0GNPhVc8D9N9fQq2EMBAI0Gk7rH5p4ZZLdntUpKN0do/qRbwny+cZ/kLveVRzPzjEbf2jQpdUFysOvudfqpFS/lhU3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD3A3Hk5; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so9323265a12.0
        for <linux-can@vger.kernel.org>; Tue, 12 May 2026 03:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778580433; cv=none;
        d=google.com; s=arc-20240605;
        b=aY1p/30vfhO2grDnH/8hIQJ5qwwonMMdDzWyJ312ZdyUD5D1ared40RWn/32u3n9WT
         ryRYTNu++kRyyMRvZnQGi2vCghUO9nLRokB61RQ1YFgo6Ezbg15fsrkRCB10/GlvsXME
         Nt+C6kG3bzbLhg1aChzSFuoGuy70EBZFHgVliBiUm7xvtCTVJp/pFXZZj2jQlnaJxBRI
         SMK3ukLnc8HCkrJVWMmSDBHDjL0VbHYGYpixAqI+uhmcEDVxU24mN6OMIOr70GNd8bgV
         qz8tUHTpVQbD5MPmA9wJCNVTuQKIWUeIf7ofrdWlKKEh6HcfTUd+rc8JTBj9qGagVVUp
         macg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tX7ywuewMGw3Ld3p25pdc9W6MqhJu/knbiI0jlAqXJM=;
        fh=P2hVssZfCtYVd12JfQShm7m4YD+sccbgUuxUCRVNWI0=;
        b=OM9k4t6gMSJA53mGr/V2ihe+Ld8Qaxz7bV2i+8l6n3L9voutLhB5+BcZ5LqTAUmOY1
         BHe3w6+3rkBIZbSMvKW0WHchD5MyyiwjaTCYDxEMLBTGnGmMLCVpvheGJepP52Fqu3hr
         WNwtyzlFk7ti0j5MswHJSA2P6lwcM0pYGO4g01nXMwUChWRBUZAM9kw4eSz3ThIBBhzb
         z78xmmbXS1r2EBouKb/9BWIlxVaZvYSRq34r+BZKEsNS6FGm4YfPPbXW+6nv1I8d3QqL
         zynD5HEyxPoO3DBvRv7UkuFhCoXwp2/8ok4WnM1uYJ/367+xY+lAFQg/z8qxacFb5Z1p
         E/uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778580433; x=1779185233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tX7ywuewMGw3Ld3p25pdc9W6MqhJu/knbiI0jlAqXJM=;
        b=TD3A3Hk5RsojzqBRzPYz1/HX4r/Wn4ETeZUYO8mCHFUHeAvmxhtJ317DFar0/XAVbh
         RT076W3p+XO1YMoxZJXzsNtiupUbaX4LKk4NdywwiOZIsN78j6vmMrh8GTTGXV/dP+nH
         nKl1asKIRgqSBiM/Tmgi8fFYBuM9phaUOwCx1DJqj/FMugxvWPhRw+YPdIJkvA5qbUgp
         NLWb4kfJYVe47Tl3Wc39gxrK8gchjmZUve4Tpe9mA0azY42ivOMWExO8D0IQXzT1HzfF
         RYgANwOGgOrdHR50SLj7Ea7mNhUZOzmjZroO92aHEQJHLmrWOK+spxqbHwqgoK1QXEO5
         nfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580433; x=1779185233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tX7ywuewMGw3Ld3p25pdc9W6MqhJu/knbiI0jlAqXJM=;
        b=jlFgPV2URNN49pPITqhTe83l6pxz0iZIWBaOeMFcEw3LlYQVAtICmkrGi0R4zAmVbp
         TnM+n4czXgX1ZH9bsfZtv4sZuOGi0g5eH71pRPiriOO4aD2GK7jd7heUMXAGPgAozIuH
         OQWmxQJ/bZoJtKstv+KnThkFXncr0hpO8nkhVyYijQSb0Azd+Fm/maXH3D2jVMpYHWag
         JUdRdSs+jDrlrjlZSeSweLL6jXw2+e5gzxgBxlGrySa7PBliTpjm4s0+Kao2+dBC5bAy
         KgiayAMgr9KYM9BcYFs89ufv7JUFnyIuFZm9gBBRJt6RhPA9UHwldh0klmmn6o8kqpiS
         G6vQ==
X-Forwarded-Encrypted: i=1; AFNElJ/p74GUxsUC4CZkMW+mGprJPzfTtDzBbY6YkRc9Hz5/gkIaacMfaToEoujCSBvve8nf+y5xYXK19T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFlsrKt9pt106Wg+bOnxpPKZ5UKAjMN7bxVKnHVRa8xJ+tojL
	RCUmAqY+JOyfbmcHGt9aT9dR6ZGuGjcK8Iu3u6ZlB6zVS76JcbF2uXK5ePP3eYCKLHnx3H8sNh4
	dYZeII+WKzIgbymhZlYeAyRR9TNsUqJM=
X-Gm-Gg: Acq92OFH6mrVJPB47YG1T/1HATSY6pJBxZJcsn1b0mr7AikQ/J3iYwB7JCVcNSqY60z
	NWAJx9nuw1qsu/ahKmPA5ue4UYGx0TSA72j4qtLMQP4TJpJ6Mmdrwh7LxTstzQ0kplYsrvUIrJO
	ckPHJXlLnNOHB6ui7wft0HsxZANWaxH6EjNojSmSzUmAgAYFIQDRODfn6qGa9uK0hyQufFRzg/e
	6mtVlM7/68Goe6l73NHOrsqpkqQ/RpUw1M6tc06zRSXLanCCwWQPXOBMrU3tjzw/Clse0otc0Lc
	DIuhb5su
X-Received: by 2002:a05:6402:3908:b0:678:a507:e82d with SMTP id
 4fb4d7f45d1cf-67f718da6b0mr6982993a12.25.1778580432581; Tue, 12 May 2026
 03:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777273055.git.zhoubinbin@loongson.cn> <ee7e4e0d968428761b0fc50e56560165b4020161.1777273055.git.zhoubinbin@loongson.cn>
 <10ea6570-56d7-47ab-9082-3fc8f96d989d@kernel.org>
In-Reply-To: <10ea6570-56d7-47ab-9082-3fc8f96d989d@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 12 May 2026 18:06:59 +0800
X-Gm-Features: AVHnY4KxWvpskvfK3qMQJqeTPL21k_bfRauoUJtKE5PG4fLBozGrId3dhtQRyqU
Message-ID: <CAMpQs4J068sWWDmU5Dgn3SfMo5cTQvJwhguKbdQ9WghOSVS4zQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] can: loongson_canfd: Add RXDMA support
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Bingxiong Li <libingxiong@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-can@vger.kernel.org, jeffbai@aosc.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4E14B51E567
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7598-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubbaaron@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Vincent:

Thanks so much for your thorough review.

On Thu, May 7, 2026 at 1:51=E2=80=AFAM Vincent Mailhol <mailhol@kernel.org>=
 wrote:
>
> On 27/04/2026 at 09:18, Binbin Zhou wrote:
> > Add optional DMA support for RX path using the Loongson APB CMC DMA
> > engine. When a DMA channel is successfully requested, the driver:
> >
> > - Uses DMA cyclic transfers to write incoming CAN frames directly to
> >   a coherent DMA buffer
> > - Replaces RXBNEI (RX buffer not empty interrupt) with DMADI (DMA
> >   done interrupt)
> > - Dynamically switches between DMA and PIO modes based on channel
> >   availability
> >
> > This significantly reduces CPU intervention under high RX load,
> > especially beneficial for CAN FD at higher data rates.
> >
> > Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
> > Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/net/can/loongson_canfd/Kconfig        |   2 +-
> >  .../net/can/loongson_canfd/loongson_canfd.c   | 179 ++++++++++++++++--
> >  2 files changed, 160 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/net/can/loongson_canfd/Kconfig b/drivers/net/can/l=
oongson_canfd/Kconfig
> > index 5a2540bb5410..8fe44b804991 100644
> > --- a/drivers/net/can/loongson_canfd/Kconfig
> > +++ b/drivers/net/can/loongson_canfd/Kconfig
> > @@ -5,7 +5,7 @@
> >  #
> >  config CAN_LOONGSON_CANFD
> >       tristate "Loongson CAN-FD driver"
> > -     depends on HAS_IOMEM
> > +     depends on HAS_IOMEM && LOONGSON2_APB_CMC_DMA
>
> Allow people to compile test your driver:
>
>         depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)

OK, I will add COMPILE_TEST in patch-1.
>
> >       select REGMAP_MMIO
> >       help
> >         This is a canfd driver switch for the Loongson platform,
> > diff --git a/drivers/net/can/loongson_canfd/loongson_canfd.c b/drivers/=
net/can/loongson_canfd/loongson_canfd.c
> > index 20ac95dc528d..ba9570c34c94 100644
> > --- a/drivers/net/can/loongson_canfd/loongson_canfd.c
> > +++ b/drivers/net/can/loongson_canfd/loongson_canfd.c
> > @@ -6,10 +6,14 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/acpi_dma.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/bits.h>
> >  #include <linux/can/dev.h>
> >  #include <linux/can/error.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-direction.h>
> > +#include <linux/dma-mapping.h>
> >  #include <linux/io.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > @@ -26,13 +30,21 @@
> >  #define DEV_NAME                     "loongson_canfd"
> >  #define LOONGSON_CANFD_TXBUF_NUM     8
> >  #define LOONGSON_CANFD_ID            0xBABE
> > +#define RX_BUF_SIZE                  SZ_1K
> > +#define LOONGSON_CANFD_DMA_RXDATA_NUM        (RX_BUF_SIZE / DMA_SLAVE_=
BUSWIDTH_4_BYTES)
> >
> >  struct loongson_canfd_priv {
> >       struct can_priv         can;            /* must be first member! =
*/
> >       struct napi_struct      napi;
> >       struct regmap           *regmap;
> >       struct resource         *res;
> > +     struct dma_chan         *rx_ch;
> > +     dma_addr_t              rx_dma_buf;     /* dma rx buffer bus addr=
ess */
> > +     unsigned int            *rx_buf;        /* dma rx buffer cpu addr=
ess */
> > +     u16                     last_res;
> >       spinlock_t              tx_lock;        /* protect the sending qu=
eue */
> > +     u32 (*get_rx_data)(struct loongson_canfd_priv *priv);
> > +     bool (*get_rx_pending)(struct loongson_canfd_priv *priv);
> >  };
> >
> >  enum loongson_canfd_tx_bs {
> > @@ -137,6 +149,54 @@ static int loongson_canfd_reset(struct net_device =
*ndev)
> >       return 0;
> >  }
> >
> > +static u32 loongson_canfd_get_rxdma_data(struct loongson_canfd_priv *p=
riv)
> > +{
> > +     u32 c =3D 0;
> > +
> > +     c =3D priv->rx_buf[LOONGSON_CANFD_DMA_RXDATA_NUM - priv->last_res=
--];
> > +     if (priv->last_res =3D=3D 0)
> > +             priv->last_res =3D LOONGSON_CANFD_DMA_RXDATA_NUM;
> > +
> > +     return c;
> > +}
> > +
> > +static bool loongson_canfd_rxdma_pending(struct loongson_canfd_priv *p=
riv)
> > +{
> > +     enum dma_status status;
> > +     struct dma_tx_state state;
> > +
> > +     status =3D dmaengine_tx_status(priv->rx_ch, priv->rx_ch->cookie, =
&state);
> > +
> > +     if (priv->last_res !=3D (state.residue / DMA_SLAVE_BUSWIDTH_4_BYT=
ES) &&
> > +         status =3D=3D DMA_IN_PROGRESS)
> > +             return true;
> > +
> > +     return false;
>
>   return priv->last_res !=3D (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTES)
> && status =3D=3D DMA_IN_PROGRESS
>
> > +}
> > +
> > +static u32 loongson_canfd_get_poll_data(struct loongson_canfd_priv *pr=
iv)
> > +{
> > +     u32 data;
> > +
> > +     regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> > +
> > +     return data;
> > +}
> > +
> > +static bool loongson_canfd_rxpoll_pending(struct loongson_canfd_priv *=
priv)
> > +{
> > +     u32 rx_sts;
> > +
> > +     regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
> > +
> > +     return FIELD_GET(REG_RX_STAT_RXFRC, rx_sts) ? true : false;
> > +}
> > +
> > +static void loongson_canfd_rxdma_remove(struct loongson_canfd_priv *pr=
iv, struct device *dev)
> > +{
> > +     dma_free_coherent(dev, RX_BUF_SIZE, priv->rx_buf, priv->rx_dma_bu=
f);
> > +}
> > +
> >  static int loongson_canfd_set_btr(struct net_device *ndev, struct can_=
bittiming *bt, bool nominal)
> >  {
> >       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> > @@ -308,7 +368,9 @@ static int loongson_canfd_chip_start(struct net_dev=
ice *ndev)
> >       if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> >               int_ena |=3D REG_INT_STAT_ALI | REG_INT_STAT_BEI;
> >
> > -     int_ena =3D REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STA=
T_FCSI | REG_INT_STAT_RBNEI;
> > +     int_ena =3D REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STA=
T_FCSI;
> > +     int_ena |=3D priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNE=
I;
> > +
> >       int_msk =3D ~int_ena; /* Mask all disabled interrupts */
> >
> >       /* It's after reset, so there is no need to clear anything */
> > @@ -514,12 +576,12 @@ static void loongson_canfd_read_rx_frame(struct l=
oongson_canfd_priv *priv, struc
> >
> >       /* Data */
> >       for (i =3D 0; i < len; i +=3D 4) {
> > -             regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> > +             data =3D priv->get_rx_data(priv);
> >               *(__le32 *)(cf->data + i) =3D cpu_to_le32(data);
> >       }
> >
> >       while (unlikely(i < wc * 4)) {
> > -             regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> > +             data =3D priv->get_rx_data(priv);
> >               i +=3D 4;
> >       }
> >  }
> > @@ -532,8 +594,8 @@ static int loongson_canfd_rx(struct net_device *nde=
v)
> >       struct sk_buff *skb;
> >       u32 meta0, meta1;
> >
> > -     regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
> > -     regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
> > +     meta0 =3D priv->get_rx_data(priv);
> > +     meta1 =3D priv->get_rx_data(priv);
> >
> >       /* Number of characters received */
> >       if (!FIELD_GET(REG_FRAME_FORMAT_W_RWCNT, meta1))
> > @@ -718,16 +780,16 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
> >       struct net_device *ndev =3D napi->dev;
> >       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> >       int work_done =3D 0, res =3D 1;
> > -     u32 sts, rx_frc, rx_sts;
> > +     int int_ena =3D priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_R=
BNEI;
> > +     u32 sts;
> > +     bool rx_frc;
> >
> > -     regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
> > -     rx_frc =3D FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
> > +     rx_frc =3D priv->get_rx_pending(priv);
> >
> >       while (rx_frc && work_done < quota && res > 0) {
> >               res =3D loongson_canfd_rx(ndev);
> >               work_done++;
> > -             regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts=
);
> > -             rx_frc =3D FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
> > +             rx_frc =3D priv->get_rx_pending(priv);
> >       }
> >
> >       /* Check for RX FIFO Overflow */
> > @@ -757,13 +819,11 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
> >       if (!rx_frc && res !=3D 0) {
> >               if (napi_complete_done(napi, work_done)) {
> >                       /*
> > -                      * Clear and enable RBNEI. It is level-triggered,=
 so
> > +                      * Clear and enable RBNEI/DMADI. It is level-trig=
gered, so
> >                        * there is no race condition.
> >                        */
> > -                     regmap_write(priv->regmap, LOONGSON_CANFD_INT_STA=
T,
> > -                                  REG_INT_STAT_RBNEI);
> > -                     regmap_write(priv->regmap, LOONGSON_CANFD_INT_MAS=
K,
> > -                                  (REG_INT_STAT_RBNEI << 16));
> > +                     regmap_write(priv->regmap, LOONGSON_CANFD_INT_STA=
T, int_ena);
> > +                     regmap_write(priv->regmap, LOONGSON_CANFD_INT_MAS=
K, (int_ena << 16));
> >               }
> >       }
> >
> > @@ -855,7 +915,7 @@ static irqreturn_t loongson_canfd_interrupt(int irq=
, void *dev_id)
> >       struct net_device *ndev =3D (struct net_device *)dev_id;
> >       struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> >       int irq_loops;
> > -     u32 isr;
> > +     u32 isr, mask;
> >       u16 icr;
> >
> >       for (irq_loops =3D 0; irq_loops < 10000; irq_loops++) {
> > @@ -864,14 +924,16 @@ static irqreturn_t loongson_canfd_interrupt(int i=
rq, void *dev_id)
> >               if (!isr)
> >                       return irq_loops ? IRQ_HANDLED : IRQ_NONE;
> >
> > +             mask =3D priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_=
RBNEI;
> > +
> >               /* Receive Buffer Not Empty Interrupt */
> > -             if (FIELD_GET(REG_INT_STAT_RBNEI, isr)) {
> > +             if (isr & mask) {
> >                       /*
> >                        * Mask RXBNEI the first, then clear interrupt an=
d schedule NAPI.
> >                        * Even if another IRQ fires, RBNEI will always b=
e 0 (masked).
> >                        */
> > -                     regmap_write(priv->regmap, LOONGSON_CANFD_INT_MAS=
K, REG_INT_STAT_RBNEI);
> > -                     regmap_write(priv->regmap, LOONGSON_CANFD_INT_STA=
T, REG_INT_STAT_RBNEI);
> > +                     regmap_write(priv->regmap, LOONGSON_CANFD_INT_MAS=
K, mask);
> > +                     regmap_write(priv->regmap, LOONGSON_CANFD_INT_STA=
T, mask);
> >                       napi_schedule(&priv->napi);
> >               }
> >
> > @@ -1054,11 +1116,56 @@ static const struct regmap_config loongson_cang=
fd_regmap =3D {
> >       .cache_type     =3D REGCACHE_MAPLE,
> >  };
> >
> > +static int loongson_canfd_rxdma_init(struct loongson_canfd_priv *priv,=
 struct device *dev)
> > +{
> > +     struct dma_slave_config config;
> > +     struct dma_async_tx_descriptor *desc =3D NULL;
> > +     int ret;
> > +
> > +     priv->rx_buf =3D dma_alloc_coherent(dev, RX_BUF_SIZE, &priv->rx_d=
ma_buf, GFP_KERNEL);
> > +     if (!priv->rx_buf)
> > +             return -ENOMEM;
> > +
> > +     /* Configure DMA channel */
> > +     memset(&config, 0, sizeof(config));
> > +     config.src_addr =3D priv->res->start + LOONGSON_CANFD_RX_DATA;
> > +     config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +
> > +     ret =3D dmaengine_slave_config(priv->rx_ch, &config);
> > +     if (ret < 0) {
> > +             dev_err(dev, "rx dma channel config failed\n");
> > +             goto err_config;
> > +     }
> > +
> > +     /* Prepare a DMA cyclic transaction */
> > +     desc =3D dmaengine_prep_dma_cyclic(priv->rx_ch, priv->rx_dma_buf,
> > +                                      RX_BUF_SIZE, RX_BUF_SIZE,
> > +                                      DMA_DEV_TO_MEM, DMA_PREP_INTERRU=
PT);
> > +     if (!desc) {
> > +             dev_err(dev, "rx dma prep cyclic failed\n");
> > +             ret =3D -EBUSY;
> > +             goto err_config;
> > +     }
> > +
> > +     /* Push current DMA transaction in the pending queue */
> > +     dmaengine_submit(desc);
> > +
> > +     /* Issue pending DMA requests */
> > +     dma_async_issue_pending(priv->rx_ch);
> > +
> > +     return 0;
> > +
> > +err_config:
> > +     loongson_canfd_rxdma_remove(priv, dev);
> > +     return ret;
> > +}
> > +
> >  static int loongson_canfd_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> >       struct loongson_canfd_priv *priv;
> >       struct net_device *ndev;
> > +     struct dma_chan *rx_ch;
> >       struct regmap *regmap;
> >       struct resource *res;
> >       void __iomem *base;
> > @@ -1079,14 +1186,24 @@ static int loongson_canfd_probe(struct platform=
_device *pdev)
> >       if (irq < 0)
> >               return irq;
> >
> > +     rx_ch =3D dma_request_chan(dev, "rx");
> > +     if (PTR_ERR(rx_ch) =3D=3D -EPROBE_DEFER)
> > +             return -EPROBE_DEFER;
> > +
> > +     if (IS_ERR(rx_ch)) {
> > +             dev_warn(dev, "Fall back in poll mode for any non-deferra=
l error.\n");
> > +             rx_ch =3D NULL;
> > +     }
> > +
> >       /* Create a CAN device instance */
> >       ndev =3D alloc_candev(sizeof(*priv), LOONGSON_CANFD_TXBUF_NUM);
> >       if (!ndev)
> > -             return -ENOMEM;
> > +             goto err_dma_rx;
> >
> >       priv =3D netdev_priv(ndev);
> >       spin_lock_init(&priv->tx_lock);
> >       priv->regmap =3D regmap;
> > +     priv->rx_ch =3D rx_ch;
> >       priv->res =3D res;
> >
> >       priv->can.clock.freq =3D clk_rate;
> > @@ -1111,6 +1228,19 @@ static int loongson_canfd_probe(struct platform_=
device *pdev)
> >       if (ret < 0)
> >               goto err_candev_free;
> >
> > +     if (priv->rx_ch) {
> > +             priv->get_rx_data =3D loongson_canfd_get_rxdma_data;
> > +             priv->get_rx_pending =3D loongson_canfd_rxdma_pending;
> > +             priv->last_res =3D LOONGSON_CANFD_DMA_RXDATA_NUM;
> > +             ret =3D loongson_canfd_rxdma_init(priv, dev);
> > +             if (ret) {
> > +                     dev_err(dev, "interrupt mode used for rx (no dma)=
\n");
> > +                     goto err_candev_free;
> > +             }
> > +     } else {
> > +             priv->get_rx_data =3D loongson_canfd_get_poll_data;
> > +             priv->get_rx_pending =3D loongson_canfd_rxpoll_pending;
> > +     }
> >       netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);
> >
> >       ret =3D register_candev(ndev);
> > @@ -1123,6 +1253,9 @@ static int loongson_canfd_probe(struct platform_d=
evice *pdev)
> >
> >  err_candev_free:
> >       free_candev(ndev);
> > +err_dma_rx:
> > +     if (rx_ch)
> > +             dma_release_channel(rx_ch);
> >       return ret;
> >  }
> >
> > @@ -1133,6 +1266,11 @@ static void loongson_canfd_remove(struct platfor=
m_device *pdev)
> >
> >       netdev_dbg(ndev, "loongson_canfd_remove");
> >
> > +     if (priv->rx_ch) {
> > +             loongson_canfd_rxdma_remove(priv, &pdev->dev);
> > +             dma_release_channel(priv->rx_ch);
> > +     }
> > +
> >       unregister_candev(ndev);
> >       netif_napi_del(&priv->napi);
> >       free_candev(ndev);
> > @@ -1154,6 +1292,7 @@ static struct platform_driver loongson_canfd_driv=
er =3D {
> >  };
> >  module_platform_driver(loongson_canfd_driver);
> >
> > +MODULE_SOFTDEP("pre: loongson2-apb-cmc-dma");
>
> Is this really needed? Isn't it enough to just put the
> LOONGSON2_APB_CMC_DMA dependency in Kconfig?

It is required; otherwise, the DMA data transfer will fail immediately.
>
> >  MODULE_AUTHOR("Loongson Technology Corporation Limited");
> >  MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
> >  MODULE_LICENSE("GPL");
>
>
> Yours sincerely,
> Vincent Mailhol
>

--
Thanks.
Binbin

