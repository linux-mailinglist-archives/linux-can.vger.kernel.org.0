Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C952CCA7
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 09:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiESHQL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbiESHQD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 03:16:03 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7712A24D
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 00:16:00 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id i187so5283447ybg.6
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 00:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWBKmbgKZwHjW4MpK8pxL8gh5o1oOiQQk9hgpFjm3Yk=;
        b=ugTu+qmPOSKcb8UYp8d9pkfdN8WMSv0dsXSdQolsXIhTlmwuMQ0XUtiCKS62jVs7GV
         4eqSPM94YPEryBgyrsMz7sca5fmi70AWMnzsu21Gp148NzZRys7BzErmMWMU4b65E7Ec
         uxiTYqOue29Gn6Jlq05hfzmBAcPE1mo7V9zQPlYtKQiuhFqkDQ+UKtATJU55de2dTAS7
         Q2myPK4vaa2SJziurb206D9VUqJpwOXDP9aNMwJfVMe52A/zL4jZ13hC0wR56HfovVkR
         VdZ+saaUaAew+Jas5E88uwYragPC/9px38T1q8QX+dG9RSMhQjALT7D1dp3OP/Q32fez
         y3bw==
X-Gm-Message-State: AOAM5331lHN34JtIKNhV4x1NJ/W8Und1EXtbZ2Yqqv9xt0+zv94UusbB
        1VNmb1pQu2EBNRN7UFF+JlOP3BzNEradDqI4ZvGUNlRADgLGOg==
X-Google-Smtp-Source: ABdhPJz2XsadZXLbApnt6Fgn68JqP3SCy8kwXDN6P1rzUl4FMTjRTmEsf5HUdMx7Fqcj182R8v6IOeM/I3HqzTzqvUw=
X-Received: by 2002:a25:5c1:0:b0:64e:a4aa:e206 with SMTP id
 184-20020a2505c1000000b0064ea4aae206mr2997705ybf.381.1652944559883; Thu, 19
 May 2022 00:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220518154527.29046-1-socketcan@hartkopp.net>
In-Reply-To: <20220518154527.29046-1-socketcan@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 19 May 2022 16:15:48 +0900
Message-ID: <CAMZ6RqLSSUkqSQBE+bYzvKfp2=bAn8jk+byXQS5cM_7VrJj2-Q@mail.gmail.com>
Subject: Re: [PATCH can-next] can: can-dev: remove obsolete CAN LED support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
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

On Tue. 19 May 2022 at 00:52, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Since commit 30f3b42147ba6f ("can: mark led trigger as broken") the
> CAN specific LED support was disabled and marked as BROKEN. As the common
> LED support with CONFIG_LEDS_TRIGGER_NETDEV should to this work now the
> code can be removed as preparation for a CAN netdevice Kconfig rework.
>
> Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
[...]
>  struct net_device *alloc_c_can_dev(int msg_obj_num)
>  {
> @@ -1376,12 +1367,11 @@ int register_c_can_dev(struct net_device *dev)
>         dev->flags |= IFF_ECHO; /* we support local echo */
>         dev->netdev_ops = &c_can_netdev_ops;
>         c_can_set_ethtool_ops(dev);
>
>         err = register_candev(dev);
> -       if (!err)
> -               devm_can_led_init(dev);
> +
>         return err;

I think we can remove the variable err and simply do:

return register_candev(dev);

>  }
>  EXPORT_SYMBOL_GPL(register_c_can_dev);
[...]

Yours sincerely,
Vincent Mailhol
