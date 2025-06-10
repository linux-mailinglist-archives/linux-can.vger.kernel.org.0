Return-Path: <linux-can+bounces-3802-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834EAD45AC
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 00:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C8317D222
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ED9286D77;
	Tue, 10 Jun 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNuDHYPl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD54283C9C
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593335; cv=none; b=AcWh9FwHnCqILr/Djq2KbjxxUCFYvB3CTdcqgRzW/BU/oBncfuODb6GgH8zwbXPotLLSdxqO2xQnGjdDCA1jxkQeKzOnU+RcOdxYe7a8I24dJyxlnbJ2jxxVAQVMONOCQ4puD7eBfeM9hfpURZ1N/bg/KYN3klfRQiJOTeoeIag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593335; c=relaxed/simple;
	bh=y7nuDXxHMeW+apAcE+4L7YtuvyqeNU/MY3xvfvw+85c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihqIvfJya7dk8hWvjEibNNAuO+PQ3ft/Nur4m5op4tQVxWPuOVinLyYYJgI1IsW5IJGURRQUwMoWd9c3hUZxDO83X7ecoxUm/68zThclGwTP5snbgXnVGj+I8AL+wzv75ZXpsgRna9CdeFfkainev+YRB2IfjvNWF2VaScxPd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HNuDHYPl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55350d0eedeso6227827e87.2
        for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749593332; x=1750198132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7nuDXxHMeW+apAcE+4L7YtuvyqeNU/MY3xvfvw+85c=;
        b=HNuDHYPl+K2Zm5Mnxn2A5pYoDofWUVMI9eny4zxnJqj9L+tNaq3dT9srblTB9Cl+Yo
         cMdG/rtMGo02HzGBe2TU3voDdHpHg5Eb9cK1o/VLXS0Ng2MjiKY9lrmh0Un6XNL643eq
         cEhhRXkcoMAEZTdH0eBxGpsluQHJJtox9sdfAuS5hd0vRva4vdtsTOXF8ChPGfVsOLvR
         KLOza4yaAa/VOROLBFy9QhzupDz0JVGzXkYMKwwFLmjR/rdX2++MX6ESNmNZQOceaQuJ
         oAFBK9EKp6EK0rChdUA5oZfrJ35zRnxZtJmqJqVbcocgfahNKuCTtVGupI6Y82qhuSh8
         qcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593332; x=1750198132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7nuDXxHMeW+apAcE+4L7YtuvyqeNU/MY3xvfvw+85c=;
        b=bGw3H6E1JQaCcgyi66WNW6sdEBFr7wTC5m0IABZqaXqdqtijwpKvK9LIZm+i3UUD0f
         qNdFq/juWWbYmK/7aHredBZdwH3XyYoxeztqK0NUUnB1+IU8m+aXzejzkPU4ljxnJrn8
         L7fLa4og1L8uUxKqnGwpTg/T5nGeBNKRni8AvgHSzXWB34Uckf0El8EGzzZKjPttmqA2
         cgr9c9qDY8DjlBg1OncthouMM5k8l3YVe9UuZ4xbZgbF9WRWsX0ulbaZ/KzVTMJsXTbX
         Tx4oDmYa5Wkhi7PLNXvXAxfbsLZlVELMnLAsXApbl0RdK7pnykDkF19NjM/y+uNDgdu0
         FpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYvBPUcbBFRkweUYE+RkWVY6b+ByXZt5C95PilkeCrUZqgOwwJF00QzxaCm6rxewe9lXc1/yqcVdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs3y0ytOI2auPX5FrO4DCu2cXNyjrz/76ydAvVHO38JogwtSm8
	VLQWvK+BNGt4+fO+mjpjs3b/Jl0HARJZz/Yd7Z1oTXaqzqVvLoDAQ7TQ4LqO/94tnvFjz4vo41A
	HSktBfVp6aakRddZME+kQKvRVAr0KyYfXyOJl8Z6y1w==
X-Gm-Gg: ASbGncu9VR+2bkr7QkxGjcCpIpv/vbGCgweY5liRyJmIqhFlUdJMHKoWDZP0zpfEptt
	DB/VeLD3+zF4veklf0DTvPcolF8Cj/BS3UnHAoLYIs7lDxypebPMGVZG+0JgSELEiOWCEOaSEcv
	NyA1pwY1sIs5UivKAT6qxNIyZ8LbB87x89j69Smbzw/28=
X-Google-Smtp-Source: AGHT+IH8MetiTltiLxVsoQdcqnz9SyKbfeIivBe6BgaYPax7FqypUr47bqpDDYKrtQHdmKVxRlIZT6Fr1Q1yswx0lfM=
X-Received: by 2002:a05:6512:3b96:b0:553:202e:a405 with SMTP id
 2adb3069b0e04-5539d327776mr135286e87.0.1749593331540; Tue, 10 Jun 2025
 15:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org> <20250610-gpiochip-set-rv-net-v1-1-35668dd1c76f@linaro.org>
In-Reply-To: <20250610-gpiochip-set-rv-net-v1-1-35668dd1c76f@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Jun 2025 00:08:40 +0200
X-Gm-Features: AX0GCFvL7R8uIhwfFeu8Zy5wwVjWQCtUtnOLFaGyd-WVGbMxfXjNiZWqOaZW5QQ
Message-ID: <CACRpkdb+1uYy92975JbFUgvO0GWZBru1A8gOsF_VY-opzxopSQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] net: dsa: vsc73xx: use new GPIO line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-can@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 2:38=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

