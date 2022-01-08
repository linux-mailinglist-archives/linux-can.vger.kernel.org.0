Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD24883B0
	for <lists+linux-can@lfdr.de>; Sat,  8 Jan 2022 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiAHNMq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Jan 2022 08:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiAHNMp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Jan 2022 08:12:45 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50540C061574
        for <linux-can@vger.kernel.org>; Sat,  8 Jan 2022 05:12:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o12so26045128lfk.1
        for <linux-can@vger.kernel.org>; Sat, 08 Jan 2022 05:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Zg8P7fGcgVyDhkiXiomY6QYxZqF7A8Xr9jIGsaRiAw=;
        b=Rq1tZYtn6sVUm4uesEbPdNQZFcy/XnM06033GvXtK7YtFJefFfjlTts4ZQbDBv2tUe
         mpDWRAtRJsJdLs40Q8cSqwE1tSpH8xoMDBtNrD5Vg6uw1UEVWD26mZVUJ1/yCoIIvgix
         WSUvfLLUQuGvgcki+W53Onq2JiX06+Ka+yg84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Zg8P7fGcgVyDhkiXiomY6QYxZqF7A8Xr9jIGsaRiAw=;
        b=KlLXUkJ/TPW4FtoPH9I5NRdOTtppCWb4d0ZOdp1bDIP+OS6oh4jm5wjhVSEGvjwh5L
         N0JjzJG240lJtTzmpr7NAITb+BbndDB/QrRpD9UpVWQtg267mQKZ8kEFFa3Uw5/tZbGn
         VBRjXLqwstI9FJwANkZ74zuxYvyHO7NbcIhAin7b7N/c24/x1dGCiwB4ILRBqulUrkB+
         wge1q3A4rR/1Mj1sLDFxmJpZAs5xBoDCsTftgWDHBhXd+fliweodcERpnv4h6akwtjhi
         vPjMOTTfsd6M8qoRdCOz5PYhnD0/vI+9PUie/D/sp9G7sHustT5BoJR7kOts7ujaxoFS
         OWjA==
X-Gm-Message-State: AOAM533PEUpoxA744v539Yy/i0xS5Gjh2p7M3YB4E9DWGFDMXsG8+erR
        Wrucp8KOJBeXzmZD0AaWA73sHcWvyBLTEztnSIrexjcV1Zg=
X-Google-Smtp-Source: ABdhPJzQCg5iwhPhBn16Ltp0vCo86ygMyL4sNd5xBg9kyaMhV6/FCmZ5xpZv1Xa1wrqoTLYx0LBDGp+ajkpSo5Jckj0=
X-Received: by 2002:ac2:5970:: with SMTP id h16mr56218240lfp.172.1641647558326;
 Sat, 08 Jan 2022 05:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20220107193105.1699523-1-mkl@pengutronix.de> <20220107193105.1699523-8-mkl@pengutronix.de>
In-Reply-To: <20220107193105.1699523-8-mkl@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Sat, 8 Jan 2022 14:12:27 +0100
Message-ID: <CABGWkvpKLc13vSDUDquSZeR+2t9tEenAduxtWeyLK4xpRdKKig@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] docs: networking: device drivers: can: add flexcan
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Fri, Jan 7, 2022 at 8:31 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> Add initial documentation for Flexcan driver.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../device_drivers/can/freescale/flexcan.rst  | 54 +++++++++++++++++++
>  .../networking/device_drivers/can/index.rst   |  2 +
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/networking/device_drivers/can/freescale/flexcan.rst
>
> diff --git a/Documentation/networking/device_drivers/can/freescale/flexcan.rst b/Documentation/networking/device_drivers/can/freescale/flexcan.rst
> new file mode 100644
> index 000000000000..8cc0359a8588
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/can/freescale/flexcan.rst
> @@ -0,0 +1,54 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +=============================
> +Flexcan CAN Controller driver
> +=============================
> +
> +Authors: Marc Kleine-Budde <mkl@pengutronix.de>,
> +Dario Binacchi <dario.binacchi@amarula.solutions.com>
> +
> +On/off RTR frames reception
> +===========================
> +
> +For most flexcan IP cores the driver supports 2 RX modes:
> +
> +- FIFO
> +- mailbox
> +
> +The older flexcan cores (integrated into the i.MX25, i.MX28, i.MX35
> +and i.MX53 SOCs) only reception of RTR frames if the controller is
> +configured for RX-FIFO mode.

only receive RTR frames

> +
> +The RX FIFO mode uses a hardware FIFO with a depth of 6 CAN frames,
> +while the mailbox mode uses a software FIFO with a depth of up to 62
> +CAN frames. With the help of the bigger buffer, the mailbox mode
> +performs better under high system load situations.
> +
> +As reception of RTR frames is part of the CAN standard, all flexcan
> +core come up in a mode where RTR reception is possible.

all flexcan cores

Thanks and regards,
Dario

> +
> +With the "rx-rtr" private flag the ability to receive RTR frames can
> +be waived at the expense of losing the ability to receive RTR
> +messages. This trade off is beneficial in certain use cases.
> +
> +"rx-rtr" on
> +  Receive RTR frames. (default)
> +
> +  The CAN controller can and will receive RTR frames.
> +
> +  On some IP cores the controller cannot receive RTR frames in the
> +  more performant "RX mailbox" mode and will use "RX FIFO" mode
> +  instead.
> +
> +"rx-rtr" off
> +
> +  Waive ability to receive RTR frames. (not supported on all IP cores)
> +
> +  This mode activates the "RX mailbox mode" for better performance, on
> +  some IP cores RTR frames cannot be received anymore.
> +
> +The setting can only be changed if the interface is down::
> +
> +    ip link set dev can0 down
> +    ethtool --set-priv-flags can0 rx-rtr {off|on}
> +    ip link set dev can0 up
> diff --git a/Documentation/networking/device_drivers/can/index.rst b/Documentation/networking/device_drivers/can/index.rst
> index 218276818968..58b6e0ad3030 100644
> --- a/Documentation/networking/device_drivers/can/index.rst
> +++ b/Documentation/networking/device_drivers/can/index.rst
> @@ -10,6 +10,8 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>
> +   freescale/flexcan
> +
>  .. only::  subproject and html
>
>     Indices
> --
> 2.34.1
>
>


-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
