Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87819746B
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2019 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfHUIHY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Aug 2019 04:07:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35675 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfHUIHY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2019 04:07:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so961028oii.2;
        Wed, 21 Aug 2019 01:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXpq27Y/6uOHBaJM2/YHsAGx1VCUbYjrhwaxusYnlJw=;
        b=o1jqSF7AyFceYpB84QwGG/MUennbaN1YRWGjFn4cezDYeizsA/jyzALxvZVmMt+4N1
         IguBw4hqR6Rla3M2m9LlTO/qT9xHs6sxka2RB+xPywEkPk18bTLNGJPqBJUX4QP6fK59
         BJ7FWOeHTFGx3KJfwfYtL8xL2TTUN780w/YPaYOUKpd2R0yLvZ/KiXx+Q5SgTYO+eu4J
         Ga0Gp4x/vRj3ifZI8jtc42hpez3kPe0jBoBJmuWD5SRJ5OjcEqPz81M6cuLlUDNGDa2a
         lG7I7GDSrp3worYTyrbVByTo+bipNIuNFz1K7isFc72OCDRwJyXJrGwnZTWAh4eYn7Cc
         Z2kw==
X-Gm-Message-State: APjAAAWbJefHCCf7f4+LKnjeF7uFmRzLN6O1VSpGzNek1t54asUvk/63
        gJjbPXENpjGoNErse9k7U5Krj6MHxe+jbnMuDQU=
X-Google-Smtp-Source: APXvYqxwIS20ToA4PgbklgxDV0PjtaLxrQfkDOR9OgXyglBsXvEJDLz04KeHFTI7ZAKylzV1yWJ7pMMog5tBfstVXII=
X-Received: by 2002:aca:3382:: with SMTP id z124mr3021580oiz.102.1566374843108;
 Wed, 21 Aug 2019 01:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <1543972625-11267-1-git-send-email-uli+renesas@fpond.eu>
 <1543972625-11267-2-git-send-email-uli+renesas@fpond.eu> <20190316222547.GB1111@kunai>
In-Reply-To: <20190316222547.GB1111@kunai>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Aug 2019 10:07:12 +0200
Message-ID: <CAMuHMdWzBzk_No3DnP2heb4HeS8xPwxYTA0LLid=07YiYxGY2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: can: rcar_can: add r8a77995 (R-Car
 D3) compatibility strings
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-can@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Mar 16, 2019 at 11:25 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> On Wed, Dec 05, 2018 at 09:17:04AM +0800, Ulrich Hecht wrote:
> > From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >
> > Adds compatible strings for the R-Car CAN controller in the D3 SoC.
> >
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Adding Marc to CC.

Thanks, queuing in renesas-devel for v5.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
