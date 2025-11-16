Return-Path: <linux-can+bounces-5448-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0601C61867
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 17:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C0C70290B3
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEB530DD21;
	Sun, 16 Nov 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aknmoqcs"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894A30C63E
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763310043; cv=none; b=jtotqeRjODP/vb27f+OVMpXFVbygStXFOVFIiwG+LCqy9yowJmQYgwHUO0OgntQtx0J5EjhGfgz7D5gJdRynrmap4OS9u2+nEV222SDy0FI6gcc/JBEBdWET52lTorcDIY3x8I3WwI0khVx84uRSmkXW0iKsfVBVkKFLwOQ0x3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763310043; c=relaxed/simple;
	bh=IcWG0c7Ap4vHQVKjcGsS3wLPIyj8+cOECPrxfy8qqX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJZOX5rrz29N4pVWJNp+aAZ2KcjRhvjyGHnd5dgI4CQNT4jmrUORFlVN8nTSTe0c4Mlm5OguiIzX2NBCn/ylk8XY8GRNwQQ9jeTA76RlkpN22aaftPkafTJUV6KdsRonutKhnQFvJn8TmfDPmXUAdMVg4aTMAW8X1O03VYwVbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aknmoqcs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b739ef3f739so28250466b.1
        for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763310039; x=1763914839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcWG0c7Ap4vHQVKjcGsS3wLPIyj8+cOECPrxfy8qqX8=;
        b=aknmoqcsJdOe5Kp9laS8fEBxGyp/YzrI9hVWDh+RQ0fJnC32dYSnW20Ed4aUm3EeCH
         ZJB7+FIt2yYtyNoPQ64z4+VpNe3U9wP0Jyfw6xEVKUjPtIv/6xknlpdZG3P7ZAK9f9mu
         cFheUJRrUeJh/86ZI0eGZfXL/wuDRJxEJ6KhMDgMAZo0m5VbqqzIhqJ8Y0hXndkNxqdV
         IG/ir4YRJwZYQzXmz1eDooCV6gAMmw9Q3ZMUKme0ToU8rHjcO2Z/BbmUywkN+Ficesk7
         UXnQxPdD9sAl5OpCGibBNdCNj5Lde0PBTv1EIOHzmHMqgkHJvPocDg9tjI7FVjfJ3xGH
         NMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763310039; x=1763914839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IcWG0c7Ap4vHQVKjcGsS3wLPIyj8+cOECPrxfy8qqX8=;
        b=C5a7SD8lLnZtra0D8jxn+4qePoD4ghHT/wTtLRCY/3TuQLIBPXgz0nfvDf0aDzeXtK
         juytTv3iiFS1uU8ugaa49FEzZbCeFfmQeSkxMO4uIXZFZKeprM6fwp4eanY/d5ZQ6gCN
         GlUszc4tWyAJHfbjy+reGdPhK9oZgXEpiAyegb6P2OmqxBP8GO4BtjvhzklELWC3hMlk
         JUUdHj52cvsNDREB6dUYygiZhOXmSTks/kvhw75O2pgZVMHWE4cl+3cBHvhoH8mBXy5v
         j0paw0FyAZcNwJJ49zf8bmmymTMDatf7ZgwBW/wllIaILjHRjH8GToL2GoPBqcyc81EG
         Zq4A==
X-Forwarded-Encrypted: i=1; AJvYcCVr9Iaf+U1mBl9EihWT/t16JRT5xIVyoqQ3pQ2f7wkAblUWGWcu0z+PL0MyX8UUr7lVLS//ORsLCsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqS24DjEEW8fqxOTap/2ZkE5QxVBvlTZQP2lcAAtNzCWMeKLQS
	Zg67A0lA+yjPvVm1yffhpQ2nVREAv08nXJIy5rzlf4Tws/V+zpm01p4/
X-Gm-Gg: ASbGncu1X2z9jH7hdiSlYpa9J74ytph5Zl+EFPkEG614XuBi+/ZNFWb9L3UsuzsT++Z
	8djzzKI98vgXBnNgEEV8nBUEY2/urR/V3f84qLm7yGAh1/AERG4hy5N5VdDKhl58jMrpsFmvtgr
	VMShHqERS3KoIJSC4BBYZ2rWvWak0AgeK6l+bb2S24Fs4JkUHYt6BAaUrZFo/EFZo8/mLXRab3+
	zAUPT2UawmcqS23cuGDNhjMKoPjg8987Kk2JtQdCM9yNeTUoTtuTQbWDwqWLJdwibEHTzJ4NyF/
	Ill6+18D0pI+182JyibuL2pyCMvtYX0IOUSqZ2tDZfsDXUQOsIcdETmYPqOq2u5XFJFkr3RtTST
	T6YDNTrvj2QMm1broqzVvGzWLPHQJCEucQaSL39Sjeu++XG3ZcSGDxloxHzAaaBe9g6LSKL8dUB
	ame9yo4SSwTqQODjAd2K2paSLyREv58/watSyZDIP+kAh87X4Cr/cblZfDNCw4sHL5em7mHP0aA
	78Vdw==
X-Google-Smtp-Source: AGHT+IGimZSxkgoIOpfCKAWCHgTmcdkmEWm6/VMebPbmR8mxODGAMWNDh5ErsjYw3DRmDL/5wQcxSw==
X-Received: by 2002:a17:907:1c81:b0:b71:2145:dfc8 with SMTP id a640c23a62f3a-b7367962422mr1083057166b.39.1763310038731;
        Sun, 16 Nov 2025 08:20:38 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdae69fsm852257866b.51.2025.11.16.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 08:20:38 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
 Maxime Ripard <mripard@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Thomas =?UTF-8?B?TcO8aGxiYWNoZXI=?= <tmuehlbacher@posteo.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Subject:
 Re: [PATCH can] can: sun4i_can: sun4i_can_interrupt(): fix max irq loop
 handling
Date: Sun, 16 Nov 2025 17:20:37 +0100
Message-ID: <2804881.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de>
References: <20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 16. november 2025 ob 16:55:26 Srednjeevropski standardni =C4=
=8Das je Marc Kleine-Budde napisal(a):
> Reading the interrupt register `SUN4I_REG_INT_ADDR` causes all of its bits
> to be reset. If we ever reach the condition of handling more than
> `SUN4I_CAN_MAX_IRQ` IRQs, we will have read the register and reset all its
> bits but without actually handling the interrupt inside of the loop body.
>=20
> This may, among other issues, cause us to never `netif_wake_queue()` again
> after a transmission interrupt.
>=20
> Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Ker=
nel module")
> Cc: stable@vger.kernel.org
> Co-developed-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> Signed-off-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> I've ported the fix from the sja1000 driver to the sun4i_can, which based
> on the sja1000 driver.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



