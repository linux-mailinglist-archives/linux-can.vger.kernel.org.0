Return-Path: <linux-can+bounces-2905-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E309A3DF91
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 16:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23B916B255
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F01FF1AD;
	Thu, 20 Feb 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc5iwXNz"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4F8F5B;
	Thu, 20 Feb 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067009; cv=none; b=A52ewjvE0IMJ72az5pSbGY6L7pj8TiasMZRgpMwUEVv+yKRdvQfEh1cA2ytU3oAFhiiwfy0v2GNFmIVRzxEvoemY4t+H/gtI2DPYpyHOu5YJdt6+nFlE2ezGOV068aTexCgCp/qldo6tfHQj8+tlJpp+f7SWLGPiJi4ULulHu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067009; c=relaxed/simple;
	bh=nffl1SGgb9k0XBd8LUDc+D1JLkHpjuO5YPcb5/zg9yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2WhqGFNafoz6mI6ItXESX71Z1utftdqlemfVwd7N/0kU3mYuuXe1LOD94BkUf6RAeO/Lgs9uV7euic/yroOxkuKBAPmLsxjaQWWPLbyD+48AyhSPdDVPFubKHDqRou6xCDmxH6Xd6CZu8osbf/Mopk6nUzMP03ORizoFTEsfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc5iwXNz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so351149a12.0;
        Thu, 20 Feb 2025 07:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740067006; x=1740671806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsbE5OioLs2uyCIYYbmafxzSYqPUZVYTy2gzhJIQqy0=;
        b=Uc5iwXNz2VoZ+RZnHH7Fc8l3u7B3agQeHeYPsFkbM1cKVEbVQrIkqmODbGIuy1oaQR
         2RwC3yiTOWf1J/K0JEhTE1ESa/jisDXwxY+s1OKeTsCLGi2XXu7dxFdAKXb/ShffFFv0
         azuu+kzxjXXFF766LEB97qZ8eerhD90oFgZ/AdyvgkRGadoEBGGJJWb2Gvi0bNfd68i0
         uy0lwFKzepMYUwZc5zG/dze0u7t2hCd8/wykyZNx/Wczr1QrhHKdbwMVywkXXd9wF47h
         WUrgj4TaukX0oop6/XKyzUNINibxH87DV1q2owbfs2NOob8608IAyzd/KM0vy+1bYR7v
         0U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067006; x=1740671806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsbE5OioLs2uyCIYYbmafxzSYqPUZVYTy2gzhJIQqy0=;
        b=gwo7fRxQjGvShJMW6/mo0T2dmgSQfnCsH9dghpa9DRDn8GrcNrk4O5/Y9EKzJrZjBr
         maGc83t8+pBAX2M+3veLFTwcTh2gpI7QQ9CPZ+QOETASkcM5OwkIeNorwu6zQk5o1xpu
         X6OxZr4svr0h7dIBywO6zYCg9XRb2S148TZoZNvRqD62vSut5Yv2QMjNlOai6RK40S2u
         wXaA71bUb1Ol/4A0m9U0amuubefZpurkmp1TzYnWjhce6rogqULQ/HXu4TXHpuz/HDPK
         ZFPTvjfJcAuFh0yzADo0fpLbNYz3Bozo7V88RiHASU08XaoHMluS+SWVQIW1tPJwqmLv
         W80Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAT7ldHsgGvpiinpUfCoa5XHpRyrRFIIVMQw5iYXS1j4ot8lZzvpV5hNSnBK7QpvI0mkwgt5l88YEO@vger.kernel.org, AJvYcCULyXqkgAnzqZKLDK+jH6PPXKz1ETFB1QedUIEMzyVe2pV/jc46zdejzEpJNu56o9wSBypE5sJuT79zn8M8@vger.kernel.org, AJvYcCWel0txuIpg4suINM+wmPWQBaOCpCBGPNul616ifffYzf2Zlolr3sGi5begTx86fpNWqGFWjLgPkjF3@vger.kernel.org
X-Gm-Message-State: AOJu0YwCI2u3IqoXXKpGMxPpuopL0sQcp5AX8jnq/uRicsNsV2zc7+E5
	Im7xoa0Vc31oXrjK1jaiqsgUBRll6+Kq/MMpQtSB0QvzuZ5vmWiqyo4+0A==
X-Gm-Gg: ASbGncuz8oqX8NkMiP3d9Zk7gU1f0KppjPbDzvnFGqLYdpOVCy+W4K9/a3eCphsvgKG
	/1n4sKHeIfsHgkAV3y1+H5CQWj8Nl4l+iTJzSUoHnUhGHtmSBGIpd+1WjpeDzQlOnK1iC8dsZWm
	khY2soP9TASxntUBMjEut3rID6VzlyJBYNiyTcpHmR2HVHh0Kqn0ALaTT5L4pTjTRlKk/7raqtF
	pkuxM2HhMeWerAf7/lDAvxmZ0tVJDrd9Gj3PC62n93aKvtkL4a1eIMNCstuA6mlAZ9mqCY/hMFZ
	sAQI3eilz8M0
X-Google-Smtp-Source: AGHT+IGIujcWQDxo5qV8UJ8g4ZyLG5Wa9jYKSb9r73rJ517jMf8TRzcFwudi44KSrQwdSdCPdZ92FQ==
X-Received: by 2002:a05:6402:5306:b0:5dc:c3c2:225e with SMTP id 4fb4d7f45d1cf-5e03607063fmr19939243a12.8.1740067005059;
        Thu, 20 Feb 2025 07:56:45 -0800 (PST)
Received: from debian ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270affsm12053072a12.54.2025.02.20.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:56:44 -0800 (PST)
Date: Thu, 20 Feb 2025 16:56:42 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250220155642.GA43726@debian>
References: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
 <20250220-flexcan-add-transceiver-caps-v2-1-a81970f11846@liebherr.com>
 <20250220-tasteful-loud-firefly-1e2438-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-tasteful-loud-firefly-1e2438-mkl@pengutronix.de>

Am Thu, Feb 20, 2025 at 09:44:50AM +0100 schrieb Marc Kleine-Budde:
> On 20.02.2025 09:22:10, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > Currently the flexcan driver does only support adding PHYs by using the
> > "old" regulator bindings. Add support for CAN transceivers as a PHY.
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Is it possible express in the biding that we either want to have
> xceiver-supply or phys?
>
I didn't found anything to express that in the binding.

Best regards,
Dimitri Fedrau

[...]


