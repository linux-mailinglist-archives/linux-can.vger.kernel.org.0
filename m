Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086C079FF09
	for <lists+linux-can@lfdr.de>; Thu, 14 Sep 2023 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbjINIxx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 14 Sep 2023 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbjINIxx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Sep 2023 04:53:53 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464711BEF
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 01:53:49 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-26b41112708so596620a91.3
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 01:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681629; x=1695286429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V+C9x1ym6ouaEURD2L61y6vg1QXM3KQlYwJZMnkFkY=;
        b=sn+YP/0AxZogCUtmoIKqAagCGo3UTwfLIBCTjiSTimZqiXEYAOW8lyluGJJXMYNSlQ
         5ct+fTlXng+kU76TlI0uBFzX+9b1eQxWG8yZG0SoXVBCUpHL/a6gq5wbTu6HGQd5AYvF
         3Buj+n6fNA9i2mbhKUYKWuHb1hyCv3dc9OSbAZLwwPrX5dQECozfXTt7VCHW8eU0d1Pk
         xwkgBWrS5xoBHLvIy2gPsHy2BOxu72P08XeSdkAf9XblC/YDMXk/kv2VzhPaJawB3qrn
         dMY8EQptRw8PkJclfoARmFPueBUAN1P2jDjP73J/b5a21O1w0sf2JaiASN98ciiQyiTK
         DWQQ==
X-Gm-Message-State: AOJu0Yz1Sw85WdHRfrR863Ks8F1JaXAFq6B4vEyxw96PXzazVA4jNyUM
        XEK5po5KWayWTBt/s4StycgFfN8wURnxQxZ8e0yYg3uFNjs=
X-Google-Smtp-Source: AGHT+IHPjIXB3VfVcyNJH1a6kQ9Zlugh23QBVcnQb2lhaOgyb+ZeZrgRe0grbPBbopTMFfSCND7+VyxFstq/J2z+CDA=
X-Received: by 2002:a17:90a:b109:b0:268:60d9:92cc with SMTP id
 z9-20020a17090ab10900b0026860d992ccmr4767927pjq.43.1694681628545; Thu, 14 Sep
 2023 01:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230914-carrousel-wrecker-720a08e173e9-mkl@pengutronix.de>
In-Reply-To: <20230914-carrousel-wrecker-720a08e173e9-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 14 Sep 2023 17:53:37 +0900
Message-ID: <CAMZ6RqLdcsWgcuKivmN1EFTaxz+pRzDwN61kZP=V8OE6jYGQWw@mail.gmail.com>
Subject: Re: etas_es58x warnings with gcc-13
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On. 14 Sep. 2023 at 17:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Hello Vincent,
>
> when compiling the etas driver with gcc version 13.2.0 (Debian
> 13.2.0-2) and W=1, it fails with:
>
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c: In function ‘es58x_devlink_info_get’:
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:55: error: ‘%02u’ directive output may be truncated writing between 2 and 3 bytes into a region of size between 1 and 3 [-Werror=format-truncation=]

Actually, I was aware of that format-truncation warning, c.f. this
message I wrote during the patch review:

  https://lore.kernel.org/all/CAMZ6Rq+K+6gbaZ35SOJcR9qQaTJ7KR0jW=XoDKFkobjhj8CHhw@mail.gmail.com/

What I did not anticipate is that the -Wformat-truncation would be
re-introduced in:

  https://git.kernel.org/torvalds/p/6d4ab2e97dcf

> |   201 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
> |       |                                                       ^~~~
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:44: note: directive argument in the range [0, 255]
> |   201 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
> |       |                                            ^~~~~~~~~~~~~~~~
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:17: note: ‘snprintf’ output between 9 and 12 bytes into a destination of size 9
> |   201 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
> |       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> |   202 |                          fw_ver->major, fw_ver->minor, fw_ver->revision);
> |       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:55: error: ‘%02u’ directive output may be truncated writing between 2 and 3 bytes into a region of size between 1 and 3 [-Werror=format-truncation=]
> |   211 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
> |       |                                                       ^~~~
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:44: note: directive argument in the range [0, 255]
> |   211 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
> |       |                                            ^~~~~~~~~~~~~~~~
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:17: note: ‘snprintf’ output between 9 and 12 bytes into a destination of size 9
> |   211 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
> |       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> |   212 |                          bl_ver->major, bl_ver->minor, bl_ver->revision);
> |       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:52: error: ‘%03u’ directive output may be truncated writing between 3 and 5 bytes into a region of size between 2 and 4 [-Werror=format-truncation=]
> |   221 |                 snprintf(buf, sizeof(buf), "%c%03u/%03u",
> |       |                                                    ^~~~
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:44: note: directive argument in the range [0, 65535]
> |   221 |                 snprintf(buf, sizeof(buf), "%c%03u/%03u",
> |       |                                            ^~~~~~~~~~~~~
> | drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:17: note: ‘snprintf’ output between 9 and 13 bytes into a destination of size 9
> |   221 |                 snprintf(buf, sizeof(buf), "%c%03u/%03u",
> |       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> |   222 |                          hw_rev->letter, hw_rev->major, hw_rev->minor);
> |       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | cc1: all warnings being treated as errors
>
> Can you create a fix?

Sure! This is not an actual bug but I like to keep my driver clean of
any W=12 drivers.

Yours sincerely,
Vincent Mailhol
