Return-Path: <linux-can+bounces-2836-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C58A39A58
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 12:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76687A48AE
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B2241105;
	Tue, 18 Feb 2025 11:15:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4123C8AA;
	Tue, 18 Feb 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877332; cv=none; b=esUf5SiUt3gvaDt4mAU9aHKL8mqX/NEzLDTvtfWXHzRro2w6d83siVFcENQ/3Ndtui0pAAJhFr5L7a0SBX5DFGKcZF3jq/DZI6Pe9Yu86iuDj4boKGI/qNWyfm/3WhbDvubf3WmsLmhFJnlj0sP2p2UtHBDx0EStreCMfUpWEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877332; c=relaxed/simple;
	bh=tDhzPakJ5XMfCG46Ztb4sSp6+H81MO0bxXrBQiJmges=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWTugjYddXwYoSKSe7J/jRJHE/ioEcY1G8XIOOr9bQy0Q96kghUwjJ0pw3OC6FtSu7WEXk23C2ODvpYd2a7MKjkUfcNdSr12+uqIIkGk5gvr++k/4gsn4QlgtTBSmHvPpBbgzIvZ9YUwQKhMy5ZnI3AqgnHoij3da3ybGDQf7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86712bc0508so1672085241.2;
        Tue, 18 Feb 2025 03:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739877327; x=1740482127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDx7VS3L0njwqbhFxMTC4VAHmC+fcqcjdgOzLKHDmHY=;
        b=P7Xp7rWo14OPt1fgz/toLnextPQLsOsymP31SCEa4djcJM93SqT/naXVQbjmHWyWVv
         XREQFX6b/GW1K2ihLGIZSVtiKEolVuoqyEmCCCHoR9ByYnESaQDr68D+3hkHuacWfvRO
         MjqsFgGon5cN7R0ACzcssM00HywxCxNFJRqFyw6PEf7a+8bZ/0Szyc1hGtZzbGthlZXX
         YfuyRFPkw/zS6Ag8uL69Pezllv0B6uUonbsh0yxFbKsOAteXAc++Obe+ydXsSKtnHkSq
         2YLH6ZYuvdJvHzkPX42hMOiYvRj3OEIXbfcU6Hic9ToYruqvA0ZDL+s1FiVPE8yYBoSR
         LW8A==
X-Forwarded-Encrypted: i=1; AJvYcCVMAZCZlec03KxLtI7DcST3In8pKveml0BCttbhuPnSu/6emil5xxDGY1leigOlu2xSxPIWw1lUh0BpRhLrdERqnS4=@vger.kernel.org, AJvYcCWjYB6YmRgyzAhMudcOHYbJlkUfOaZG1t7ALDBFRGf3GJvmvNEjSaGgM8AfaMgZc+Py1L2tDF+i1xA3@vger.kernel.org, AJvYcCXJdVM23XCdDZ247zHWPld9EB0zhSeIqNwkxSv5edZi41gOcraRSq4yITo3tovWdLentOw8Uta520h5@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZOR0VlDhGlK1VCGWEkQAYOZV3p/Fg+wy+OFoutKKuYo6peK7
	joGWTwhy3RAstS8wt4IaAlomPulnlOEN+2ydAb8UCd4xFAb13yHqh5jNO9XDygE=
X-Gm-Gg: ASbGnctlqiTsl3UnHfih42khfETjZ7fK1eWVdCwDaDrb/9Ss3gTPSFevfsYFUcaHhox
	XdaeZFfrk2wHVXkd+1egdHobaH7nry3sMqN3keiebCJMhdmaJA/FKDFakTNXi4t2Tpazx6EjF9I
	4iifxpQOsKgPu5IFMR3egUu4Y+h8eVhfm5AM3cv9CyfZ8jlrXpQlgxScowqTaIRpNhHrG7aY27p
	7an5ZLx8wEaSVS4Jhl8LEzZxhBsYmBBytN3c5Bgj7pr7O3puPXD+PljDeFHs9a7Rawtmc9dIuzR
	xdeOIDaS8SpQCxeU4McVAYkY+2mPCdA8tBB81c+IwmCOx0bBitBEew==
X-Google-Smtp-Source: AGHT+IHSCvJ79vkN9MAc4uBVUpxJ5xYtB0YSKp2tw49BmSfxs/PZR2CmbPblPbf9r4iOw094bTSRpg==
X-Received: by 2002:a05:6102:f0c:b0:4b6:15fa:566a with SMTP id ada2fe7eead31-4bd3fbcc3d3mr7096206137.2.1739877326975;
        Tue, 18 Feb 2025 03:15:26 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bda662615dsm1500006137.11.2025.02.18.03.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 03:15:26 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4be707ffebeso327520137.2;
        Tue, 18 Feb 2025 03:15:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5ofIGkxazCpllHQ3U9WpPd3Hr6SHf8zKIBShcls5MM9Wq7dYLAgA/6r0fp/etku5mNlqclrQIMRJ5@vger.kernel.org, AJvYcCXOKTeRASTShg6ywFaLyLFf4ZOVLA4DUlRcgvux2ttBsILZWchF10kQYCVfyapOZR8fayZ6S8v1nj/k@vger.kernel.org, AJvYcCXzcbD17Ho/txO9tNgax0lKsrvq3PJzl9NZ5HbUafSIw2VD5gFsllzDE0lAbQ6E+FZzSyFydUnCx3Xy7bJZ7TvBzHg=@vger.kernel.org
X-Received: by 2002:a05:6102:509f:b0:4bc:18aa:51b1 with SMTP id
 ada2fe7eead31-4bd3fd51f63mr5967548137.21.1739877326073; Tue, 18 Feb 2025
 03:15:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com> <20250218105007.66358-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250218105007.66358-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 12:15:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9KOKc8iHh1WppnxhcW+-PkNC=9JP7E4+-X8Ls0GvF0Q@mail.gmail.com>
X-Gm-Features: AWEUYZlsMzm74aTFSixczw1n_AGyLj3mqcqDABHMYvcwmH3WFZ2pm9QwUhy1HhY
Message-ID: <CAMuHMdX9KOKc8iHh1WppnxhcW+-PkNC=9JP7E4+-X8Ls0GvF0Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] dt-bindings: can: renesas,rcar-canfd: Fix typo in
 pattern properties for R-Car V4M
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Simon Horman <horms@kernel.org>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 11:50, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The Renesas R-Car V4M(R8A779H0) SoC, supports up to four channels.
> Fix the typo 5->4 in pattern properties.
>
> Fixes: ced52c6ed257 ("dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

