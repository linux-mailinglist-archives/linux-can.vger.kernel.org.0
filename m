Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59F631C9F1
	for <lists+linux-can@lfdr.de>; Tue, 16 Feb 2021 12:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhBPLkx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Feb 2021 06:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBPLjK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Feb 2021 06:39:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B74C06174A
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 03:38:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v7so12464874wrr.12
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 03:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNFNS+U1GZM9tMVWSGoy3aUx29HmWOqw4ECSHZLe2rc=;
        b=GQXjhvO9yO0MAIKt/xvv043lB0DV1xqaA7Rr6BhEUN1YYNoZsRTk1QPml/KogEXeMJ
         1Wc7gKVU9152ikhsY2B5M38NXse0rYrONom15p8pPnb/RTC2MztSuJPg11XiPND306Rq
         6MYggrxdxHsXUYAmQZvdoor8Q1nN9lkrY3bf/1MyesYWigcZszflYqJKYaqZaed9Tjas
         Ii4HXuGizYtDyL+GRgZwlRl1BoYC58g/TSMFpZknnAlHpEaoOUtEIx/kPHZG9shYKXke
         IVhG1F/EGycK/J8mBfZgp4zCIYYCmgrqxRSPSxlc4RgRKdmBKP/gK4Zhc0OjBJQfPQUk
         uLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNFNS+U1GZM9tMVWSGoy3aUx29HmWOqw4ECSHZLe2rc=;
        b=T8/Ztf3TGrVBZJ9eztuuXMaL2eU7MkOJ5bbwE4l6DtSfRaP4C+xSXyyXFYakzSlhuA
         qb1U+A2b1uNCcplijPYWVldhtg46npC7SeSjnoXdJXcs3pfD9aoYlOQq9TKnzJD3o8Qx
         KkFNtQIU25BRFoeVzDWB38xMTDGzO5NYuhlNoNskBJPucDKwZQ/PxaZYAHwR62t1vLU/
         dwjOHjpSnNAAarhkbgnSjoev3JLno/vT100CEsptZWOARHkscLF/A46xiaESmcxAZafT
         aW6TwaU3yhsClOHqi5lCSQmNyJ8Pq7BsBZWt4mT+dWFWxqK9t1eAxmE5ZNg9LdIdVx4t
         6WxA==
X-Gm-Message-State: AOAM530XCdx5rP9wdM8qqLh+msC8Vv/Rynclj+C5f7mZWiC0bOGzcGut
        oauHXbZ3OBg/mYR4M9bmIQRxZ+juW5/EmkaTabA6EDp3O3QOf0yR
X-Google-Smtp-Source: ABdhPJxv4HuJByd5pAQTiOf5LzXl/D4qKtYt177a+SXjdhv2zwJMhnokSktlaontxsDJohTJBhMi7yzqkYG4rC381LQ=
X-Received: by 2002:a5d:4cd0:: with SMTP id c16mr23517469wrt.84.1613475508746;
 Tue, 16 Feb 2021 03:38:28 -0800 (PST)
MIME-Version: 1.0
References: <602651f9.1c69fb81.302a5.647d@mx.google.com> <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com>
 <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
 <CAALJrqj=QC1to9ja0CeL76JxVF1iwjsW7YJHs18VbXea=PvBGg@mail.gmail.com>
 <c47647cd-01c1-a924-263d-72c84b36b2e0@pengutronix.de> <CAALJrqiAFR7bacR3eB40OU0fbM1QOc-xnvDtts5tDh5cE+3rrw@mail.gmail.com>
 <20210216102835.v5goqyksqsu6h6xr@hardanger.blackshift.org>
 <CAALJrqiVdmLQr7q2ijbWq70RD6PTD8PtVX_zmLW9=uNdc57WqA@mail.gmail.com> <20210216111930.pcg4e7cildzuri6d@hardanger.blackshift.org>
In-Reply-To: <20210216111930.pcg4e7cildzuri6d@hardanger.blackshift.org>
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
Date:   Tue, 16 Feb 2021 11:38:17 +0000
Message-ID: <CAALJrqjGKPo+5B_qBX1b0hAheiaZk4so85OrjQT=1d51Vj8a=w@mail.gmail.com>
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 16 Feb 2021 at 11:19, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Please keep the mailing list on Cc.

Agh! My bad.

> Where do you see these blank frames? On the sending rpi with candump? An
> on the bus (with a second system) you only see the full 8 byte long
> frames?

My apologies, I should have clarified. The Pi is receiving all these
frames. The sending node is sending the same frame every time (I'll
have it send increasing IDs from now on).

> Use "candump any,0~0,#FFFFFFFF -extA" to get RX/TX annotation.
> Use "cangen -Ii -L8 -D000102030405060708 -g100 can0" to get increasing
> CAN-IDs, so you can figure out if a CAN frame got lost.

Fab, thank you.

> Seems I have to add the TX path to the list of broken things...
>
> The mcp251xfd driver can be used as a template for the tcan4x5x driver.

I'll go ahead and compare with mcp251xfd and continue testing. I'll be
working towards getting this stable in the coming weeks.


-- 
Regards,

Torin Cooper-Bennun
www.maxiluxsystems.com | Software Engineer
