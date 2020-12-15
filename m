Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263D02DAE1D
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 14:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgLONh7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 08:37:59 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39563 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgLONhv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 08:37:51 -0500
Received: by mail-yb1-f194.google.com with SMTP id 82so12038201yby.6
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 05:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dY/ubB1lAfEmqBQlTmk1OLIpZeNPeJ680Q+cyqyH6MI=;
        b=g0OlINtSoiY4hleQF0Md/PT1NItQghxUplj76Siw+DJtSUdVmYK5IslgCi+JHcKfwv
         yNo/9am581Ws+b2l9m3+dzeFB8KPG3OVVYyFUxuG4bx0x0ax6mYY317TmLfvP9NdQJaX
         z1i5XdA2TRYxYkNdZxLbWykVIuBv6VeLcmXXM5QSS72z+CeTQZBPvZNNJt3iinCQNfm+
         2ZqDqvRTP5Q/MSwMPi9ZefanI6Ndbcc3oJg9Jj4Ilw1Lzv0lvAeMFiJShYnt+7TjjaKy
         b/S65CLNlCEk5brM4LKdW4QfxCTTrrryttE8zYPTS8bQL9y9NBz4S4OsI1wVnbnKjzLl
         gESA==
X-Gm-Message-State: AOAM533pEswxuONgeChNWBwPzP21laDxAHDOLzXfYVME9RA5Hvd3gyu3
        t3zrsezzxC8yBgyby6/7zR2eloo9Mw/XP195XwSrEz0rcTlB3n/B
X-Google-Smtp-Source: ABdhPJw561J6OBtE/r6Qar6EfJ+mDeWK0v0/lwe3yD9Isi0NRsoEuqM1lUGIjhIPLrVRL8ymxCxKRXldfjjvcO/vpO4=
X-Received: by 2002:a25:4e09:: with SMTP id c9mr41306182ybb.360.1608039430768;
 Tue, 15 Dec 2020 05:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20201215125549.540918-1-mkl@pengutronix.de>
In-Reply-To: <20201215125549.540918-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 15 Dec 2020 22:36:59 +0900
Message-ID: <CAMZ6Rq+0oreKdMLTS-U0L+6PBTyXHVikk=jT5+9n7H7pAG4Z+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] can: dev: add can_len2dll_len()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mar 15 Dec. 2020 at 21:55, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev.c   | 21 +++++++++++++++++++++
>  include/linux/can/dev.h |  3 +++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 68f37ac54327..fa81e3067b3b 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -60,6 +60,27 @@ u8 can_len2dlc(u8 len)
>  }
>  EXPORT_SYMBOL_GPL(can_len2dlc);
>
> +static const u8 len2dll_len[] = {
> +       0, 1, 2, 3, 4, 5, 6, 7, 8,      /* 0 - 8 */
> +       12, 12, 12, 12,                 /* 9 - 12 */
> +       16, 16, 16, 16,                 /* 13 - 16 */
> +       20, 20, 20, 20,                 /* 17 - 20 */
> +       24, 24, 24, 24,                 /* 21 - 24 */
> +       32, 32, 32, 32, 32, 32, 32, 32, /* 25 - 32 */
> +       40, 40, 40, 40, 40, 40, 40, 40, /* 33 - 40 */
> +       48, 48, 48, 48, 48, 48, 48, 48  /* 41 - 48 */
> +};

I totally misunderstood what you wanted to do in my previous
email. I thought that the numbers were placeholders and that
the final goal was to take into account the CRC as you previously
mentioned in your first email.

This function is just here to sanitize the data length, right?
Then we could simply name it can_fd_sanitize_len().
