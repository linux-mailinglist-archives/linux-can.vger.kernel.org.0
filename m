Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554293729C7
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhEDL7p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhEDL7p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:59:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA682C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:58:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n205so4336697wmf.1
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3CUEjPuKCjwRuDy3UJoU7dnHPd4RcBlJ4pd49oLkpSo=;
        b=KlGqYkweaPj3NVaMYP25E7ong3zYsb8jDs6asWepisG4Sfat/GUM77lD8Q/ZJ7/4nA
         ecvMasyHrRBAwDZcXQm2VccqDvkern3gl0lt5q1GXQJaJp2K3SKr9GogZaigsthq0Kbo
         fMRtbnTMH1HfC6WXu3YuTKuAHSPYKl2pYLylTDUgVpRldazdn5IRiGRwjEEsC76jQh23
         MVS+6TX/M+g+72rXspY+rlP7MuHcIn3a2LL4mvLw/XUNe3s6dkhZkGjQ84ts+PvmopP6
         uhzPA5ZrpRTk2l9yPZ8ipzdqfjWCnhDbyBV/TQDgjW9a/HM0QbA4F94a4EKQmz/9vEwX
         g8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CUEjPuKCjwRuDy3UJoU7dnHPd4RcBlJ4pd49oLkpSo=;
        b=f0jFM+Q7KX0/svxFf11SOzkEGxeeVhLb7h5iVahHLku/tX05p+nqY5XBKsiir6LdFF
         rN4dnImnBTkVx7Vn3IXigpTdFBpJ/zDs1uu+Ogd1cJ5nQDt1sE25OEQCghRY1ygR0VeO
         FBIyn/TmDaqacAkAlq0LtxHNnnbhXT4YGga9hp7dR4CjbeC7lbpEHJ7xWf0gGSLbhJ9i
         lvvt7/etivTR6ix6tzBq8C6QxNKwFz5wIhEz6l+mPva/toF2tUzyXksPZvTTFSSDAn6m
         7tcOjQHMF2FOQE7Jd4hrFqxPhlX+f3aKv1/LI6rvL7wlJmRQaANlRf/TMEFsvRZcA8vJ
         Nv8w==
X-Gm-Message-State: AOAM53157fwFuDQY6f/m1kG8VojipuVtOuFgHTPBDP7a8FXMeYPJWyXe
        3kaLWPhiBnYQ40cBnqQrd0StGeQpyw7YMcGS
X-Google-Smtp-Source: ABdhPJzxzBDVxQnnpW7cRU6r3Qp0AFEW5mVvB660C8lesDSkBX4lIF6xZ/H/yA4Xt++IrRCYyFWyYQ==
X-Received: by 2002:a05:600c:322a:: with SMTP id r42mr15661161wmp.98.1620129529695;
        Tue, 04 May 2021 04:58:49 -0700 (PDT)
Received: from bigthink (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id q4sm16301413wrs.21.2021.05.04.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:58:49 -0700 (PDT)
Date:   Tue, 4 May 2021 12:58:47 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [REPOST PATCH 0/4] can: m_can: various regmask-related cleanup
Message-ID: <20210504115847.b3t6zbgxxd5gntct@bigthink>
References: <20210504114900.351170-1-torin@maxiluxsystems.com>
 <20210504115433.nz3q4fbr62hecnmj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504115433.nz3q4fbr62hecnmj@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, May 04, 2021 at 01:54:33PM +0200, Marc Kleine-Budde wrote:
> What's the base commit for this series?
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

Effective base is:

644022b1de9e - can: m_can: m_can_receive_skb(): add missing error handling to can_rx_offload_queue_sorted() call

(This series rebases onto can-next/testing without conflicts)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

