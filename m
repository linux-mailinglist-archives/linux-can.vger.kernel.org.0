Return-Path: <linux-can+bounces-696-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E58D743E
	for <lists+linux-can@lfdr.de>; Sun,  2 Jun 2024 10:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00005B2114B
	for <lists+linux-can@lfdr.de>; Sun,  2 Jun 2024 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643CC17721;
	Sun,  2 Jun 2024 08:05:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF08AD59;
	Sun,  2 Jun 2024 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717315502; cv=none; b=V5MFawZYSJB+ouXGUEW/FAeNigN3AIW8J+x0jFkMP6q8mWYO7OpDNORJ9JfbJYWOncpZwrvjIkKQy+bKcQFgYXsAmvotGqfT9BL5wIYjRiaN7ivNF5ZThOqVC5BzACzmnQ6n0O6Uz3+yKJbkv9r5mWb/0lzyyqxsSfyZCMJVx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717315502; c=relaxed/simple;
	bh=gR0H26PHEjvVe8itH5EYq+JCOkaSJHGx/hS0FRcpX6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLdSU7J7C443P2KDk44fAIWiacvtWRN1zZMT8knt+yAosOciJJ3yo49rE1ehBxLKH4HJqRgBJhqTWdt7GvmL5tF1iQMxt/Y4uevcThYrOwMMnLPXAwoDAdrQ8oXZta2C/baReB7m6ED6CkjpH9fV/LLPKRVB3G8uvLoqYSuMbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c199e37f4eso2816536a91.1;
        Sun, 02 Jun 2024 01:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717315500; x=1717920300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3MiZNvKl+XV+b17OssT+nbj4O2+/u8kuzvWMYKAS2M=;
        b=HuIOWJvHPi6dJHSXfraDbNVf97BqQ8F7spnv2BByXeBLHgvDDAviaLnEJN3SIgl5sI
         oL9iV9zhhfxzwUAaBQ9jj1vhwTNHyJP7zz9gESnGiYO+hDb/MJYYUzekN3O+arK5FHuR
         1wF89UoYPlwnLAe0vPPxx36GrbMjjv/+cOqFzzI2GYlfcRmjXAY0tnqKjYU7XY5h2MKK
         CzHQ15M+oHKwcimyIM7dF4Tp+jGqyRjTQlbSv7m/GEIWzg+URNBeCvwghSd4BDIDGjat
         Y6aw+BwoPwYshOzDxGBZntugOHz7EHfSgeUI8B+NfSZuFGy73uwuwdM3E/R/Xay2YJmX
         clQw==
X-Forwarded-Encrypted: i=1; AJvYcCWbpuNG2KKVXV81xrrejIQMKuxvL0g4fPqK3bCV4AEIrvOK4EzG6IZD7TU8PR2Uk8SGlHN7jVNezxc7f3+I4G8/I9tLIVqtIO89iYzgnAqW/DXREKew706We2VfC3pgTl90R9zK1khw/es8jUZ9EkDthcRLpGtQXYGl++KWAfMVVW4AKJk=
X-Gm-Message-State: AOJu0Yxv4f5ds3VxAU1Aq8jE33+pUpHbyMCNrnNup14AvQH5e4o5BjE/
	tEXZ9do8EpXcsNjzshp1G9QH4InRM3uuRIsixAV2fkIybSA0bmlIg/geAFKAEUd0u28zx3eSfHi
	3wAz+rJH2LwDv6z/XFxiDDkONOkE=
X-Google-Smtp-Source: AGHT+IE6q7yd/YVo/jQt7Neknot7S8QsGvptk6hX/Ial1GXidK5YQkoccS9zmBmcYnfe5Bk8P/r/jM9MwBtaarTMh8U=
X-Received: by 2002:a17:90b:118f:b0:2b6:c650:fb54 with SMTP id
 98e67ed59e1d1-2c1dc5df200mr4808657a91.49.1717315500142; Sun, 02 Jun 2024
 01:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973640.git.geert+renesas@glider.be>
In-Reply-To: <cover.1716973640.git.geert+renesas@glider.be>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 2 Jun 2024 17:04:48 +0900
Message-ID: <CAMZ6RqJZoq3vwgyC5RgOtdzAhoYRibPQXKwuKUfTmmSx4tJJzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] can: rcar_canfd: Small improvements and cleanups
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed. 29 mai 2024 at 18:12, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi all,
>
> This series containssome improvements and cleanups for the R-Car CAN-FD
> driver.  It has been tested on R-Car V4H (White Hawk and White Hawk
> Single).
>
> Thanks for your comments!

I left one notwithstanding comment on the first patch. With or without
that nitpick addressed, and for the full series:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

