Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29536160B5
	for <lists+linux-can@lfdr.de>; Wed,  2 Nov 2022 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKBKRa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Nov 2022 06:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBKR2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2022 06:17:28 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C924952
        for <linux-can@vger.kernel.org>; Wed,  2 Nov 2022 03:17:28 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id q71so15828817pgq.8
        for <linux-can@vger.kernel.org>; Wed, 02 Nov 2022 03:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+rvuF/jot8MY3pB0elCKcrYiA5LZOATXgGEer1D60Y=;
        b=I3WnipgI5WyS0ZCd8OBBPkk2F+2srlJhZaeaik0A7HD3oM2ChL/u1J9YfC22fukybO
         z7xs4eZwScrPTlwBvDpEtHdO0gt+JT/9cg16KaFIvrim8h0aL3NOOWLHP/0Hg8+th1vI
         fOQNGsUZ96rcZIX9c+aqomNsdGw+JGfY+lXMyj5tAnMX5IvYJnTwHbzHDQvKbF90PLeY
         Zmx+846OKY3KrcO3XwtfRf2+OezbOrv9Ms3vxMkIuCnIy5dnW/56y5+Zj8eh+bQcXS9y
         3yfaTE/+cZYnSqcE9Ikr2sd4lHoPIqIJ+96gYq0mCZc2rdUr9NIeGvtv4m7biJA9aNzv
         siyQ==
X-Gm-Message-State: ACrzQf3/eFnrZxF9WULE56aiXIfOEpsNooP3NOlhYsWAsWJ6O7S/0bBe
        j56dSnars/i46OCxrYN7mku4Jn3Z6R61LG3oXpjdQEPo6CI=
X-Google-Smtp-Source: AMsMyM7xaHevpwrDCkk4TA1IcbBxLLSoI744rjVWqUsyVHuIAHHFtDJNxOAxAZ2RkrEuGMdW+WF5tIEqnCugpuBqd+Y=
X-Received: by 2002:a05:6a00:1304:b0:555:6d3f:1223 with SMTP id
 j4-20020a056a00130400b005556d3f1223mr24556724pfu.60.1667384247579; Wed, 02
 Nov 2022 03:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221102095431.36831-1-socketcan@hartkopp.net>
In-Reply-To: <20221102095431.36831-1-socketcan@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 2 Nov 2022 19:17:16 +0900
Message-ID: <CAMZ6RqJ+q5UmFrQFKKzxHzC4pOVT0HS6vD9509Rbth_cUFkjkg@mail.gmail.com>
Subject: Re: [PATCH] can: dev: fix skb drop check
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org,
        Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Max Staudt <max@enpas.org>
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

On Wed. 2 Nov. 2022 at19:06, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> In commit a6d190f8c767 ("can: skb: drop tx skb if in listen only mode") the
> priv->ctrlmode element is read even on virtual CAN interfaces that do not
> create the struct can_priv at startup. This out-of-bounds read may lead to
> CAN frame drops for virtual CAN interfaces like vcan and vxcan.
>
> This patch mainly reverts the original commit and adds a new helper for CAN
> interface drivers that provide the required information in struct can_priv.
>
> Fixes: a6d190f8c767 ("can: skb: drop tx skb if in listen only mode")
> Reported-by: Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Max Staudt <max@enpas.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Cross fire... I missed your patch and sent another one. That said:

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thank you!
