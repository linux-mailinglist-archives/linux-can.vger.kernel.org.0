Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE13D57BB
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 12:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhGZKDn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 06:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhGZKDm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 06:03:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B7C061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 03:44:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d1so3777993pll.1
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARXJtpM8ive0ddkC8WbiasF1alQsNr8ci1wJ8QN+308=;
        b=CL2jA4zx0bo3T9hwLioPqCMFv+RKmmwl3p/cg9+0wOodf9ohzEg2xxmHTTIxW6krPW
         V4eg79/hyZ0dhZM2jGNGyG5m4bS3ijzJI/9lpmHse0VRYEfa/ZJ5+cGQ17gFKoLwUAH3
         /CEZyX5Makp+bXvJykqvmIvrKKHM6a7hgDAdGz1TfNAqaixdhXPxGny83k33xbzvR2UL
         sOxN49WTWKHUR364jlZVBFfrgtAyhvMdRYQDM1m4FgGs1esDf9p7l199oQJiE88Ub/vp
         N6FunxX3KDykAQknGEOxzqPDWxRQsqT3Am6lT2RFQXPUdEKUkc64oZuzKPnFI1fhPgxS
         ofow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARXJtpM8ive0ddkC8WbiasF1alQsNr8ci1wJ8QN+308=;
        b=rkk5/3v5nJ0KiZ5Ybv1zyA1JPaVyy3HCq7ySP2jOMrPfmVbHvlDfBuLb415j5OcTdO
         TmyKltorVvoztQCYfedDT0x7mDz49CqSdN/Htbs2VnY+ncccKv1sErjWy+Fo8D1k8l6M
         j85eKJg6YOm8wfDy5pISJ5Eqzr5VWV7wkye3sIAUOEh5tOIr+Io0hDN56SWROY6dGutw
         bO9w6dK5+Wodn6KjG8gjUr5fVdkStzRvIZYFa3jwfXnJHCCKRuHIOfDo8JJ11mmBEbSJ
         Ls1zW0MlkqFF+3rskVrdWQr6HoEWk+RAvzy8ETg5tH8JHMx0ob9HsBbw+hGtFxCr+1t2
         Vang==
X-Gm-Message-State: AOAM533nTRQyk410dnPkHflLDmUosv1yOOVZlkp5bNiDrOKZmkqA0rXg
        7iCTj+XIwCgcmjH/qwa4w27zxDTP3qJMnCw7diXgVg==
X-Google-Smtp-Source: ABdhPJzhUHfHbCLSXGxoL/jAslcHHSte338xbfc5xb3VnjAJrZGS865dhP1/m2IdMBSeOaHfc1ctaWo46aUT4xIVX90=
X-Received: by 2002:a17:903:22c7:b029:12a:efc6:374d with SMTP id
 y7-20020a17090322c7b029012aefc6374dmr13962180plg.71.1627296250653; Mon, 26
 Jul 2021 03:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com> <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
 <20210725162720.74fu6qny6dqdc625@pengutronix.de> <CAELBRWKqs_XndF46Ucw9g0Y0n2q9qz-iO+CHyDvdJGMt37OuwQ@mail.gmail.com>
 <20210726093108.4uqfrvoiu5d2s4br@pengutronix.de> <20210726093448.glt3uikxvvryqlbx@pengutronix.de>
In-Reply-To: <20210726093448.glt3uikxvvryqlbx@pengutronix.de>
From:   Yasushi SHOJI <yashi@spacecubics.com>
Date:   Mon, 26 Jul 2021 19:43:59 +0900
Message-ID: <CAGLTpn+bRbRgmpKEV7oGu0eOL8RUf7shgZctm7yU68j6u=bUEQ@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Jul 26, 2021 at 6:34 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> BTW: is this the device we're talking about?
>
> https://www.microchip.com/Developmenttools/ProductDetails/APGDT002

Yes, that's what I have.  It's about $200 USD.
-- 
              yashi
