Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01045536EF
	for <lists+linux-can@lfdr.de>; Tue, 21 Jun 2022 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352148AbiFUP5u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Jun 2022 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352261AbiFUP5h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2022 11:57:37 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7226E5;
        Tue, 21 Jun 2022 08:55:58 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 23so25199357ybe.8;
        Tue, 21 Jun 2022 08:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mlFBxCefqBg6G44Ir094I4j/4idwR3pS0t66Iw9bC8=;
        b=g8PbRYND5LTwMQTyHurHwIPHMvgt4Mb56cWSi9hlv2GzskxPhvB851dEh/LpcRDxBz
         wjatYVz9zqKhtKbk8FSW2PBTCM4SFHOl4AhJ9knSS73Dw3DWMKUAZH5r1MqyLFZHvtUE
         S4xgx0i7q+QaARYj0swWz4pPym33nB9nt5Ku9CfTqfAQki03n82hc6rwDCjVBQWn4Res
         IMzHqFFhaBlfMPIU6zZ4ZfiGpyRyHqGhBrS4c+E3nVqsymqF5A7J90ao05SH+T4W/inL
         Fi17+U+tTdoLKdwZfZyxsbgxR1NjtWzypSVkoXmo9h2ss3b9se8nbAfhjusEGg9oQs2y
         qtKg==
X-Gm-Message-State: AJIora8WjNQi3wLKRWxQfBaF4Q3xzuV/6jlL+XW975Z5fG0A1loAPUkb
        He7ay9nlvZl1FHTrtOQzJperxtZ25S2X0rgMjvk=
X-Google-Smtp-Source: AGRyM1uZvNc+tPoQCeHDkZP3/mX1OyfFtGAhwekXMHM7LOSahSOzjxKMoWk748hx51i4+zvRB/NaROm3yqO83oY7wXg=
X-Received: by 2002:a05:6902:242:b0:668:f7e9:b2f8 with SMTP id
 k2-20020a056902024200b00668f7e9b2f8mr14629702ybs.423.1655826957780; Tue, 21
 Jun 2022 08:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com> <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com> <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
In-Reply-To: <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 22 Jun 2022 00:55:46 +0900
Message-ID: <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
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

On Wed. 22 Jun 2022 at 00:13, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, Jun 21, 2022 at 11:59:16PM +0900, Vincent MAILHOL wrote:
> > I (probably wrongly) assumed that urb::transfer_buffer_length was the
> > allocated length and urb::actual_length was what was actually being
> > transferred. Right now, I am just confused. Seems that I need to study
> > a bit more and understand the real purpose of
> > urb::transfer_buffer_length because I still fail to understand in
> > which situation this can be different from the allocated length.
>
> urb->transfer_buffer_length is the amount of data that the driver wants
> to send or expects to receive.  urb->actual_length is the amount of data
> that was actually sent or actually received.
>
> Neither of these values has to be the same as the size of the buffer --
> but they better not be bigger!

Thanks. Now things are a bit clearer.
I guess that for the outcoming URB what I proposed made no sense. For
incoming URB, I guess that most of the drivers want to set
urb::transfer_buffer once for all with the allocated size and never
touch it again.

Maybe the patch only makes sense of the incoming URB. Would it make
sense to keep it but with an additional check to trigger a dmesg
warning if this is used on an outcoming endpoint and with additional
comment that the URB_FREE_COHERENT requires urb::transfer_buffer to be
the allocated size?

Yours sincerely,
Vincent Mailhol
