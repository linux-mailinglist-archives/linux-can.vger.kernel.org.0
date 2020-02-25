Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DF316F290
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2020 23:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBYWZx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Feb 2020 17:25:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33215 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYWZw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2020 17:25:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so1119273otk.0
        for <linux-can@vger.kernel.org>; Tue, 25 Feb 2020 14:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdH+yxbAhUB4UY/s7QjGS1gpAo5FXhyFRsa4xxUTp5A=;
        b=fQ/sKKht62Wl7N94VjMHNK/K4I/aKoxyhqQyngIB+7G6dmIF77e43Dhcx2NPFKf1Hl
         JMJ9P1uOpE99hvIkdE9+o7JvuwJKd0q4fJDVyZAXMd2hyBCVoiJEjpc+40AaARhYZ2P5
         k151SykV9p9yuPK61UxwkIViDIEs5Mx8DV8ObsNC7hejaLVsaHxxfWxHO0RoLJE9ls/0
         C0xPOQ///z1oz136gbT/dTZNmKrQ1iKKlnhOJF6sSViOR8d1eZFqksjhxbu9AlhTrOtz
         kxcqcwq5gnGaCCXKOtxHqh28GczNoMDba0jDWH+XWl9GFklYcKMrPZXVzfvec4CrB275
         DVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdH+yxbAhUB4UY/s7QjGS1gpAo5FXhyFRsa4xxUTp5A=;
        b=R661nPGZtmspOaQlnVu5asB45TTrCGRiXBcrz1h9DD/sp7KA/rPWTG0A22R92pITQI
         LUt5Yp7ziLDHK+zm4gCO7npxSFyvQpLIFdev2RDNRTkytrogWAnqviYxvKUt+hmNBaki
         DgbRfvCdr+QhGpHW5s0CqghQFWeI985FxV4DIZX19Mzh9GJ1PRMbeo2alxDZ7yRJRhV1
         BpKjfonS6ZxyBkBzDoid/QYWjFVEevTEqsFuR+TqNNGatRpVXVRCxJkA13b6ytITU81k
         5Pa7BQPYNnBgluMyWDUQH/KqOBY9KwoiTSHLZjvvQMcts74JWajirmsGQsijhcSOTT1N
         jiUQ==
X-Gm-Message-State: APjAAAWbq0tyjseZEx3Zvi0t64WvI6CWJrrWN70hvU9xJ3ho3qv59vru
        OtxVdEtvXd+7vn2Eq6SovKK16jz3hJNwm4r3Oh7e4g==
X-Google-Smtp-Source: APXvYqx2/YsTotylW/r2EQUH4xN/RZ5uHi/ZTmKKH3C1Ka03nm+cOU0HFAzZNbSQVAM/gv7aJ8sUW6vHA7/KZMqdduo=
X-Received: by 2002:a9d:7842:: with SMTP id c2mr591161otm.252.1582669552159;
 Tue, 25 Feb 2020 14:25:52 -0800 (PST)
MIME-Version: 1.0
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com> <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
In-Reply-To: <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 25 Feb 2020 14:25:40 -0800
Message-ID: <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        =?UTF-8?B?VGltbyBTY2hsw7zDn2xlcg==?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Feb 25, 2020 at 1:43 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 2/25/20 7:35 PM, Tim Harvey wrote:
> > Some SPI host controllers such as the Cavium Thunder do not support
> > full-duplex SPI. Using half-duplex transfers allows the driver to work
> > with those host controllers.
>
> There are several transfers left in the driver, where both rx_buf and
> tx_buf are set. How does your host controller driver know which one to
> handle?
>

Marc,

Your right... there is the mcp251x_hw_rx_frame() call that also uses
spi_rx_buf after a synchronous transfer (I didn't see any others).
I'll look at this again.

In general is it an ok approach to switch the driver to half-duplex
for this issue without the need of complicating things with a
module/dt param?

Regards,

Tim
