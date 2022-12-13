Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0449A64AF6D
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 06:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiLMFse (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 00:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiLMFsa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 00:48:30 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3031A5FCC;
        Mon, 12 Dec 2022 21:48:28 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id 65so1458662pfx.9;
        Mon, 12 Dec 2022 21:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USGbP6nNUlE8y8qEKpiV7jl0miBlf/8AS0294ze5eaQ=;
        b=TAVE+mKyYO5U4JLC8KL3RMu6CSCN+WlH1NbJ2WpxspyjuOJOFv2UYRnhNm4Z7EeQg/
         QGgA+b5mPiB72/rnkCQYVIhHpjSMoS1vLh1Mm6RrfvN6jl24cgdCBfadEW2yzYKRxbdN
         VVNTj4l9gPPrkWObH6XYtftJqxaLD8nf9hqOgsCK+VzwdrXeLaBX2dW8e/Frxwq9slt4
         jQSCAwKAyzVu3xsKqlui3vdRrZmLAhCsGv/JbZOJBPRHmO/jakYbaPa44JvbzXe0MC8H
         pCSg2dglzaRpW6DKHQwqrN0GmN3EOixPYe83lU2RXMB6O62Y3sH89zBV9WMI5yug7yBW
         lcew==
X-Gm-Message-State: ANoB5pkzoefNcCbBB/6993JTw10evNOovC8NE0M5OZYUgie9Y2RA6F4+
        4P+2QFJaOmGvVsbV0oyZWnS1hZdqb23IYukZh2N53QKV/Aw=
X-Google-Smtp-Source: AA0mqf7PLyHYqHuPO2sPHEsPk+jZrO2MfZb0xKZVtq+aQC7QPTd/lkm+Cm0g91VJTE1+nYRtE+OMwUwN391tP0LH03g=
X-Received: by 2002:aa7:8608:0:b0:578:8864:7b2d with SMTP id
 p8-20020aa78608000000b0057888647b2dmr353529pfn.14.1670910507586; Mon, 12 Dec
 2022 21:48:27 -0800 (PST)
MIME-Version: 1.0
References: <202212131058.keOvD6kU-lkp@intel.com>
In-Reply-To: <202212131058.keOvD6kU-lkp@intel.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 13 Dec 2022 14:48:16 +0900
Message-ID: <CAMZ6RqL23hbqNsMk8F8wjN5fEs2wwRBwO++FQu=GEFRQWPO0Dw@mail.gmail.com>
Subject: Re: [mkl-can-next:master 22/43] htmldocs: Documentation/networking/devlink/etas_es58x.rst:
 WARNING: document isn't included in any toctree
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 13 Dec 2022 at 11:17, kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git master
> head:   47bf2b2393ea1aacdefbe4e9d643599e057bb3a2
> commit: 9f63f96aac92751e85f8313f59f2c867b88ea453 [22/43] Documentation: devlink: add devlink documentation for the etas_es58x driver
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=9f63f96aac92751e85f8313f59f2c867b88ea453
>         git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
>         git fetch --no-tags mkl-can-next master
>         git checkout 9f63f96aac92751e85f8313f59f2c867b88ea453
>         make menuconfig
>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
>         make htmldocs
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> Documentation/networking/devlink/etas_es58x.rst: WARNING: document isn't included in any toctree

Stephen Rothwell reported the same issue on linux-next mailing and I
sent a patch here:
  https://lore.kernel.org/linux-next/20221213051136.721887-1-mailhol.vincent@wanadoo.fr/T/#u

Yours sincerely,
Vincent Mailhol
