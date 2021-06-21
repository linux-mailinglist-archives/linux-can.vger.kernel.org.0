Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066CA3AE9BD
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFUNJt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhFUNJt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 09:09:49 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A6C061574
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 06:07:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a21so20141929ljj.1
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UyPxp0v8uPqJluhDVjnbsvpnwwAHrAcHqt9QJm04lc=;
        b=GLnC7aWUIEdauH1HwOlQFdPCEUdx2RTSNC0fdXVw5UrTZObhlO2IsiaaUGOaRqBIYO
         JAHcJdgCg++RUEktHXVB0ERWK17LfqWbDy2G2yolSgzJbGsC61KAq4p0I0tFdnaH1d6K
         NM1Wkhcw0TgePKOIObpNsdkHwOPrZUA6v3tC1xLMXdFA52qxUQwlytm6giv7TkGb8cQL
         PRD54tuPwUjZO9wRyZy1/oJeu0zmwDhenNWakYpkAnmUpNi7M0RW0ARcsY+taVMyeqv3
         eZUFpr2qlMCgYUiBVFPslRT5BbmQyKOvlzFgd6nTaHJwBsk33Aj4FCp2Br61ebwBqLhX
         XYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UyPxp0v8uPqJluhDVjnbsvpnwwAHrAcHqt9QJm04lc=;
        b=m9q6tiHAcdFcvyIQixureT4Y7R88KV74KoAsEfa2d7nYnTbvRrIPRufLoBZgdVLcf6
         ckeJi7MgNbHiMYRaz/PUVDtjGM4yayHjs9Ngv5D86Stj0g/n8kis5fG/fGVilg8iRW7H
         /Vtm36hMl4k7WiuqDNgXWNELDvvu+BiZMP91sLgQTVrGhfcsVMRVt8Qcf/pI7/OkB4OW
         3bXqEEcWgUb5Mwzs3rO8fcCc4Tmf78psmPiEZngmQbTynu89AVkRVMsxN1ZmC4INLakf
         ZInglsY1pBGMMNVDKRSuuO4/tcuJolpoNlxe1egpEVFgCXSFIvb9l49iVgmO1Yb+ihbB
         pd0A==
X-Gm-Message-State: AOAM531mX5PbSYhIucpURLqJhCsjgz0sXLXwvM7kxrD5Fll5voTIYi+c
        CIeYxWQY53rWMRSZLVBKa6JpJfHl2flWrCZBlLPx8+uN653sbg==
X-Google-Smtp-Source: ABdhPJx5PiIziHM196guhmlYttpzT8e3M9jZz2+CBmgIyveTHzZLIcZrEyFVlvlce3DSN6TtbXZYvy2MdVBEWtF/i/4=
X-Received: by 2002:a05:651c:54f:: with SMTP id q15mr15782579ljp.347.1624280853248;
 Mon, 21 Jun 2021 06:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5CwS-cO3W148YHVYFwcL3QC8oFJfeQBb+WN=QgEPU7AsQ@mail.gmail.com>
 <CAOMZO5D3suvPzaMq3Fx9LKDC9mzb-0w6i3EbQum-ozczdY-EPQ@mail.gmail.com>
 <20210615071557.o7fjkleuk777otvm@pengutronix.de> <CAOMZO5AMP537Qz1MAb-D_27C=WH-5Cf602hichxty95A6db9-A@mail.gmail.com>
 <20210621123704.yc7ohwbuedofoq53@pengutronix.de>
In-Reply-To: <20210621123704.yc7ohwbuedofoq53@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Jun 2021 10:07:22 -0300
Message-ID: <CAOMZO5BgUHHsT_abpPgOdgVXNSrDApouhtWydvS9soYH65PJww@mail.gmail.com>
Subject: Re: Testing two MCP2518FD's on i.MX8MM
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Jun 21, 2021 at 9:37 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> Can you test if
> https://lore.kernel.org/r/20210621123436.2897023-1-mkl@pengutronix.de
> fixes your problem? We still have to check if lockdep complains...

I tested your series and I don't see the initial RCU errors after
launching the application, but
now it causes a storm of cansequence errors:

root@verdin-imx8mm:~# ./cantest.sh start
root@verdin-imx8mm:~# interface = can1, family = 29, type = 3, proto = 1
interface = can1, family = 29, type = 3, proto = 1
interface = can0, family = 29, type = 3, proto = 1
interface = can0, family = 29, type = 3, proto = 1
2020-02-12 19:36:05:161 sequence CNT:   1304, RX:     39    expected:
24    missing:   15    skt overfl d:    0 a:    0    delta:  15
incident: 1    seq_wrap RX: 5     sequ_wrap_expected: 5   overall
lost: 15
2020-02-12 19:36:05:406 sequence CNT:   3015, RX:    230    expected:
199    missing:   31    skt overfl d:    0 a:    0    delta:  31
incident: 1    seq_wrap RX: 11     sequ_wrap_expected: 11   overall
lost: 31
2020-02-12 19:36:05:455 sequence CNT:    742, RX:    238    expected:
230    missing:    8    skt overfl d:    0 a:    0    delta:   8
incident: 2    seq_wrap RX: 7     sequ_wrap_expected: 7   overall
lost: 23
2020-02-12 19:36:05:730 sequence CNT:   1287, RX:      8    expected:
 7    missing:    1    skt overfl d:    0 a:    0    delta:   1
incident: 3    seq_wrap RX: 12     sequ_wrap_expected: 12   overall
lost: 24
2020-02-12 19:36:05:746 sequence CNT:    991, RX:    228    expected:
223    missing:    5    skt overfl d:    0 a:    0    delta:   5
incident: 4    seq_wrap RX: 15     sequ_wrap_expected: 15   overall
lost: 29
....

For mcp2518fd usage with imx8mm: would you recommend SPI in PIO or DMA mode?
Looking at your imx6dl devicetree it seems you use DMA.

Thanks
