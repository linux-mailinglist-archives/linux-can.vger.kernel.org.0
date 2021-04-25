Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA636A6EB
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhDYLlF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 07:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhDYLlD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 07:41:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790CC061574
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 04:40:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c4so14009811wrt.8
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=nlPkc3yLjB8ztnEoQxGNvyEpo51PywG0EprszA54rY4=;
        b=MIo4GLF/Lt+VvXbgjvKPsCstBqsFfHbgM2RI5jpCuT+kHcm4I1jTRoGR469nKYHZVi
         oexNfT+wawzpXjQ3PFzdytAaU4ffg/IE9FCZ8wwYlUn0RWOWt1UikLg4Z26FmORIwHii
         vG1DKNkoS0FyMYx1+KUMRdt/NZuFzxlhaRbRLc/zy8ZMUtcTcm1n9GURcgI4JBLZQDCN
         AzqeNMIX9kRP9/T6e9+opNMcatsbounh/K9ec2GkohvgpyqqxUPHOLK44b/97vptGA4i
         oKVfmfqdyCXLUVemIeAF9S1zM2iqISSBwt4sTo0Uzmys/9T4+iDxC7OEWcmjrm4fE+08
         brUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=nlPkc3yLjB8ztnEoQxGNvyEpo51PywG0EprszA54rY4=;
        b=Y9pwoYpiCQV5q1K25u2cbZdLTMXEU8umiNtisXzGTblIT1yDQU880w2xB1XAQ+gvsL
         wZDLSSrlNTonAYNqUVZKzcjHW6HZ2NM0iLkaZrW0Nrc9JwpJGP1kuCZA5dFyQlVlilIf
         CqW2cr5LJw9+Pyy9xkTd2MrKoAzOiYLi40x+f6XXImgIYilpesufEkojbBmXGPWry5F8
         as+vGr890G0EM5MOQzKpOto6Tmq44nZBCHChkB5H1nTO7pKVZKbWJWjI2SSEBo7v1PZN
         4M9sTXorbSOBMuHmUfytzzUB2ZoghEwsOJ8PDYabXD4rxwYy14XwCSomOartdie/YFYe
         hXPA==
X-Gm-Message-State: AOAM532WqZgr79wia1ndFDAVqHSPPtCfpNaig6qSTuOOGIoGdxKyXW6w
        o6ylLrzZXxsf17K4A3EZEpv17s62/B04Mk5W0Z4nCA==
X-Received: by 2002:a5d:640e:: with SMTP id z14mt11705015wru.258.1619350821152;
 Sun, 25 Apr 2021 04:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210425090751.2jqj4yqx5ztyqhvg@pengutronix.de> <20210425095249.177588-1-erik@flodin.me>
In-Reply-To: <20210425095249.177588-1-erik@flodin.me>
From:   Erik Flodin <erik@flodin.me>
Date:   Sun, 25 Apr 2021 13:40:10 +0200
Message-ID: <CAAMKmodFEXj69mA2nHNfdtJYBTUR+sBpPc_2krm27oKUyVtqKA@mail.gmail.com>
Subject: Re: [PATCH] can: proc: fix rcvlist_* header alignment on 64-bit system
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On Sun, 25 Apr 2021 at 11:53, Erik Flodin <erik@flodin.me> wrote:
> -       seq_puts(m, "  device   can_id   can_mask  function"
> -                       "  userdata   matches  ident\n");
> +       seq_printf(m, "  device   can_id   can_mask  %sfunction%s  %suserdata%s   matches  ident\n",
> +                  pad, pad, pad, pad);
>  }

If a compile-time variant is better I'm happy to change this to e.g.
something like this:

seq_puts(m, "  device   can_id   can_mask  ");
if (IS_ENABLED(CONFIG_64BIT))
        seq_puts(m, "    function          userdata    ");
else
        seq_puts(m, "function  userdata");
seq_puts(m, "   matches  ident\n");

or something like what Vincent suggested:

#ifdef CONFIG_64BIT
#define PAD "    "
#else
#define PAD ""
#endif
...
seq_puts(m, "  device   can_id   can_mask  " PAD "function  " PAD
PAD "userdata   " PAD "matches  ident\n");

None of these versions are really grep friendly though. If that is
needed, a third variant with two full strings can be used instead.
Just let me know which one that's preferred.

// Erik
