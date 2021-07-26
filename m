Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF13D57C8
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhGZKK7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhGZKK7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 06:10:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DAC061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 03:51:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nb11so15795432ejc.4
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RHbm+2AUNLRwxkJWYjd+0VTCq8brK3R93haksUsa+I=;
        b=ZVqk+HwhQHwzVbVBH4PPsqo9iTlRzXKBxdlRsPdwHSsLTAgw/IYJSEh6bQDdFIKHUc
         tF99MAUSTlZbSBeBdRr77nxzgQnOfwBdFE/MvDhlFKWIc2+D49S0rGrClRQnhi9i4lhZ
         +lMP36knSi/YnvpVFxJWXYk1ROGs+Q3fHYjLM9Uy9R+vT/AxcMBUcdWOzAs1ZeAzLI1X
         s5T3aJ8uOEZRJcWCrxtE3AggRvSbDfCBDngChqBZZyuuHVgAKKSST2DcE9ePrI9Oxq7h
         3QREvMZP5NCZrOIdPOaCs9nAMxVD2dk+3Zf8uL4swxao0TbpuuyfXv76TW37HOmHk2Tg
         FMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RHbm+2AUNLRwxkJWYjd+0VTCq8brK3R93haksUsa+I=;
        b=F1DaX5rujpIzBhVhRtMKHeo44Xay+X18F2EKs0juEXtD50n4qUBbG0O9bDKwUxEgyC
         AG4FhFsoImt2Pr+IsG6FioU9c8w+9XPkIwKT2ctK0e37UockqGTRE3jTtH0P+vTBNqXj
         5/YErib6qDZDTvFa1SGDiFu9khJVjPp8NPX9rGuB8xOk2RcB5UXSBtsIvj/HOOo76jHl
         kT4fGoeTZh5uB3Aw7ueuIXHYTfBLDi73+dtOFZAaxbtRD87e/HIGrICxJzSazJxrfGwl
         7BNcL83fyYCi9wLHKNBK4hbzeW77AxLGrzveo3TEPhSE0VSf1khYJwGB48ZsLiJFKCRA
         nQpg==
X-Gm-Message-State: AOAM53081vLv1ewKPfBMENU+yAhEdXArrUSnXHyoX/YGCycWH5r2mk19
        l4nMoaK16GVEzgDcM8kEqthQyLAqkWDKlcdIoxU=
X-Google-Smtp-Source: ABdhPJwO9h5o5gl51ekGvXqMOMSj+mZsE1U+BEdSsKFHAORCd4NNg0jjbzAbuu6fs+XxNCScK6U/aJk02k8mFkyPxBE=
X-Received: by 2002:a17:907:2721:: with SMTP id d1mr16270471ejl.170.1627296685438;
 Mon, 26 Jul 2021 03:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210726092945.1017567-1-mkl@pengutronix.de> <20210726093646.rahtialrojy2dcjb@pengutronix.de>
In-Reply-To: <20210726093646.rahtialrojy2dcjb@pengutronix.de>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Mon, 26 Jul 2021 19:51:14 +0900
Message-ID: <CAELBRWL2rNw6GkbuH6iL8snBnSNm3WehdaCS=nKd9==0-VTnvQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Yasushi SHOJI as reviewer for the
 Microchip CAN BUS Analyzer Tool driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Yasushi SHOJI <yashi@spacecubics.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon, Jul 26, 2021 at 6:36 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 26.07.2021 11:29:45, Marc Kleine-Budde wrote:
> > This patch adds Yasushi SHOJI as a reviewer for the Microchip CAN BUS
> > Analyzer Tool driver.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 58afeb12d3b3..8a002b48fbdb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11327,6 +11327,12 @@ W:   https://linuxtv.org
> >  T:   git git://linuxtv.org/media_tree.git
> >  F:   drivers/media/radio/radio-maxiradio*
> >
> > +MCAB MICROCHIP CAN BUS ANALYZER TOOL DRIVER
> > +R:   Yasushi SHOJI <yasushi.shoji@gmail.com>
>
> Yasushi, I just noticed you're using more than one email address, which
> one should be added here?

Please use yashi@spacecubics.com.

Thanks,
-- 
                yashi
