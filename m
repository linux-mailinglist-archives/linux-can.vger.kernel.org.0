Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38B43262B3
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 13:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZM17 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 07:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBZM15 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 07:27:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892E8C061574
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 04:27:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g11so3555904wmh.1
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 04:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oVfdHU7r0OSGiRuzFifgdGL9zdk9tzIdacx5Stxkr20=;
        b=dvDUB2Am7pNXFC+LueIlVj5CbJU6W2FmlevSs3WMN7dRWeoWTtMC0MHflvVoqwVauV
         AYRb0oDvVRifK8JmAXWIVMPArousHRw3WbmdirWA3OnstFX1JQ1Hzbr0nravPLLZRfGo
         Z4ubV+YUvO1Gf+7Q+PrTU4HCoRXrpFqeNKm5G0AS+y6Q2O9vptWJjFhbs2UoCXahhv0L
         4VUQuk8GupGiKlzyKE0IOrVSxdzoqqjyAZbr548iVwMsMlSWF7EK0ckEzPWBy72YqAKg
         Fp/NjZgaYUlC/WVmaUHno1bjuKXNxw9memo46LrNVzOXChauOBckW12wMOnXDg+RuB9a
         BQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oVfdHU7r0OSGiRuzFifgdGL9zdk9tzIdacx5Stxkr20=;
        b=aFwnMkoMAgrdPd+9Cpz1SmccJZtETH147jmFvWOiG63EI0fj+ivmfQbx7TtygPaSGf
         JokwY3J+Tp5qX4xrAPFQ8N6cMAjGbi9+H22ZkUsPKH8kyePfelclOUjPSfarxbqZkqJW
         //BReMjbNU9+YhEYz+xTg9d9ct3/OnpAJ3StvZ+GcyKfHkzp7SiL+xEepFJ2FAGNt/87
         MI3FWpifYmVzzX+2IViCInxHoOjqOeGne+b7ePVvUPzxbMQnTq0MHINF3zv4iyT++dP+
         Uvt5jYYMRvUdtcddWLz83/vhrsL4miSjz0ctUzVv/PDHytMt5xaeheDDAtL07+4WGOda
         tFLw==
X-Gm-Message-State: AOAM531XQABVOUwqiJizX75RJy2JEnrDavvnKimCuPUNCFVcG1MGJuoN
        Rm9SYhJscmVlUd+AazO61cQB4ydnvLpBUQ==
X-Google-Smtp-Source: ABdhPJxYEj9m4X5rcblFYHYi6XDjbVCF/DSc29Pr3tb9pFHGHGldLW06n5JOV8O1pTnBtTND8IkZEw==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr2720738wmj.122.1614342436298;
        Fri, 26 Feb 2021 04:27:16 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id f8sm11774574wml.20.2021.02.26.04.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 04:27:16 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:27:14 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226122714.os5sbvyujavrubym@bigthink>
References: <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com>
 <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
 <CAALJrqj=QC1to9ja0CeL76JxVF1iwjsW7YJHs18VbXea=PvBGg@mail.gmail.com>
 <c47647cd-01c1-a924-263d-72c84b36b2e0@pengutronix.de>
 <CAALJrqiAFR7bacR3eB40OU0fbM1QOc-xnvDtts5tDh5cE+3rrw@mail.gmail.com>
 <20210216102835.v5goqyksqsu6h6xr@hardanger.blackshift.org>
 <CAALJrqiVdmLQr7q2ijbWq70RD6PTD8PtVX_zmLW9=uNdc57WqA@mail.gmail.com>
 <20210216111930.pcg4e7cildzuri6d@hardanger.blackshift.org>
 <CAALJrqjGKPo+5B_qBX1b0hAheiaZk4so85OrjQT=1d51Vj8a=w@mail.gmail.com>
 <20210216123235.i63toczore5vfftp@hardanger.blackshift.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216123235.i63toczore5vfftp@hardanger.blackshift.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Feb 16, 2021 at 01:32:35PM +0100, Marc Kleine-Budde wrote:
> If the number of blank frames equals the number of missing frames, then
> have a look where the message RAM is initialized:

This is the case, but it occurred over a matter of seconds (the frames
were only being sent about twice a second). I've finally got some time
to investigate, so I'll try to find out what's going on.

>     https://elixir.bootlin.com/linux/latest/source/drivers/net/can/m_can/tcan4x5x.c#L335
> 
> Oh! This doesn't look right :(
> 
> I think it's a bad idea to first bring the chip into normal mode and
> then initialize the RAM.

I'm unsure whether this caused it, but needless to say, this is bad in
any case!

--
Regards,

Torin Cooper-Bennun
Software Engineer  | maxiluxsystems.com

