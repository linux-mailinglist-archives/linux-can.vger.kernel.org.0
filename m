Return-Path: <linux-can+bounces-5089-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB16BB093F
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDDC3B7188
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62A2FC89C;
	Wed,  1 Oct 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HUfgTKlY"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897842FC875
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326801; cv=none; b=URsFkAOZ0hjsy/UOjGmNF6M80L/81asHAeCGLXmb9ex/k/sKCMGlTfZ51/DtdAWK80xjHnIEeBpVxbfUrWlMWjf2Mz3x2EQ/xAH4O0ec9dcs/FhiOYmqoKmJjNBRIeMxmELM+MRh0MkPCwyuyTsoc0zy2uwiTfFurCkNr8BuUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326801; c=relaxed/simple;
	bh=HKbSceL0DqvzVkSf6+zthbI4p8KdIl+ZOzq+TUc17ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PukM7YVYBP7iUjezd9zC42Fbs9f2qnRd9xhPR2D/d+sNE8uPz6kr2rCYxPIImzKStEycO+r2RLpUn7MdKcFl6e5mdURYlEq1r+ZmmA4LyzDt+FBJwKXjS1AMp/bxHfHmVyfOgWmOmd5wksrNFgJPhnIR/ZsrF+vEACOS55Sgnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HUfgTKlY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-366ce79fbeeso64353551fa.0
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759326797; x=1759931597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKvM2O7Z2RHzNxkLRoLXZKV8FObDukkA/ffySi/dWJQ=;
        b=HUfgTKlYyVnJ7X1ZPU4BQieTHwWZxcpgiOjQWpJyk28jeRbcttMC8NHUtrBLFEHrGz
         E5PVoqB56vzqIPnOXJr1ZQHz4ElFcUenbNAEzz7b8dVbxoGEYE8JmBCfmj2x4DweV3jg
         BuK1k6EFp6q0M8bLBuPwGmaySRBukzqSB6MD2N4k+sKp92Ifcmo9A1mvqtzkRgPN4ZVk
         fpwHo9+3bw00uZG8WtvvTjpJiqrHfIuISeG5S6+7K87SHz7L9H06bLuS4hVSCuPH5cE3
         atKETBgXOxL1UDJ3AUwHIJarIGecYy7SoBTHXjnLw8s5VfkZ5KGnwvtC58H6nCXE971P
         GsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326797; x=1759931597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKvM2O7Z2RHzNxkLRoLXZKV8FObDukkA/ffySi/dWJQ=;
        b=gAVVj04caA7Loge0mW1LDjEvJ3i90zluNBRPIgCDn/2G3Z+8cs4E11K7WTFs8+/nIN
         lnFgJS8W+7uoK5TrQk6JsXWfTZUcApFXbMfOUdFiJfRFzpUbKvrwxn3wNtQrbyyOBttR
         oHXMBgEWd/6TPHIdwHgvyXWgPeK77bnlYaGOHX7ab8NIsymbs3e4Ow2HdiyHZmw5GmLM
         GOYSXxFagam5ZnhvASle5ZkuYsjN41WAdFt5nbpkBGVhMzQ4wQAaUbkMGI0lBUjYCIpA
         V97dnPRY38e/BLdbmTIoU/JabHaeiqNr6yTuiMZVgnWvsBVHZx4a2CMG8zpYRibM+952
         6gpA==
X-Forwarded-Encrypted: i=1; AJvYcCUh4p4b+lC+qzc5jZuBF2a/bV7N0QAY8dwygvbTSF/G6fbPxu5v7aaou75cI9vVwvBXTwNJkKzOEhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQxYrOehzGN9of6M6omJc65rgFXyPx9SGFRgcdnI6/aNQZ1Mq
	IWXPtXj4Cu/K9jPFxtMYYyVufuTnJ7mzpt6ZHy8F2LHJ93DLa3v8dAXM8GDnYfbj8vJdAGbUEgs
	sb7DporMcK8Y6J9ygODwBbAu7jG8jC7aV818Aud678A==
X-Gm-Gg: ASbGncuqpABG/MC+gl2L/HUoAg5hkUmjb+3mEyrgZ78Kz62TaUMVkJMJX01kqxkVJYz
	MpAFLwkFAUutjoBBOcCm4tcejc0GacpgSjrNoYorgmEoFqMAlFSBeGPNvjEmFEvT3lv+Wxy6lu8
	zQ1+8YXR8v6naLKHKcDKDddGum+vKyEhC/tcNJmmCoIeSBgFF3mOl2km5+IsAjHaRg4jbncAo4M
	QQfDsUFNm44+8IWt90jze59l/tQ4rdU/2GnZ/mg5r7q/e0LHXhgZm+6y63vTx8=
X-Google-Smtp-Source: AGHT+IEawILhQN5Tlcl9p5Mjqx/+g8BzI0MIHHSa+12Xe6GG4A6vAQ2TFwAqsdfR65LWs2suCvY9l7MTmjpZSBMVUHs=
X-Received: by 2002:a2e:bc0b:0:b0:372:9bf0:aec9 with SMTP id
 38308e7fff4ca-373a70e9ceemr10229771fa.8.1759326797528; Wed, 01 Oct 2025
 06:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com> <20251001091006.4003841-6-viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20251001091006.4003841-6-viken.dadhaniya@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 1 Oct 2025 15:52:56 +0200
X-Gm-Features: AS18NWAmCgokIXZ1UkEVryOtNua26Mh7SEmTh-56Mvq0WRalU4tAqLsD_FATkks
Message-ID: <CAMRc=MfMO-+SSrTY-XQLtsDnxpj_E3TdTJ43ZxCUi-iDrvnc2w@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] can: mcp251xfd: add gpio functionality
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com, 
	mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:10=E2=80=AFAM Viken Dadhaniya
<viken.dadhaniya@oss.qualcomm.com> wrote:
> +
> +       if (!device_property_present(&priv->spi->dev, "gpio-controller"))
> +               return 0;
> +

Hi! I didn't notice this before you're returning 0 here, meaning the
device will be attached to the driver even though it doesn't do
anything. It would make more sense to return -ENODEV.

Bart

