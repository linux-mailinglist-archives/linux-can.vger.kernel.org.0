Return-Path: <linux-can+bounces-2799-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB82A33025
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2025 20:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0CD188B87D
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2025 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859EA1FFC6F;
	Wed, 12 Feb 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cns6rxkw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37811FCF62;
	Wed, 12 Feb 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389930; cv=none; b=G1q6g+oMbMuI9c6g6tkY5MvwOaT9c4oUuqfY2ah6SNsvs3jiJgno0A14e+hpjVyNjnWyCSLc5VXoyOwnrSPKQrXLH0rCS6BCCMDZ1FHkpcvnU5vmxc+4IA0WNnmRg/1vExrHPFG+8aYod8Krxm/F5G79/wLygqdAy6zcSZ0N/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389930; c=relaxed/simple;
	bh=svP2bHtEKxrxgwCc30XUkXTy8s3nGvIl8JxdEDlF8vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLUTKCQt2g6qgokXs8J5nH1QFWXt56n98JFOxmtLKjLK308JacygGSNploi6EA5EG5x1vvwIIN6d5OpOBKGLYIh8dR6kSCUUeak0V8yljPA4y6SBAM7zNbpIrx/Or3BJ6F6pK/Am/umOR45H1O9GEc5EfmYOMg3Xh9jmcoiXotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cns6rxkw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so28085366b.1;
        Wed, 12 Feb 2025 11:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739389927; x=1739994727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zhd06IjHZfLT4HBytQORmwA70omsIFv46zwYCqr16k=;
        b=cns6rxkwVKByB7uGTv5wjbmNGyb4+sFAyBsALD2g9ZP+JutOh412YwIU7Fwo2yIzvE
         wGRi2G/t3MHyyGTKATLTiNflSC6OEQPeN7XopxExPfzVyoRdSTjp/B1yRChQtHGB8DcA
         eiY8YN/D0KktnbC0XWkfqtjoEstbdWrKQilYO/d8VFHocAy8Ntx1PMjRWnwPA1AhyHgr
         dahJTRm7UJZjUBqa0HsUuaQxnU3fpFnKPAvuyCetG2/uoqCwzdpAWGurDYlsbN/PWcsZ
         VfTiPpa5gqC9da7V80RdLjH3CbpmYEBvItwRuI/EvsM0CfI/Z7YRbgZJInIJYyz6nI3l
         f7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739389927; x=1739994727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zhd06IjHZfLT4HBytQORmwA70omsIFv46zwYCqr16k=;
        b=CFMosxF07Jqiq0SfQzLVM3TVfoZ5t8XW2i0/jUhmCzaVSXtwEeP0ChZeG8iygHxpO+
         UzxaNeU5qoHT+7UkRhmqik9c/lFF+X2NBQcFa3Vnuntl9UY1wQZsZHjV23xv88g200L5
         eBWYXZfKV7qIa604KHEoG51tiIZuYs9Z6wohLH7+uAsj9MfiKvriMIJ7iujOVMt6HYlx
         JSZoI/BtAhaFmtHsxuulT0EwgwAkGBARA8lWmZk4Fr9Y7ktFd52qZW9TtYtENoy1FW8r
         +aZVbLtmP4flE6HC8zVm3aNpzJTmGWs5pYRxeInFjDcb+MbaM57EA8WeqVKrE0Lvuk7P
         L31w==
X-Forwarded-Encrypted: i=1; AJvYcCUfbxD6KayaJmZi9fG5UZaOGoSm2SH586Gsi+7+RBsBA8j/wzp1qhXEPFcnL1aS8qfLESjLWUilMZe2@vger.kernel.org, AJvYcCVQTJYwcBV7HO7hx5aa3mMEqzziULkwjiXFMA8piRPoUlseOGVZBE6shHZWn+CGFfcyBOWf7kJVn3g07X/n@vger.kernel.org, AJvYcCW+IH58eFGk8tQk0YlxRlV8yoRFxy83EuvofKXs+ADuTneq0sImY4e8+SH0ZWKrcZNW8H8r03iDJcGb@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMTtTOz5o8aGNvE1K+PYvIxD9ZUuuB3Dd141Q03xCg7DQI8Tl
	8to7t5JLwXfEJb9jmsNT2eayGA8vW1mv5VGUHwtr6OtK3Ta/kBvP
X-Gm-Gg: ASbGncuJXHPNDP5adrj91yRMaxMoJxX2Dm9Cv7YdVPCnVd8gnKFW1Hx3T0l80vXjUcx
	uvYOr6KS9nnr/Mj4oUzSOS515RsRzCOuUSFSQana7k76Ib2ylsgXZJYGBc6dBwOJ0Ee39vQBRkR
	7trfMVXX0THRc8ysPQN685hB90UVZRu0Yk8r4Bv1nCJUpXJO2vPZq7f2gnGDnsATCl007ZsFl+U
	IZH9gqWpVERSM7oqeysRSueTxBVH5jr2cdXO5YIFYwKPgILVdhrw3Dlr8WQTduVeOrahDHMY27H
	l80rSCkgoD5Z
X-Google-Smtp-Source: AGHT+IEm0Yy0AXrIZrejQ4Xge7HMYIS4YDk6Ve/VUXQl7pIf3gyjWYOZ8w3UfqE3bUf5C2okTvxsJg==
X-Received: by 2002:a17:907:97c8:b0:ab3:7812:ba69 with SMTP id a640c23a62f3a-ab7f3325a9bmr431574366b.5.1739389926793;
        Wed, 12 Feb 2025 11:52:06 -0800 (PST)
Received: from debian ([2a00:79c0:659:fd00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7eaeb8596sm308690866b.138.2025.02.12.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:52:06 -0800 (PST)
Date: Wed, 12 Feb 2025 20:52:04 +0100
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
Message-ID: <20250212195204.GA6577@debian>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
 <20250211-epidermis-crib-b50da209d954@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-epidermis-crib-b50da209d954@spud>

Am Tue, Feb 11, 2025 at 04:38:48PM +0000 schrieb Conor Dooley:
> On Tue, Feb 11, 2025 at 02:12:33PM +0100, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > Currently the flexcan driver does not support adding PHYs. Add the
> > capability to ensure that the PHY is in operational state when the link
> > is set to an "up" state.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > index 97dd1a7c5ed26bb7f1b2f78c326d91e2c299938a..397957569588a61111a313cf9107e29dacc9e667 100644
> > --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > @@ -70,6 +70,9 @@ properties:
> >    xceiver-supply:
> >      description: Regulator that powers the CAN transceiver.
> >  
> > +  phys:
> > +    maxItems: 1
> 
> Can all devices in this binding support external phy? Are all devices
> limited to a single external phy?
> 
As far as I know, these devices are controllers without integrated PHY.
So they need a single external PHY. Transceivers can be very simple like
xceiver-supply in the binding, but I want to use "ti,tcan1043" in 
drivers/phy/phy-can-transceiver.

Best regards,
Dimitri Fedrau

[...]


