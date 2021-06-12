Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F563A4F74
	for <lists+linux-can@lfdr.de>; Sat, 12 Jun 2021 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhFLPMg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 12 Jun 2021 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLPMe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 12 Jun 2021 11:12:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208EDC061574
        for <linux-can@vger.kernel.org>; Sat, 12 Jun 2021 08:10:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m21so13233652lfg.13
        for <linux-can@vger.kernel.org>; Sat, 12 Jun 2021 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykPI4HH0SC/VWY27HGZ1a2z7D4uLGivlFbMyMdOdpbA=;
        b=duAckLmaN9hDm6gXQfSxZAwykPNXif6rUpVNbPDLz75pEYRggX5dVG36F/89GMCAQx
         W363fjT6nfMnjD/2bFUm26cK1erVDRSdBOUqr0wMHo/xbJFdSOQV5QrLKKdczjoCPv65
         CqJGhT/zW6wWuXFf5u4AXZMmBrknGM2wMVwV1WtPqV9UcHj5R2ye2+4QkhuanGrccRbq
         eT4LxRddcmCfQkDjuZugTy5dbnrR727LqCBqwPzYTRWKl9rh1pSaHyPk/WQDeSoRRlAx
         dniaOSmKqYS9wkE8ie2l8AXX29pDMntDhkpWmhIT0jxaOimRCio/qXFZS1MRX5aJmN8i
         219g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykPI4HH0SC/VWY27HGZ1a2z7D4uLGivlFbMyMdOdpbA=;
        b=q6jdkOU/r9YUgBtdjGU5Ppnyg4OrrthtjfslO2DjrHAAzZvcJQVxDN3mNoM3r74tQT
         NuvWHDiZCZni7gEJqr4IW8DV3cjZfhhToKN3EgbqLc0H5jjLqsYOkBmhpGwY3TTt/uD7
         DRieXM/LvTpdZM455MohmI5okhi+Y7a/oJkuTa7RBmkkH1A0Qr2XqgQyEiInSv/Q6G9o
         l5TwTBbzT2mKu2hD+ay1OLLdq3ZJx669Kfl0oJH9SxIwORV4SfLxh6Rf7dfMSkm1DLka
         8B0a46io/vQeobcKyIMIH5GCN5Dpo7gFEb84JNEk1/kYXO9jbuFJvEwJVnif4eOZ7ioa
         FbsA==
X-Gm-Message-State: AOAM533nolxe4/IGJmCzceQICmjHuF5pkHr6VnpAi5KlQkVMSLQrPhGZ
        q7PCmnDUfo6e31X+LU3ISHCw7HDv6U3496+JgWM=
X-Google-Smtp-Source: ABdhPJzYw7osmdVTtW/yuQeHJRbUodNUNt06qBA/Ebf28CUKZwb6bPlQQon4oXwtF4flj4bWHac9UhKkkZDHIYNIEfU=
X-Received: by 2002:ac2:4d25:: with SMTP id h5mr5381412lfk.583.1623510630218;
 Sat, 12 Jun 2021 08:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5CwS-cO3W148YHVYFwcL3QC8oFJfeQBb+WN=QgEPU7AsQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CwS-cO3W148YHVYFwcL3QC8oFJfeQBb+WN=QgEPU7AsQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 12 Jun 2021 12:10:19 -0300
Message-ID: <CAOMZO5D3suvPzaMq3Fx9LKDC9mzb-0w6i3EbQum-ozczdY-EPQ@mail.gmail.com>
Subject: Re: Testing two MCP2518FD's on i.MX8MM
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        dev.kurt@vandijck-laurijssen.be
Cc:     linux-can@vger.kernel.org, kernel@martin.sperl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

[Sorry, resending. Sent HTML content by mistake]

On Sat, Jun 12, 2021 at 12:07 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi,
>
> I am trying to run CAN stress tests on an i.MX8MM-based board that has two mcp2518fd chips.
> I am using linux-next 20210607 and this is the ecspi dts:
> https://pastebin.com/raw/YVvuqAAc
>
> Then I launch the test script:
> ./cantest start
>
> This is the script content:
> https://pastebin.com/raw/hc8gKgUf
>
> The problem is that RX FIFO overflow happens:
>
> [  128.559485] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
> [  128.573478] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
> [  128.584787] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
>
> and also cansequence errors:
> # 2020-02-09 01:41:15:368 sequence CNT: 2779938, RX:      8    expected:  34    missing:  230    skt overfl d:    0 a:    0    delta: 230    incident: 6    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 136
> 2020-02-09 01:41:15:368 sequence CNT:      9, RX:     34    expected:   9    missing:   25    skt overfl d:   [  899.794388] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
>  0 a:    0    delta:  25    incident: 7    seq_wrap RX: 10860   [  899.804780] mcp251xfd spi0.0 can0: RX-0: FIFO overflow.
>   sequ_wrap_expected: 10860   overall lost: 161
> 2020-02-09 01:41:15:370 sequence CNT:     40, RX:      9    expected:  40    missing:  225    skt overfl d:    0 a:    0    delta: 225    incident: 8    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 130
> 2020-02-09 01:41:15:392 sequence CNT:    137, RX:    105    expected: 137    missing:  224    skt overfl d:    0 a:    0    delta: 224    incident: 9    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 98
> 2020-02-09 01:41:15:396 sequence CNT:    137, RX:    145    expected: 137    missing:    8    skt overfl d:    0 a:    0    delta:   8    incident: 10    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 106
> 2020-02-09 01:41:15:403 sequence CNT:    160, ERRORFRAME 20000004   00 01 00 00 00 00 00 00
> 2020-02-09 01:41:15:414 sequence CNT:    192, ERRORFRAME 20000004   00 01 00 00 00 00 00 00
> 2020-02-09 01:41:15:414 sequence CNT:    192, RX:    210    expected: 192    missing:   18    skt overfl d:    0 a:    0    delta:  18    incident: 11    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 124
> 2020-02-09 01:41:15:416 sequence CNT:    220, RX:    222    expected: 220    missing:    2    skt overfl d:    0 a:    0    delta:   2    incident: 12    seq_wrap RX: 10860     sequ_wrap_expected: 10860   overall lost: 126
>
> I have applied this series to get SPI DMA to work on i.MX8MM:
> https://patches.linaro.org/cover/417924/
>
> I have also tried SPI PIO mode instead of DMA, but it does not help.
>
> Any ideas of what can be done to improve this?
>
> Thanks!
>
> Fabio Estevam
