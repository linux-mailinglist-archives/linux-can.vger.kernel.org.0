Return-Path: <linux-can+bounces-2934-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E1A40612
	for <lists+linux-can@lfdr.de>; Sat, 22 Feb 2025 08:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6D2189D752
	for <lists+linux-can@lfdr.de>; Sat, 22 Feb 2025 07:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B341FBCB5;
	Sat, 22 Feb 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHxcmYpb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F347494;
	Sat, 22 Feb 2025 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208969; cv=none; b=SR2usAJ2q7Leha9+qd5xhqRX02YXoSU6gN+AY7pFv5lZ5sWi3sTmbqGboGn2dFQCiL1RPfkUa8eEn4acbB+Rf955s4mYQaP1F0m0HA4RgoNQaTb7nwOYBrKDYNuNavw3unY5OsImfGfNwLtu/dguFJlc+7PBVkbN9S5Bwt2WIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208969; c=relaxed/simple;
	bh=1wLzZlUplRYghJxP4Pd4ugXxm92+g9Fy6PS8vGc2tM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnQqPrGN8LciwMXneRXMYvi2mty3mN08NDAWppJ/frWyBtnmIg3DjM49eMPZX1PkndjcmKd7So/6oE6fKUN9ywd6OTLXMJCOHIgDvU8kfYBUpt7QjSOpmxBusQwkc9Cd55sd1XsPjG0fPs0aL7xRVWbfR2xEXwO0k75vRC7KeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHxcmYpb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso491461466b.1;
        Fri, 21 Feb 2025 23:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740208966; x=1740813766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEnOhCave/qwMORS6+m/BSs/u7Kbv390RWFos8Jc8bs=;
        b=OHxcmYpbqK6UwO5UJuguY1msLcjPSaRoZxAlqBDWY1f8v26icJaMj0ClvPVZjtdth8
         YQCYFDYYP7TbTwq6DjPd03xPtoCrqC5CG+Q/iD/6gR5KNjUOXDX8JuzAju1PPZCqytsb
         b9+JU06ZK0rjqwlyVmwzFGXUdG1mcsGNr2nxoCrSKdyIMwwmQxBf7u+3rrn45U0oTTyN
         T5DAu3j/yvVEFb9yYCzuXz/ozUhzn0FhlHAjY61HZGmDdNZRk9Qq85YOT/6eL1j5nQ2s
         +HZjhiGMkAeolA4+Jw72vNmX7kVzW37QJcXMlVCy3Q9RkeaQ2UiDMxU9kvnATePSVuUm
         1HJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740208966; x=1740813766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEnOhCave/qwMORS6+m/BSs/u7Kbv390RWFos8Jc8bs=;
        b=trbDycvRW4GkUNSNzHbkkO8ljw3vUNZy2A4zxUqUnn9CJXZhESvGUHZYLlKKZbUDrY
         GPtFBP7rxwZX+MD6zTyHc0xThZkDsNoEH0n3XgacFHi4FRvy+5jfipMqvbE41xze7Dit
         8SZRy1x0hOeUnATxtKar/W186FsSbOT68HusIx+G/ZJfdt08I9ldHGi5a38fLNnh3y47
         8WxL3L51YrKZQg4sc9ZuydZkLtbZqchsMnyelSndzcZAGlfJtZPKoukAPIoY1UTfRraD
         SyrDF/oEr8ERVQOx163Lvxmnx5mIKbYPhWSTeiFBDh4P12rfxztyg2BXEA323QkN3N/d
         i+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgLP1aUYmE3EbRB4VrZB6cPhBVFllnaaFtI9jwedpD08yfg7oX1A1nOWEmaOh5r86n7rVBibwo1lYLVd7d@vger.kernel.org, AJvYcCX171mnCTEm1jJ9nWykr+qluNvZQToY9Tn8EO5P45lIdm3LflvghLqEkWlUL0/YLgezlDtUvj9Oq8nC@vger.kernel.org, AJvYcCXWgzTRWQa1MS4Cdy6p9NkeI6pz2EbZSOozEegixW+3i3vKmQJV9K2rHebZZRkyUd/aAL+z1ZFNYmSH@vger.kernel.org
X-Gm-Message-State: AOJu0YwuAIvIOTRClSwohsyIom+rF/b1nRqK2ELhxouoE8XW43ygk3sH
	nxn0Va/PJP3nfJTmXAbxoGaWcY2s0yTLTyO+bAp3QXumwC/ByWv+e7LTvE79
X-Gm-Gg: ASbGncsIbIQWwYM8W38oVeEBtu5WqJVR6jdObX9q9+tHQ85SmvEQxNYO95FJsRChLc9
	jWOUHkMaR039RIegZQXZNZMfiR0icm5XhJn7njXgAy6T8QdW8YG+JW+aCpixgvd3x/6/5XKj2ef
	dSEctMrKYgdLVH8QiMHOrVodaCf+uz08SwbeXAec6AkSYEYv4VYabHcKEEW7/cRA/ZbSeH5qCyT
	E1Ir6KqKLB+rXdHZ8WVyTpeNWO6VYQ1Niid07WY1AH5p0XG0zdzsfgF0PVfAtjV3TsnNKWIL5BD
	xHW1hww0u5gK9YN3HNZgvGQ=
X-Google-Smtp-Source: AGHT+IFsLluCqw1OK1Vu8s2oXQXiFugZr6iSL5teJLTvRjaP7xZkkMKHNbaGmCsCMH4Xe4pZawKPkw==
X-Received: by 2002:a17:907:7815:b0:ab7:faca:a323 with SMTP id a640c23a62f3a-abc0de14741mr546560966b.39.1740208965284;
        Fri, 21 Feb 2025 23:22:45 -0800 (PST)
Received: from debian ([2a00:79c0:67a:4900:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbda707e3dsm645419466b.106.2025.02.21.23.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 23:22:44 -0800 (PST)
Date: Sat, 22 Feb 2025 08:22:41 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250222072241.GA3458@debian>
References: <20250221-flexcan-add-transceiver-caps-v3-0-a947bde55a62@liebherr.com>
 <20250221-flexcan-add-transceiver-caps-v3-1-a947bde55a62@liebherr.com>
 <20250221-drinking-tantrum-6e0bf9051160@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-drinking-tantrum-6e0bf9051160@spud>

Am Fri, Feb 21, 2025 at 04:59:16PM +0000 schrieb Conor Dooley:
> On Fri, Feb 21, 2025 at 08:40:04AM +0100, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > Currently the flexcan driver does only support adding PHYs by using the
> > "old" regulator bindings. Add support for CAN transceivers as a PHY.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  .../devicetree/bindings/net/can/fsl,flexcan.yaml          | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > index 73252fe56fe6c8e9fd19142208bb655dc86d47cd..81125883cf86b9d19616bde378f74bdb6a32f1b2 100644
> > --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > @@ -77,6 +77,9 @@ properties:
> >    xceiver-supply:
> >      description: Regulator that powers the CAN transceiver.
> >  
> > +  phys:
> > +    maxItems: 1
> > +
> >    big-endian:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description: |
> > @@ -171,6 +174,18 @@ allOf:
> >          interrupts:
> >            maxItems: 1
> >          interrupt-names: false
> > +  - if:
> > +      required:
> > +        - xceiver-supply
> > +    then:
> > +      properties:
> > +        phys: false
> > +  - if:
> > +      required:
> > +        - phys
> > +    then:
> > +      properties:
> > +        xceiver-supply: false
> 
> The duplication here is not needed, they both will cause errors in the
> same situation. With one dropped,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 

Thanks for your help, will drop one and sent out a V4.

Best regards,
Dimitri Fedrau

