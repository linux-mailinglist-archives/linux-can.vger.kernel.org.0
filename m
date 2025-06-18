Return-Path: <linux-can+bounces-3863-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBADEADEC5D
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 14:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BAD176BAA
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F1E2E54C5;
	Wed, 18 Jun 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q62LiJ4a"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187AF2DF3F2
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249669; cv=none; b=Bsqcy7fTVXdo1CkHQs6AbpGInp1fIcTyWWZ3D1RW0KfD8SHfdmCM7kIn2NhC54WdrydWGWmSlssNKxvUhgUbQ1Y8OKjfuD0xswJpCc2084nOupcI7DU4ykycTVCsbjYO0mblrY8m1uEMOpQGOkc3uKBl/7y0de3nKq0WfAF/DoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249669; c=relaxed/simple;
	bh=lvDeYY1tyHLW44AqHwWF82BKnD0o1q8Cao4PGtdqJcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQz7r9D+UG7JIaAcUB/1DRhnpEgpmFlUFPO4FAMRdFVFjor4jAePTFWxI9NCfnfNJr/lQNbDoV528YSS44EN/18vRGhItvmr491hhtWjjdk5LmirGcTAv+uQNJzUWKtuVM9xNFuPrrwS7etNGJ3s61fKzwXaMGcuc/VFR1JVMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q62LiJ4a; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so4917161fa.1
        for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750249666; x=1750854466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvDeYY1tyHLW44AqHwWF82BKnD0o1q8Cao4PGtdqJcc=;
        b=Q62LiJ4anBM9mCtPO1s1wPQafnXMiY44Wb6sed9JH7B+3kqfcj6OlRn0afcRWdxW2T
         GbRcS2/PDp9OME8vCM6aCKmKaSnRlRkd59Vywk+e0f+LJKKgmpr0IkbPHWiFpdeQJTed
         Ki1UZKrjGbTKc3php1hkcjQXclqOj8kH4nvJPUbCkJ64BuXCSjNYt7EpEJ9H8YK6/UAt
         hYlkTo3J5CwzbkEY7LCkAbhwCYvxdwlCVBsecB6OxorgUdahP0dPqdIUTSpYbRS0VW0b
         jmNktZZFxYS4UhcC6SxCXM/VnJgbSDqrjF/aSDVzedYhZLiOR6sWKcwvIHp7m1Ky8hvt
         U3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249666; x=1750854466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvDeYY1tyHLW44AqHwWF82BKnD0o1q8Cao4PGtdqJcc=;
        b=bTTl4MBxqsP2Kk1CGog1WVJxfWYW9YnTyB0Fuy8BgsuH+hubhLvWshawhw+FbqfVmY
         713bc0mWmfqvkLxB2VWNAJD/AEpE2cdTmQ4G8LtOHlVwqPombGucyEnnaaAgHHgdVle5
         /BzclBFV/Ap2GdIFd0HhEH0rizFvGhQ0BNzk5Nqi+vM3+QFcVF0EMRcCIv471I3b7u36
         AmrAdLykcpdUmZ5HeFBGHIcijijdBCPF97u69pzgf6iRF/zJk2c+/lU1VVIt/XfZ5JVk
         z+nDM3vLSiglOonbvmlDGQYcdon2cO7SQXXAiQprlKJJw6uLqUaJLdI3vMKDUQ/4Sj5n
         G6ug==
X-Forwarded-Encrypted: i=1; AJvYcCUtJFa/mzm2/kD1Cf4tXGO4cZ/+VOqFxmthDrfRwCFHBvowrgrDTvJHTkybZyzcUbVUfk/r6jIJQYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+u/bhF62BdEwz4Yw0AAfVCSLcTAJpfk3VKJegP431y2LBFQpr
	dlMez13Z/K/em4aYfAEhxdcwetBpSJoIWKw2SVSQffiHBoWT7s3HqdvJ6TB+y32JBH8N2PbQ0FE
	PqE16shqkrrL7af1nWTUjeEicqLUXz0vrOLn+v6ggxw==
X-Gm-Gg: ASbGnct4zjhONT1pr5+h/sv12BYbyOijR2r2aIEZ3q4BMNf4xybMJTmKo7p7X7cGXnR
	g90JdCBkuPztrv6e4nGFs5PiGBeMtAnbZGrc9UXQsQYBllXvcgX2DPE8JsZJnlH5NmKx5REeWna
	FO/1fquEvSe3i7PgQrme563GZmCvGC+Ld99LuvxTihNUE=
X-Google-Smtp-Source: AGHT+IEO41Nyhls6z+tYoLHnOV+DOmxEURxkPhjx4goE9pZdzx8ZYG8pWoqgfu9hnvxH3hdYq4NmpJCLdC/k/NenFbc=
X-Received: by 2002:a05:651c:169c:b0:32b:4441:e1a6 with SMTP id
 38308e7fff4ca-32b7cece005mr6055841fa.1.1750249666214; Wed, 18 Jun 2025
 05:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org> <20250616-gpiochip-set-rv-net-v2-1-cae0b182a552@linaro.org>
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-1-cae0b182a552@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jun 2025 14:27:32 +0200
X-Gm-Features: AX0GCFudNOYMyXLJ7vMaeO2dSvhoaQWQJroQG17p-nXTR5Iec4T0QKmapC2D9eA
Message-ID: <CACRpkdYJ9O_y9TGTOw8mzf1=LvaxYCE463MPf12YaXUQCKaLzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] net: dsa: vsc73xx: use new GPIO line value setter callbacks
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

On Mon, Jun 16, 2025 at 9:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
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

