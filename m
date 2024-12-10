Return-Path: <linux-can+bounces-2374-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24229EB125
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 13:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8427D188C533
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60021A725C;
	Tue, 10 Dec 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="N5GTBVsG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8C78F44
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834818; cv=none; b=H7L/ZVd1lOId3qf2QoJOEKOUF8Pbjk1EHv/lZpjqSTqKNx3YUGmzLyjQz5Qd5/um/ee//TO7bRlL26UN2sC7GQE2N57eNnFILeliCmWlFrlaqMmcYFHfuYIh2Xy+T2XH8PQNDDX18NwCw8Qnhy1g7dLcNltDWkqRfl8f8w/PTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834818; c=relaxed/simple;
	bh=KX4EV3S5tpdSVPVaMW0IgVo/XNFVcw+zGMXFSjwdn4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiRvtcvHODWNSN3ONUWlJNdDPuHeXRLFcZSyAETRuHWdOyFJsalmQBqi/iqxGmMK+YXHUrMGhZK2+Zl0KpIKLZPG/UrlpJXZTKebKLUtZ+qW4P3+sAStLy5g1peh9aU37cfthPFF/yuRtsBlBmghZyD5eWTOtnXlvr+czuB7MHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=N5GTBVsG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so51452091fa.0
        for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733834815; x=1734439615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2gv17yRT4z0rHDfJ0xNPXvIsRkRnNe0DZfYlBqVB+Y=;
        b=N5GTBVsG2KMmwjiFXXNZANCiDdkUOMEhZXubJTwofUPnyPJfittosAC9P85mzVRcUH
         m1f6AVL/CWSwuJ/9xgi2NmpmQVIR9Yb32Nfsd7P6xqViG6WPfpSp5oCB/UsFnQkk9Cnb
         z1KIfeQUX1c0ob0E8NQmktlYOJTBjZlb+7YKZnCL9qrw3D1LUJuUBLeXxGF9aDR8alkp
         xmIZDjVBiYMtP6SDIvy559XqDYGBGWVQEscQOUVYL/uuqVKyZqI5U2p0I4dtUbViHixk
         WraUB39L/Av+uWRqoJfwJ6383htCur/3f9CAi1UskwuBuzUDkZnRB1ZEIlrdZLIJzCQn
         uBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733834815; x=1734439615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2gv17yRT4z0rHDfJ0xNPXvIsRkRnNe0DZfYlBqVB+Y=;
        b=t4sxwzdXDRRCKDI5V/Weu38gdzsZLhC43seZasVLEZTUgDYUPeR6jcOjXPR8TncjXS
         BKb2XHUV7XrFo0F7wapXyE9rSZTZuFVds36BXn9FfHPGL7UTGsKeA1Kjc0z0VzIhd+zr
         YoqjLx+KR7kEraRGA/JTZWupXiutVyfENkm0WfGVJQrNFskirOM07DdQwhRDZTZNHang
         xxNjLTwdTxpLIVS/6C61/Cl5uoaYwHiNw1BNif/OpvZr65Nu0Nrx5Cui2YXXlLCWoTso
         mzmxGgE+COyYnsdLZOid20/1IVhPVRZxuZJ3WgAKJwf9lbGPNcux7CjqzhgH/1C6mbQ8
         2x2w==
X-Forwarded-Encrypted: i=1; AJvYcCVEuuFBS+uGLTiKdaeoUyUiDU6QQPZsi7Tr0BWgtnBX9s0Qfp6uGCumNCClKt+//qmDAsl7Fwy1Xcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBNllGn0y4GfqysuNCHuH2IhMo5kxHJzIbi6j9sTSzbJGt/DV
	VMLtVK/LTthuAlUswfaDc9IbLAsVcCEN4rFTiWbGSdPinv31NLt6MUu4vJ1bpkGjrTpNzjWpyKZ
	pHRxIG0PVx2RQvnLPZkXYvythRsfHBYN1kkb1vHoq3Zjj96As
X-Gm-Gg: ASbGncvLbwuQ6RK+9tP0rm6IHCeo448GxTXMIZbhSsCI5df8lN1mEMpu9/JsGVeuIRt
	ybUgfknAkoJBaQjbGLUAKhEAfEb7VgKA5VnrYcBEl9UbFIHfUu5pD+vaKzKyhRQJGvz0=
X-Google-Smtp-Source: AGHT+IGlGjnX41lf5nD3xaDqv4/+1zouMo9m8MDdOTdpToJj+sYN673kMGyE3ysEnuS7DFynzHplBUGfucHdrqsCYuk=
X-Received: by 2002:a2e:a163:0:b0:302:336a:898f with SMTP id
 38308e7fff4ca-302336a8a1emr6922311fa.9.1733834815083; Tue, 10 Dec 2024
 04:46:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210104524.2466586-1-tmyu0@nuvoton.com> <20241210104524.2466586-3-tmyu0@nuvoton.com>
In-Reply-To: <20241210104524.2466586-3-tmyu0@nuvoton.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Dec 2024 13:46:40 +0100
Message-ID: <CAMRc=Men4QM3a2rydxDYwLjJLYPB7Uid=y_DJ8YNa-So2H3NQQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpio: Add Nuvoton NCT6694 GPIO support
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	andi.shyti@kernel.org, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, wim@linux-watchdog.org, 
	linux@roeck-us.net, jdelvare@suse.com, alexandre.belloni@bootlin.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:46=E2=80=AFAM Ming Yu <a0282524688@gmail.com> wr=
ote:
>
> This driver supports GPIO and IRQ functionality for NCT6694 MFD
> device based on USB interface.
>
> Signed-off-by: Ming Yu <tmyu0@nuvoton.com>
> ---

Looks much better now. Please address one more issue I just noticed.

> +
> +       mutex_init(&data->irq_lock);

This is never destroyed. Please use devm_mutex_init() preferably to
not add remove(). Also, the other mutex doesn't seem to be initialized
at all.

Bart

