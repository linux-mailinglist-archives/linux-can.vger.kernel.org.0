Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B265F9B9F
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKLVNJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 16:13:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40354 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLVNJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2019 16:13:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so12661565pgt.7
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2019 13:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sPAt5BR/SUzFPl5yvnwRm6FMeQY2XF7mr2Vkv7POVr8=;
        b=bIqchA1KyxBObqgEPY8kSTPxgK4/IhQLda5EB8nmyDsssVnhufTHiLz5c+Jtpb/Y5O
         vcVNJn8oKRVDUblMbYwPenSfqN+jgR3sPMqlIKypP/Sb+JmL7W7JUERGKEw9g+imDdxU
         hfLoPjK0+lY2vB/TNIlyd5Hyo3icQFcdKCvsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sPAt5BR/SUzFPl5yvnwRm6FMeQY2XF7mr2Vkv7POVr8=;
        b=isYvCMYyYVBU9aGfThYCMA59tz0O8q/v5OGZ8M87ZrhspPZjIlP8eDVhykEcTviDod
         /waevP/tfMtWEBjtSvJXBQy9XXbqNuPG7TLX8ICN/A9ATv5+oIUt59nQ0Szz873cApyf
         oDvmMCKtJiiHXZ6JR2514qf3Zl4SuHR71rW+Q+bylBxkRx5NtSEiNmJnFarMRBjHB8NC
         AMr4CfbCwnmcteNetjGM9oaIt0El5pvedmNh6fE5Q6hR7st5pU+k2OITmFA2CggDxW3s
         Af6uwxr7plDQ4pewkErbK9am7tygFegkQCzkhftg1Y04ddRtdyAunPA7WCG/fhmS/Uit
         cEaA==
X-Gm-Message-State: APjAAAWFb89QkyMtSvvpMsYDo6nrHF9j8ehJ5T+8QjYup8NDtPmYxayc
        7VhE6Kma1n1elqTH/vYsjo6ZIzwaAwY=
X-Google-Smtp-Source: APXvYqxes/8GaF/ZooF2sLVqYpwGHQmihsnNOG3D/WOY+A2DV7xkcHsW6QPedFsOxvIxuDVNLdrEGA==
X-Received: by 2002:a17:90a:970a:: with SMTP id x10mr231470pjo.39.1573593188698;
        Tue, 12 Nov 2019 13:13:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q26sm19396529pff.143.2019.11.12.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:07 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:13:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Subject: Re: Coverity: can_rx_offload_irq_offload_timestamp(): Resource leaks
Message-ID: <201911121311.2B77400DA@keescook>
References: <201911111735.C0D6AFBDB@keescook>
 <8d96e404-10af-1af2-2351-aee71f76d819@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d96e404-10af-1af2-2351-aee71f76d819@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 12, 2019 at 09:09:13AM +0100, Marc Kleine-Budde wrote:
> On 11/12/19 2:35 AM, coverity-bot wrote:
> > Hello!
> > 
> > This is an experimental automated report about issues detected by Coverity
> > from a scan of next-20191108 as part of the linux-next weekly scan project:
> > https://scan.coverity.com/projects/linux-next-weekly-scan
> > 
> > You're getting this email because you were associated with the identified
> > lines of code (noted below) that were touched by recent commits:
> > 
> > c2a9f74c9d18 ("can: rx-offload: can_rx_offload_irq_offload_timestamp(): continue on error")
> > 
> > Coverity reported the following:
> > 
> > *** CID 1487846:  Resource leaks  (RESOURCE_LEAK)
> > /drivers/net/can/rx-offload.c: 219 in can_rx_offload_irq_offload_timestamp()
> > 213
> > 214     		if (!(pending & BIT_ULL(i)))
> > 215     			continue;
> > 216
> > 217     		skb = can_rx_offload_offload_one(offload, i);
> > 218     		if (IS_ERR_OR_NULL(skb))
> > vvv     CID 1487846:  Resource leaks  (RESOURCE_LEAK)
> > vvv     Variable "skb" going out of scope leaks the storage it points to.
> > 219     			continue;
> > 220
> > 221     		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
> > 222     	}
> > 223
> > 224     	if (!skb_queue_empty(&skb_queue)) {
> > 
> > If this is a false positive, please let us know so we can mark it as
> > such, or teach the Coverity rules to be smarter. If not, please make
> > sure fixes get into linux-next. :) For patches fixing this, please
> > include these lines (but double-check the "Fixes" first):
> > 
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1487846 ("Resource leaks")
> > Fixes: c2a9f74c9d18 ("can: rx-offload: can_rx_offload_irq_offload_timestamp(): continue on error")
> 
> This is a false positive:
> 
> >> 218     		if (IS_ERR_OR_NULL(skb))
> >> 219     			continue;
> 
> since skb is either NULL or an error pointer not a pointer to a valid
> skb object.

Wow, yes, that certainly is! :) I will see if can find a way to teach
Coverity that the ERR span of "pointer" values do not count as
"allocated".

Thanks for taking a look at this!

-- 
Kees Cook
