Return-Path: <linux-can+bounces-2818-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E234FA355FF
	for <lists+linux-can@lfdr.de>; Fri, 14 Feb 2025 06:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604C2188D60B
	for <lists+linux-can@lfdr.de>; Fri, 14 Feb 2025 05:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024A15748F;
	Fri, 14 Feb 2025 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPoX5Vpi"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF40C15442D;
	Fri, 14 Feb 2025 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509548; cv=none; b=Mr95EJTmLd7OPiB50cD7kPzf32+lU5YBuE8Eootr0Wio5RyTeKKvmIAfkdtHtjaOmPLbK9XbJ5DoiSkzE63S6407f+vcJ4swafbvbYDTPSGRpv692BoePP6orvwciWF0fBo7n+F03RRTDPr6/o2kbZbD+VlwY/FXvOWkhQDV0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509548; c=relaxed/simple;
	bh=W9xzcKzzqpRTDvCmTpbkkfQznC4Yz3/T3sUJwlIDtKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEwc8ZJib8A/xbbQVo6bCDQ3UHBRWSp+aAw+VFuL6LoeDWj/tC7cJju0SZ6qWQmQtT5EgoMZZe8M4OVHAVo/+nd9M18L+i1oh/3Xu+EIC/4nUhvo/vKU/lnPEISdzpcyoanwAN9Oi2b3nO9mc6pYde/2TZVZia55Ok+tIUNflJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPoX5Vpi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso572735a12.3;
        Thu, 13 Feb 2025 21:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739509545; x=1740114345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6y8dDAtdsuLGiNq0Uhroh633zd/41tN4sxwt2UHLOM=;
        b=nPoX5VpiwXsFMnuuF0OiS41WoXDM07JbMziXJWNa7QyhEmpMdwgxVceOPMO3k3DjV3
         gx8LNEb5BPgmYKLiUXbkWEW+2InTE32qk8xNoQUoGftqaWwDlh2wMuIl43Z8DICt0Z+f
         8xdDbLb7pU0Dmsnw0XjyLQSBRtbGYW/d70pz5JdAyppigqmt9O/EKNZnSj6YcXffagUV
         0LaIzvY7aaseJfOSKWB7R2qTP4uu8LJSr5RvzHgcV5H4FJ4kEKuT9ao1YLgEdvgtPtK3
         S8TYrFVZcnrxPvkyfl+CH6amaGr8Gpx7Ja80GcgXTc1aPnmroVZWW6onrsN+jxKdwKKR
         6U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739509545; x=1740114345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6y8dDAtdsuLGiNq0Uhroh633zd/41tN4sxwt2UHLOM=;
        b=lQGLQrBoTuTPvmyr3Pg+z6ViQBu5Tj/1c2Z5oxqVvf9BSfd/7cdaHEkzgvqHBhZtC8
         kqTuIKb/6Y+FbZ0G146vqV3g/nIuPLO9jduRMjZhtGdVoK2PwF0JsBu1CRVS+BzeKq47
         2jt3SlrIRAzF0tD4+LyFlp5vnkWpaALTZV6fvne4lHeqTuUhWskU6I3i8LgXwefmw8gw
         vZJgn6rJuTmaWmTUwoxvdI3V2DR76ArTwGjGzAytR6lvvQhGdA2bxp+exzkmKGVsV5W7
         RGw2q7IP9+XA5fu5KCy4UbTL7NOWr/UdhAgahMhufg/IAD51s8XlDu9WzwNVbm0YpX9t
         uX7A==
X-Forwarded-Encrypted: i=1; AJvYcCUF6vLeKsU7PfAISEiJN9Omfqso8UlXDdWLDrU9olfWVnYsaejJtFPA9CuF6mVwmStraYTiO4tSZnKH@vger.kernel.org, AJvYcCVFz8FysWlyggRFqRMNqN+KsJQZ3n9WQnfnF6dS2UN5RBgubJ088yChQ9bXHk+3ROdy5OljnGqfHblJ@vger.kernel.org, AJvYcCVtXrt3y7edDXkEfI75HbXtz4lJ45EsgNqXGW4xfFG2nR0eV3WbX4bMUxFY6bhTg+9JoK3v2fB9/GqYLzZS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7m+8q5U1OgIp8XWSI7PjCFnJeTYrG9dnB9PMuavijfkOz6Ccv
	uRXI+kEkR4bZi/iOOrZPXN1jzlAx6o2JlqQ1r9WJ0T5RPAkcd9UN
X-Gm-Gg: ASbGnctGQukURANWRLZ07wV5EOYgBiG4q0tUmzZGp9rzEo8/f495xmOkCb/2cO+sPyD
	K+b68LblterAJDfAqBn60fc/GCfh2rY7+DiGNefzi4iJj82Ab/EOwSxlxKDBxcjKAm+nBvhlC+g
	Y2FCrYSMQ5z0xbedCZiPzhkuk1twHf/IWKmySYARUQNp/apiYOry8wWGJBcdV8lv2/DwIzXW45K
	HWVlCHnnnFCjLrPNFwmHB11gQ7RYrB+BXnITI+mlgL/XlKVos/U8Cw+eFpCNO9Tm2qVUYky6e5x
	GZzUfbFVRbgZ
X-Google-Smtp-Source: AGHT+IEH3bBKeyyUEPgOcACTpRbfh9j/BQFlm3mYol8UGPcKSBqjbSUmJIaMirsEGeSasKzpr5YXBA==
X-Received: by 2002:a05:6402:4409:b0:5dc:89e0:8eb3 with SMTP id 4fb4d7f45d1cf-5deb08810a7mr8070846a12.11.1739509544975;
        Thu, 13 Feb 2025 21:05:44 -0800 (PST)
Received: from debian ([2a00:79c0:653:f300:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5decdfe758asm2282677a12.0.2025.02.13.21.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 21:05:43 -0800 (PST)
Date: Fri, 14 Feb 2025 06:05:40 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250214050540.GA3602@debian>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
 <20250211-epidermis-crib-b50da209d954@spud>
 <20250212195204.GA6577@debian>
 <20250213-scariness-enhance-56eda6901f69@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-scariness-enhance-56eda6901f69@spud>

Am Thu, Feb 13, 2025 at 08:07:22PM +0000 schrieb Conor Dooley:
> On Wed, Feb 12, 2025 at 08:52:04PM +0100, Dimitri Fedrau wrote:
> > Am Tue, Feb 11, 2025 at 04:38:48PM +0000 schrieb Conor Dooley:
> > > On Tue, Feb 11, 2025 at 02:12:33PM +0100, Dimitri Fedrau via B4 Relay wrote:
> > > > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > > > 
> > > > Currently the flexcan driver does not support adding PHYs. Add the
> > > > capability to ensure that the PHY is in operational state when the link
> > > > is set to an "up" state.
> > > > 
> > > > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > > index 97dd1a7c5ed26bb7f1b2f78c326d91e2c299938a..397957569588a61111a313cf9107e29dacc9e667 100644
> > > > --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > > @@ -70,6 +70,9 @@ properties:
> > > >    xceiver-supply:
> > > >      description: Regulator that powers the CAN transceiver.
> > > >  
> > > > +  phys:
> > > > +    maxItems: 1
> > > 
> > > Can all devices in this binding support external phy? Are all devices
> > > limited to a single external phy?
> > > 
> > As far as I know, these devices are controllers without integrated PHY.
> > So they need a single external PHY. Transceivers can be very simple like
> > xceiver-supply in the binding, but I want to use "ti,tcan1043" in 
> > drivers/phy/phy-can-transceiver.
> 
> I'm not quite following, do all of these devices need to have an
> external phy but the property did not exist until now? How did any of
> them work, if that's the case?

The property xceiver-supply is used to describe connected transceiver
which do only rely on corresponding regulator configuration.
For example here:
https://elixir.bootlin.com/linux/v6.14-rc2/source/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi#L105

But I want to enable support for these:
https://elixir.bootlin.com/linux/v6.14-rc2/source/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml

Best regards,
Dimitri Fedrau

