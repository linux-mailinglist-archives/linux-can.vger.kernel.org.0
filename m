Return-Path: <linux-can+bounces-3824-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CAEAD6F16
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2C53A888D
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F62F4314;
	Thu, 12 Jun 2025 11:34:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93CEC2;
	Thu, 12 Jun 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728044; cv=none; b=MkEJ9Rmw4n3qZFgwnMUzKVtns4DyIFKByXogE/ENzlAaBQ6mmzat482ayeiHUCnW2H7JOeJRUIy42vvYWOuhzpp3Hc9Rei7y9+dNv7cUYJbwn2+2hQh61lkqCzef9VYWzehBLYA2jzoyE4l5bHLvlgugC9JGzS/C8t350S8PZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728044; c=relaxed/simple;
	bh=oJmbUiZ/kU6IuF5+FzbWKirIJYndUG7+SYQ7PWPAEaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7KXEOkdTIt5cW89TPkbLZnxjpMFRZA+ux4BoABEJJmJKevfchuLt0t8a50sKgBSTor5ws1g6pUeGZf+2Jpzpp24JXt2Z7RP1nO7twT8jLoKIQGh7iMgVyMGzH4KPMGtNiYoL+LOE9TwJMFUXLOtPe8UPnNabvKazeKp3/vPkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e7b8112f4dso226225137.0;
        Thu, 12 Jun 2025 04:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728040; x=1750332840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2e04F18MiWEOEGCvxzdMdeRWfi39l+x6X4Bb2RiR5ak=;
        b=offvl2WKJLch/zPV1X+MWlBZltixrdedlQzGNSYTXZgn5BoBvXIVAb8xR83v0eg55k
         AEImUPk/F+EOC0vTlzGwo3SAOPVDcocItdM4gu7QXmS0Yyvtr8dEBK1VqEvU9aCO5/7F
         NhlJKdlVHf2wESgjd7KQ7TJrulgFWvIcYNLTLv0q+KASdjE4SJu7C5tkDH1PGxq8UmIo
         9SYWgghG4vneIm/NbNot6D1XmZZH5KlDeNNev/eDe0ffp+mX/Mn7jM3VDlL7qaHhweHs
         QneIeQ3/yYcS3h/js6JuwvJLDE2+CEQEKdD2oS79E9l0eSUVoEa72v+zk8BpP4WwtYQ3
         AkhA==
X-Forwarded-Encrypted: i=1; AJvYcCW18aqjPokIx1AA7Mft5qMvjgRjOsR8rWplETawqRRmWh0hkCnhp6Ep+2/56i9x578RDkqkVlGTyQQ=@vger.kernel.org, AJvYcCWyo27CCm/chHMacF5k8xv5YtmrXxS5gG9WzLIehQk9YzDQyN5PO5oqWy6tobikkf3ZkvBf92iZNTGSysK1QnE95jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8dllGCkqzCoTh/9LLgTGp4s61TbhCqdqU6jiqsuiz8BT8hzR
	CQXv3eDG37EsvhmM+2o56w/b+rRcjB+BF2hOlqEtMJvr3Tkf6adv9spE2+C5vGwl
X-Gm-Gg: ASbGnctcuQTlgcnCoIUIZ+gF+jT1ZSolFI5MEcLXcOohv4K6E/OMY+uuIh/xoLeYu0V
	9D/Bc3ZCM5PpLO/0jSnWv45qVwaf17xHtP9AEWeGz7a2kv8ZrHTPB/QMyu9w2htrQoZPzLG5o4k
	UzYjVWneVpNrFYaxeNi0sR4st/34noYdWBaxYVGMhfqCHRVWvqi/twoQe9wpJR/QBmR+HQuOivU
	ed6IiuOjoZAMVPhoo1bdeOqP1ZPx4vF6QEULs+yOBTWWe4YaumMcvVF6rO4cIg1BDeESHLdKa1z
	18uw5mCbIxDyIV7J4aw9DIrGHutBv3R7PwJLBd84Kt3p0nRaJdHh4IYk5rGRwTsWZyI/giCr2zV
	gS4Ir3yApZ4kFrIy1/taSbHYf
X-Google-Smtp-Source: AGHT+IGwjGzkY6qTB4RHlusLOtUfnoeo1VRDKQiw+x2DkamLHmAUbYJkq7nSbcYM2AZEUJvV0w1hIg==
X-Received: by 2002:a05:6102:6e8d:b0:4e7:db51:ea5d with SMTP id ada2fe7eead31-4e7db51eb7amr286725137.6.1749728040271;
        Thu, 12 Jun 2025 04:34:00 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87f012432a4sm254891241.2.2025.06.12.04.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:33:59 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e7b8112f4dso226220137.0;
        Thu, 12 Jun 2025 04:33:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAun1Ut77H8nfpLQ3rzdCKe8hxHVUVSLsBAoi8dJekUIl7CHKoVt2tbM95M7mmW62SQpbeHwSReVuPIsuV88QrymQ=@vger.kernel.org, AJvYcCW8rI818NSUf6K8FeL82R/4txG0W1UvAu7/xzZsr2S9mmcqvRsDpeEs2V73kayObDFxFdNCEbmF6aI=@vger.kernel.org
X-Received: by 2002:a05:6102:cca:b0:4e5:a394:16cb with SMTP id
 ada2fe7eead31-4e7ccb6b7d6mr2812310137.7.1749728039651; Thu, 12 Jun 2025
 04:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749655315.git.geert+renesas@glider.be> <75c8197c849fc9e360a75d4fa55bc01c1d850433.1749655315.git.geert+renesas@glider.be>
 <420d37b1-5648-4209-8d6f-1ac9d780eea2@wanadoo.fr>
In-Reply-To: <420d37b1-5648-4209-8d6f-1ac9d780eea2@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Jun 2025 13:33:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdEtjbAjeaDxxZuQeJg5GByhpoZXpZ0Gydjk60pMkN6w@mail.gmail.com>
X-Gm-Features: AX0GCFsPomL1703NswaKihahQ9te90BX_vZhh-MqS-3k8Ala6BSmXquwIEUNYVw
Message-ID: <CAMuHMdWdEtjbAjeaDxxZuQeJg5GByhpoZXpZ0Gydjk60pMkN6w@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] can: rcar_canfd: Repurpose f_dcfg base for other registers
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Thu, 12 Jun 2025 at 06:00, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On 12/06/2025 at 00:37, Geert Uytterhoeven wrote:
> > Reuse the existing Channel Data Bitrate Configuration Register offset
> > member in the register configuration as the base offset for all related
> > channel-specific registers.
> > Rename the member and update the (incorrect) comment to reflect this.
> > Replace the function-like channel-specific register offset macros by
> > inline functions.
> >
> > This fixes the offsets of all other (currently unused) channel-specific
> > registers on R-Car Gen4 and RZ/G3E, and allows us to replace
> > RCANFD_GEN4_FDCFG() by the more generic rcar_canfd_f_cfdcfg().
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > v2:
> >   - Add Reviewed-by.
> >   - Replace function-like macros by inline functions,
>
> Thanks!

> Thinking of your code, you are still using some magic numbers, e.g.
>
>   0x04 + 0x20 * ch
>
> to access your registers. But at the end those magic numbers are just describing
> a memory layout.
>
> I think this can be describe as a C structure. This is what I have in mind:
>
> --------------8<--------------
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 1e559c0ff038..487f40320c20 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -560,10 +560,21 @@ struct rcar_canfd_channel {
>         spinlock_t tx_lock;                     /* To protect tx path */
>  };
>
> +struct rcar_canfd_f {
> +       u32 dcfg;
> +       u32 cfdcfg;
> +       u32 cfdctr;
> +       u32 cfdsts;
> +       u32 cfdcrc;
> +       u32 padding[3];
> +};
> +static_assert(sizeof(struct rcar_canfd_f) == 0x20);

Is that really needed?

> @@ -883,8 +883,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
>
>                 for_each_set_bit(ch, &gpriv->channels_mask,
>                                  gpriv->info->max_channels)
> -                       rcar_canfd_set_bit(gpriv->base,
> -                                          rcar_canfd_f_cfdcfg(gpriv, ch), val);
> +                       rcar_canfd_set_bit_reg(&gpriv->cbase[ch].cfdcfg, val);

Nice!

> To be honnest, I am happy to accept your patch as it is now, but what
> do you think of the above? I think that this approach works with your
> other macro as well.

Please take this as-is, so we can move forward.
I will create a proper patch (with your Suggested-by) later,
I have more CAN-FD items on my TODO list...

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

