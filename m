Return-Path: <linux-can+bounces-6417-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI+6KA+IfGmbNgIAu9opvQ
	(envelope-from <linux-can+bounces-6417-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 11:29:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA4B95DA
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 11:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED538300A8E5
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D00235E54F;
	Fri, 30 Jan 2026 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oln1L8NE"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984535CBD1
	for <linux-can@vger.kernel.org>; Fri, 30 Jan 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768944; cv=pass; b=YYKf6huRwrNWll9TyFoWQfIv/ogtpaDhxhHsawkogkDdp8s6SbxP2DYCAXWKkcdq2qTOo7fK/zFUJP5HcCKtJZYedPeUV1yOoIak4NWZ6OtdO6bBkC9qmnjtKbFa6EfLHwnIZ+t5cK+2mgHPoy1WWtOb4IKiUWgkmPnSXds7LHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768944; c=relaxed/simple;
	bh=4IZOypoh2mxenIel1BEB+3XJOHnFitDgJDIz3Q5JdHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3KZZjAlxeU/wlYCaJGtagiR+Puo0AeuPcVF2xSUKoJSLOXHP8NExL9WoWS7DIp8pupTfPMzLOEI9hHbvo5+Xai3tLw7jE8a+SVVhdxJRj5Bx30xcAOOqMTGlct51HcMvq0P28ZndzNjwG6NnHJKAudpGCJ0bJs+D8DzcJAZAI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oln1L8NE; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso3266327e87.1
        for <linux-can@vger.kernel.org>; Fri, 30 Jan 2026 02:29:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769768940; cv=none;
        d=google.com; s=arc-20240605;
        b=Z6Qa8ohHFtD9SJEscvnNEOgyiatpLywfa+dete5Vs5PuXZm79zfRR7u6S33S+aBRnH
         iBxjN7CXsMAou9HUNga7pr6UM04XdIv8Krzy7twbHTQnV2z3nkTxypM5qnlyx8NcUpIZ
         U/PTlkODm4gEbOHrbLJmqyo0PFl04YceY4JyuinqGYf8HKKknxKYLCY+dHDyVNEpn7MZ
         Vf0cbMPYJ2N39aim+Qb7tIU9E4HS0eafl9APJicEtrLimzDk0EiEJwMQkAmHGeUcOgT+
         BYKoqhZEtOnKTzRlSyGyHWaJNkbqLrp7+XwHSSPhf/WqT7UT27MbELH+cMbBhZv1KGFZ
         Vy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        fh=+X0DEDqeT+YUWDaJ3EJDHYZz77uM9aip6EPefbNSRG4=;
        b=bHivxoiZqoHk3baD7P8kXbXT24j7tlXX5OkLVW0EEFxcLiCucUCbUUR1EV/GqTGRcy
         URItDj8XZCdQE9KN49g2NYPNwM7F+SCZ1eNrexYwiWSKtDOWCcFKjrrHiyfcWr0HeE8L
         zMQ69dBviFoN/o9m6mnqvf6jYcTL4dm3qirvm0S2JsZL+ZAbHQ8u/RtnAbNU9VySICz+
         raHqvbyr95iKA/CVMrVldJNLbxnjO60zgsVAyQXjzM80wdqVrMhBXpzAn4chGh4xHChX
         rCQ2wykLsh2SH5v+DrO/u1JIe+J83ILqBqR4WWz7PSpSVDRVEEkMsbahAEDwKRV5FOEb
         c1Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769768940; x=1770373740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        b=oln1L8NESX4rFb4aQJM6o8+hQcZgtNvlDrkk5mWrDRGAqBdlUxeNxMcw2eX8cve9/k
         /B/tgoSqfiLOIQ6n5A7FGYAnfj5EkEFL8G5PmeCNy5FvfcKTZeeYcb2oSeEK7SPS4D8e
         AveR4t8N/Rp88C06eoXuFV1HaAjukzyQGL78WB1q/NBX2S2iW4b37uTbndAiZcD8Y53S
         yszc4WtoiN/tvRc5QBRssoUdiZyxH0VsMZ2fxnhKCwbFVUuo7ahbde+gcZ+cU5/AhEdd
         giiAjMR47BZz/ObY0X3fCnsdeDveajpO1Ikp0KpWblJ/09ymDA34ELw6z8uXK7gTFL4x
         OZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768940; x=1770373740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyyRc5JdnkROBEHu+xYdCyJ2Awi4tcsQvb7pPKheNS8=;
        b=KltJci30YS+9TxYr5WhMBAdZccuccVnsC2Vh1HzPnthU3rYkBHR1awIFzqriTSPO1B
         xrdmPPWyBFPEQXeQ0sfd88adsAe9EEMCl3af0/Fp9aDwdK6VfPxDC+2I4uY4nRk6L4Ar
         k4WgwZYszCTASCB4eenQVzQxUmqtmPJr2rUAmp91jO4HracirrJMJaQEq3SMO+X6hyHX
         zXRzHqsc5CwhLzyBrccZGsps2SmN0iNcj6gF+aOt7x6PTJv/Dbm7ompGBvnbLanl3cng
         chjaRgOVLabyguviig/ElwF9umlaQt2gbGMUGVXN/frfIb7F9E6Ym9iIjhBNZaJqx9E5
         uMOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqbkioTqBxLyrF5+aRplO3CfwcgzDl3tTKPxOFlS+6Qld8bJpiBbxPAH5wiEYRwjenKdxccGAJBp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBa1/RK/obgSertAzmdxTkHDVBj5W2h/1ZhvBFkbkE8+2yVpi
	cvF8fEDAESs2F8hq2xUKdwkInR2YfIIA6ECpeRIizXXDJLhK1MuhSXIDmWu4wqaaOUl7A6S/8T8
	mMBhWl5i2wcu4+IKrhinuD8WhqcFFrb/GtMewi7a5gA==
X-Gm-Gg: AZuq6aIqOwp0HErn7mwlkAbL/W/5SoQOhtUt9XYpBCG/IJm+fo5Czo2rCCvRkGPJJPM
	HgRQlHb+TxSzH6bJw91k3VGhdVAR3ag5HTNqOQfuVG+s/HQ3ygUCiW6KPKRanUwPfyzyM7vwRdw
	3TtWHPF13tLSw8V961TcAFpF9P4RaQedohTxV8loqTPjVLxypanm7N2ySbi3ipTTq8ssC77dvOi
	r/qZxQVN8lY6zdrSDOVP0OuLEaeB9MM4gWAtDzHekawIQAo2GP9G7SrMVVIG5JnB+jceenb
X-Received: by 2002:a05:6512:3090:b0:59e:19f8:e7e5 with SMTP id
 2adb3069b0e04-59e19f8e879mr389940e87.10.1769768940222; Fri, 30 Jan 2026
 02:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com> <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
 <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
In-Reply-To: <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Jan 2026 11:28:24 +0100
X-Gm-Features: AZwV_QjKt-7WVZ6iCRSlLFm6WIvZGroCu2x79LzMFz95tWuDMfGW172v0QkfhHE
Message-ID: <CAPDyKFrvSp6tmhP=2=9kca1d3+b6MezvxJWwMOW=Gv6D8TKrgA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6417-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email,linaro.org:email,linaro.org:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 06DA4B95DA
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 18:46, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, 29 Jan 2026 at 17:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
> > >
> > > In-tree phy-can-transceiver driver has already implemented a local
> > > version of devm_mux_state_get_optional.
> > >
> > > The omap-i2c driver gets and selects an optional mux in its probe
> > > function without using any helper.
> > >
> > > Add new helper functions covering both aforementioned use-cases:
> > >
> > > - mux_control_get_optional:
> > >   Get a mux-control if specified in dt, return NULL otherwise.
> > > - devm_mux_state_get_optional:
> > >   Get a mux-state if specified in dt, return NULL otherwise.
> > > - devm_mux_state_get_selected:
> > >   Get and select a mux-state specified in dt, return error otherwise.
> > > - devm_mux_state_get_optional_selected:
> > >   Get and select a mux-state if specified in dt, return error or NULL.
> > >
> > > Existing mux_get helper function is changed to take an extra argument
> > > indicating whether the mux is optional.
> > > In this case no error is printed, and NULL returned in case of ENOENT.
> > >
> > > Calling code is adapted to handle NULL return case, and to pass optional
> > > argument as required.
> > >
> > > To support automatic deselect for _selected helper, a new structure is
> > > created storing an exit pointer similar to clock core which is called on
> > > release.
> > >
> > > To facilitate code sharing between optional/mandatory/selected helpers,
> > > a new internal helper function is added to handle quiet (optional) and
> > > verbose (mandatory) errors, as well as storing the correct callback for
> > > devm release: __devm_mux_state_get
> > >
> > > Due to this structure devm_mux_state_get_*_selected can no longer print
> > > a useful error message when select fails. Instead callers should print
> > > errors where needed.
> > >
> > > Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> > > property presence check") noted that "mux_get() always prints an error
> > > message in case of an error, including when the property is not present,
> > > confusing the user."
> > >
> > > The first error message covers the case that a mux name is not matched
> > > in dt. The second error message is based on of_parse_phandle_with_args
> > > return value.
> > >
> > > In optional case no error is printed and NULL is returned.
> > > This ensures that the new helper functions will not confuse the user
> > > either.
> > >
> > > With the addition of optional helper functions it became clear that
> > > drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> > > Add stubs for all symbols exported by mux core.
> > >
> > > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > > ---
> > >  drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
> > >  include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
> > >  2 files changed, 253 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> > > index a3840fe0995f..b01ec126caaf 100644
> > > --- a/drivers/mux/core.c
> > > +++ b/drivers/mux/core.c
> >
> > [...]
> >
> > >  static void devm_mux_state_release(struct device *dev, void *res)
> > >  {
> > > -       struct mux_state *mstate = *(struct mux_state **)res;
> > > +       struct devm_mux_state_state *devm_state = res;
> > >
> > > -       mux_state_put(mstate);
> > > +       if (devm_state->exit)
> > > +               devm_state->exit(devm_state->mstate);
> > > +
> > > +       mux_state_put(devm_state->mstate);
> > >  }
> > >
> > >  /**
> > > - * devm_mux_state_get() - Get the mux-state for a device, with resource
> > > - *                       management.
> > > - * @dev: The device that needs a mux-control.
> > > - * @mux_name: The name identifying the mux-control.
> > > + * __devm_mux_state_get() - Get the optional mux-state for a device,
> > > + *                         with resource management.
> > > + * @dev: The device that needs a mux-state.
> > > + * @mux_name: The name identifying the mux-state.
> > > + * @optional: Whether to return NULL and silence errors when mux doesn't exist.
> > > + * @init: Optional function pointer for mux-state object initialisation.
> > > + * @exit: Optional function pointer for mux-state object cleanup on release.
> > >   *
> > >   * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
> > >   */
> > > -struct mux_state *devm_mux_state_get(struct device *dev,
> > > -                                    const char *mux_name)
> > > +static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
> > > +                                             bool optional,
> > > +                                             int (*init)(struct mux_state *mstate),
> > > +                                             int (*exit)(struct mux_state *mstate))
> > >  {
> > > -       struct mux_state **ptr, *mstate;
> > > +       struct devm_mux_state_state *devm_state;
> > > +       struct mux_state *mstate;
> > > +       int ret;
> > >
> > > -       ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> > > -       if (!ptr)
> > > +       devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
> > > +       if (!devm_state)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       mstate = mux_state_get(dev, mux_name);
> > > -       if (IS_ERR(mstate)) {
> > > -               devres_free(ptr);
> > > -               return mstate;
> > > +       mstate = mux_state_get(dev, mux_name, optional);
> > > +       if (IS_ERR_OR_NULL(mstate)) {
> > > +               ret = PTR_ERR(mstate);
> >
> > Should this be PTR_ERR_OR_ZERO?
>
> "mux_state_get() never returns NULL"
> https://lore.kernel.org/202601221036.J0kR78Uw-lkp@intel.com

By looking at the code in mux_state_get() and mux_get() that $subject
patch changes, it intends to add a "bool optional" as in-parameter. If
it's set, it looks like the intent is to allow returning NULL, which
makes sense to me.

Anyway, there seems to be some additional smatch warnings to fix
before this is ready to go.

[...]

Kind regards
Uffe

