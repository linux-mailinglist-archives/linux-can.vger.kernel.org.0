Return-Path: <linux-can+bounces-3572-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14293AB663C
	for <lists+linux-can@lfdr.de>; Wed, 14 May 2025 10:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0F13AA746
	for <lists+linux-can@lfdr.de>; Wed, 14 May 2025 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6720C031;
	Wed, 14 May 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LuLlMCJ9"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-74.smtpout.orange.fr [193.252.22.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396F21B9E0
	for <linux-can@vger.kernel.org>; Wed, 14 May 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212075; cv=none; b=QwX7roPddunt5A604NcRJ5gNMqWs9irxa/0AufrO0/XW++1BaRtg5zs6DJC7IpNsDDNom37BoQLTkUZQOowqZyUsD5n5KwysSS0h1DXBJjymzbYj40mUiQWMtunKXs0zBkoaxxGf4GmKKjDmEyl1cpV53Ptn2xU/Aw+ooLv0r3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212075; c=relaxed/simple;
	bh=eNXjyaptsHRsPQ84Tvwyb1/XUJRI6zKXHTGnUn2Bbh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDs125WWYtpP2Xg7y92AltgTK1IIwYqbYetsUWiwq6sZ6fyhFpqSnw7NNhc2vVS9eiE+6kG0JcldwF+n1IZ4VnQGfj3agvYZKS6tfCij94+wROovN4FPhJiLUTv5cLwKjJ1OF28GMe4UgUSa4/u+FhJaE8cZ7ZmkhyiLnImaDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LuLlMCJ9; arc=none smtp.client-ip=193.252.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by smtp.orange.fr with ESMTPA
	id F7eiuLf6aRkjxF7eiumfGt; Wed, 14 May 2025 10:40:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747212000;
	bh=kPmxeUh4eufXhCjRbYn18T2LZ1zNyKbh+49enrkA9Bg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=LuLlMCJ9Kq1zOXhENcm7nnl4kyZCad60YUc2+XJIxgyXJ2D0SHvAdYvxaTqXduUvg
	 M4fE6iMk09JOjNoBw4Sy717HA4Mo5nWVgSwMZGHaSObtdtm225SdWhJNYP4ageJez2
	 vVAs7+WQN8NSi81R91iJgH229kJkVaftL+tOA23ou8Oz8F2XHvaQrFYHOZAj8cS2EN
	 5WsGOmHmSo3XyXt1a7pRb8Hgllt0khhwO2vNp90O8F5GPzFr5qYVNBMM4/vtPA7HiR
	 vxsfHopN5UecVznJi4nZeurmT4uDFq0nvVC9s5XZ1JTqiuOGtu4vfhAFKJfnM2ovkS
	 DmpH4xzC2y5Uw==
X-ME-Helo: mail-ej1-f50.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 May 2025 10:40:00 +0200
X-ME-IP: 209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad243cdbe98so645497766b.0
        for <linux-can@vger.kernel.org>; Wed, 14 May 2025 01:40:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUZ5Mxog8+FJ2UV3cw6LBBAqRrtif5XdzZvZtP0eEgsLXRsdE4xXSHTHYaM8pHlX6NVkzs9bz+bns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlN6Ti4a2NdZXQ2N4DZdc1f3tbBHotHbhIz1Y2mzjc5nXSlGrT
	mBtk4LkphhSVgLC7N3CGDQ7GciZ5AYeoTTwj1+IMJiKtM00jMJAgmE5U4Pz1eWSHS21NSfZjx3V
	S0vgJVt4anjHktGK3qtjvnXYkWz8=
X-Google-Smtp-Source: AGHT+IGHb0uYAYAJivR4T77aJM52F88NJUVCImP0tMI7JeJh5UEMkiXX2gtVXZOfj/Pzc9GQMODs3i5jO7ZP/UO6WEY=
X-Received: by 2002:a17:907:6a17:b0:ad2:4fb8:c0ab with SMTP id
 a640c23a62f3a-ad4f71e99cdmr202213966b.31.1747212000163; Wed, 14 May 2025
 01:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514081707.1059116-1-carlossanchez@geotab.com>
In-Reply-To: <20250514081707.1059116-1-carlossanchez@geotab.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Wed, 14 May 2025 17:39:47 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKnt9QySegZqJzECtCFURKXS9F9SCxRQDpQuuhADYUu3g@mail.gmail.com>
X-Gm-Features: AX0GCFs6ulE6ZNL-XiTtqvZ85DmfWgWqaiFZb4IY9QofUkD1Kwjs-uXfixof1i8
Message-ID: <CAMZ6RqKnt9QySegZqJzECtCFURKXS9F9SCxRQDpQuuhADYUu3g@mail.gmail.com>
Subject: Re: [PATCH] can: slcan: allow reception of short error messages
To: Carlos Sanchez <carlossanchez@geotab.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Carlos,

Thanks for your patch.

On Wed. 14 May 2025 at 17:18, Carlos Sanchez <carlossanchez@geotab.com> wrote:
> Allows slcan to receive short messages (typically errors) from the serial
> interface.
>
> Signed-off-by: Carlos Sanchez <carlossanchez@geotab.com>

Can you add a fix tag?

Fixes: b32ff4668544 ("can: slcan: extend the protocol with error info")

It will help people to backport it.

> ---
  ^^^

Anything below the --- cutter will be discarded when picking up the patch.

You wrote a great description, so better to put it before the --
cutter so that it remains in the git log.

> When error support was added to slcan protocol in
> b32ff4668544e1333b694fcc7812b2d7397b4d6a ("can: slcan: extend the protocol
> with error info") the minimum valid message size changed from 5 (minimum
> standard can frame tIII0) to 3 ("e1a" is a valid protocol message, it is
> one of the examples given in the comments for slcan_bump_err() ), but the
> check for minimum message length prodicating all decoding was not adjusted.
> This makes short error messages discarded and error frames not being
> generated.
>
> This patch changes the minimum length to the new minimum (3 characters,
> excluding terminator, is now a valid message).
>
>  drivers/net/can/slcan/slcan-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> index 24c6622d36bd..d889f6a43e29 100644
> --- a/drivers/net/can/slcan/slcan-core.c
> +++ b/drivers/net/can/slcan/slcan-core.c
> @@ -457,7 +457,7 @@ static void slcan_unesc(struct slcan *sl, unsigned char s)
>  {
>         if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
>                 if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
> -                   sl->rcount > 4)
> +                   sl->rcount >= 3)
>                         slcan_bump(sl);
>
>                 sl->rcount = 0;
> --
> 2.49.0
>
>

