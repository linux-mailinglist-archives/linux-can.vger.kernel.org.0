Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A035B32C5A6
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359423AbhCDAX7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380742AbhCCN3m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 08:29:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AECC0611C3
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 05:27:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u187so5166585wmg.4
        for <linux-can@vger.kernel.org>; Wed, 03 Mar 2021 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xg/4klZsQ9wmjU9GwbsYsl+5QIiHUxWqtcuX9MplH4Y=;
        b=svEK9WHcNzhnb1aKJSzuc60jxOO1cEY/RQ8WIyIr3ptgteEZKp0Yf94E7NN/+xKvz3
         wcHu4ovpuqwHv34e/AGvI6QkDEgYBq20grJM7cVNlM4uq0X3BJIqz8kzYNsCjBOzUlDb
         PlcOEMxfceWMa42Tpkgrn4H8C9f+Trroxe8jTO6jz6EXKpcdNM6UCDiO+cYGfIsYMjdU
         tNKzqOergR7+ZgYY/H95DClvIy+nMpilr/HMkgC9Fzsq78lk4qwHA3EDAxWWfXgmujqj
         fwNBDKOBcoyEdhiAtz/6PTq593A3TmDOFRV9GBqqzn4ShTS/3BjZiH8tV/9JRvls+9NV
         f+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xg/4klZsQ9wmjU9GwbsYsl+5QIiHUxWqtcuX9MplH4Y=;
        b=dI3BawI6zGyxOGVlamycVQlcMVsmsKZGxSrhX+YcIt91gOxt7jZenq+JZNiT9W+jy4
         OW2fbQLXYIdwEA+ap3wYpQN6WyX5TyCa7bMLi/PCHqo/cB242sif7QdeGKYg6mOb1JMO
         MWKYdgmRNyu7OyjgkAtGQO8uEYa5DIwBNEUtVF1Oq9VH5itjQr+tS+4gq8uP/nzUFQoc
         vtRh2k+Zl92tRH5ObhE2K3u7TpNcTXr5kBh2Zpq0iDjqnAWQez2lWBxowctlKAuGMOvA
         EKy7mIThpAGOqgcDuQr3Om07QrSOiVplpqIEWwQ7qJpPR9QYj4BF96rPSiy5sSCp+XwC
         kWHA==
X-Gm-Message-State: AOAM530I7mS6QUpKxgBxu/HwLLCwJCriO+5Hzjg7/c3HrkOqwKQ5cFol
        +kIcRTBDpiQYeZN5qvvKkyRPr3tpQC9WWw==
X-Google-Smtp-Source: ABdhPJxds3B/+QR4y6D09D6r9fvtcvZGaIBFVmmGszS+tbRxkj8Mq0PUvIfCQz4B6+nSDtQLONclPQ==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr9282187wmc.85.1614778034812;
        Wed, 03 Mar 2021 05:27:14 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id z82sm5821311wmg.19.2021.03.03.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:27:13 -0800 (PST)
Date:   Wed, 3 Mar 2021 13:27:12 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: m_can_rx_handler(): fix RX in periphs being
 blocked by error handling
Message-ID: <20210303132712.a3sq2ljozqc52gyz@bigthink>
References: <20210303124950.3917746-1-torin@maxiluxsystems.com>
 <20210303125523.4tfd6ifwyugoygzh@pengutronix.de>
 <20210303130750.y2leqimmthzn2liy@bigthink>
 <20210303131122.nem3z2iq4ts3iirj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303131122.nem3z2iq4ts3iirj@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Mar 03, 2021 at 02:11:22PM +0100, Marc Kleine-Budde wrote:
> > I see, thanks. Forgive my ignorance, but how long should a threaded ISR
> > reasonably block for?
> 
> It's a IRQ thread, so it's subject to scheduling and priorities can be
> configured. The IRQ thread of the mcp251xfd driver runs until all IRQs
> are handled.
> 
> > Was there ever a good reason for the quota to be 1 here?
> 
> Don't know.

OK, thanks for the insight. I'll discard this patch and rework the
peripheral interrupt handling logic.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

