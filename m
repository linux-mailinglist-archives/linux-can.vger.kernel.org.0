Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC8C78A4CF
	for <lists+linux-can@lfdr.de>; Mon, 28 Aug 2023 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjH1DrR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 27 Aug 2023 23:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjH1DrD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 27 Aug 2023 23:47:03 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05A8F4
        for <linux-can@vger.kernel.org>; Sun, 27 Aug 2023 20:47:01 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5922380064bso32315427b3.2
        for <linux-can@vger.kernel.org>; Sun, 27 Aug 2023 20:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693194421; x=1693799221;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28JjByh6sN5NCHK02Hw1vI3IuOyxycxGXjf/E6wXk3A=;
        b=eEVmjXcUqvBEDuumDwEc8ztzu7vcNaW2XKX6fu3RpJ2oyf515yX6tkcXP7aVprpPI3
         5TwQK2cTrt0qxoPrnoKf3PYEuaV2oWxcSfBWLVpxDab0ou0X8KqVbChB3ecELAvLW43v
         P8k9iN1rjf9GLY5SsSmnGYw71SIy59AL8kE03axfWdzfcQtQfD1NUmgkIMMHrmSYLIaY
         m8RRAxjLaClQwzkaaBfAly9uf1cBm6slfx5kQe09A4/pVtYeFn86aDmwHqj9cMyQw+Cj
         qjZtNTRi3bK3EJh+cNvfynmZ81km/FlJ/i2s3yga//aa9KPKCsGA89Y27D2+Hjt2cWpJ
         3O0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693194421; x=1693799221;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28JjByh6sN5NCHK02Hw1vI3IuOyxycxGXjf/E6wXk3A=;
        b=a5LeUwUO+qYIn6Hnfx4NwGeAIR+42/WtS7DVsg+JOG2HnePrN0XcNGcpViRiAJ42Vm
         3hF5uMe9M9+f1pTAI8iHUcMmiF+6ZkDZLnBfGt9HC4L5SDVscVgBQHW4v9a8htg9NbfK
         naUlAxDUgu7Zfwxm2mBP05L1eGkMSnaxoL7eQjnAR1QnkJMbNYt3Oyf/+9I1L2fi8YQE
         zznIaOUkdhPx0Wuekd1BbSFkGFjT+/bNresnIrmEz02ZsDdNFcXxNXvNvk/rd9ZnXz7i
         uxp4AdqV9809NBwO5l51VBINfij73cxbEjRRUfclNtUdGqjCGK36kACAOW2eOffCpllx
         n5YA==
X-Gm-Message-State: AOJu0YwU2W5LFDpeyTlvM6yT3g/uVfIcKavVa6PvftinrfstWeM5qdLX
        CcL2W9Jy1qm9Bu7K2wUaRidhWAW1k7wV2lJuhxk=
X-Google-Smtp-Source: AGHT+IHlbK38fstudSvZfQaMaanOo7Xea2skeRZNjwFzXC56K0XVFavfL5m3lzLzuDlxCwfo5I1tppUYxAqLQyJ8L/o=
X-Received: by 2002:a81:a081:0:b0:573:285a:967f with SMTP id
 x123-20020a81a081000000b00573285a967fmr25439846ywg.38.1693194420721; Sun, 27
 Aug 2023 20:47:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:e00e:b0:16f:626:b017 with HTTP; Sun, 27 Aug 2023
 20:47:00 -0700 (PDT)
Reply-To: elbasa.adm@hotmail.com
From:   Usham Ahmed <elbasatrade@gmail.com>
Date:   Mon, 28 Aug 2023 04:47:00 +0100
Message-ID: <CALXtU9+n421mjmWaQQWPxSN1hHVoPwGePnDMdHpdG0L+_vePuw@mail.gmail.com>
Subject: RE;Order Request
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_60,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:112b listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6047]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [elbasatrade[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear Sir/Madam,

Greetings,hope your company do export your product to
Kuwait,please we have interest to buy from you.
=C2=A0Send to us your product catalogue or pictures for checking
so we can proceed from there.

Regards

Purchasing manager
Khalid Ahmed
=C2=A0Al-Amin Group.
