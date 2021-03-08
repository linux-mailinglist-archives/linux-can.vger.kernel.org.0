Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293CF330CCD
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCHLzH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 06:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhCHLzD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 06:55:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C2C06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 03:55:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so3623984wmd.5
        for <linux-can@vger.kernel.org>; Mon, 08 Mar 2021 03:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o8Ta+vdorvkLD8idQ6hGBWD1lQOhbd2DV+DhaFS9Ks4=;
        b=R2gGbVVcH2gjl8fB6DHArqz7fU3GX8O1bo6xnhJRU/rZVQA4i97KTYL953apkkydT7
         Gb2VAZUSA6cBTvM0P0wG7VakOirorkFkTmbG6Y9RoCQovP6/2drzwS7NHqXRD02sTvIA
         zQ7ATAbCtP6ykPu2hSzwpLKxKnLg4bVpUXxAAnMLutCtU9isnULBg/nTHWBFMHZjME5V
         UM3dNniGoDWCEnUqvWvXO1OapdSO8iOzUUs/WaDV2t4idA8v07Z20A2cXrvfL3PSIN/y
         W59F8yMY3YoHzOSx3jQsf57v/AvQ0kYcYNNVSxadDyn/0Ht9c7Diu6Gkz4YaAvr/ZI4W
         MYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o8Ta+vdorvkLD8idQ6hGBWD1lQOhbd2DV+DhaFS9Ks4=;
        b=t1BcObfWU6WciSdVLr+Pvo/G+0ZeIzNCWKB5IfQL5zB4j6NpLKP1zFEkvYzdtfLZfg
         zj4leyz8rFuRIHQXtYbBFlC9dHHtfDjxvXthlYoULTDijfrkoIFX6/FpIzkwtSWBnnFp
         nagiFV8vj119IHK8OwCAddQnm/7yA6yE2PN1qSIpFMe0kxhMJKr4rw0kVaQtmgDegHDq
         EB1pF4KDC/u7LQFuAgBgBnSXY/U4J8pM8kRq0ycuZSBNxjl6OwpKCRnhyNEkNQBoETYi
         M2q8B8MgkH9Yb95X29FLA3dGWLaZh4yGDRV1OpTOmMjSqK4gXhl/dvr0JJbrL03Fv1Rg
         Bz9g==
X-Gm-Message-State: AOAM533jc2W0Af2kiiLUBAIOvyjD60MJpcVWlQJB3dEaDTu9xSdwHtW8
        zHv5Qio89BS+ztl8YuAtS6Rbnw==
X-Google-Smtp-Source: ABdhPJxL/DK+zSVjvDfVhojfeScpJPZjjs9Z+EW9WCYuuSNT33BrvUtrBR1M8fd8ZpB2RExp8E1Wsg==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr21151833wmh.56.1615204501493;
        Mon, 08 Mar 2021 03:55:01 -0800 (PST)
Received: from bigthink (92.41.6.207.threembb.co.uk. [92.41.6.207])
        by smtp.gmail.com with ESMTPSA id a8sm14183785wmm.46.2021.03.08.03.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 03:55:01 -0800 (PST)
Date:   Mon, 8 Mar 2021 11:54:59 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3] can: m_can: fix periph RX path: use rx-offload to
 ensure skbs are sent from softirq context
Message-ID: <20210308115459.pekta5yarm22wsm6@bigthink>
References: <20210308113144.3058817-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308113144.3058817-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Mar 08, 2021 at 12:31:44PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> for completeness here the v3 of Torin's patch.
> 
> changes since v2:
> - fixed commenting style
> - add some missing variable initialization
> - m_can_class_register(): update error handling
> 
> regards,
> Marc

Thanks for the review and for applying the corrections Marc, much
appreciated! :)

Just tested the updated patch on my setup; no (more) problems.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

