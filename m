Return-Path: <linux-can+bounces-6163-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C8D23C98
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 11:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7CA13001FE6
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF8356A37;
	Thu, 15 Jan 2026 10:03:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4633CEB5
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471426; cv=none; b=jYVUZnw0lXFfttS6lojunVcBv47RRF2WzqNPDN/dd3Gtfjavg/BI8SUa/DNwFv9OuDIgtDoL+egTRzqsflra+zsfLo0MRxannTHNWZmVWwjKzcnn+grlVJRT2gdlEJSUMpyp/vUFX6KZuaZ5JQoGDtla7tCAF5CuF5GUflON2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471426; c=relaxed/simple;
	bh=RE+BJgoRw2g5IS+v92/qs5tkLXWM/g8t4jE9iLZlX58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fszOVj/K29UlESxgVvKVTLmj49c+FX5X9eYyUKtwQ9awHZPYgwqcT0qtoZOjNUws6wgbinUlrP1houVKbG28JsDW0Cn1C02aF0XPnyqYGyRogFQK6EWgpgp+umUF4mu1c30u042AV/9SmVQm4gVCDDaN1LDmqLpPU9PmtqyY3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f542917eeso257064241.2
        for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 02:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768471422; x=1769076222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgC0QjrYtZFKzuf+BESjeNcO1FE23KHL3L5ezRaJhpA=;
        b=pE7ejtRh8gwMNnhwdDiFsmnzSCcQ5OYX1x0PJbcm7Ovrk0Kf3JUyX07NI9ZxE/OSd+
         XkgglLsvqDuVWIJs95FOWIVytqgGp3E47jL1G9kluXnwF8yM4IfrQs6fB+X1WeibN7qo
         JGc/S+sBq5BHbHgi/0/hm0hwCMpS3Q5U7wNKNTj7nsSw3gY9uMQQ8Oam6nRQ78f/rXep
         xGBqLkHkB7SYImtVMd/nRDWH+k/ufKrBaentgoQSCQG9tyelWHZwOC6Y6VHXBE3fUduS
         2KNOtGFupWNL8LiLYuVRoWLzBt7O33d8Z309iUEScoCf7Q/nQOL2BziJNEZu9IbCE3m0
         z7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVKMiM9BU5IDs7yXIDEvCKNXpqFyzNqTANIr15KK5Rqpxl1sBbZWJ3tgqVwztoGMRZnCii1SuMXgK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzGpaulJ0onkXzLMJRIPvlzy/HEjRMlsVSBJf1qf5j1lTVQvq
	TrQWEFz7rRDxlawbboVTliOREtmy0/5O7M67MB5P5SoySnawTykiCcaSjyzdhhYm
X-Gm-Gg: AY/fxX74eiEPHD+JPt+pk885UOyqpOwQ+p0Aug34qz1nEDz+tfUCdqh3O9rg/GWwZ5X
	TKqfGww4wfh1w0DkDsMitah6s+7xkHkqme2CZ0VxZtezw1Zs9fR2Tg7nl1jcJYc6lFp4s9956JI
	Yu11MJXw5PyHuauHnU1sMkYFweDCWWTGPc7qsoU2EQNhhp3kFNysMQiA0cMBaHmEl8sQ0ap0cdY
	iE+4srwCYS7lpP1heR6LQ26/ZXymSnFypx1Ifr3LL5c7TzJjrwUprMgCE/pHgekEGA5GqUcIkwI
	76zAUdxHobtlGYD8TH/nF0AZUqPxlHmHgbPvH4IRK/zRIp8dOSwp9boui53FvE2MaAq8xlxJZig
	VjffjY6S17n+AiAEeS45o6Wul0k6KXRSRh1f517/lZHKR/1Xi1KfWTn4D66H0wq8IxIEkW2ygYj
	HU9KF07M2ZXjCGfwnm1N8JJO5IWDj6gbyRt7kQ7iIbx0cWSkkMnhJne8VW/vk=
X-Received: by 2002:a05:6102:e0e:b0:5db:cc69:739c with SMTP id ada2fe7eead31-5f17f48c133mr2451507137.17.1768471421558;
        Thu, 15 Jan 2026 02:03:41 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ee9fe7f478sm20965460137.3.2026.01.15.02.03.38
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 02:03:39 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-93f6bd3a8f4so244340241.3
        for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 02:03:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVU+2niIzMyCwrbOUj3vHxqjFO6LxB57nQnn70Vug4SrmY5Sz3Lqbl1KGX98MokDvq5MK4toZ6GYF0=@vger.kernel.org
X-Received: by 2002:a05:6102:3913:b0:5db:e6bf:c4d7 with SMTP id
 ada2fe7eead31-5f17f5c0ffbmr2421625137.21.1768471418298; Thu, 15 Jan 2026
 02:03:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114154525.3169992-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260114154525.3169992-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260114154525.3169992-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2026 11:03:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjYLQJDdqi_hShbOzeCQ6vcC0KCox4GqYTuGpDpF_FWw@mail.gmail.com>
X-Gm-Features: AZwV_QitLLKMPfpHq9dKw_djeiwJFqwAAQTIpORIKL7aOAuxz5cFYxB71KZhGwc
Message-ID: <CAMuHMdVjYLQJDdqi_hShbOzeCQ6vcC0KCox4GqYTuGpDpF_FWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 16:45, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Specify the expected reset-names for the Renesas CAN-FD controller on
> RZ/G2L and RZ/G3E SoCs.
>
> The reset names rstp_n and rstc_n are defined in the SoC hardware manual
> and are already used by the driver since commit 76e9353a80e9 ("can:
> rcar_canfd: Add support for RZ/G2L family"). The reset-names property
> existed previously but was dropped by commit 466c8ef7b66b ("dt-bindings:
> can: renesas,rcar-canfd: Simplify the conditional schema").
>
> Restore and constrain reset-names in the binding so DT schema checks
> match the actual hardware requirements and driver expectations.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

