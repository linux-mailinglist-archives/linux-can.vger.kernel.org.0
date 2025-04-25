Return-Path: <linux-can+bounces-3483-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5CA9BFB4
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 09:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD037A7468
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 07:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D31FCCEB;
	Fri, 25 Apr 2025 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="f9nflK8v"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3AC34CF5;
	Fri, 25 Apr 2025 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566046; cv=none; b=T3YT6wDITW1hPplql0ye8DBdy0N8x+WZWI8t7SEW0FKUOWlhSgqt07+xStSVIyXiwij0ObwV820arKK0mAAvTUSy7tfkunBezJsE4xPcx4xCDK9tb9gTgT3dfWSKGxCsdUeZYcmHsO0Mobc2A3y2xofgu/7NonU1JPbcVx58SFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566046; c=relaxed/simple;
	bh=Se6m6y9sZN9J3EHuJl9Vxwvd6h6QBpXAImKVKhBleeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoIQCMDMOzQc/KLf2Nlf8uA/nC9VW63Jp3D5Px3Oa8jkN8fELlTGIq9Vg68HdZzuhykLbyzCEUkJclFs5wcIlTYDy0v8qlierKzmbMZGLE3pv++u0bEBAFOKzyFFDyJFm0UnAm+7ex6Xnkmyq1/4HbkOHudx/OzZBrph2T1BjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=f9nflK8v; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by smtp.orange.fr with ESMTPSA
	id 8DKLuQzncXKsE8DKOuD0HC; Fri, 25 Apr 2025 09:18:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745565509;
	bh=9MXYhfLDZ8sZbT5kwKmQD0pmgRml2HdigMCY0fKRBow=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=f9nflK8vOGeLNHBUFgEJhoLnthzXyfcR8scN2J/LiE5oXLRQfHt9HzouptysiS9Di
	 g2KrGk7KOX9GsAinJdfxH2ujQw+tqV4c6au/TKojKMsiHB/s/AOwO5mpfzUolMbNTV
	 tRbbCBOjxqYbhYjKmfn7CWPWZI5eEqvtaGc2EI9O5iiAJs95lRSg7+/mC3WZCJFu0f
	 dYN2C3J/1OMIOhi6mBW9ojH6vVyth7iNBglWOkb7U/BGxe731uq+rp7PJaG80R6Rsv
	 Ij9v12Yr66GJpsXFrLJYErm/3fs0ugUJxmBKVgSgl3mYJEzT8DaLNovc2JF4vvngqP
	 HKWx4GZJioXgA==
X-ME-Helo: mail-ej1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Apr 2025 09:18:29 +0200
X-ME-IP: 209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso351057066b.0;
        Fri, 25 Apr 2025 00:18:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVObnGUjIlQmPkRgRof0bSmwIiUFdL/JAmKL9Tyuinc4j/90MFH/g0jS//yaqZ3lYzkbisBWOLb7Hk=@vger.kernel.org, AJvYcCWnwFKPqz3DoRtT3ixgMshKJEtvSVlOSh7Fj3X6jq8eS1bICyUYRcEc2E81uS2ATa2IlfpnEkN6hNmS1QJu@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYfw/kITE/imp+QgScvOlKgC9sFq5RsozXo4NZG2LFIZDTeMt
	SIjlRTUPFX9POuU91zlTsaJA9LINIEUCRdNR3dRBjgBEU7+Xyxdfh8Shrp8AoNgpzKuU/ez3mvS
	nYV2MYI+wY/epCM7PXdZ8ybZ/kTc=
X-Google-Smtp-Source: AGHT+IGrec0S8ejf3QeHROL33sZQ5R1s3Y99LeRod6Z2yTrMqhM0sZC+BJ1CYHCgmoPuDFbs5EHVnuxhZnpbrA+1h4U=
X-Received: by 2002:a17:907:1c92:b0:ac2:dc00:b34d with SMTP id
 a640c23a62f3a-ace73b469f0mr84570466b.53.1745565505472; Fri, 25 Apr 2025
 00:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424125219.47345-2-antonios@mwa.re> <20250424-industrious-rottweiler-of-attack-e7ef77-mkl@pengutronix.de>
 <a5684bfe-981e-4ba3-bbea-d713b5b83160@wanadoo.fr> <2fe59c0c7e0f7b9369976501790fce5beaea5bc7.camel@mwa.re>
In-Reply-To: <2fe59c0c7e0f7b9369976501790fce5beaea5bc7.camel@mwa.re>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 25 Apr 2025 16:18:14 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+QVHAh8HvWcn8rAYGE8VoJmhQUxOFNqBpijSQz10Dodg@mail.gmail.com>
X-Gm-Features: ATxdqUEIr0eIXQ8_SCkkchVgXe4gjbCfeg1hy5EZFXU1ZytGNyoezpTiOmcsor4
Message-ID: <CAMZ6Rq+QVHAh8HvWcn8rAYGE8VoJmhQUxOFNqBpijSQz10Dodg@mail.gmail.com>
Subject: Re: [PATCH] can: m_can: initialize spin lock on device probe
To: Antonios Salios <antonios@mwa.re>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, rcsekar@samsung.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@mwa.re, jan@mwa.re, 
	Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

On Fry. 25 Apr. 2025 at 15:34, Antonios Salios <antonios@mwa.re> wrote:
> On Fri, 2025-04-25 at 00:23 +0900, Vincent Mailhol wrote:
> > Maybe you can briefly describe what kind of bug (NULL pointer
> > dereference).
>
> It's a spinlock bad magic bug that occurs when one tries to send a CAN
> frame using cansend. The frame gets transferred nonetheless.
> I'm testing the driver in an virtual RISC-V 64-bit environment with a
> recent mainline kernel. The M_CAN controller is io-mapped to the
> system.

I guess this is because your kernel has CONFIG_DEBUG_SPINLOCK:

  https://elixir.bootlin.com/linux/v6.14.3/source/lib/Kconfig.debug#L1437

Without it, this would have been a more severe NULL pointer dereference.

> > Also, if you have the dmesg log of the error, this is something you
> > can add at
> > the end of the patch description.
>
> Will do, I'm just waiting for more feedback on the patch before sending
> a v3. In the meantime, the dmesg log looks like this:

Great!

My comments on the patch description are just nitpicks anyway. You can add my:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

to the v3.

Thanks a lot!


Yours sincerely,
Vincent Mailhol

