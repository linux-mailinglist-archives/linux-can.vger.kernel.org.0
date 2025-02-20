Return-Path: <linux-can+bounces-2906-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B5A3DF93
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 16:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E813B2FD5
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206DE1FE46E;
	Thu, 20 Feb 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9K8ubvx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497551DF75D;
	Thu, 20 Feb 2025 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067040; cv=none; b=EHHiYcfNQ1IqufckdgVZ++IkJbJCqG9ZveCpST4jesqWhVI8R2U9KAUxVk/vInCiRggl3S8Y0BlKJiLgPucEusRiuYpAPgkAYlJmTQ7kOBUWqI08XGkKjDhx1s44wZxDjnP8BKgeia6C0D3+KBBMQeZdi0zPJnBiTzV1eIcUlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067040; c=relaxed/simple;
	bh=qgqI6Yx4pkbvJzvbgweusfjlfpWLNMLohQYFjHIfDRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+q1lQ8lpnG+n1UmtsWr6ndMkQJR+62dNmtzOuINiUlf6AEV+cVAYW26siP01vFugpOnF6ZE6OAqU7s/xZ+sQWkRtpV81OH96szMCkXDPS9fkfN50/HCziMbPkN0/RrCqf0ZljJtrJWYvp2JhrO7Pdw+U4IAT9lU9ze8585r5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9K8ubvx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbc38adeb1so199152966b.1;
        Thu, 20 Feb 2025 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740067035; x=1740671835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrH2Exi5lgYYO9KhuM65AVtP/mrtwiIHocHcMAGs1Dc=;
        b=U9K8ubvxilibBWy1zYiir+QRzXsOY7f/sKmHi8S4ymCo5bPPeOk57RaNzDtnEfXprv
         PWkCvXJuUMpCLpY2n/YrNMr+Cry+FjVD1XIXR3sdEukz8YNdNo/InAgC+GjfsdIRCMC5
         /Kyh4dRNloPReHO3ii76lqICKhwk8IZ3uXgTsNbGt58Zw+Z1lwj4Hm1idHVyZ5xT9Dor
         4Nvb9+acqQUTHI2xvROVK1uwnduYcAtJNsk4zzX1knac9oUqS1pHKfJUEk4BA3im7rfz
         rlGKt/IFCsVoux0SggTuwhzLFb0qSvpgOQKwCZynMx8hZyL4RuuSaA/W4qTEQRMGE0KB
         umTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067035; x=1740671835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrH2Exi5lgYYO9KhuM65AVtP/mrtwiIHocHcMAGs1Dc=;
        b=JYlW9KANnjivcp1o55VQ6Ri3NjLuiK1Mq4hCKrPX/0XLLWKi7RJViNgKwdLtbs3+Rf
         B1JcKfUih9awnK/6Nyp6nrqKLpbWrSsBL3FM6dIBqsw24ZwI5JftQKFEqEguo9gQyVJ0
         P9PeJJ9iA4ioTY39gIG0PioirdgNXkopin59wCtyNYPA0jxYL2+CaD5G2o+F4hmcCFhm
         DSA7mfl5GNT89NhwEZmS+xypXwRMIw/R83PeayJsqnyjLK9yFLFOlpr9dNkBbuvyRjM/
         mN8X3lOWAYrTpRJxdZa23YoKnqh7GfuvRqpxmKNOxfn0cwXzRKb1wQ8a+MNfghH6zEFT
         XzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGj/sd0TT22U4abpRMzOGDLGSeScpfwXwQ+MFRS5I5HyXq3es/YcKnFWHeRXEPTOnTyT7weByDaJwV@vger.kernel.org, AJvYcCUU/FTKvgO8Wqy+sbnFb95yEfovCzwfr393HRpZNskLpk2adLyltKXh2eI0ncWQ0MphhTDYtD2V2Do4@vger.kernel.org, AJvYcCXPe2NQjn5naNoChVtcJRSkI0Vrd90ngTOYHS6+JyAd+3Gs5qEq+dzqGNk5PAoETrkm04l5umnJBumZhzVw@vger.kernel.org
X-Gm-Message-State: AOJu0YwGC7BI7w4PYIxv+JecIYZqGXRa+u4haWg3LD/8Jv0gOZ3g8Cqs
	GKr8RAywhNxCgiynqghhpkXr0XvkXvMkjkErAPXlJMUJ0h75kP96
X-Gm-Gg: ASbGncsUv5bGGlL4bk0Kz2epfuGznTyDm7o0OXRCVZziFOoz4P5q2tvGHzcP2tSPLNs
	vJB5MNiwlyjII8wokD7xqVGzldX1kPNFlHzLsNlh9tXUOS1fa40Fb4LpkBsx3xs8DDfSNYlJK2y
	f+0WYBQXD6AwLuZXw12jtGBUom20RB1dgw1zkTMvMUswlzYGJ6zStqynckv6AItIfnPl1kR+Inx
	wFczDyzpli7IGfbjAiOX30RQRcz1dcV099tPZIsyOtItE2eqv0chZ+uji4DMdRKlTVVBayBs04V
	qfOxyxj4Aeol
X-Google-Smtp-Source: AGHT+IEr1TcuzpdbJIjgDo+D69B4/MMmm/vyWh3fj47pTFCZoY0xptHE8m4rjkLgkInw8pA8FPJ2Lw==
X-Received: by 2002:a17:906:f1d9:b0:abb:e259:2a64 with SMTP id a640c23a62f3a-abbe2592c7amr540851666b.33.1740067035161;
        Thu, 20 Feb 2025 07:57:15 -0800 (PST)
Received: from debian ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb843451b1sm980092166b.42.2025.02.20.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:57:14 -0800 (PST)
Date: Thu, 20 Feb 2025 16:57:12 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH v2 2/2] can: flexcan: add transceiver capabilities
Message-ID: <20250220155712.GB43726@debian>
References: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
 <20250220-flexcan-add-transceiver-caps-v2-2-a81970f11846@liebherr.com>
 <20250220-rugged-solid-gopher-541299-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-rugged-solid-gopher-541299-mkl@pengutronix.de>

Am Thu, Feb 20, 2025 at 09:43:13AM +0100 schrieb Marc Kleine-Budde:
> On 20.02.2025 09:22:11, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > Currently the flexcan driver does only support adding PHYs by using the
> > "old" regulator bindings. Add support for CAN transceivers as a PHY. Add
> > the capability to ensure that the PHY is in operational state when the link
> > is set to an "up" state.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  drivers/net/can/flexcan/flexcan-core.c | 30 ++++++++++++++++++++++++------
> >  drivers/net/can/flexcan/flexcan.h      |  1 +
> >  2 files changed, 25 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> > index b347a1c93536d54efaa5f7d3347bd47c20860b3e..45d9a6957d9a806ed80d810a6a5f7eb99fcc702c 100644
> > --- a/drivers/net/can/flexcan/flexcan-core.c
> > +++ b/drivers/net/can/flexcan/flexcan-core.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/phy/phy.h>
> >  
> >  #include "flexcan.h"
> >  
> > @@ -644,18 +645,22 @@ static void flexcan_clks_disable(const struct flexcan_priv *priv)
> >  
> >  static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
> >  {
> > -	if (!priv->reg_xceiver)
> > -		return 0;
> > +	if (priv->reg_xceiver)
> > +		return regulator_enable(priv->reg_xceiver);
> > +	else if (priv->transceiver)
> > +		return phy_power_on(priv->transceiver);
> >  
> > -	return regulator_enable(priv->reg_xceiver);
> > +	return 0;
> >  }
> >  
> >  static inline int flexcan_transceiver_disable(const struct flexcan_priv *priv)
> >  {
> > -	if (!priv->reg_xceiver)
> > -		return 0;
> > +	if (priv->reg_xceiver)
> > +		return regulator_disable(priv->reg_xceiver);
> > +	else if (priv->transceiver)
> > +		return phy_power_off(priv->transceiver);
> >  
> > -	return regulator_disable(priv->reg_xceiver);
> > +	return 0;
> >  }
> >  
> >  static int flexcan_chip_enable(struct flexcan_priv *priv)
> > @@ -2086,6 +2091,7 @@ static int flexcan_probe(struct platform_device *pdev)
> >  	struct net_device *dev;
> >  	struct flexcan_priv *priv;
> >  	struct regulator *reg_xceiver;
> > +	struct phy *transceiver;
> >  	struct clk *clk_ipg = NULL, *clk_per = NULL;
> >  	struct flexcan_regs __iomem *regs;
> >  	struct flexcan_platform_data *pdata;
> > @@ -2101,6 +2107,14 @@ static int flexcan_probe(struct platform_device *pdev)
> >  	else if (IS_ERR(reg_xceiver))
> >  		return PTR_ERR(reg_xceiver);
> >  
> > +	transceiver = devm_phy_optional_get(&pdev->dev, NULL);
> > +	if (PTR_ERR(transceiver) == -EPROBE_DEFER) {
> > +		return -EPROBE_DEFER;
> > +	} else if (IS_ERR(transceiver)) {
> > +		dev_err(&pdev->dev, "failed to get phy\n");
> > +		return PTR_ERR(transceiver);
> > +	}
> 
> Please use dev_err_probe(), it will be silent in case of EPROBE_DEFER.

Will fix it.

Best regards,
Dimitri Fedrau


