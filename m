Return-Path: <linux-can+bounces-6235-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF6/FWbib2n8RwAAu9opvQ
	(envelope-from <linux-can+bounces-6235-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 21:15:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B67AE4B1D0
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 21:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57E88A4D3D6
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF77363C75;
	Tue, 20 Jan 2026 18:04:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A286352934
	for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932259; cv=none; b=XjuSBiCqxFtazNM1EH+TQbuLHUcIGjnW3qWZg/iLD7L1pUiydIRqD3w7Tj5UjyvNDI1jUXjx/YMSN7iGOg7QPc5a6EXlJkJbx7+3wkmCesTULS/rMhodnEytntYrw3DeaHNILhXfz5YqCsq0SBjYz8BLAKSW0MbnQxNg9v7UIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932259; c=relaxed/simple;
	bh=3/JP3tCIvtYedAAyMYL0a51zMnc14SZU20ikWY9BXqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIDjMDHQHRoxwIuIUWLWzXH0QAfmVeHgFsbmTl3nUbs/QRegl8VR6yvNHDuXEZYROPfUNBGyq7VP7oOR3aCxAHnvOc0gDDg87y1CV5rEdj9Va/mOo5GaWtXgtud5mLrYU2wTexNcDbRuPBhIxMmC/2wJdZ85KFn7NrsmM3HnspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8946a794e4fso6716516d6.2
        for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 10:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932256; x=1769537056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcPNSr1vco6+E9e0XJi5xyBPxmbRiBl/7/yDisLqrnI=;
        b=Ax7Zipai5jjhDhO5GJ9o6HtYMc+zEea49A/byCrWWO1jdo1ei5Jc7z01da7uYJMUqN
         B1raqwMrKNSWh+ecc1SYnwHpsdfEAZfEa+mKtQ5HRIVHMW14Z/givBH77P1TE0QDeUaN
         2PFqSLAGwgbkS+7auJ0QC8DbymZ56n5BkhfRPyFo73an/F5oA9hlWVeh48QO/g2hQVWB
         oGhqRDEdfvTHVc3RwfWGK6YBHNphRaRJBe41/2J683VNxfmDmnC16uXWbYtzXCLO6q3c
         zaGo9m4ggQJ7bChRSaMjq/oCYyHiJd6gweJx7V0x2PIfzRBrn+a1o9ztk7cBUkjG/Bej
         8c4A==
X-Forwarded-Encrypted: i=1; AJvYcCUvl0W2UgN/WfjAvEjIdXbQauD96Ma4RuG2aEYZUb9mB9Rz98sOMUOT0lbxWiQQt4DRFjm+uCN/9zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhjoHRF3S0sb88UMDkIZuubLXc0SdQwWeK+dNgc7maKnk9F57
	vh+kV6fOFcTv+BVLfz7AvXryuhez5FEOGoSnLYl2VuPRUl9WR3FIpkpUiIvjrDHe
X-Gm-Gg: AZuq6aLoL1UaBEJpG/zJ2zNkqVNC1b1SN13oPIK+f4qbXBpoMxypln3gk9ZovL1zXeD
	5mu377Y0MEgofypaeXpYl1qKv7ai1W6uMeBoXJ+p+qXGCmtGLOmCdOyGTIiUz4yb4MfP5sOBV3s
	sSk9d5D+A7VPipkg/JiktbmneIjhFkcwlSkTKqQaadU95OYhih1oO9EaqVb/VUlLaO2XWZVrPhw
	ie0hJKhPryx3dsU4U8SxkqDc3LkyXm6zditoGCTGBR41MydNIY8E7Vg6e+VphZAai76nifHSSi9
	wVYHBQIVO6rGHefoZPIeX/+ubFewP/MQcp4Pob0iE57j84GOoAjEVVgYAIjmZThmyyjgTiaa0aa
	slMyp3woTVLNVzMBAAmjJYTJEX5K+O6i5i7n7z4Hbx9yclOVTxnfjjbMIDJ1MQyp8b3MW9Z1bYA
	humkI7zBze5FP/bCvsQttPBt+1Q8fAE0D3qhX4iIgXlj9SQa0=
X-Received: by 2002:a17:90b:254d:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-35273273fa2mr11742821a91.32.1768925143977;
        Tue, 20 Jan 2026 08:05:43 -0800 (PST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com. [74.125.82.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352733f7ad4sm5951097a91.2.2026.01.20.08.05.43
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 08:05:43 -0800 (PST)
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11f1fb91996so12475882c88.1
        for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 08:05:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkzo0wj0paxC3au3Kn8IEEybm5/tizv0CUoAZ9IcoWoFefvmcIXnWuMaJjFEJi9CcqZ4H8PcwBwuE=@vger.kernel.org
X-Received: by 2002:a05:6102:b15:b0:5df:c094:628d with SMTP id
 ada2fe7eead31-5f1a6fa3ca2mr4116825137.3.1768924652088; Tue, 20 Jan 2026
 07:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com> <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
In-Reply-To: <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 16:57:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=wDmDJFYvtzxptAkkOQ8r7sPGUxp9u71e64ikY85+Zw@mail.gmail.com>
X-Gm-Features: AZwV_QgiDRrYV1BByFjO2lg9vbxQpf_lMefb8OE6E5E-nZ3iF4svsU32o-Zkiz4
Message-ID: <CAMuHMdU=wDmDJFYvtzxptAkkOQ8r7sPGUxp9u71e64ikY85+Zw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6235-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,solid-run.com:email]
X-Rspamd-Queue-Id: B67AE4B1D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Josua,

On Sun, 18 Jan 2026 at 11:29, Josua Mayer <josua@solid-run.com> wrote:
> In-tree phy-can-transceiver driver has already implemented a local
> version of devm_mux_state_get_optional.
>
> The omap-i2c driver gets and selects an optional mux in its probe
> function without using any helper.
>
> Add new helper functions covering both aforementioned use-cases:
>
> - mux_control_get_optional:
>   Get a mux-control if specified in dt, return NULL otherwise.
> - devm_mux_state_get_optional:
>   Get a mux-state if specified in dt, return NULL otherwise.
> - devm_mux_state_get_selected:
>   Get and select a mux-state specified in dt, return error otherwise.
> - devm_mux_state_get_optional_selected:
>   Get and select a mux-state if specified in dt, return error or NULL.
>
> Existing mux_get helper function is changed to take an extra argument
> indicating whether the mux is optional.
> In this case no error is printed, and NULL returned in case of ENOENT.
>
> Calling code is adapted to handle NULL return case, and to pass optional
> argument as required.
>
> To support automatic deselect for _selected helper, a new structure is
> created storing an exit pointer similar to clock core which is called on
> release.
>
> To facilitate code sharing between optional/mandatory/selected helpers,
> a new internal helper function is added to handle quiet (optional) and
> verbose (mandatory) errors, as well as storing the correct callback for
> devm release: __devm_mux_state_get
>
> Due to this structure devm_mux_state_get_*_selected can no longer print
> a useful error message when select fails. Instead callers should print
> errors where needed.
>
> Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> property presence check") noted that "mux_get() always prints an error
> message in case of an error, including when the property is not present,
> confusing the user."
>
> The first error message covers the case that a mux name is not matched
> in dt. The second error message is based on of_parse_phandle_with_args
> return value.
>
> In optional case no error is printed and NULL is returned.
> This ensures that the new helper functions will not confuse the user
> either.
>
> With the addition of optional helper functions it became clear that
> drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> Add stubs for all symbols exported by mux core.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -46,6 +46,16 @@ static const struct class mux_class = {
>         .name = "mux",
>  };
>
> +/*
> + * struct devm_mux_state_state -       Tracks managed resources for mux-state objects.

Please run scripts/checkpatch.pl:

    WARNING: please, no space before tabs
    #80: FILE: drivers/mux/core.c:50:
    + * struct devm_mux_state_state - ^ITracks managed resources for
mux-state objects.$

> + * @mux:                               Pointer to a mux state.
> + * @exit:                              An optional callback to execte before free.
> + */
> +struct devm_mux_state_state {
> +       struct mux_state *mstate;
> +       int (*exit)(struct mux_state *mstate);
> +};
> +
>  static DEFINE_IDA(mux_ida);
>
>  static int __init mux_init(void)

> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h

> +static inline void mux_control_put(struct mux_control *mux)
> +{
> +       return;
> +}

    WARNING: void function return statements are not generally useful
    #441: FILE: include/linux/mux/consumer.h:139:
    + return;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

