Return-Path: <linux-can+bounces-1206-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5EB95AE70
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 09:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9463A1F21FB8
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA83D0D5;
	Thu, 22 Aug 2024 07:10:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17233EA;
	Thu, 22 Aug 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310644; cv=none; b=fdk4z70Q3pONg26RTPRkNkEfJkdfhFfz41Rdw4zKFqYGUUJA3+pQQeSy3pZ5vSOibRmk1Rc4VG93V3wK1WyniQ74xyGinJx/zqFl6PS1nlZsPJQa/wRHmV12YXWqsao7RZ/f9nX9BF7BtMEQDbtBmCMGUMiucIrAcGoxrTgEtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310644; c=relaxed/simple;
	bh=w/J5Bic5tv3Or0sd62UrBFfcKPFWqaU06HdsfJQJCRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYygAh+QFPPrZJ6To/WHATWqWb/J19yMo9KCwqPs2mrSqB6KM+5OGjW2KIqSxCZ9J79Y2ZyJfrjuVm2GpZf/CWz5V79CPGdqI9tsqSdq43N9+RruQOmBvWnHapIHnGQn65Hu7dxiE2/3CyOvJGLzI9FwQesr5yuthFFmVbbCChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e0d18666so2553715e9.3;
        Thu, 22 Aug 2024 00:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310641; x=1724915441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJLS+VMzjQh/qW23wkGqqs7vCL2z1TRLs+avsxI9g9U=;
        b=H1CJGsYtUMzN6psxU63B/mlq/DXGhGIyfVCj2sMpa6qU0yXsSuXZ7W2Ys3Qj0rgmBa
         RtJHBi4KPnaKNp1n9Oi9U+gtAaUvlIwhNyu/ajlYQYMmzJkCBV2C3MBMiWTwi321knDo
         Lr5b2tPFhjkxNQpKYD0CgAswZJUp2g2n83qwODI3k+x5N5abSMVxYQT4Gu1pFb+42B3B
         xnAiayiTO0er51vnd38v5+HyNKg/5X0UKTQIB6jreVa0RbMW+bjuHQTbyYh9Uqy6BYar
         E5J2dTlluA+ZGZTlWeL6MxFnb+08A5pFW6XiB/O2mkVdcBUez7d4S69Gh22PORRo6gWo
         FWLA==
X-Forwarded-Encrypted: i=1; AJvYcCUFiQgc5YmUCNL/30DDFVrdkOEGLkogT6XaX4FFhKoeuCjBlvlBI58cWPQ29KlKP9uENkeusDHPvgZ2@vger.kernel.org, AJvYcCXLFGn+TYaIa9uR0f40XiH4NqiA1oQvbBmSmjjuRZcid5N6Hnq7rHA9PatB2bbi7Y9UP+cRk/8l0z5r@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwV71nrwmxuhO3VLWZJmtuqJPwb9tl01Xc2rFv87TqAsX6ggj
	cZ4KtpvnjiptOaaattBks/yFBtPp4pw2GK//er0VSaCm0NhaMVAy
X-Google-Smtp-Source: AGHT+IGhVPATLSo8mqmfADnE2rN+0EPjvp3o+g8b3YIlLtzolWkMDw+jE12kniXWaVfmPiUENvKPmw==
X-Received: by 2002:a05:600c:a0e:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-42abd244b8bmr27855965e9.27.1724310640800;
        Thu, 22 Aug 2024 00:10:40 -0700 (PDT)
Received: from krzk-bin ([178.197.222.82])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abef81a5esm50053995e9.28.2024.08.22.00.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:10:40 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:10:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ilya Orazov <ilordash02@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
Message-ID: <txb77x3lkk6gnhzavx5j7ahqg6wjdm2zjpk2fe3z7vopit5kvg@pxom5ang6izt>
References: <20240821215357.20224-1-ilordash02@gmail.com>
 <20240821215357.20224-2-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240821215357.20224-2-ilordash02@gmail.com>

On Thu, Aug 22, 2024 at 12:53:57AM +0300, Ilya Orazov wrote:
> Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
> 
> Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> ---

Where is the changelog?

Where is the tag you received?

Why sending it again without any of the above?

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


