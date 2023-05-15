Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44863702675
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEOHx1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 15 May 2023 03:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbjEOHx0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 03:53:26 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93DBBD;
        Mon, 15 May 2023 00:53:22 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-55b7630a736so182997097b3.1;
        Mon, 15 May 2023 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684137201; x=1686729201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JERc9IUVRqk4tjUXjqhcThAzcCzz7kZRH46NjyT79tk=;
        b=J0jOv9zyW1RRGzumstQ9oZxx/XrZ9L92v0FUPhoAovtAzR9uTv4G188MHN0/R81C74
         +594LUWc+RvPoZjGlimRMRT933F7CsMwgbUhJaPkZitx8h+1YuNebeSxISZyOuz3rGAQ
         mtyvK3tzBAH0h3xBuvIoq8on+jPv6i/dRjlMBf/BjNaVZ0g0WhGxHIpAc7cb/EP7pXxF
         JAhwySJ/8lGQk3W7+wvWxQXnolVqA4yGMMDXMFYlywZHDPyB7P3rTeE/ZFD2dFGzWWuW
         1USzq0KcGzUaL4xZLWKV7Axrbi3Oq6KBZ43xJS+Qsgd62XeFdfvhyCqRu99/oPxyO9nr
         RSCw==
X-Gm-Message-State: AC+VfDxYVoYBLqbP4FhMvHvwkdjVyjKRSuJraQ6hheACspMcIALklOXN
        iUkqGJ8HKWZ9eh0BSDLtUqv3vhyLBizCag==
X-Google-Smtp-Source: ACHHUZ6JkJIYJSySCOHbRo+xuKvYtW5Wp+tO6UebIeOS2ZeO5CMe2qeAMYTskOKwrZfPJkj3lMyRfA==
X-Received: by 2002:a0d:d705:0:b0:55a:792:8c20 with SMTP id z5-20020a0dd705000000b0055a07928c20mr31296750ywd.6.1684137201624;
        Mon, 15 May 2023 00:53:21 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id l65-20020a0dfb44000000b005461671a79csm4813655ywf.138.2023.05.15.00.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 00:53:21 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-55a76ed088aso182863377b3.2;
        Mon, 15 May 2023 00:53:20 -0700 (PDT)
X-Received: by 2002:a0d:e808:0:b0:55a:4ff4:f97d with SMTP id
 r8-20020a0de808000000b0055a4ff4f97dmr31597295ywe.48.1684137200429; Mon, 15
 May 2023 00:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de> <20230512212725.143824-14-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230512212725.143824-14-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 May 2023 09:53:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAy2RKkAesNi1PDJmzWUTQqViho7zGOmZr0ooGD+je_g@mail.gmail.com>
Message-ID: <CAMuHMdVAy2RKkAesNi1PDJmzWUTQqViho7zGOmZr0ooGD+je_g@mail.gmail.com>
Subject: Re: [PATCH 13/19] can: rcar: Convert to platform remove callback
 returning void
To:     u.kleine-koenig@pengutronix.de
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Simon Horman <simon.horman@corigine.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, May 12, 2023 at 11:27 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart from
> emitting a warning) and this typically results in resource leaks. To improve
> here there is a quest to make the remove callback return void. In the first
> step of this quest all drivers are converted to .remove_new() which already
> returns void. Eventually after all drivers are converted, .remove_new() is
> renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove

these drivers

> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
