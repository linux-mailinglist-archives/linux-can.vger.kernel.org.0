Return-Path: <linux-can+bounces-2315-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC89E189E
	for <lists+linux-can@lfdr.de>; Tue,  3 Dec 2024 10:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B08B60852
	for <lists+linux-can@lfdr.de>; Tue,  3 Dec 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B91DF275;
	Tue,  3 Dec 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WgC0sSIW"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBD364AE
	for <linux-can@vger.kernel.org>; Tue,  3 Dec 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219244; cv=none; b=pWOhXwxMQ1U7Xip/kR1pI91gSwY153ukex30/YeIspVpe81NzjJk2hSVSZDEndCW96TkGWENs/QgRn/RC1zcmdI6i38bUCT0g05tQb4SkHZ7bvM25bG0DjKgpjwCsUWMcOzD3hAmhXsQcwvAea2kwlTc8YBqLgGbkXiPwfLlfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219244; c=relaxed/simple;
	bh=jm+E1GpF/RUhgrOP012stRANKX0TWnwEv6XmT7fpEe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEz6Rpv+YFRAHpqzagq9QfN8jRGf9OL46toBIhG7+oUJz+jtaiqOEXOYv1ictYYLgAIvr1+rXlPdI0y3+xqbBlvoZ8VbRp+JlV0V+zORd08e1F2S8Jn/3jkgsAqR6FHctbbqGSjI6zFYT0mtC8nlMRjEUpHVC2dAn6S1fAeEJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WgC0sSIW; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by smtp.orange.fr with ESMTPSA
	id IPTmtju9PdwuOIPTmtbPiL; Tue, 03 Dec 2024 10:46:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733219162;
	bh=thLoruC4yUFDv+ISgmGKaXWPgUV99B5qVBSTju5LHwU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=WgC0sSIWW5lguk2ns0ImMU05qjGENR4pxxPExTKqtK1PECssmyFq9TLlQHDxMx1R4
	 FO29EKkdjIZEw0fdoA8Y7rYJukMcFr9UMyBW9O459fBip8Z/eItWub2uKSdOX2SedW
	 mC/xXrGeMNapancrtWgeCaSRXV7FobU2xsHVP3t+1bTrPa1gxQ5Lf7/ZSMMgm2Esv4
	 +2RVwVgyof2VOIUV2eSUFW0QyCkILHFd9yHrKel1McXwzZlS9nRj2TswlJrrm203ie
	 avZJxxa2UeF9aik8jOjUewAaQf4LtNdTMOypMeOS9EtLZQ5t5T+r8nXpzrZkkGh7zb
	 EjEJb4i0r2EGw==
X-ME-Helo: mail-ej1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 03 Dec 2024 10:46:02 +0100
X-ME-IP: 209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso757913466b.2
        for <linux-can@vger.kernel.org>; Tue, 03 Dec 2024 01:46:02 -0800 (PST)
X-Gm-Message-State: AOJu0Yx0frf88jFh8RKtJxus8GZcIiX4QJ41V9PYi272lFYnhItNL9GN
	5ppwR32YBKp9zpv836FvVBGZaAV555enYzar8Ym0WRyPvGAmKHRiwP8sqh/dLUv7k+cswxPKp7E
	jxkWPagGOg3GPfn+FktYglq8cCJQ=
X-Google-Smtp-Source: AGHT+IG7rfxsZd4h6smMLKUfSOZOW1GQMZAuultjuL1fRyG9DYHwNAIvOoyOLMXWkfmvX79tZQa6XSiK/MlsrhWu3zg=
X-Received: by 2002:a17:906:bfea:b0:aa5:3853:5535 with SMTP id
 a640c23a62f3a-aa5f7eef1fdmr126741566b.38.1733219162013; Tue, 03 Dec 2024
 01:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net> <a9d8eb65-c88d-4bc9-b0c2-c0e0799ea5bd@wanadoo.fr>
 <23c914cf-0af2-4619-9f83-e4b6339ef65f@hartkopp.net> <12e013c2-d6ff-42b2-91ef-921db4e7ee0e@hartkopp.net>
 <77331a33-ac82-4cfb-9881-159d6d2daf58@hartkopp.net>
In-Reply-To: <77331a33-ac82-4cfb-9881-159d6d2daf58@hartkopp.net>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 3 Dec 2024 18:45:50 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqLi1oywkSZ=pVFnV04efwk8mJWmwP+FzSyMknR2d+9=RA@mail.gmail.com>
Message-ID: <CAMZ6RqLi1oywkSZ=pVFnV04efwk8mJWmwP+FzSyMknR2d+9=RA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Robert Nawrath <mbro1689@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun. 1 Dec. 2024 at 20:38, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Vincent,
>
> I found some issues in the code and fixed up the problems below.
>
> The funniest thing was this copy/paste problem in netlink.h ;-)
> (see attached patch with my changes)
>
> The patch descriptions are not finalized - but it becomes usable now.
> I will add the CAN XL transceiver switch to the controlmode definitions.
>
> For the PWM configuration we would need some more discussions.
>
> https://lore.kernel.org/linux-can/20241201112333.6950-1-socketcan@hartkopp.net/T/#u
> https://lore.kernel.org/linux-can/20241201112230.6917-1-socketcan@hartkopp.net/T/#t
>
> Best regards,
> Oliver

Hi Oliver,

Thanks for all the testing and the fixes. Because of the lack of
testing of this RFC on my side, I was expecting such issues. But I
really appreciate that you took time to investigate and debug, really
helpful! I will make sure to incorporate these fixes in the next
version.

On my side, the last three weeks were more busy than anticipated but I
finally found some time to do a deep dive in ISO 11898-1:2024, I read
two thirds of it so far, just a few more pages to go. It just takes me
time to digest all the information. Once this is done, things should
be more straightforward.
The next series I send will add the pwm and drop the RFC patch. My
goal is to have this CAN XL series ready for inclusion in linux 6.14.
I don't want to overcommit, but hopefully, I would like to send the v1
either this weekend or next weekend.

I will also rethink whether or not is it worth doing some NLA nesting
as suggested by Marc here:

  https://lore.kernel.org/linux-can/20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de/

(I am still divided on this subject).


Yours sincerely,
Vincent Mailhol

