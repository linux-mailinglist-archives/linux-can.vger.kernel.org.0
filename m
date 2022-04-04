Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680264F1447
	for <lists+linux-can@lfdr.de>; Mon,  4 Apr 2022 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiDDMFE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Apr 2022 08:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbiDDMFD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Apr 2022 08:05:03 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99B35AA1;
        Mon,  4 Apr 2022 05:03:06 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id br1so1404824qvb.4;
        Mon, 04 Apr 2022 05:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBn9C74+atHxv2JGnCFTFZEwPIzG8cnL4fdmUex82pg=;
        b=q0qHcIqvq8NLHCB8swUVFi8OBkyPe8o7EAXGeXOHNf1AHDv63UBpEUBs+8VXPU7jGW
         gpeeZODMlKenSIww6OLM5qHbm1K4TeT1csUoyxj+PCsnJ0YnX2Mopw2n07ltVoTb08D3
         Cx7YQ8ZdtW9chidwrdXbPgUNFdYd3XCMmReCpBRUm8YjhznCLPHIUIMKgpoqeq1/SglL
         vtcSpnfwa63gWqwVBSf5WQff7Eut7AQ8qiNPCfpctkFp/vgoIe61Lm8Dgg1a2ghbRXnL
         IghHCLEh4Gsk+gVy5s81E3yavTZQJd4p3INiMurqdPVP6WFk7VIuBPvWbFesaOWUKwpP
         mCnQ==
X-Gm-Message-State: AOAM531fz4oWvOQX4jgiiXB/CCpHsYebqdegAjcBelr5RM2qhQFUddRj
        ir5I1IlbuLz+vzxJuvV/534HPX1P06Ot8A==
X-Google-Smtp-Source: ABdhPJwPTOtiVXNvCX/pKqWrYha6lZQy8p7KfmyavhmlzM6+laaTyO10jq+zadGAbMUmC27l3oz6nQ==
X-Received: by 2002:a05:6214:529e:b0:441:2c37:52e5 with SMTP id kj30-20020a056214529e00b004412c3752e5mr16852928qvb.4.1649073784957;
        Mon, 04 Apr 2022 05:03:04 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85c87000000b002e234014a1fsm8616195qta.81.2022.04.04.05.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 05:03:04 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id g9so7515651ybj.9;
        Mon, 04 Apr 2022 05:03:04 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr4305546ybp.613.1649073784139; Mon, 04
 Apr 2022 05:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220401153743.77871-1-wsa+renesas@sang-engineering.com> <20220403110534.2k3ojnkkrsdjzimb@pengutronix.de>
In-Reply-To: <20220403110534.2k3ojnkkrsdjzimb@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 14:02:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2Ut9A57UkOO4f+q8Awu0K9Oek2Qhujr+TaKNTpkVU=g@mail.gmail.com>
Message-ID: <CAMuHMdX2Ut9A57UkOO4f+q8Awu0K9Oek2Qhujr+TaKNTpkVU=g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Document r8a77961 support
To:     mkl@blackshift.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Sun, Apr 3, 2022 at 1:05 PM Marc Kleine-Budde <mkl@blackshift.org> wrote:
> On 01.04.2022 17:37:43, Wolfram Sang wrote:
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Wolfram, thanks for the patch. I think usually Geert takes the renesas
> DT binding patches. (If it would go via the CAN and net tree, that patch

Usually only for Renesas core patches, unless the I/O maintainers
are unresponsive...

> should get a patch description, my upstream doesn't take patches
> without.)

The other usual suspects are the DT people, but they weren't CCed?

Of course I can take it, too. Are you willing to provide an Acked-by?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
