Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5D34F2C3
	for <lists+linux-can@lfdr.de>; Tue, 30 Mar 2021 23:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhC3VGk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Mar 2021 17:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhC3VGR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Mar 2021 17:06:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C18C061574
        for <linux-can@vger.kernel.org>; Tue, 30 Mar 2021 14:06:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y6so19838349eds.1
        for <linux-can@vger.kernel.org>; Tue, 30 Mar 2021 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvssqWTMrJ/J7pRLXG+SmB9kt5T5qwQJhSZ5S47rDOs=;
        b=D/blLsxPeDKIwwepj+mYPJNF7ItiWIu8/oy2+c5IR8LpYLoBJEM1aetKUOdxOfFyax
         l2CvhzQbXa7g1Xw+PhzBEWD9yTXPDMVj0k18/sQwJiNSl8FXf8MKDHgcEM8dQAQq/QS0
         kdClr1pjhoJiNeo9ajnB8f3SHnNqUgtdLVYuZzh3JRlIcLCfwoD4BWbDP6U2nz7U4Wzh
         gIFHBPw4yfmPep9KTOD5/4avSKm3nILr/zcDatmhge+s8VwOsu/e7xvhvVVxr50ndeZb
         SuxmfvOaPxwJxxreMMkuRDmG/CkwBm0DY8n257CYZzFqez981X+AhkfTqxBEdN5mZQ4t
         wUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvssqWTMrJ/J7pRLXG+SmB9kt5T5qwQJhSZ5S47rDOs=;
        b=Cye8GHaaM2xl9OusBHxEAH6DY9QAWo6wDA8soczhedRv+ovoLlJ3sd8Mjb9OvA1U7O
         Mkhm2uzt/QdkUjYxqxit30rx+NDBgYTsZFdykGhipURO9xum4fyJyFb0h7HGuyWG9IA7
         6HoNvgH6e8tGCa5KTsNZnhu9x2tEqoV15HHYOgTgIX/PcoywklDdJ4bqIFs+MD+fRQy9
         rKd1FXPo7+QXxOhZw/sSNIIDQskymUUgWj4nJ2wqaQP/fympYCPlkdS8arbT5mor/ZMb
         u6sJW+5nlEoYawMcyOHaGi4iLX99KSp6OLbyNmZf3ptHKYb4FfV9u4wA99Abso+l9msO
         ZksQ==
X-Gm-Message-State: AOAM533guUrxgZUd2vXLof/oB0X6SU64Cn51a5PIi0yM13AczXBHLDrT
        DbMqK0ne+D2ja3X0AlCIJOye+sD9UkqW8uUuHUHSfw==
X-Google-Smtp-Source: ABdhPJwTNgDxtt9W3JmFGXueXTsleRs7R1KXvbf/j+Nmuvq3QeB/yEDrqPCd71ljBeZSa2z5ffHKzGKnyZ72/Kg1DUU=
X-Received: by 2002:a05:6402:1051:: with SMTP id e17mr35863291edu.42.1617138374672;
 Tue, 30 Mar 2021 14:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210330100246.1074375-1-mkl@pengutronix.de>
In-Reply-To: <20210330100246.1074375-1-mkl@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 30 Mar 2021 14:06:03 -0700
Message-ID: <CAJ+vNU0w2faqmW0MOA9FQD8=vxpJH1Lc8c0BMcAVKGNq1vNjjg@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251x: fix support for half duplex SPI host controllers
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Mar 30, 2021 at 3:02 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Some SPI host controllers do not support full-duplex SPI transfers.
>
> The function mcp251x_spi_trans() does a full duplex transfer. It is
> used in several places in the driver, where a TX half duplex transfer
> is sufficient.
>
> To fix support for half duplex SPI host controllers, this patch
> introduces a new function mcp251x_spi_write() and changes all callers
> that do a TX half duplex transfer to use mcp251x_spi_write().
>
> Fixes: e0e25001d088 ("can: mcp251x: add support for half duplex controllers")
> Cc: Tim Harvey <tharvey@gateworks.com>
> Reported-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

Mi Marc and Gerhard,

So was the issue being resolved here that there was another SPI host
controller that wasn't advertising that it was half duplex only or was
something else wrong with e0e25001d088 ("can: mcp251x: add support for
half duplex controllers")?

Best regards,

Tim
