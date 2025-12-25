Return-Path: <linux-can+bounces-5935-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32148CDD6D1
	for <lists+linux-can@lfdr.de>; Thu, 25 Dec 2025 08:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B492F3015028
	for <lists+linux-can@lfdr.de>; Thu, 25 Dec 2025 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2A2F39B8;
	Thu, 25 Dec 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilbkhPYD"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44E2D7DC0
	for <linux-can@vger.kernel.org>; Thu, 25 Dec 2025 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647746; cv=none; b=JGh2VpGE0F8o5NKLxaDRisX/807Po149D7+zMBUsl3YBNECyu1p9Sw43k65qxvs1LTpEUz9rKQyTQ8EkP8u1LCutRhDxK7D0PjHaoiMoSXlejJBGz97gy3MWrJtdxXQAaD/PXNDK70lftECaUTmIEVpO0dcfXObdS3ePks34v4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647746; c=relaxed/simple;
	bh=8vRLfhIUeM10MZQMkRFvfBNtxfHbjybdfprvT3apTE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N16C69eztPy3k8vNy45dnjGTRqFf4oF2dY0AHmAJKFcl6FPQXnq9h+TKrq7gtstFC3ftZ3DOgjFgKOaZs3AIFhkQ1dN36HL9HpfiMij2GrM3DYTlWLCL/MGM4OQ87JdMdQ7O/DgW4JTqyw5Hi+AI5vNUmE4fzfSeDtHvhhQ/GQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilbkhPYD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7e2762ad850so6722723b3a.3
        for <linux-can@vger.kernel.org>; Wed, 24 Dec 2025 23:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766647744; x=1767252544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4PxTLcRhV02JhrM3zAG0ZiRLecDRevSACvJtyy7e18=;
        b=ilbkhPYD5dBYW1UZdsEiWf0GMP5PI/CBrf9BYOC0gaQmlOf4esaNBaOHk751LjXw+i
         O7opan1b+FKhkxt3RW9+dXbUSQUHi6eQoQA8JEALAHOugdfmsAh9NdHJoZtMSCu6chDf
         gteEp+gpV9HfT2DWwsDNWR8auiCUthV9c9XDJH219mkhu+8Gg6kHOtjm9reS2WlY9Sa8
         +4qG1KQzD6Su1tQVn5zMKxZEZ6Ff94FMiuV+ZGAyAgBfmlTdpz7YoLE4+iCh/GlM5TSa
         KxBidVvRGKRBrq4e2mjqfGKgHG8+Sd4E3eGwR2scsgs+bDbv/lhhk1SAu908g7mC2vx5
         208g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766647744; x=1767252544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H4PxTLcRhV02JhrM3zAG0ZiRLecDRevSACvJtyy7e18=;
        b=aEE9nK/ZInXDAz8CO9QUxsBOkkIrw32CplNw3PGs8DoFbBeDKNs1EbR1N0Gae7VOiu
         bgizPtHsKFGpZXY6vQgk2aC0YN/16OzkPXTTjqNd6UeJQ5cXAs+pE7AgVxZVYkSSwhkw
         9gBecPa1lfaACuYhK1zACjoXdNk8lhlwYPVC0W6mA9b9pT5zDukMrVGCIjCORbb1C37T
         05YDFbpJYkMs3ikIum9dU5Ypl7YkPWdSkG7CgAjA7+Yfz2QUpRXJCGLnCix2WXI32n42
         gna8a7EjbqsGziyagh5iby+hKtI3KC3Ynz5rBX0mx26TwUljFVeOemhwMpyaxxxcNxjk
         vmgg==
X-Gm-Message-State: AOJu0YyRp0YNrGeDhSj5pUT1Ha0ztrdnBzbmgLRQiKPzZaQ7Ovl8lf6q
	+k7sqVtQ/n9u+AhhBSJbt0/4PMI9eLVCy7uSHxErjiVBZlmZxhsaEuYB
X-Gm-Gg: AY/fxX7rTIKsD38oqJSqPxD300O9xUoVudJQopYLVMNUF/lhq0Kk6aueRaramBXtp40
	X0/vcz3qTa8GolQfBPbhTMu8mtUImy/1/o7lxbQo11A+eTFvWjRprm27fh0y8V8mkBLJO3FgCfX
	4rW0dpukzWjNMJAPB4H+wMuH47TPrEQAEyaih+jGAP3/3HSi3tebSHqFmbQKM2wDqjouKsFBncx
	0jUDLITiNQdXl0AL1aswDTI0AKX96gnVni8/vEykuRO+ihtVs1DV5l9mVnXkPx9OwZgf2GpP08S
	468zkkSIijomMmSEqnwU5Xrk107qJcYYgMczoweq0dhcVJDa7ab0mKPg30JlPZ0eXFr6JtFAJtM
	42kg1ym6N4MEdDq8zPH8yOyil9I9XzgfDvlgb2MxU/Huzwlx1ZDCRQu9KuNBm5zjPm2YKTlZZm4
	EsoPgvpKOoCtawNPiugja3ZGs+bHU=
X-Google-Smtp-Source: AGHT+IG6opa3oqxFSPA/MNWdnHMCdRbA3sZg+BBm70hMufpLc03qIkSSDXXBZ4h+R9OYRZU0x56APg==
X-Received: by 2002:a05:6a21:3282:b0:366:14ac:e1fa with SMTP id adf61e73a8af0-376aa6eadfemr19958794637.76.1766647743863;
        Wed, 24 Dec 2025 23:29:03 -0800 (PST)
Received: from rakuram-MSI ([2409:40f4:2007:f705:4461:8ef4:d041:3e1c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7e2sm20218153a91.2.2025.12.24.23.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 23:29:03 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	rakuram.e96@gmail.com,
	socketcan@hartkopp.net
Subject: Re: [RFC PATCH 1/2] can: dummy_can: add CAN termination support
Date: Thu, 25 Dec 2025 12:58:54 +0530
Message-ID: <20251225072857.53085-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: a85b8659-d4c8-443b-abb1-ae557a2a9896@kernel.org
References: <a85b8659-d4c8-443b-abb1-ae557a2a9896@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Vincent, 

Thank you for the review and the detailed feedback.

On Wed, 24 Dec 2025 at 03:03, Vincent Mailhol <mailhol@kernel.org> wrote:
>
> Hi Rakuram,
>
> Thanks for the patch. My comments are only on the cosmetic aspect.
>
> Le 27/11/2025 à 20:18, Rakuram Eswaran a écrit :
> > Add support for configuring bus termination in the dummy_can driver.
> > This allows users to emulate a properly terminated CAN bus when
> > setting up virtual test environments.
> >
> > Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> > ---
> > Tested the termination setting using below iproute commands:
> >
> >   ip link set can0 type can termination 120
> >   ip link set can0 type can termination off
>
> When you test, do not forget to also try incorrect values ;)
>
>   ip link set can0 type can termination 100

Noted. I did test with invalid numeric values and observed that
they were ignored.

>   ip link set can0 type can termination potato

Good point — I had not explicitly tested non-numeric inputs.
I will verify this case as well.

>
> (I think that the code is correct, just see this as a generic
> comment).
>
> >  drivers/net/can/dummy_can.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
> > index 41953655e3d3..2949173547e6 100644
> > --- a/drivers/net/can/dummy_can.c
> > +++ b/drivers/net/can/dummy_can.c
> > @@ -23,6 +23,21 @@ struct dummy_can {
> >
> >  static struct dummy_can *dummy_can;
> >
> > +static const u16 dummy_can_termination_const[] = {
> > +     CAN_TERMINATION_DISABLED,       /* 0 = off */
> > +     120,                            /* 120 Ohms */
> > +};
> > +
> > +static int dummy_can_set_termination(struct net_device *dev, u16 term)
> > +{
> > +     struct dummy_can *priv = netdev_priv(dev);
> > +
> > +     netdev_dbg(dev, "set termination to %u Ohms\n", term);
> > +     priv->can.termination = term;
> > +
> > +     return 0;
> > +}
>
> The driver has a kind of structure:
>
>   - first the const bittiming struct declarations
>   - then the dummy_can_print_*() functions
>   - finally the actual code
>
> Try to preserve this structure when adding your changes.

Acknowledged. I will reorder the termination-related additions to match
the existing structure in the next revision.

>
> >  static const struct can_bittiming_const dummy_can_bittiming_const = {
> >       .name = "dummy_can CC",
> >       .tseg1_min = 2,
> > @@ -250,6 +265,12 @@ static int __init dummy_can_init(void)
> >       priv->can.xl.data_bittiming_const = &dummy_can_xl_databittiming_const;
> >       priv->can.xl.tdc_const = &dummy_can_xl_tdc_const;
> >       priv->can.xl.pwm_const = &dummy_can_pwm_const;
> > +    
> > +     /* Advertise software termination support */
>
> This comment doesn't add much value. You may omit it.
>

Ack. Will remove it.

> > +     priv->can.termination_const = dummy_can_termination_const;
> > +     priv->can.termination_const_cnt = ARRAY_SIZE(dummy_can_termination_const);
> > +     priv->can.do_set_termination = dummy_can_set_termination;
>
> Here also try to maintain so kind of order: your declaration of
> dummy_can_termination_const is before the other const struct
> declarations, but the priv->can assignment is done after the other
> assignments. Not a big deal but it is nicer to keep the declaration
> and the assignments in the same order.
>

Ack. I will align the declaration and the corresponding assignments to
keep the ordering consistent.

I will address these points and send an updated version. Is it okay to send
the next version without the RFC tag?

Best Regards,
Rakuram

