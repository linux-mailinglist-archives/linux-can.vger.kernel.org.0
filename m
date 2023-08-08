Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208A774237
	for <lists+linux-can@lfdr.de>; Tue,  8 Aug 2023 19:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjHHRhS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Aug 2023 13:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjHHRgn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Aug 2023 13:36:43 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB30EF05
        for <linux-can@vger.kernel.org>; Tue,  8 Aug 2023 09:16:01 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-7656c94fc4eso775645885a.2
        for <linux-can@vger.kernel.org>; Tue, 08 Aug 2023 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691511332; x=1692116132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtJtQQGDLreKoq4GEc3nJUPXs81XhTcTJsIrwxyT11s=;
        b=IwnwGD1irozfRzPZrpfeHlTOR/YXfDt5cGBhf5r2TkM6WGmE+7IvHMYAjVgplBzqDu
         QWp/Rxhh6cixbOwACjM76FWlqX4SUcfqJTv1/NuGYpOKSPeRaeG78WASUeMNCXMckM7q
         H9lxbhZI7yhx2DfGYwZwZV9eSF1sCzxp4vl7x0BE6SJz7lSHEbdvdBYrNwWE7cfuIqL/
         TqFT1P9KGum88DmLACvnteoJBjpI5OVVjVs5PIEF9FA85TaMet0ljt2dm7iY0c9AflGC
         i4apmowffrD5yFtIyDqYhz6gmsKLm1JSAFVsk+ssPsCT76vOFBViQtzCFv9IzWUSut/9
         PLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511332; x=1692116132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtJtQQGDLreKoq4GEc3nJUPXs81XhTcTJsIrwxyT11s=;
        b=V6rhpnNv6FtDX34DtQRJTeugBXsS4lbj+v0P1prDkvByvtN7e6NRB9S8rOhetkOFVa
         AaOq2OaxTKTTHoQvYrdU8O0Yf+9Zy/prKX5THTY1cQde+9V+7+syL2wiSUBkiEWtuupl
         dTwZpoiaJrCDq2ZLssXhOBYXJUP6bPsZLBCbyFVIHM/bs7y27nmYurGT38/6ojk5gjO/
         eVTOTnt+W0ntfspoHqDLmyImzFtF29OiXbVZXFW/yb3Aeu6sqQyP0CP4Xn4xVPGkE4uM
         hGttWBBuYsgt16ztRfqBY8en76roSvI1X5tETEUiQRIs1fMwaClNgmtTvAif2mMaahHe
         lilA==
X-Gm-Message-State: AOJu0YwT6NUmfRXOtAxxuExx46ZuYRxYE9BulJAsxNkWm32SbB/gxG9k
        W/HdaBNRZ4fD0FBXHicdRPXCT1gCECw=
X-Google-Smtp-Source: AGHT+IG4txtV+6uc+oKF7CSQYQrKbqcJE3xU2dySXADEt+XujAyR+d+nq4ZhFg4L/8/3n+EKVUl8bqf3zUk=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:98a1:340:cd3f:85e0])
 (user=nogikh job=sendgmr) by 2002:a05:6902:4a7:b0:d11:3c58:2068 with SMTP id
 r7-20020a05690204a700b00d113c582068mr72309ybs.2.1691505300509; Tue, 08 Aug
 2023 07:35:00 -0700 (PDT)
Date:   Tue,  8 Aug 2023 16:34:57 +0200
In-Reply-To: <0000000000004a33ca0601500f33@google.com>
Mime-Version: 1.0
References: <0000000000004a33ca0601500f33@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808143457.3503251-1-nogikh@google.com>
Subject: Re: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From:   Aleksandr Nogikh <nogikh@google.com>
To:     syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com
Cc:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, dvyukov@google.com,
        ilias.apalodimas@linaro.org, joabreu@synopsys.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, nogikh@google.com,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:

#syz fix: can: j1939: transport: make sure the aborted session will be deactivated only once
