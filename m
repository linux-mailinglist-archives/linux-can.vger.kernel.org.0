Return-Path: <linux-can+bounces-1643-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509E99B964
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC653B212BC
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A5140E34;
	Sun, 13 Oct 2024 12:32:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED3D2FB;
	Sun, 13 Oct 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728822773; cv=none; b=jGN52eNnKfdjruwZeNYOSmgB6CczeojCtEKsPOPec8VER6Mli4hSIfmFND38HvUX3oRPHnMAmmlY3gzHSNjKq1YTk1k+XdZKntTkoADHlgLnF+rx+y4tCRmbSSYt8moal84bb7zT2tWHe7A6Jifo4NML30l3rJ8okBmJJo1yQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728822773; c=relaxed/simple;
	bh=ARfThhotVaHMUQhQBiE1tCpMvsmySbMl5/P8aQPFNDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BipN0egRbXVd/Lq9rfIt+qF5oKj/04LmAs+dgJLFsjfdOrJbJ4EwxW9WRpv7XpWgUDcHIdo9uwGxgcsffXOqEp/1gOmpoo55awN5L8hamlHxy6PlhwT/BqwIlAeps8GHAfmtszJJGaMLZg4JikiM/xAJ8+5CTJ3tPVWaosDeFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso3527166b.1;
        Sun, 13 Oct 2024 05:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728822770; x=1729427570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARfThhotVaHMUQhQBiE1tCpMvsmySbMl5/P8aQPFNDs=;
        b=UM7KPo3AwN/+8xqruSfFCY4iUCO7Rj64AvuEbTqVGJP9KAnCRnoCRmHuwi9dvXnCGf
         ZdmRIWBLp2jDJM7E9iE3Mz+nsOm7yXI7C4311lfNiCP0LBF2N4yMTtq8DupO6b2xXAs6
         0dOq4COY/FpczMNS0m+nveY7lpOJCtP/yjgYJs8P/cVhyVUjiHsyoZlgvuQt1z9pU1vK
         0bccIQAmP0h5AOBUYtGI06f8SsD/PwAcPxpnCjFz/6YdbCM30pc5BlNUpq9z58/d+T7D
         anRqkWPGul5o9qBEy8cdkGE9UQN/mIU9doyvn9pJnwgyZtib4WBl2EjERKWe9fRVtJRs
         LKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxW/ZChrw2iAnGZcoDTmglr7z6Kx2epaiKbLX1TRor7mGJGUzIETjXc7JSPTicFVdL/8F68cVetRMG@vger.kernel.org, AJvYcCWvrgDD9EC9sJh0VFI/7FnxM5Iw9abwD8eMvHk271wae7msDbwkji4i8gzdiet+YKQs47rHpqelX2k4@vger.kernel.org, AJvYcCX4Yb33ZTrfmR7oOkGdIXPOwH3D6v7F48bCHeM2kwzNpwgAb7ApHNLMQqrfUh9s6Wa1/sAo3aKA@vger.kernel.org, AJvYcCX5mdheqNf/V8N/w+KHXL3rLhGC8Pun+xox5Ly9fmNxa/4FgOtRgSKON/2bSYFMXESDkPocrebQcVgdKEXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyOD6IK80Gn3clEZqpotpf/7HcFaiydckvXgJVixbChysiWZ2Ik
	X+Wv1gZ+xqCmo0Oi5fHelBnHr675H3Ve3zXQPGc9KXZicz356II/L8/fM1CN8hCfb/4vvcFDtgt
	5MCCpq162TXsQ/kVkIjywmP4VSq8=
X-Google-Smtp-Source: AGHT+IH11eiOSQMRI1e2DEwTP6fVuT2nwzcMTDFKk0J3FRYbrVJMWDPbLPH800VJr46cq+Ri1n+8mYrdImvjj4tIVOQ=
X-Received: by 2002:a17:907:3e23:b0:a99:43e1:21ad with SMTP id
 a640c23a62f3a-a99b9585822mr795316666b.45.1728822769721; Sun, 13 Oct 2024
 05:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-4-9752c714ad12@baylibre.com>
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-4-9752c714ad12@baylibre.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 13 Oct 2024 21:32:38 +0900
Message-ID: <CAMZ6RqJHhZjdRyBC-gR+HpDGOkT_9s++d1_yYToDZXaAUfaNmg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] can: m_can: Return ERR_PTR on error in allocation
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

Thanks for the patch.

On Fri. 11 Oct. 2024 at 22:19, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
> We have more detailed error values available, return them in the core
> driver and the calling drivers to return proper errors to callers.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

