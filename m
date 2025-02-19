Return-Path: <linux-can+bounces-2853-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0D6A3BBC2
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AB9177952
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8811DE3BB;
	Wed, 19 Feb 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV86bqWV"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3011DCB0E;
	Wed, 19 Feb 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961602; cv=none; b=pfeiYTgEYHPmEEHHQBRy1gjmi0bzL4lkxfQzQNzXCXlo/YD1FRcvtHnzg7XMVke8F1GofPejiQMIttrXpdiSEgecmZnFnsCfHZAQGTnKvD1uGv6piYoX7hXMFMeNG/ydBCHL9xyazS8C6sfOxjOoxEDI2FCH2qNd5fUvKPidCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961602; c=relaxed/simple;
	bh=lXU3tTIAeJiomJooZbXJpor0uGS973vQBTqQNryFYqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaS9pZfGyBwSq5Ck5ylFXpK0m91ZSkZpK24JoWwUEqiCyW/xDyAoQJw1CBnyj2ElFsazK0LtbSCQ8J50Xg33LL7TCNRorJgMunWgXOrve80AerDKxdg6OICfFE+zxbCMz4tExSWbDM+blWeXHqCpEqV8uugYTmvj32PtXMAsnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV86bqWV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso620425166b.0;
        Wed, 19 Feb 2025 02:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739961598; x=1740566398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUGhyiuFOr1ZWNKevH7tnwn0IzxKsvGCdgwL0ltDteA=;
        b=DV86bqWVm5xw48nmrAhjzzxVttFHq5YsiT//IpASLNVpbKZ2w1Pty2lqum+Mm0kpER
         BUM1TeXuSpFB7njneHZF1aitjBZcrEQU0Cly8SYtG+MGtxa//MofpfX5ufD/cVghGv07
         h3VFtGV3DP4oT3FeL7O7J99u703Mzz0+E25VBTd+4R16+dH2487Qm/W+AwnzXsYms37x
         1zUrGBt4M1bzTepJ/SoDI2dhOxeXhd0j5LSao/0Dl4mmqB3EB4yaRhrpFqYr1piufca5
         r/ITG71lpSiT+M3Jpisdb9Azf8qFRUbOKXtAKY42KQf3h8/c6a1mX0FXW0YYM7Wzw3M7
         LrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739961598; x=1740566398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUGhyiuFOr1ZWNKevH7tnwn0IzxKsvGCdgwL0ltDteA=;
        b=u2zMywbJBBq3wE36gPiR5sgB6dT8SuiX+SmaQDdvT3Exr8AuPo6j1ivGDalHypiFL1
         m3FADMlTSg8Pa0viXHfBD8acPJaZ/Q1VSFg88GWcXSM2x23soPIia8Ra7rBLh0meqR8j
         dQQ+0yECj/6EPZBlPwKqDYBUCDOyH8Q+ohAcjMx9Po9sxSuqbVM1IAN44Uzg2acXBaLi
         ArX7V4IMs+CMzk3Wl2CpduYO+9nUHkDmFvfJ71ls44DyYpa8ZCDug8XULEiVjZynnU1K
         fAHvmCWbzBFCmkSgccktzZ/o0+vE7q2PDiTNsZSIoGp4P005T3kEin4xbboNGmAFu77l
         a3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF4xv5Y2Bj5Yq82VcNMQhi2BQMX+YtEqPX2kZePZHcdqJ0XV9pQw8+O0HiRANHxwjIePpYmOSd+uHa@vger.kernel.org, AJvYcCVX+4DtschiklDR5EjxyWG0fKaDKRLyC24tSuqGdBoc52dAu5dBBYomX3OiZxQAz6yZ7xjsn6vkZyiuL6Md@vger.kernel.org, AJvYcCX0PTRNNGBRrntT/nV9BqyX95BXGBWgBN6PHv4odjEp56yIlsKwtDkp1wpvZ7HJwelhWT8+7/g3mDjw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnrd4pyIh63hJOPH+o/k4kVv+cSstRDsE1dGjmySQjldVi2XgM
	mN4I18XDy0lKdpAPW7fdwZF56hnrNm38kfaszo9DfQVpZgHYgeii
X-Gm-Gg: ASbGncvlS5kCDwByKF+v1KYPfmnHclFK5ZcRwPWd/+/mKFO2t9uTa1QXGc4sGpLCYTJ
	/SB6qBslnBc+Kw4MPHQ32o2UNEOD4fEVdXzv/+ebhAcow5M2XORw60mxi/QF4pvZR9/7NmfAZjf
	WQKW2ji91fHqvZ71ifKdWbNw7zIlChy9e8v8LkkvNPwdPfJe8cpZMqZd+h476EE3NfVsiiYOf6R
	XObHhDVP8fir13HR7rFlR79pfvPqTpz671wcIvncO+vkPq0H812mXHTE096TnRegyH9N07rqTRM
	iM5ctgMB1qp0
X-Google-Smtp-Source: AGHT+IFZOJr0RD8oSFFzKuNKPNhV3qDiWrFYEJv8XqOoA/m0Yzw0TYkg+/f0prDgRkLbm1psWPtJmw==
X-Received: by 2002:a17:907:da6:b0:ab7:87ec:79fa with SMTP id a640c23a62f3a-abbcd0bbdddmr281041766b.51.1739961598268;
        Wed, 19 Feb 2025 02:39:58 -0800 (PST)
Received: from debian ([2a00:79c0:646:8200:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb99fd1983sm581040466b.108.2025.02.19.02.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:39:57 -0800 (PST)
Date: Wed, 19 Feb 2025 11:39:55 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH 2/2] can: flexcan: add transceiver capabilities
Message-ID: <20250219103955.GB3888@debian>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-2-c6abb7817b0f@liebherr.com>
 <20250219-garnet-gorilla-of-will-6e389e-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-garnet-gorilla-of-will-6e389e-mkl@pengutronix.de>

Hi Marc,

Am Wed, Feb 19, 2025 at 10:41:24AM +0100 schrieb Marc Kleine-Budde:
> On 11.02.2025 14:12:34, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
[...]
> > +
> >  	if (pdev->dev.of_node) {
> >  		of_property_read_u32(pdev->dev.of_node,
> >  				     "clock-frequency", &clock_freq);
> > @@ -2173,6 +2185,7 @@ static int flexcan_probe(struct platform_device *pdev)
> >  	priv->clk_per = clk_per;
> >  	priv->clk_src = clk_src;
> >  	priv->reg_xceiver = reg_xceiver;
> > +	priv->xceiver = xceiver;
> >  
> >  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> >  		priv->irq_boff = platform_get_irq(pdev, 1);
> 
> please also add
> 	if (xceiver)
> 		priv->can.bitrate_max = xceiver->attrs.max_link_rate;
> 
> 

Yes, will add it.

> > diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
> > index 4933d8c7439e62b5d6fcc445d88c2b5ccbfa13bb..56be40875eee24aee9297c4bc7c2fc4380e682ff 100644
> > --- a/drivers/net/can/flexcan/flexcan.h
> > +++ b/drivers/net/can/flexcan/flexcan.h
> > @@ -103,6 +103,7 @@ struct flexcan_priv {
> >  	struct clk *clk_per;
> >  	struct flexcan_devtype_data devtype_data;
> >  	struct regulator *reg_xceiver;
> > +	struct phy *xceiver;
> 
> All other drivers name this variable "transceiver", does it make sense
> to use this name here, too?
> 
I have no preference on this, but my intention was to name it xceiver
according to reg_xceiver, so people familiar with the code would know
what it is about. I can change it to transceiver, what do you think ?

Best regards,
Dimitri Fedrau

