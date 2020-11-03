Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33E2A5815
	for <lists+linux-can@lfdr.de>; Tue,  3 Nov 2020 22:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgKCVsT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Nov 2020 16:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbgKCVsS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 16:48:18 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8E5C0613D1
        for <linux-can@vger.kernel.org>; Tue,  3 Nov 2020 13:48:17 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 9so19966089oir.5
        for <linux-can@vger.kernel.org>; Tue, 03 Nov 2020 13:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ODKRDsSMIPdBXu49kyOj33LiydR4dwOAg2L0ROOmCs=;
        b=yOJO0XcMZnUKbvikWLzPw+nP+XnhxkT4e/tHdmqMpqkq5QK7D4fkpWgvQIyjQB81DU
         QUtfezkwoPhzUGtGX8gur4DwNCkG7iK673E3NGQt5ONS90a9jVn0MJ/eT3ocludmxMF4
         M/zegHMqyA7WrNniw1VjJdxog3Az1lRYqNAapiH9ShLkxs/2XCcGwIYjZSXJj0LgW9EG
         KDGAmsw6/Ms/UNgJwB5HWhSYP+OaoSO3LgQI68LEkTOv+RMRNBkmFxZf6DLHbb3xzvts
         JV7eb1T4nKRBiEDU6FO74gj4v/vy3lan4KgnMB9os597Uz0W5MsDV68p50GjyGxwFSQQ
         gGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ODKRDsSMIPdBXu49kyOj33LiydR4dwOAg2L0ROOmCs=;
        b=YqLEIomSB5f1WBedhH4/O4LOZm5IlO/xQhqP8THt2NLLS3mXoc9xfz6e7gB7eAeM2d
         3bllCTGbRXyv0ENEYNlcOyWaSnpbkVrKuPmuLCrhWsW38SoOALEiMcXg+3MibiMkMtNk
         2pfFQU26/uq22wu3wN6h5roe1037ZLOHWDAZL2f0B+0P9DDXzjPlqqDbj2ba5KcmL2gn
         wRC9KJt9UIIhvi3k8Tk289atb5pcnz115hgMhZUHRMAH7rvqMpdXAaOtUuCcoAQrwVqn
         +C+GGRPFPsViKSSEBR7OZrGOsDRwxulFmtrhMlWm3Q1xDkWtdZQjURUvFd1Q9pvIBhpQ
         vvag==
X-Gm-Message-State: AOAM533DgpJR/dvDxM5A74mj/3wI8pCiGFtTHifvIZVRxGc3JomAQ+P3
        4wnotKqEnBIZfqiIeikhtrxRJTkIk7Y/s3riVVPld3x50byvGMaO
X-Google-Smtp-Source: ABdhPJxUmeoESaK338zl3pjWw/2IAc1XpfKrWWgQ1yaDnyTu6W9zRoVAqmt31ewGdEdTj37NZVskKEdwzSi7wRFuqmc=
X-Received: by 2002:aca:b644:: with SMTP id g65mr747612oif.164.1604440096641;
 Tue, 03 Nov 2020 13:48:16 -0800 (PST)
MIME-Version: 1.0
References: <CAPgEAj75pUnhOrvQ5basubGfpMoijpBonOsv-Wio=WP55dmFNw@mail.gmail.com>
 <90e05b20-d863-49b8-670f-e74bca7537be@pengutronix.de>
In-Reply-To: <90e05b20-d863-49b8-670f-e74bca7537be@pengutronix.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Tue, 3 Nov 2020 22:48:25 +0100
Message-ID: <CAPgEAj4DoWU7w7-NdCB=XQdn3zmtS3Wtr4uMr-zG_Xk0-PNg=g@mail.gmail.com>
Subject: Re: mcp251xfd: rx-int setting
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 3, 2020 at 9:03 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 11/2/20 11:59 PM, Drew Fustini wrote:
> > I modified devm_gpiod_get_optional() in mcp251xfd_probe() to look for
> > "rx-int" instead of "microchip,rx-int".  Is there a reason it was
> > looking for "microchip,rx-int"?
>
> The DT property was changed why upstreaming the driver. So the overlay has to be
> patched, not the code.
>
> > I am using branch v5.4-rpi/mcp251xfd-20201022-54 at commit 9e02abd4fe59.
>
> I'll update the overlay.
>
> > While it does now see the property, it does run into this issue:
> > [    6.830900] mcp251xfd spi0.0 (unnamed net_device) (uninitialized):
> > RX_INT active after softreset, disabling RX_INT support.
> >
> > Any suggestions as to how to troubleshoot this?
>
> The waveshare board doesn't have the INT1 connected. So chose a free GPIO on you
> rpi, add this as the parameter to the overlay and connect the GPIO to 3v3.
>
> Or, if you want to solder, connect the INT1 pin of one of the mcp2517fd with a
> GPIO on the waveshare module.

Thanks, I used rx-int of 27 for spi1 and connected to 3v3.  The driver
successfully registered the rx-int setting:

[    6.983684] mcp251xfd spi0.0 can1: MCP2517FD rev0.0 (+RX_INT
+MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
r:17.00MHz e:0.00MHz) successfully initialized.

-Drew
