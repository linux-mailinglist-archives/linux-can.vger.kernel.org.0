Return-Path: <linux-can+bounces-6619-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGQdCKLunWncSgQAu9opvQ
	(envelope-from <linux-can+bounces-6619-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 19:32:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B718B6AE
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 19:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8846304E77E
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A629BD95;
	Tue, 24 Feb 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOwu1Tzl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B51F5846
	for <linux-can@vger.kernel.org>; Tue, 24 Feb 2026 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771957807; cv=none; b=oGuT6s42TXwmamJALvNZdwrlmMshoEAxtWKwIuOGv3kbpdKxNYMa3sQ0S5swLHzD+Wk5LRfINeI9rkJybbClAiisWY1hpFDF98zSGlXFXHsJX7fwsIIBFnp40asWRaXAM26XXRqXu0Qrm7GXMAiCo/iZFalxP0VCJe5a9ohs3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771957807; c=relaxed/simple;
	bh=PbWZcT3aIYFxW5Ppb1wt0AuvqcdTG4aMUdC3K7Y8Al4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjivVPJUf4tWCYNO5TCaDle5NP+iV+aZ2PEw+3A6EFjAgaLvszRB4W2+gIVwaXiMxSaD+4u07CyEXQVVyPUVvEJeiLaba8VWuGGP8sVO8A9ZXtDGb6Ab6zvk+EEThLaDefhD3eZ+nUztkEimQqiKLLlf1d92uXyC02Ia+vGdyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOwu1Tzl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837991d1e1so7336895e9.0
        for <linux-can@vger.kernel.org>; Tue, 24 Feb 2026 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771957804; x=1772562604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vy6D+hE2xhOiRI343jCC4Oy3zlTR5Sfyp5vbNl4FLck=;
        b=MOwu1TzlNkaHTjAY/kjFzhMfrw3YMh+DCp7RFsczNj7z/TMwK5rMuRjklmk1THbBT2
         WS4DE4QboA4CHkn0cEE/q/vGSyx9i9H/FBFwGxPUh6sdPcAlAFq+ndF6fi+C0EfDLTDz
         KZ5Y647ipXr7g6CEqVwuLLQSnpRCSFq2WdqANGNkEFs0VFsQlIXy6IQW+qpf2WWS8alx
         hBREeuPmVx/nbYloc79yYJztcFa4HkglBzdvAyUKZW4G7JDQEVqHTKgh4A5M9ivp2rRl
         oySGw8V2akJbTN5PubfL8LcH8AVRgKC6/DK8MeEj3zEKFxl496tZHLJOy2N2xXmvCN4A
         30iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771957804; x=1772562604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy6D+hE2xhOiRI343jCC4Oy3zlTR5Sfyp5vbNl4FLck=;
        b=ZhbvatsFCvDyQF3ydgeyn6crVlNd6CTJ3l0wlmUpPFGp7M3DSSt0/zMmv5Tm7ElfR5
         a2QiwCISf77qxWEJ078d3vGm5dxZtGgaUmY3mpJebcHDllTVw25lBs0aerE+3vQ2ve3k
         4AzUtKokTX8dt1CjTwQu0BfgQX7Df4deoElb1W62Ff5UKFJzFKC2DZ0dFKx6kgWLgup6
         +o9WxbVk/M0/uRNUr5uGG/LoV3oresKi7zgqlnLWiGVOchuhIRr56aRawfUuhFLgO7Hp
         dTmBoyEqpN8RG2LV5PEAFviBv4k3XGkVn0AcSpT9w68kOL7PWFW4sFEgEoAeG8B+p8HQ
         VW0g==
X-Gm-Message-State: AOJu0YzmV4SA/K7fws7Qd1xGhSw8MPBQt4wNsf2Nv4TYDjiOSPLIVTOO
	wwszMl65HSr2C2l1MWBmdZi7m4nwJXq4dNKWxtNyyvyk5sWXkH3HQsQQ
X-Gm-Gg: AZuq6aLKDi2HRVv+Vcvm7v4yZkocl3a4FMKtg1/ekhf6/hSWL3eJSJFI1IWfXgujRW2
	XboZk+HkrMvRKbtOQLBW8z7LXhBCCIg+FsJdyimWPnoNHaCCboNJCLuJHpmViF0TeRaCKuT6NPZ
	lgX5/XdarB9tXmn5kNYzMMsm++JRXTEgb18gJtQw0Cylz4d0reb92UhBE+QlIvcs6sXPjtYHBe2
	nvabyF4HaHDyZm3kUGUdNpIr467iqcOW4jeAFZmnoQsZI2Y8ZCALm7mFJvkUewY/dEENKnAh2ph
	9uLGCXkwYd65EkMxt2RhxPekaIDwvsc0cMR3XZgafakPvYP0ryikPGFBqtSTNps0eR60D9igtcq
	7gdVJrtadtvlsZezPIjc3EjqKc3hAZFJIi2FXD1gcCvag4xGOwU1ISY5vC81ELJ64iXowNnQWEj
	5vwh3PXkMshr3ZnvQ=
X-Received: by 2002:a05:600c:470f:b0:483:7d93:9fb7 with SMTP id 5b1f17b1804b1-483a95ec6bamr135887715e9.2.1771957803799;
        Tue, 24 Feb 2026 10:30:03 -0800 (PST)
Received: from skbuf ([2a02:2f04:d809:4b00:7cd9:3431:5b61:7303])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b89095a7sm22695185e9.24.2026.02.24.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:30:03 -0800 (PST)
Date: Tue, 24 Feb 2026 20:30:00 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH v1 1/4] phy: phy-can-transceiver: Convert to use device
 property API
Message-ID: <20260224183000.txlazzyw7z34nhsj@skbuf>
References: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
 <20260224162606.spnzzedvmvp2h7xd@skbuf>
 <aZ3X2J1rBq1pMkae@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ3X2J1rBq1pMkae@smile.fi.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6619-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 323B718B6AE
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 06:54:48PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 24, 2026 at 06:26:06PM +0200, Vladimir Oltean wrote:
> > On Thu, Feb 19, 2026 at 09:26:19PM +0100, Andy Shevchenko wrote:
> 
> ...
> 
> > > -	if (!of_property_present(dev->of_node, "mux-states"))
> > > +	if (!device_property_present(dev, "mux-states"))
> > 
> > There's an entire saga with this function - devm_mux_state_get_optional().
> > Josua Mayer is preparing to move it to the MUX core, which will be a cross-tree series.
> > Would you mind not touching this, to avoid complicating what is already
> > a complicated operation? It is going away anyway, and from what I can
> > see in Josua's last series, its implementation from drivers/mux/core.c
> > is already using device property APIs:
> > https://lore.kernel.org/linux-phy/20260208-rz-sdio-mux-v9-2-9a3be13c1280@solid-run.com/
> 
> Basically you ask me to postpone the series until that will be in. Since this
> file is a mess in terms of OF/fwnode API use in exchange I would like whoever
> is doing the other part to speed up a bit if possible.
> 
> I prefer to see cleaner solution to be applied sooner and last in a long distance,
> that's why I see either mine first but soon, or that first but also soon should
> be in. Can we try to achieve that?

The idea is that Ulf already expressed the availability to take the phy-can-transceiver
patch through the mmc tree and provide back a tag to be pulled into linux-phy:
https://lore.kernel.org/linux-phy/CAPDyKFrtTaJ5fqqbGrE_K6SAdTZYUfp-BycGjtWs4SabwBysKA@mail.gmail.com/

If linux-phy takes your patch first, there will be a conflict when pulling the
stable branch, and it won't be so fun, plus we can't even build-test Josua's
submission on linux-phy, so that's obviously not great.

So yeah, I'm not requesting you to postpone the entire series, just not
touch devm_mux_state_get_optional() and don't let it appear in your
patch context.

Somebody will have to remove "#include <linux/of.h>" at the end of the
whole process, but that's minor.

> ...
> 
> > > -		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
> > > +		phy = devm_phy_create(dev, NULL, &can_transceiver_phy_ops);
> > 
> > It is not obvious why you replaced dev->of_node with NULL here.
> > It doesn't appear correct. You seem to be breaking OF-based PHY lookups.
> 
> It's the default. Yeah, I probably have to explain this in the commit message.

Ah, ok. Found the "phy->dev.of_node = node ?: dev->of_node;" assignment.
Sorry and noted, but please add it to the commit message too.

> Basically all devm_phy_create(dev, dev->of_node, ...) for clarity should be
> converted to that approach. Or even better, a new (agnostic) API should take
> default fwnode from the same device.
> 
> 		phy = devm_phy_create_simple(dev, &..._phy_ops);
> 
> // name was quickly chosen and may be not the best we can come up with

I agree in principle. PHY drivers shouldn't be given a function where
they routinely have to set one of the arguments to NULL, but a simpler
function without that argument.

But the phy-core.c doesn't support fwnode at all yet, it uses OF
throughout. I think it would be preferable to leave this change to
somebody who has business in that area.

(are you interested in PHYs with a fwnode for any particular reason, or
just because the API is more "generic" just in case?)

