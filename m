Return-Path: <linux-can+bounces-268-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486EE854521
	for <lists+linux-can@lfdr.de>; Wed, 14 Feb 2024 10:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B711C22B66
	for <lists+linux-can@lfdr.de>; Wed, 14 Feb 2024 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DCD12B74;
	Wed, 14 Feb 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="skAN+5S8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A4125DD
	for <linux-can@vger.kernel.org>; Wed, 14 Feb 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902764; cv=none; b=tP5Xo1qsyAdbp9og+gpzKH5Y7msJKsCz64iYkjb2yqM+iOleYh0qx5zWa9kjnNZ7eOGlJCN0U25IUJR2q+wj3CftYn4sD1ddNpK7rnaERKZG7veVs7sncejZ5QfYvzORb48JhrNODfrJS2PS5nLILeT+WLSfajoB4ZmB2plMSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902764; c=relaxed/simple;
	bh=xj9dXaeOIXA5BqZZhc5Y4+eZOBSkuMkXvEhH1aPuNYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noDRHWCqMZRxRXEuBSWhiiFbYIzVvJ4e4dIGHpq/VTaxRRW2fYv/RPGqXkOBwCgo/zQWVPHNx0HNnPOXfL2S/XqdA/tEC8zAIK8WTeFi2kvQHrIFQTdB8KZupDPZXaWviBJkYyKQtN8Uy30M4lUa6buhQAkQJE3hNsp95O/m3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=skAN+5S8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso798448566b.2
        for <linux-can@vger.kernel.org>; Wed, 14 Feb 2024 01:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707902758; x=1708507558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhxRs6SSjkibA7W5pC9FVX6HwhYeINzSzFuIy6CNJvo=;
        b=skAN+5S8m9p+79WlYWdGKF7hpYwFyqUHWcm0ylGfj9Jgq2StGw0NPOP9SzObRcjAhC
         Rk2hY1xp+5Ng+h9iO+89kfiB9lFyfy1Lo8C0s/qt6DOxJ+x5HEHGmJMQrc2qPdf4pwZZ
         krQqp1qcBv2RtQIid/zUNjXb7NsC9Y0lOpaTMyodjdR2TDMl7u4fNsIjdfnMH7tcOpKq
         F65iWcDPrsrOS300pT7XEL1WP8P+mm3DkNGg81AnwleSOVghGfuusYwTMhb7b9URaOhr
         FWuw6Tdm49oDavGATt8ULit09WOb58xUu2dpaySrxMAPL2mq2m0WZaTiTKaAHlEB7ZOK
         2Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902758; x=1708507558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhxRs6SSjkibA7W5pC9FVX6HwhYeINzSzFuIy6CNJvo=;
        b=WQFqJKV8q5icN4xzO0FgZmgXYjWiXGl34CXshnyyNDVeW4HD59RVPKQcP5hE20ELT9
         2K11oZNXQx8r6cePyKTo5t3eh1HLin4yguldAqYu91BekiWAygJyuJLa6rZA4C36gjEB
         HMTZriiv9uq6K1Wbd1KZscQcctOgAL0sTJLCcQIz/I8MP7lrornUvQzNgcv7Jn4mJl66
         spyBaFnzaRywwcP+DOpe1QjGa2erG3bg98LgXqebsZ2GM8G19zOsaUdlVvjF5iZHmT3Q
         84hw6i8nNf+L0tog5m9BsdoSBoIUjLlq4lbC1Dmj5sYszfouniXDNSvLnfZNtUxnyf/H
         OuUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYCii01qRmY8GXGzlqmHkB5Xj+b36GVqLEs84EYp2+pH6vWqP3+iyDQZJv2LsqQ3OQ9bfTH8aXJbNeqHDCMswJxdYuwVWaLEK4
X-Gm-Message-State: AOJu0Yz98spp1JCcjaVvxQLzTtie4kca+WrMdCicQSx6Y6LXi0evX2PD
	VEMZYG1RSiwGAfVfWqfuPAxwVeLV+xZ+AN+tgsSv1+4U+fz6/XDvu2bC/6by7ds=
X-Google-Smtp-Source: AGHT+IFbZEP05mfaQf4n8yLVLtlI839TcHu6ebPxjrTjCWzpnc6cuBGhvvEuaKti+0azSexmMaRdww==
X-Received: by 2002:a17:906:5a8a:b0:a3c:e99f:c08f with SMTP id l10-20020a1709065a8a00b00a3ce99fc08fmr1426951ejq.40.1707902758518;
        Wed, 14 Feb 2024 01:25:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLnb0HNi/cCNAzkyVRZEOCvecUYK6wndtUGIFSyZQuWP8byOSVlPR4x4GugMKhjiLCTCCkh/Os/MnaGfEleDnMvRMzl1y1pHlL
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3d52fb111csm277721ejc.76.2024.02.14.01.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:25:57 -0800 (PST)
Date: Wed, 14 Feb 2024 10:25:56 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dave Taht <dave.taht@gmail.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH net-next 17/23] can: m_can: Implement BQL
Message-ID: <qtar3a55kqrkxgyon6xezhg7cx4rmh2epk55xqziioeezuqb35@ym42pclp6sxw>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
 <20240213113437.1884372-18-mkl@pengutronix.de>
 <CAA93jw4awX=pjLVh4u3ERboZw+gG1aaAaEc2Q4ixa5fpS7UNxg@mail.gmail.com>
 <20240213-uphill-cussed-820d691c7d95-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213-uphill-cussed-820d691c7d95-mkl@pengutronix.de>

Hi,

On Tue, Feb 13, 2024 at 01:04:17PM +0100, Marc Kleine-Budde wrote:
> On 13.02.2024 06:45:04, Dave Taht wrote:
> > while I am delighted to see this, what is the observed benefit?
> 
> Let's add Markus (the author of this patch) and the linux-can Mailing
> list on Cc. I haven't implemented this feature, but Markus has.
> 
> IIRC BQL is mandatory for xmit_more(). And xmit_more() is used to batch
> more then one transfer from the host to the CAN controller. This brings
> a performance improvement on for tcan4x5x, which is connected via SPI.
> And SPI is a quite slow bus with lots of overhead (at least on Linux).

Yes, exactly, it is in preparation of the next patch in this series

    can: m_can: Implement transmit submission coalescing

In this patch I am using netdev_xmit_more() to see if we can batch a bit
another transmit before submitting all transmits. For tcan4x5x this
reduces the number of SPI transfers as the final submission of a
transmit is a separate SPI register write.

Best,
Markus


