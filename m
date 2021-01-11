Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7DF2F1295
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 13:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhAKMwE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 07:52:04 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:33172 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhAKMwE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 07:52:04 -0500
Received: by mail-yb1-f171.google.com with SMTP id o144so16801679ybc.0
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 04:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAIqFUY4VpwOzBRI3NDCjGOL5OIp4RY9bxmtm/CGCq0=;
        b=RhvWN8XwtpADsw4zGGvB6tEvt1/RAR1nl2OuAYLY6+kYuymlZfhrZq2+eHfe9ybHdI
         c9fRgA4YW0ZExH0zfsk/mDo48FuzuUMniXtyhCjJSu31bqx0Hgjvpdngz3wj44vmmuV4
         GTXLOzceg3XhMxYpQXh5asdMHkilonlJk2uyLo7fqmrAlu5vSX42R7HB14GQMqMtTFR0
         n501d22VgkaUS96riMGACvRuhr/fwwOvd7VtlGtDspY+u7AlFU3wU3eBFXQknRpr3P5Y
         ih66+zmHB/xe02LJsMey/9q+1Oe83LQv077tRYSgeVE3dByzI9s7jhWgdmk+Ut5L+TFM
         Gi8Q==
X-Gm-Message-State: AOAM532VWaTXR82xakoJN2L2/BmO369TCjfJkU3Ox52NqkU66TO/lYK/
        WIr2bLimmrvhNV8HN3HBff1bkv09FLlbpLFNK0RHOZ78lnnzDQ==
X-Google-Smtp-Source: ABdhPJxB2pug+89WVxnH6ltUSMfdGEeT0vjk50FMUb4Tdq8EiPcmkYQl1z9qw2rVYX+lhecQf0IPJbKrPl4L3hWXEa4=
X-Received: by 2002:a25:5583:: with SMTP id j125mr20508104ybb.307.1610369482828;
 Mon, 11 Jan 2021 04:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20210111104529.657057-1-mkl@pengutronix.de> <20210111104529.657057-6-mkl@pengutronix.de>
In-Reply-To: <20210111104529.657057-6-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 11 Jan 2021 21:51:11 +0900
Message-ID: <CAMZ6RqK=KKskgZ3cXEEzYFGmN8U0vGMt0rGM-5KMS2RH4cgEPQ@mail.gmail.com>
Subject: Re: [net-next v2 05/15] can: dev: move skb related into seperate file
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 11 Jan 2021 at 19:45, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> This patch moves the skb related code of the CAN device infrastructure into a
> separate file.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/dev.c | 213 ------------------------------------
>  drivers/net/can/dev/skb.c | 220 ++++++++++++++++++++++++++++++++++++++
>  include/linux/can/dev.h   |  76 -------------
>  include/linux/can/skb.h   |  77 +++++++++++++
>  4 files changed, 297 insertions(+), 289 deletions(-)
>  create mode 100644 drivers/net/can/dev/skb.c
>
> [...]

Sorry but the changes on drivers/net/can/dev/Makefile are still
missing for the skb patch (however, it is now OK for the
netlink).

diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index 5c647951e06d..2c38bd532157 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -5,5 +5,6 @@ can-dev-y                       += bittiming.o
 can-dev-y                      += dev.o
 can-dev-y                      += length.o
 can-dev-y                      += rx-offload.o
+can-dev-y                      += skb.o

 can-dev-$(CONFIG_CAN_LEDS)     += led.o


Yours sincerely,
Vincent
